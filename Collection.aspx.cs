using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using BEIS.UserManagment;
using System.Data.Objects;
using BEIS.GL;
using System.Text;
using System.Transactions;
using System.Reflection;
using BEIS.DAL;
using System.Web.UI.HtmlControls;


namespace BEIS.Web.BFBSS.BFGM.Transaction
{
    public partial class Collection : System.Web.UI.Page
    {
        BFBSSEntities bf = new BFBSSEntities();
        bss_Collection col = new bss_Collection();
        bss_CollectionDetail ColD = new bss_CollectionDetail();

        public bool Done;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                tblSubControlAccountController SCACont = new tblSubControlAccountController();
            
                ddlClient.DataSource = bf.bss_Client.Where(t => t.IsActive == true);
                ddlClient.DataTextField = "ClientName";
                ddlClient.DataValueField = "ClientId";
                ddlClient.DataBind();
                ddlClient.Items.Insert(0, new ListItem("---Select---", "0"));
                getMaxCollection();
                ddl_Paymentmode_SelectedIndexChanged(null, EventArgs.Empty);
                txtcoldate.Text = DateTime.Now.ToString("dd-MMM-yyyy");
                gvCollectionView.DataSource = bf.GetCollection_Master(null).OrderByDescending(t=>t.CollectionID);
                gvCollectionView.DataBind();

                ddl_Paymentmode.Items.Insert(0, new ListItem("Cheque", "1"));
                ddl_Paymentmode.Items.Insert(1, new ListItem("PayOrder", "2"));
                ddl_Paymentmode.Items.Insert(2, new ListItem("Demand Draft", "3"));
                pnlBank.Visible = true;
                pnlPayOrder.Visible = false;
                pnlDemandDraft.Visible = false;
            }
        }
        void getMaxCollection()
        {
            if (Session["subsidiary"] != null)
            {
                string[] s = Session["subsidiary"].ToString().Split('_');

                List<Collection_max_Result1> dt_id = bf.Collection_max(short.Parse(s[1])).ToList();

                int count = int.Parse(dt_id[0].Maxid.ToString());
                txtRefNo.Text = s[0] + "-" + (count + 1).ToString();
            }
        }
        long count;
        void MasterData()
        {
            if (hdnCollectionId.Value != "" && hdnCollectionId.Value != null)
            {
                col.CollectionID = int.Parse(hdnCollectionId.Value);
                Int64 a = Convert.ToInt64(hdnCollectionId.Value);
                col = bf.bss_Collection.Single(t => t.CollectionID == a);

            }
            string[] s = Session["subsidiary"].ToString().Split('_');
            col.SubsidiaryId = short.Parse(s[1]);
            string[] s2 = txtRefNo.Text.Split('-');
            col.ReferenceNo = Convert.ToInt64(s2[1]);
            col.ClientID = short.Parse(ddlClient.SelectedItem.Value);
            col.AgreementID = int.Parse(ddlAgreement.SelectedItem.Value);
            col.Description = txtRemarks.Text;
            col.CollectionDate = Convert.ToDateTime(txtcoldate.Text);
            col.DocumentNumber = txtdoc.Text;

            if (ddl_Paymentmode.SelectedValue == "1")
            {
                col.ChequeNo = txtChequeNo.Text;
                col.ChequeDate = Convert.ToDateTime(txtChequeDate.Text);
            
                col.BankId = txtCbankname.Text;
                col.BranchId = txtCbranchcode.Text;
                col.ChequeAmount = Convert.ToDecimal(txtChequeAmount.Text);
                col.CashAmount = Convert.ToDecimal("1");
            }
            if (ddl_Paymentmode.SelectedValue == "2")
            {
                //col.CashAmount = Convert.ToDecimal(txtCashAmount.Text);
                col.ChequeNo = txtPayOrderNo.Text;
                col.ChequeDate = Convert.ToDateTime(txtPayOrderDate.Text);
            
                col.BankId = txtPBankname.Text;
                col.BranchId = txtPBranchcode.Text;
                col.ChequeAmount = Convert.ToDecimal(txtPayOrderAmount.Text);
                col.CashAmount = Convert.ToDecimal("2");
            }
            if (ddl_Paymentmode.SelectedValue == "3")
            {
                //col.CashAmount = Convert.ToDecimal(txtCashAmount.Text);
                col.ChequeNo = txtDdraftno.Text;
                col.ChequeDate = Convert.ToDateTime(txtDddate.Text);
            
                col.BankId = txtDbankname.Text;
                col.BranchId = txtDbranchcode.Text;
                col.ChequeAmount = Convert.ToDecimal(txtDdamount.Text);
                col.CashAmount = Convert.ToDecimal("3");
            }
            if (rdbyes.Checked)
            {
                col.IsAdvance = true;
            }
            else
            {
                col.IsAdvance = false;
            }
            col.DomainUserId = Utility.GetDomainUserID();
            if (btninsert.Visible == true)
            {
                col.CreatedBy = Convert.ToInt32(col.SubsidiaryId);
                col.CreatedDate = System.DateTime.Now;
                col.ModifiedBy = 0;
                col.ModifiedDate = DateTime.Now;
                bf.AddTobss_Collection(col);

            }
            else
            {
                col.ModifiedBy = Convert.ToInt32(col.SubsidiaryId);
                col.ModifiedDate = System.DateTime.Now;

            }

            using (TransactionScope trn = new TransactionScope())
            {
                //count = bf.SaveChanges(System.Data.Objects.SaveOptions.DetectChangesBeforeSave);
                count = bf.SaveChanges(System.Data.Objects.SaveOptions.DetectChangesBeforeSave);
                hdnCollectionId.Value = col.CollectionID.ToString();
                if (count > 0)
                {

                    trn.Complete();
                    bf.AcceptAllChanges();
                    Done = true;
                }
                else
                {
                    bf.Dispose();
                    ScriptManager.RegisterClientScriptBlock(upd2, this.GetType(), "sd", "alert('Sorry, There may be a problem while saving the record!')", true);
                }
            }
            using (TransactionScope tran2 = new TransactionScope())
            {
                if (rdbyes.Checked != true)
                {
                    count = CollectionDetail(col.CollectionID);
            
                    if (count > 0)
                    {
                        tran2.Complete();
                        bf.AcceptAllChanges();
                        Done = true;
                    }
                    else
                    {
                        bf.Dispose();
                        Done = false;
                    }
                }
            }

        }
        public long CollectionDetail(Int64 colid)
        {

            try
            {
                int a = 0;
                foreach (GridViewRow item in gvInvoice.Rows)
                {
                    bss_CollectionDetail ColD = new bss_CollectionDetail();

                    if (btninsert.Visible != true)
                    {
                        Int64 CollectionDetailId = Convert.ToInt64(gvInvoice.DataKeys[a].Values[0].ToString());

                        ColD = bf.bss_CollectionDetail.Single(t => t.CollectionDetailId == CollectionDetailId);

                    }
                    if (item.Cells[1].Text!="")
                    ColD.DueDate = Convert.ToDateTime(item.Cells[1].Text);
                    if (item.Cells[2].Text != "")
                    ColD.InvoiceAmount = Convert.ToDecimal(item.Cells[2].Text);
                    if (item.Cells[4].Text != "")
                    ColD.BalanceAmount = Convert.ToDecimal(item.Cells[4].Text);
                    if (gvInvoice.DataKeys[a].Values[1].ToString() != null)
                    ColD.SubsidiaryId = Convert.ToInt16(gvInvoice.DataKeys[a].Values[1].ToString());
                    if (item.Cells[1].Text != "")
                    ColD.InvoiceId = Convert.ToInt32(item.Cells[0].Text);
                    if (((TextBox)item.FindControl("txtPaid")).Text != "")
                    ColD.AmountPaid = Convert.ToDecimal(((TextBox)item.FindControl("txtPaid")).Text);
                    if (item.Cells[1].Text != "")
                    ColD.CollectionID = Convert.ToInt64(hdnCollectionId.Value);

                    if (btninsert.Visible == true)
                    {
                        bf.AddTobss_CollectionDetail(ColD);
                    }
                    count = bf.SaveChanges();
                    a++;

                }
                return count;
            }
            catch
            {
                count = -1;
                return count;
            }

        }

        protected void btninsert_Click(object sender, ImageClickEventArgs e)
        {

            int a=short.Parse(ddlClient.SelectedItem.Value);
             DateTime s = Convert.ToDateTime(txtcoldate.Text);
            List<bss_Collection> lst_personnel = bf.bss_Collection.Where(t => t.ClientID == a && t.CollectionDate== s).ToList();

            if (lst_personnel.Count <= 0)
            {
            MasterData();
            if (Done)
            {
                ScriptManager.RegisterClientScriptBlock(btncanel, this.GetType(), "msg", "alert('Record Has Been Succesfully Inserted!')", true);
                ClearControls();
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(btncanel, this.GetType(), "msg", "alert('Sorry, There may be a problem while Inserting this record!')", true);
            }

            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(btncanel, this.GetType(), "msg", "alert('A collection already exist on the selected date')", true);
            }
        }

        protected void btnEdit_Click(object sender, ImageClickEventArgs e)
        {
            MasterData();
            if (Done)
            {
                ScriptManager.RegisterClientScriptBlock(btncanel, this.GetType(), "msg", "alert('Record Has Been Succesfully Updated!')", true);
                ClearControls();
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(btncanel, this.GetType(), "msg", "alert('Sorry, There may be a problem while Updating this record!')", true);
            }
        }

        protected void btncanel_Click(object sender, ImageClickEventArgs e)
        {
            ClearControls();
        }
        private void ClearControls()
        {
            txtRefNo.Text = string.Empty;
            ddlClient.SelectedValue = "0";
            //cmbBank.SelectedIndex = 0;
            //cmbBranch.SelectedIndex = -1;
            ddl_Paymentmode.SelectedValue = "1";
            txtCbankname.Text = "";
            txtCbranchcode.Text = "";
            ddlAgreement.SelectedIndex = -1;
            //txtCashAmount.Text = "0";
            txtPayOrderAmount.Text = "0";
            txtChequeNo.Text = string.Empty;
            txtChequeDate.Text = string.Empty;
            txtChequeAmount.Text = "0";
            txtRemarks.Text = string.Empty;
            txtcoldate.Text = DateTime.Now.ToString("dd-MMM-yyyy");
            getMaxCollection();
            gvInvoice.DataSource = null;
            gvInvoice.DataBind();
            //rdCheque.Checked = true;
            //rdCheque_CheckedChanged(null, EventArgs.Empty);
            ddl_Paymentmode_SelectedIndexChanged(null, EventArgs.Empty);
            btnEdit.Visible = false;
            hdnCollectionId.Value = "";
            hdnClientId.Value = "";
            // hdnInvoiceId.Value = "";
            hdnbalance.Value = "";
            hdntotal.Value = "";
            btninsert.Visible = true;
            lblerror.Visible = false;
            txtdoc.Text = "";
            gvCollectionView.DataSource = bf.GetCollection_Master(null).OrderByDescending(t=>t.CollectionID);
            gvCollectionView.DataBind();
            pnlBank.Visible = true;
            pnlPayOrder.Visible = false;
            pnlDemandDraft.Visible = false;
        }

        protected void btnview_Click(object sender, ImageClickEventArgs e)
        {

            gvCollectionView.DataSource = bf.GetCollection_Master(null).OrderByDescending(t=>t.CollectionID);
            gvCollectionView.DataBind();
            this.ModalPopupExtender1.Show();
        }
        void ViewDataByID()
        {
            List<getCollection_Result2> lst = bf.getCollection(Convert.ToInt64(hdnCollectionId.Value)).ToList();
            txtRefNo.Text = lst[0].ReferenceCode;
            txtcoldate.Text = Convert.ToDateTime(lst[0].collectiondate.ToString()).ToString("dd-MMM-yyyy");
            if (lst[0].IsAdvance == true)
            {
                rdbyes.Checked = true;
                rdbNo.Checked = false;
            }
            else
            {
                rdbNo.Checked = true;
                rdbyes.Checked = false;
            }
            ddlClient.SelectedValue = lst[0].clientid.ToString();
            int ClientId = Convert.ToInt32(ddlClient.SelectedValue);
            hdnClientId.Value = lst[0].clientid.ToString();

            ddlAgreement.DataSource = bf.bss_Agreement.Where(t => t.IsActive == true && t.ClientId == ClientId);
            ddlAgreement.DataTextField = "AgreementId";
            ddlAgreement.DataValueField = "AgreementId";
            ddlAgreement.DataBind();
            ddlAgreement.Items.Insert(0, new ListItem("---Select---", "0"));
            ddlAgreement.SelectedValue = lst[0].agreementid.ToString();
            if (lst[0].cashamount == decimal.Parse("1"))
            {
            
                tblSubControlAccountController SCACont = new tblSubControlAccountController();
            
                ddl_Paymentmode.SelectedValue = "1";
                txtCbankname.Text = lst[0].bankid.ToString();
                txtCbranchcode.Text = lst[0].branchid.ToString();
                txtChequeNo.Text = lst[0].chequeno.ToString();
                txtChequeDate.Text = Convert.ToDateTime(lst[0].chequedate.ToString()).ToString("dd-MMM-yyyy");
                txtChequeAmount.Text = lst[0].chequeamount.ToString();
                pnlBank.Visible = true;
                //pnlCash.Visible = false;
                pnlPayOrder.Visible = false;
                pnlDemandDraft.Visible = false;
            }
            else if (lst[0].cashamount == decimal.Parse("2"))
            {
                ddl_Paymentmode.SelectedValue = "2";
                txtPBankname.Text = lst[0].bankid.ToString();
                txtPBranchcode.Text = lst[0].branchid.ToString();
                txtPayOrderNo.Text = lst[0].chequeno.ToString();
                txtPayOrderDate.Text = Convert.ToDateTime(lst[0].chequedate.ToString()).ToString("dd-MMM-yyyy");
                txtPayOrderAmount.Text = lst[0].chequeamount.ToString();
                pnlPayOrder.Visible = true;
                pnlBank.Visible = false;
                pnlDemandDraft.Visible = false;
                //txtCashAmount.Text = lst[0].cashamount.ToString();
            }
            else
            {
                ddl_Paymentmode.SelectedValue = "3";
                txtDbankname.Text = lst[0].bankid.ToString();
                txtDbranchcode.Text = lst[0].branchid.ToString();
                txtDdraftno.Text = lst[0].chequeno.ToString();
                txtDddate.Text = Convert.ToDateTime(lst[0].chequedate.ToString()).ToString("dd-MMM-yyyy");
                txtDdamount.Text = lst[0].chequeamount.ToString();
                pnlDemandDraft.Visible = true;
                pnlBank.Visible = false;
                pnlPayOrder.Visible = false;
            }
            txtdoc.Text = lst[0].DocumentNumber.ToString();
            txtRemarks.Text = lst[0].description;
            List<getCollection_Result2> lstDetail = bf.getCollection(Convert.ToInt64(hdnCollectionId.Value)).ToList();

            if (rdbNo.Checked)
            {
                gvInvoice.DataSource = bf.getCollection(Convert.ToInt64(hdnCollectionId.Value));
                gvInvoice.DataBind();

                foreach (GridViewRow item in gvInvoice.Rows)
                {
                    try
                    {
                        List<GetSum_Result> lstResult = bf.GetSum(int.Parse(item.Cells[0].Text), Convert.ToInt64(hdnClientId.Value)).ToList();
                        item.Cells[3].Text = lstResult[0].Amount.ToString();
                        item.Cells[4].Text = lstResult[1].Amount.ToString();
                    }
                    catch
                    {
                    }
                }
            }
        }

        protected void gvCollectionView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Editrow")
            {
                hdnCollectionId.Value = e.CommandArgument.ToString();
                ViewDataByID();
                btninsert.Visible = false;
                btnEdit.Visible = true;
            }
        }

        protected void rdCash_CheckedChanged(object sender, EventArgs e)
        {
            
            if (ddl_Paymentmode.SelectedValue=="2")
            {
            
                pnlPayOrder.Visible = true;
                pnlBank.Visible = false;
                EnablingValidator(true);
            }
        }

        protected void rdCheque_CheckedChanged(object sender, EventArgs e)
        {
            
            if (ddl_Paymentmode.SelectedValue=="1")
            {
            
                pnlPayOrder.Visible = false;
                pnlBank.Visible = true;
                EnablingValidator(false);
            }
        }
        void EnablingValidator(bool a)
        {
            rfvbank.Enabled = !a;
            RequiredFieldValidator1.Enabled = !a;
            RequiredFieldValidator2.Enabled = !a;
            RequiredFieldValidator3.Enabled = !a;
            
        }

        protected void cmbBank_SelectedIndexChanged(object sender, EventArgs e)
        {
            tblSubControlAccountController SCACont = new tblSubControlAccountController();
            
        }

        void CalculateAmount()
        {
            try
            {
                int a = 0;
                foreach (GridViewRow item in gvInvoice.Rows)
                {
                    TextBox txtPaid = (TextBox)item.FindControl("txtPaid");

                    if (txtPaid.Text != "" && txtPaid.Text != null)
                    {
                        if (hdnCollectionId.Value != "" && hdnCollectionId.Value != null)
                        {
                            if (Convert.ToDouble(item.Cells[2].Text) >= ((Convert.ToDouble(item.Cells[3].Text) - Convert.ToDouble(gvInvoice.DataKeys[a].Values[2].ToString())) + Convert.ToDouble(txtPaid.Text)))
                            {
                                item.Cells[4].Text = (Convert.ToDouble(item.Cells[2].Text) - ((Convert.ToDouble(item.Cells[3].Text) - Convert.ToDouble(gvInvoice.DataKeys[a].Values[2].ToString())) + Convert.ToDouble(txtPaid.Text))).ToString();
                            }

                            else
                            {
                                ScriptManager.RegisterClientScriptBlock(btncanel, this.GetType(), "sds", "alert('Total Paid Amount Should be Equal or Less than Invoice Amount')", true);
                                txtPaid.Text = "0";
                                item.Cells[4].Text = gvInvoice.DataKeys[a].Values[3].ToString();
                            }
                        }
                        else
                        {
                            if (Convert.ToDouble(item.Cells[2].Text) >= (Convert.ToDouble(item.Cells[3].Text) + Convert.ToDouble(txtPaid.Text)))
                            {
                                item.Cells[4].Text = (Convert.ToDouble(item.Cells[2].Text) - (Convert.ToDouble(item.Cells[3].Text) + Convert.ToDouble(txtPaid.Text))).ToString();
                            }
                            else
                            {
                                ScriptManager.RegisterClientScriptBlock(btncanel, this.GetType(), "sds", "alert('Total Paid Amount Should be Equal or Less than Invoice Amount')", true);
                                txtPaid.Text = "0";
                                item.Cells[4].Text = gvInvoice.DataKeys[a].Values[3].ToString();
                            }
                        }
                        a++;

                    }
                }
            }
            catch
            {
            }
        }
        protected void txtPaid_TextChanged(object sender, EventArgs e)
        {
            CalculateAmount();
        }

        protected void txt_search_TextChanged(object sender, EventArgs e)
        {
            
        }

        protected void btn_del_Click(object sender, ImageClickEventArgs e)
        {

        }

        protected void btn_back_Click(object sender, ImageClickEventArgs e)
        {

        }

        protected void gvInvoice_RowCommand(object sender, GridViewCommandEventArgs e)
        {

        }

        protected void gvInvoice_RowDataBound(object sender, GridViewRowEventArgs e)
        {


        }

        protected void ddlClient_SelectedIndexChanged(object sender, EventArgs e)
        {
            
            int ClientId = Convert.ToInt32(ddlClient.SelectedValue);
            ddlAgreement.DataSource = bf.bss_Agreement.Where(t => t.IsActive == true && t.ClientId == ClientId);
            ddlAgreement.DataTextField = "AgreementId";
            ddlAgreement.DataValueField = "AgreementId";
            ddlAgreement.DataBind();
            ddlAgreement.Items.Insert(0, new ListItem("---Select---", "0"));

            if (rdbyes.Checked != true)
            {
                gvInvoice.DataSource = bf.Collection_Invoice(ClientId);
                gvInvoice.DataBind();
            }


        }

        protected void rdbyes_CheckedChanged(object sender, EventArgs e)
        {

        }

        protected void txtcoldate_TextChanged(object sender, EventArgs e)
        {
            if (txtcoldate.Text != "")
            {
                DateTime chkDate = Convert.ToDateTime(string.Format("{0:dd/MM/yyyy}", txtcoldate.Text));
                DateTime current_date = Convert.ToDateTime(System.DateTime.Now.ToString("dd/MM/yyyy"));
                if (chkDate < current_date)
                {
                    ScriptManager.RegisterClientScriptBlock(upd2, this.GetType(), "msg", "alert('Earlier date can not be selected than todate. ')", true);
                    txtcoldate.Text = "";
                }
            }
        }

        protected void txtChequeDate_TextChanged(object sender, EventArgs e)
        {
            if (txtChequeDate.Text != "")
            {
                DateTime chkDate = Convert.ToDateTime(string.Format("{0:dd/MM/yyyy}", txtChequeDate.Text));
                DateTime current_date = Convert.ToDateTime(System.DateTime.Now.ToString("dd/MM/yyyy"));
                if (chkDate < current_date)
                {
                    ScriptManager.RegisterClientScriptBlock(upd2, this.GetType(), "msg", "alert('Earlier date can not be selected than todate. ')", true);
                    txtChequeDate.Text = "";
                }
            }
        }

        protected void ddl_Paymentmode_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddl_Paymentmode.SelectedValue == "1")
            {
                //pnlCash.Visible = false;
                pnlBank.Visible = true;
                pnlPayOrder.Visible = false;
                pnlDemandDraft.Visible = false;
                EnablingValidator(false);
            }
            else if (ddl_Paymentmode.SelectedValue == "2")
            {
                pnlPayOrder.Visible = true;
                pnlBank.Visible = false;
                pnlDemandDraft.Visible = false;
            }
            else if (ddl_Paymentmode.SelectedValue == "3")
            {
                pnlDemandDraft.Visible = true;
                pnlBank.Visible = false;
                pnlPayOrder.Visible = false;
            }
        }

        protected void txtPayOrderDate_TextChanged(object sender, EventArgs e)
        {
            if (txtPayOrderDate.Text != "")
            {
                DateTime chkDate = Convert.ToDateTime(string.Format("{0:dd/MMM/yyyy}", txtPayOrderDate.Text));
                DateTime current_date = Convert.ToDateTime(System.DateTime.Now.ToString("dd/MMM/yyyy"));
                if (chkDate < current_date)
                {
                    ScriptManager.RegisterClientScriptBlock(upd2, this.GetType(), "msg", "alert('Earlier date can not be selected than todate. ')", true);
                    txtPayOrderDate.Text = "";
                }
            }
        }

    }
}