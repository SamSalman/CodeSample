using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DbHandler;
using BAL;
using System.Drawing;


namespace ShiaSpouse
{
    public partial class Verify_Gold_Step2 : System.Web.UI.Page
    {
        PropertiesClass pc = new PropertiesClass();
        Main M = new Main();
        ImgTools Img_box = new ImgTools();


        string DeKey;
        private string DecryptQueryString(string strQueryString, string key)
        {
            EncryptDecryptQueryString objEDQueryString = new EncryptDecryptQueryString();
            return objEDQueryString.Decrypt(strQueryString, key);
        }

        public string EncryptQueryString(string strQueryString)
        {
            EncryptDecryptQueryString objEDQueryString = new EncryptDecryptQueryString();
            return objEDQueryString.Encrypt(strQueryString, (string)Session["Key"]);
        }
        private void load_data()
        {
            if (Session["prid"] != null)
            {
                if (IsPostBack != true)
                {
                    pc._prid = int.Parse(Session["prid"].ToString());
                    M.get_Silver_files(pc);
                    string silver_picname = pc._Pic_name;
                    string[] s1;
                    if (pc._silver_file1 != null && pc._silver_file1 != "")
                    {
                        s1 = pc._silver_file1.Split('_');
                        txt_file_1.Text = s1[1];
                        H_f_1.Value = pc._silver_file1;
                    }
                    if (pc._silver_file2 != null && pc._silver_file2 != "")
                    {
                        s1 = pc._silver_file2.Split('_');
                        txt_file_2.Text = s1[1];
                        H_f_2.Value = pc._silver_file2;
                    }
                    if (pc._silver_file3 != null && pc._silver_file3 != "")
                    {
                        s1 = pc._silver_file3.Split('_');
                        txt_file_3.Text = s1[1];
                        H_f_3.Value = pc._silver_file3;
                    }
                    if (pc._silver_file4 != null && pc._silver_file4 != "")
                    {
                        s1 = pc._silver_file4.Split('_');
                        txt_file_4.Text = s1[1];
                        H_f_4.Value = pc._silver_file4;
                    }
                    M.Get_Account_Info(pc);
                    txt_verigold_name.Text = pc._fname + " " + pc._lname;
                    string[] s2 = pc._dob.Split(new string[] { "-" }, StringSplitOptions.None);
                    txt_verisilver_dob_day.Text = s2[1];
                    txt_verisilver_dob_MM.Text = s2[0];
                    txt_verisilver_dob_YY.Text = s2[2];
                    txt_verisilver_address1.Text = pc._address;

                    int val;
                    string[] s3 = pc._Docs_provided.Split(new string[] { "," }, StringSplitOptions.None);
                    for (int a = 0; a < s3.Length; a++)
                    {
                        if (s3[a] != "," && s3[a] != "")
                        {
                            val = Convert.ToInt16(s3[a]) - 1;
                            Chk_verisilver_step3.Items[val].Selected = true;
                        }
                    }

                    s3 = pc._proof_for.Split(new string[] { "," }, StringSplitOptions.None);

                    for (int a = 0; a < s3.Length; a++)
                    {
                        if (s3[a] != "," && s3[a] != "")
                        {
                            val = Convert.ToInt16(s3[a]) - 1;
                            chk_verisilver_step2.Items[val].Selected = true;
                        }
                    }

                    M.Get_Profile(pc);
                    txt_verisilver_address2.Text = pc._lcountry;
                    txt_verisilver_address3.Text = pc._lcity;
                    if (silver_picname == null || silver_picname == "" || silver_picname == "MP_Upl_Photo_thum.jpg")
                    {
                        imgDP.ImageUrl = "ImgHandler.ashx?" + EncryptQueryString(Server.MapPath("UserPhotos/" + pc._Pic_name));
                        Session["tempvariable"] = pc._Pic_name;
                    }
                    else
                    {
                        imgDP.ImageUrl = "ImgHandler.ashx?" + EncryptQueryString(Server.MapPath("UserPhotos/" + silver_picname));
                        Session["tempvariable"] = silver_picname;
                    }
                }
            }
            else
            {
                Server.Transfer("Login.aspx");
            }


        }

        protected void Page_Load(object sender, EventArgs e)
        {
            load_data();
        }
        Guid picname_rand = Guid.NewGuid();


        protected void btnupload_Click(object sender, ImageClickEventArgs e)
        {
            string ext = System.IO.Path.GetExtension(selectfile.PostedFile.FileName);
            ext = ext.ToLower();
            if (selectfile.HasFile)
            {
                if (selectfile2.FileBytes.Length < 10444800) //10 mb
                {
                    if (ext == ".png" || ext == ".jpg" || ext == ".bmp" || ext == ".gif" || ext == ".tif" || ext == ".pdf" || ext == ".doc" || ext == ".docx")
                    {
                        string EncKey = EncryptDecryptQueryString.CreateSalt(6);
                        Session.Add("Key", EncKey);
                        string sFilename;
                        string storefile;
                        System.Drawing.Image image_file = System.Drawing.Image.FromStream(selectfile.PostedFile.InputStream);
                        Bitmap Bmap_Image = new Bitmap(image_file);
                        Bitmap Image_resized = Img_box.imageResize(768, 1024, Bmap_Image);
                        sFilename = System.IO.Path.GetFileName(selectfile.FileName);
                        sFilename = picname_rand.ToString() + '_' + sFilename;
                        storefile = Server.MapPath("UserPhotos/" + sFilename);
                        Image_resized.Save(storefile, System.Drawing.Imaging.ImageFormat.Jpeg);
                        imgDP.ImageUrl = "ImgHandler.ashx?" + EncryptQueryString(storefile);
                        Session["tempvariable"] = sFilename;
                        lb_photo_er_type.Visible = false;
                    }
                    else
                    {
                        lb_photo_er_type.Visible = true;
                        lb_photo_er_type.Text = "Only .jpg .bmp .gif files";
                    }
                }
                else
                {
                    lb_photo_er_type.Visible = true;
                    lb_photo_er_type.Text = "Maximum file size 10 mb";
                }
            }
            else
            {
                lb_photo_er_type.Visible = true;
                lb_photo_er_type.Text = "Choose a file";
            }
        }

        protected void btnremove_Click(object sender, ImageClickEventArgs e)
        {
            string storefile = Server.MapPath("UserPhotos/" + "MP_Upl_Photo_thum.jpg");
            Session["tempvariable"] = "MP_Upl_Photo_thum.jpg";
            imgDP.ImageUrl = "ImgHandler.ashx?" + EncryptQueryString(storefile);
        }

        private void Upload2()
        {
            picname_rand = Guid.NewGuid();
            string ext = System.IO.Path.GetExtension(selectfile2.PostedFile.FileName);
            ext = ext.ToLower();
            if (selectfile2.HasFile)
            {
                if (selectfile2.FileBytes.Length < 10444800) //10 mb
                {
                    if (ext == ".png" || ext == ".jpg" || ext == ".bmp" || ext == ".gif" || ext == ".tif" || ext == ".pdf" || ext == ".doc" || ext == ".docx")
                    {
                        if (txt_file_1.Text == "")
                        {
                            lbl_er_st4.Visible = false;
                            H_f_1.Value = picname_rand + "_" + selectfile2.FileName.ToString();
                            selectfile2.SaveAs(Server.MapPath("Docs/" + H_f_1.Value));
                            txt_file_1.Text = selectfile2.FileName.ToString();
                        }
                        else if (txt_file_2.Text == "")
                        {
                            lbl_er_st4.Visible = false;
                            H_f_2.Value = picname_rand + "_" + selectfile2.FileName.ToString();
                            selectfile2.SaveAs(Server.MapPath("Docs/" + H_f_2.Value));
                            txt_file_2.Text = selectfile2.FileName.ToString();
                        }
                        else if (txt_file_3.Text == "")
                        {
                            lbl_er_st4.Visible = false;
                            H_f_3.Value = picname_rand + "_" + selectfile2.FileName.ToString();
                            selectfile2.SaveAs(Server.MapPath("Docs/" + H_f_3.Value));
                            txt_file_3.Text = selectfile2.FileName.ToString();
                        }
                        else if (txt_file_4.Text == "")
                        {
                            lbl_er_st4.Visible = false;
                            H_f_4.Value = picname_rand + "_" + selectfile2.FileName.ToString();
                            selectfile2.SaveAs(Server.MapPath("Docs/" + H_f_4.Value));
                            txt_file_4.Text = selectfile2.FileName.ToString();
                        }
                        else
                        {
                            lbl_er_st4.Visible = true;
                            lbl_er_st4.Text = "A maximum of 4 files are allowed to be uploaded";
                        }
                    }
                    else
                    {
                        lbl_er_st4.Visible = true;
                        lbl_er_st4.Text = " Upload only .gif /.png / .jpg / .pdf / .tif / .docx / .doc files only";
                    }
                }
                else
                {
                    lbl_er_st4.Visible = true;
                    lbl_er_st4.Text = "Max file size is 10mb";
                }
            }
            else
            {
                lbl_er_st4.Visible = true;
                lbl_er_st4.Text = "Please choose a file";
            }

        }

        protected void btnupload2_Click(object sender, ImageClickEventArgs e)
        {
            Upload2();
        }


        protected bool CheckHowmanyFiles()
        {
            if (H_f_1.Value != "" && H_f_2.Value != "")
            {
                lbl_er_st4.Visible = false;
                return true;
            }
            else
            {
                lbl_er_st4.Text = "Select at least 2 documents that you will be submitting";
                lbl_er_st4.Visible = true;
                return false;
            }
        }

        protected void btn_remove1_Click(object sender, ImageClickEventArgs e)
        {
            txt_file_1.Text = txt_file_2.Text;
            H_f_1.Value = H_f_2.Value;
            txt_file_2.Text = txt_file_3.Text;
            H_f_2.Value = H_f_3.Value;
            txt_file_3.Text = txt_file_4.Text;
            H_f_3.Value = H_f_4.Value;
            txt_file_4.Text = "";
            H_f_4.Value = "";
            lbl_er_st4.Visible = false;
        }
        protected void btn_remove2_Click(object sender, ImageClickEventArgs e)
        {
            txt_file_2.Text = txt_file_3.Text;
            H_f_2.Value = H_f_3.Value;
            txt_file_3.Text = txt_file_4.Text;
            H_f_3.Value = H_f_4.Value;
            txt_file_4.Text = "";
            H_f_4.Value = "";
            lbl_er_st4.Visible = false;
        }

        protected void btn_remove3_Click(object sender, ImageClickEventArgs e)
        {
            txt_file_3.Text = txt_file_4.Text;
            H_f_3.Value = H_f_4.Value;
            txt_file_4.Text = "";
            H_f_4.Value = "";
            lbl_er_st4.Visible = false;
        }

        protected void btn_remove4_Click(object sender, ImageClickEventArgs e)
        {
            txt_file_4.Text = "";
            H_f_4.Value = "";
            lbl_er_st4.Visible = false;
        }


        protected bool valpage()
        {
            if (CheckSection3() && CheckHowmanyFiles() && Checkphotoexists())
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        protected bool Checkphotoexists()
        {
            if (chk_verisilver_step2.Items[3].Selected)
            {
                if (Session["tempvariable"].ToString() != "MP_Upl_Photo_thum.jpg")
                {
                    lbl_photoid_err.Visible = false;
                    return true;
                }
                else
                {
                    lbl_photoid_err.Text = "Photo required";
                    lbl_photoid_err.Visible = true;
                    return false;
                }
            }
            else
            {
                return true;
            }
        }


        protected bool CheckSection3()
        {
            int cnt = 0;
            for (int a = 0; a < Chk_verisilver_step3.Items.Count; a++)
            {
                if (Chk_verisilver_step3.Items[a].Selected)
                {
                    cnt = cnt + 1;
                }
            }
            if (cnt >= 2)
            {
                lbl_er_st3.Visible = false;
                return true;
            }
            else
            {
                lbl_er_st3.Text = "Select at least 2 pieces of information";
                lbl_er_st3.Visible = true;
                return false;
            }
        }


        private void save_data()
        {
            pc._prid = int.Parse(Session["prid"].ToString());
            pc._Docs_provided = "";
            pc._proof_for = "";
            pc._Pic_name = Session["tempvariable"].ToString();
            M.UpdateSilverSealDp_pic(pc);

            for (int a = 0; a < Chk_verisilver_step3.Items.Count; a++)
            {
                if (Chk_verisilver_step3.Items[a].Selected)
                {
                    pc._Docs_provided = pc._Docs_provided + Chk_verisilver_step3.Items[a].Value + ",";
                }
            }

            for (int a = 0; a < chk_verisilver_step2.Items.Count; a++)
            {
                if (chk_verisilver_step2.Items[a].Selected)
                {
                    pc._proof_for = pc._proof_for + chk_verisilver_step2.Items[a].Value + ",";
                }
            }
            pc._silver_file1 = H_f_1.Value.ToString();
            pc._silver_file2 = H_f_2.Value.ToString();
            pc._silver_file3 = H_f_3.Value.ToString();
            pc._silver_file4 = H_f_4.Value.ToString();
            M.InsertSilverseal_Step2(pc);

            string[] s2 = txt_verigold_name.Text.Split(new string[] { " " }, StringSplitOptions.None);
            pc._fname = s2[0];
            pc._lname = s2[1];
            pc._address = txt_verisilver_address1.Text;
            pc._dob = txt_verisilver_dob_MM.Text + "-" + txt_verisilver_dob_day.Text + "-" + txt_verisilver_dob_YY.Text;
            M.Updatewelcome_SilverSeal_info(pc);
        
        }



        private void silver_next()
        {
            string sFilename = Session["tempvariable"].ToString();
            if (chk_verigold_address.Checked)
            {
                lbl_confirm_address.Visible = false;
                if (valpage())
                {
                    pc._prid = int.Parse(Session["prid"].ToString());

                    pc._Pic_name = Session["tempvariable"].ToString();
                    M.UpdateSilverSealDp_pic(pc);

                    for (int a = 0; a < Chk_verisilver_step3.Items.Count; a++)
                    {
                        if (Chk_verisilver_step3.Items[a].Selected)
                        {
                            pc._Docs_provided = pc._Docs_provided + Chk_verisilver_step3.Items[a].Value + ",";
                        }
                    }

                    for (int a = 0; a < chk_verisilver_step2.Items.Count; a++)
                    {
                        if (chk_verisilver_step2.Items[a].Selected)
                        {
                            pc._proof_for = pc._proof_for + chk_verisilver_step2.Items[a].Value + ",";
                        }
                    }
                    pc._silver_file1 = H_f_1.Value.ToString();
                    pc._silver_file2 = H_f_2.Value.ToString();
                    pc._silver_file3 = H_f_3.Value.ToString();
                    pc._silver_file4 = H_f_4.Value.ToString();
                    M.InsertSilverseal_Step2(pc);

                    string[] s2 = txt_verigold_name.Text.Split(new string[] { " " }, StringSplitOptions.None);
                    pc._fname = s2[0];
                    pc._lname = s2[1];
                    pc._address = txt_verisilver_address1.Text;
                    pc._dob = txt_verisilver_dob_MM.Text + "-" + txt_verisilver_dob_day.Text + "-" + txt_verisilver_dob_YY.Text;
                    M.Updatewelcome_SilverSeal_info(pc);
                    M.MemberShipExists(pc);
                    if (Session["member_type"].ToString() == "1")
                    {
                        pc._Membershp_type = "2";
                        Session["member_type"] = "2";
                    }
                    else
                    {
                        pc._Membershp_type = Session["member_type"].ToString();
                    }
                         
                        M.UpdatewelcomeGoldMember(pc);
                        M.UpdateUserDocseGoldMember(pc);

                    //}
                    if (Request.QueryString["pages"] != null)
                    {      
                            Response.Redirect("Verification_Complete.aspx?t=3");
                    }
                    else
                    {
                        Server.Transfer("Verify_Gold_Step3.aspx");
                    }


                  

                }
            }
            else
            {
                lbl_confirm_address.Visible = true;
                lbl_confirm_address.Text = "Please confirm your address by placing a tick on the check box";
            }
        }


        protected void btn_slver_next_Click(object sender, ImageClickEventArgs e)
        {
            silver_next();
        }

        protected void li_edit_dob_Click(object sender, EventArgs e)
        {
            save_data();
            Response.Redirect("Acc_Settings.aspx?source=Verify_Gold_Step2");
        }

        protected void li_edit_name_Click(object sender, EventArgs e)
        {
            save_data();
            Response.Redirect("Acc_Settings.aspx?source=Verify_Gold_Step2");
        }

       
    }
}