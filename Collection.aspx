<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Collection.aspx.cs" Inherits="BEIS.Web.BFBSS.BFGM.Transaction.Collection" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .style5
        {
            width: 114px;
        }
        .style7
        {
            width: 109px;
        }
        .style15
        {
            width: 254px;
        }
        .style17
        {
            width: 118px;
        }
        .style18
        {
            width: 278px;
        }
        .style19
        {
            width: 112px;
        }
        .style20
        {
            width: 111px;
        }
        .style21
        {
            width: 276px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script src="../../../js/Number.js" type="text/javascript"></script>
    <fieldset style="width: 80%; border: 1px #CCC solid;">
        <legend class="fieldset-text">Guard Monitoring System</legend>
        <asp:UpdatePanel ID="upd2" runat="server">
            <ContentTemplate>
                <asp:Panel ID="pnl_operation" runat="server">
                    <table cellpadding="1" width="100%">
                        <tr>
                            <td class="title" colspan="4">
                                <img class="icon" alt="saa" src="/../images/title-icon.png" />
                                <p class="text">
                                    Collection</p>
                            </td>
                        </tr>
                        <tr>
                            <td class="style17" align="right">
                                <label>
                                    Reference #:</label>
                            </td>
                            <td class="style15">
                                <asp:TextBox ID="txtRefNo" Enabled="false" CssClass="text-field" runat="server" Width="167px"></asp:TextBox>
                                <asp:ImageButton ID="btnview" runat="server" ImageUrl="~/images/Search_2.png" TabIndex="2" />
                            </td>
                            <td class="style5" align="right">
                                <label>
                                    Collection Date:</label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtcoldate" Width="140px" CssClass="text-field" runat="server" TabIndex="0" OnTextChanged="txtcoldate_TextChanged"></asp:TextBox>
                                <asp:ImageButton ID="img_cl" runat="server" ImageUrl="~/images/Calendar.gif" Width="20"
                                    TabIndex="2" ToolTip="Select Date" />
                                <asp:CalendarExtender ID="clndr" runat="server" Format="dd-MMM-yyyy" TargetControlID="txtcoldate"
                                    PopupButtonID="img_cl">
                                </asp:CalendarExtender>
                                <asp:RequiredFieldValidator ID="RFV_Date" ValidationGroup="RHR" runat="server" ForeColor="Red"
                                    ErrorMessage="Date?" ControlToValidate="txtcoldate"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RFV_txt_EndDate" ValidationGroup="RHR" SetFocusOnError="True"
                                    runat="server" ForeColor="Red" ErrorMessage="i.e (01-Jan-2012)" ValidationExpression="^(d{0}|(31(?!(Feb|feb|Apr|apr|Jun|jun|Sep|
sep|Nov|nov)))|((30|29)(?!Feb|feb))|(29(?=Feb|feb(((1[6-9]|[2-9]\
d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00
)))))|(29(?=Feb|feb(((0[48]|[2468][048]|[13579]
[26])|((16|[2468][048]|[3579][26])00)))))|(0?[1-9])|1\d|2[0-8])[- ](Jan|jan|feb|Feb|mar|Mar|may|May|apr|Apr|jul|Jul|Jun|jun|Aug|aug|
Oct|oct|Sep|sep|Nov|nov|dec|Dec)[- ]((1[6-9]|[2-9]\d)\d{2}|\d{2}|d{0})$" ControlToValidate="txtcoldate"></asp:RegularExpressionValidator>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <label>
                                    Is Advance:</label>
                            </td>
                            <td>
                                <asp:RadioButton ID="rdbyes" runat="server" Text="Yes" GroupName="adv" TabIndex="3" />
                                <asp:RadioButton ID="rdbNo" runat="server" Text="No" Checked="true" GroupName="adv"
                                    TabIndex="4" />
                            </td>
                            <td class="style17" align="right">
                                <label>
                                    Client:</label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlClient" TabIndex="3" runat="server" CssClass="text-field" Width="150px" AutoPostBack="true"
                                    OnSelectedIndexChanged="ddlClient_SelectedIndexChanged" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ValidationGroup="RHR" runat="server"
                                    ControlToValidate="ddlClient" InitialValue="0" ForeColor="Red" CssClass="rednote"
                                    ErrorMessage="*"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                            </td>
                        </tr>
                        <tr>
                            <td class="style17" align="right">
                                <label>
                                    Agreement:</label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlAgreement" CssClass="text-field" runat="server" Width="180px" AutoPostBack="true"
                                    TabIndex="5" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator10" ValidationGroup="RHR" runat="server"
                                    ControlToValidate="ddlAgreement" InitialValue="0" ForeColor="Red" CssClass="rednote"
                                    ErrorMessage="*"></asp:RequiredFieldValidator>
                                <td align="right">
                                    <label>
                                        Payment Type:</label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddl_Paymentmode" CssClass="text-field" runat="server" Width="150px" AutoPostBack="True"
                                        OnSelectedIndexChanged="ddl_Paymentmode_SelectedIndexChanged">
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ValidationGroup="RHR" runat="server"
                                        ControlToValidate="ddl_Paymentmode" InitialValue="0" ForeColor="Red" CssClass="rednote"
                                        ErrorMessage="*"></asp:RequiredFieldValidator>
                                    <%--<asp:RadioButton ID="rdCash" runat="server" Text="Cash" AutoPostBack="True" GroupName="A" TabIndex="6"
                                        OnCheckedChanged="rdCash_CheckedChanged" />
                                    <asp:RadioButton ID="rdCheque" runat="server" Text="Cheque" Checked="True" AutoPostBack="True" TabIndex="7"
                                        GroupName="A" OnCheckedChanged="rdCheque_CheckedChanged" />--%>
                                </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <asp:Panel ID="pnlBank" runat="server" Visible="false">
                                    <table style="width: 712px">
                                        <tr>
                                            <td align="right" class="style7">
                                                <label>
                                                    Bank:</label>
                                            </td>
                                            <td class="style18" align="left">
                                                &nbsp;<%--<asp:DropDownList ID="cmbBank" runat="server" AutoPostBack="True" Width="180px"
                                                    TabIndex="8" OnSelectedIndexChanged="cmbBank_SelectedIndexChanged">
                                                </asp:DropDownList>--%><asp:TextBox ID="txtCbankname" CssClass="text-field" runat="server"
                                                    Width="172px" MaxLength="12"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfvbank" runat="server" ErrorMessage="*" ForeColor="Red"
                                                    InitialValue="0" ValidationGroup="RHR" ControlToValidate="txtCbankname"></asp:RequiredFieldValidator>
                                            </td>
                                            <td align="right">
                                                <label>
                                                    Branch Name/Code:</label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtCbranchcode" CssClass="text-field" runat="server" Width="172px"
                                                    MaxLength="12"></asp:TextBox>
                                                <%--<asp:DropDownList ID="cmbBranch" Width="140px" runat="server" TabIndex="9">
                                                </asp:DropDownList>--%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <label>
                                                    Cheque/Ref No:</label>
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="txtChequeNo" CssClass="text-field" runat="server" Width="172px"
                                                    TabIndex="10" MaxLength="12"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"
                                                    ForeColor="Red" ValidationGroup="RHR" ControlToValidate="txtChequeNo"></asp:RequiredFieldValidator>
                                            </td>
                                            <td align="right">
                                                <label>
                                                    Cheque Date:</label>
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="txtChequeDate" CssClass="text-field" Width="140px" TabIndex="11" runat="server" OnTextChanged="txtChequeDate_TextChanged"></asp:TextBox>
                                                <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/Calendar.gif"
                                                    Width="20" ToolTip="Select Date" />
                                                <asp:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd-MMM-yyyy"
                                                    TargetControlID="txtChequeDate" PopupButtonID="ImageButton1">
                                                </asp:CalendarExtender>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*"
                                                    ForeColor="Red" ValidationGroup="RHR" ControlToValidate="txtChequeDate"></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                            </td>
                                            <td>
                                            </td>
                                            <td>
                                            </td>
                                            <td>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ValidationGroup="RHR"
                                                    SetFocusOnError="True" runat="server" ForeColor="Red" ErrorMessage="i.e (01-Jan-2012)"
                                                    ValidationExpression="^(d{0}|(31(?!(Feb|feb|Apr|apr|Jun|jun|Sep|
sep|Nov|nov)))|((30|29)(?!Feb|feb))|(29(?=Feb|feb(((1[6-9]|[2-9]\
d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00
)))))|(29(?=Feb|feb(((0[48]|[2468][048]|[13579]
[26])|((16|[2468][048]|[3579][26])00)))))|(0?[1-9])|1\d|2[0-8])[- ](Jan|jan|feb|Feb|mar|Mar|may|May|apr|Apr|jul|Jul|Jun|jun|Aug|aug|
Oct|oct|Sep|sep|Nov|nov|dec|Dec)[- ]((1[6-9]|[2-9]\d)\d{2}|\d{2}|d{0})$" ControlToValidate="txtChequeDate"></asp:RegularExpressionValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style7" align="right">
                                                <label>
                                                    Cheque Amount:</label>
                                            </td>
                                            <td align="left" class="style18">
                                                <asp:TextBox ID="txtChequeAmount" CssClass="text-field" runat="server" Width="172px"
                                                    TabIndex="12" onkeyup="format(this) " onchange="format(this)" MaxLength="26"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="NUMBERS ONLY"
                                                    ForeColor="Red" ValidationGroup="RHR" InitialValue="0" ControlToValidate="txtChequeAmount"></asp:RequiredFieldValidator>
                                            </td>
                                            <td class="style19" align="right">
                                            </td>
                                            <td>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                                <asp:Panel ID="pnlPayOrder" runat="server" Visible="false">
                                    <table style="width: 712px">
                                        <tr>
                                            <td align="right" class="style7">
                                                <label>
                                                    Bank:</label>
                                            </td>
                                            <td class="style18" align="left">
                                                &nbsp;<%--<asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" Width="180px"
                                                    TabIndex="8" OnSelectedIndexChanged="cmbBank_SelectedIndexChanged">
                                                </asp:DropDownList>--%><asp:TextBox ID="txtPBankname" runat="server" CssClass="text-field"
                                                    Width="172"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="*"
                                                    ForeColor="Red" ValidationGroup="RHR" ControlToValidate="txtPBankname"></asp:RequiredFieldValidator>
                                            </td>
                                            <td align="right">
                                                <label>
                                                    Branch Name/Code:</label>
                                            </td>
                                            <td>
                                                <%--<asp:DropDownList ID="DropDownList2" Width="140px" runat="server" TabIndex="9">
                                                </asp:DropDownList>--%>
                                                <asp:TextBox ID="txtPBranchcode" runat="server" CssClass="text-field" Width="172"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <label>
                                                    PayOrder No:</label>
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="txtPayOrderNo" CssClass="text-field" runat="server" Width="172px"
                                                    TabIndex="10" MaxLength="12"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="*"
                                                    ForeColor="Red" ValidationGroup="RHR" ControlToValidate="txtPayOrderNo"></asp:RequiredFieldValidator>
                                            </td>
                                            <td align="right">
                                                <label>
                                                    PayOrder Date:</label>
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="txtPayOrderDate" CssClass="text-field" Width="140px" TabIndex="11" runat="server" OnTextChanged="txtPayOrderDate_TextChanged"></asp:TextBox>
                                                <asp:ImageButton ID="ImageButton3" runat="server" ImageUrl="~/images/Calendar.gif"
                                                    Width="20" ToolTip="Select Date" />
                                                <asp:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd-MMM-yyyy"
                                                    TargetControlID="txtPayOrderDate" PopupButtonID="ImageButton1">
                                                </asp:CalendarExtender>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="*"
                                                    ForeColor="Red" ValidationGroup="RHR" ControlToValidate="txtPayOrderDate"></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                            </td>
                                            <td>
                                            </td>
                                            <td>
                                            </td>
                                            <td>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" ValidationGroup="RHR"
                                                    SetFocusOnError="True" runat="server" ForeColor="Red" ErrorMessage="i.e (01-Jan-2012)"
                                                    ValidationExpression="^(d{0}|(31(?!(Feb|feb|Apr|apr|Jun|jun|Sep|
sep|Nov|nov)))|((30|29)(?!Feb|feb))|(29(?=Feb|feb(((1[6-9]|[2-9]\
d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00
)))))|(29(?=Feb|feb(((0[48]|[2468][048]|[13579]
[26])|((16|[2468][048]|[3579][26])00)))))|(0?[1-9])|1\d|2[0-8])[- ](Jan|jan|feb|Feb|mar|Mar|may|May|apr|Apr|jul|Jul|Jun|jun|Aug|aug|
Oct|oct|Sep|sep|Nov|nov|dec|Dec)[- ]((1[6-9]|[2-9]\d)\d{2}|\d{2}|d{0})$" ControlToValidate="txtPayOrderDate"></asp:RegularExpressionValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style7" align="right">
                                                <label>
                                                    PayOrder Amount:</label>
                                            </td>
                                            <td align="left" class="style18">
                                                <asp:TextBox ID="txtPayOrderAmount" CssClass="text-field" runat="server" Width="172px"
                                                    TabIndex="12" onkeyup="format(this) " onchange="format(this)" MaxLength="26"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ErrorMessage="NUMBERS ONLY"
                                                    ForeColor="Red" ValidationGroup="RHR" ControlToValidate="txtPayOrderAmount"></asp:RequiredFieldValidator>
                                            </td>
                                            <td class="style19" align="right">
                                            </td>
                                            <td>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                                <asp:Panel ID="pnlDemandDraft" runat="server" Visible="false">
                                    <table style="width: 712px">
                                        <tr>
                                            <td align="right" class="style7">
                                                <label>
                                                    Bank:</label>
                                            </td>
                                            <td class="style18">
                                                &nbsp;<%--<asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" Width="180px"
                                                    TabIndex="8" OnSelectedIndexChanged="cmbBank_SelectedIndexChanged">
                                                </asp:DropDownList>--%><asp:TextBox ID="txtDbankname" runat="server" CssClass="text-field"
                                                    Width="172"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*"
                                                    ForeColor="Red" ValidationGroup="RHR" ControlToValidate="txtDbankname"></asp:RequiredFieldValidator>
                                            </td>
                                            <td align="right">
                                                <label>
                                                    Branch Name/Code:</label>
                                            </td>
                                            <td>
                                                <%--<asp:DropDownList ID="DropDownList2" Width="140px" runat="server" TabIndex="9">
                                                </asp:DropDownList>--%>
                                                <asp:TextBox ID="txtDbranchcode" runat="server" CssClass="text-field" Width="172"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <label>
                                                    Demand Draft No:</label>
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="txtDdraftno" CssClass="text-field" runat="server" Width="172px"
                                                    TabIndex="10" MaxLength="12"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ErrorMessage="*"
                                                    ForeColor="Red" ValidationGroup="RHR" ControlToValidate="txtDdraftno"></asp:RequiredFieldValidator>
                                            </td>
                                            <td align="right">
                                                <label>
                                                    Demand Draft Date:</label>
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="txtDddate" CssClass="text-field" Width="140px" TabIndex="11" runat="server" OnTextChanged="txtPayOrderDate_TextChanged"></asp:TextBox>
                                                <asp:ImageButton ID="ImageButton4" runat="server" ImageUrl="~/images/Calendar.gif"
                                                    Width="20" ToolTip="Select Date" />
                                                <asp:CalendarExtender ID="CalendarExtender3" runat="server" Format="dd-MMM-yyyy"
                                                    TargetControlID="txtDddate" PopupButtonID="ImageButton1">
                                                </asp:CalendarExtender>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ErrorMessage="*"
                                                    ForeColor="Red" ValidationGroup="RHR" ControlToValidate="txtDddate"></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                            </td>
                                            <td>
                                            </td>
                                            <td>
                                            </td>
                                            <td>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator3" ValidationGroup="RHR"
                                                    SetFocusOnError="True" runat="server" ForeColor="Red" ErrorMessage="i.e (01-Jan-2012)"
                                                    ValidationExpression="^(d{0}|(31(?!(Feb|feb|Apr|apr|Jun|jun|Sep|
sep|Nov|nov)))|((30|29)(?!Feb|feb))|(29(?=Feb|feb(((1[6-9]|[2-9]\
d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00
)))))|(29(?=Feb|feb(((0[48]|[2468][048]|[13579]
[26])|((16|[2468][048]|[3579][26])00)))))|(0?[1-9])|1\d|2[0-8])[- ](Jan|jan|feb|Feb|mar|Mar|may|May|apr|Apr|jul|Jul|Jun|jun|Aug|aug|
Oct|oct|Sep|sep|Nov|nov|dec|Dec)[- ]((1[6-9]|[2-9]\d)\d{2}|\d{2}|d{0})$" ControlToValidate="txtDddate"></asp:RegularExpressionValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style7" align="right">
                                                <label>
                                                    Demand Draft Amount:</label>
                                            </td>
                                            <td align="left" class="style18">
                                                <asp:TextBox ID="txtDdamount" CssClass="text-field" runat="server" Width="172px"
                                                    TabIndex="12" onkeyup="format(this) " onchange="format(this)" MaxLength="26"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" ErrorMessage="NUMBERS ONLY"
                                                    ForeColor="Red" ValidationGroup="RHR" ControlToValidate="txtDdamount"></asp:RequiredFieldValidator>
                                            </td>
                                            <td class="style19" align="right">
                                            </td>
                                            <td>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                                <%--<asp:Panel ID="pnlCash" runat="server" Visible="false">
                                    <table>
                                        <tr>
                                            <td colspan="4">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style20" align="right">
                                                <label>
                                                    Cash Amount:</label>
                                            </td>
                                            <td align="left" class="style21">
                                                <asp:TextBox ID="txtCashAmount" CssClass="text-field" runat="server" Width="172px"
                                                    TabIndex="13">0</asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*"
                                                    ForeColor="Red" Enabled="false" InitialValue="0" ValidationGroup="RHR" ControlToValidate="txtCashAmount"></asp:RequiredFieldValidator>
                                            </td>
                                            <td>
                                            </td>
                                            <td>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>--%>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <label>
                                    Document Number:</label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtdoc" CssClass="text-field" runat="server" Width="172px" MaxLength="30"
                                    TabIndex="14"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="style17" align="right">
                                <label>
                                    Remarks:</label>
                            </td>
                            <td colspan="3">
                                <asp:TextBox ID="txtRemarks" CssClass="text-field" runat="server" Height="39px" MaxLength="250"
                                    TabIndex="14" Width="172px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <asp:GridView ID="gvInvoice" runat="server" AutoGenerateColumns="False" Width="100%"
                                    CssClass="grid-body" DataKeyNames="CollectionDetailId,SubsidiaryId" OnRowCommand="gvInvoice_RowCommand"
                                    OnRowDataBound="gvInvoice_RowDataBound">
                                    <Columns>
                                        <asp:BoundField HeaderText="Invoice #" DataField="InvoiceId" ItemStyle-Width="15%">
                                            <ItemStyle Width="15%" />
                                        </asp:BoundField>
                                        <asp:BoundField HeaderText="Invoice Date" DataField="DueDate" DataFormatString="{0:dd-MMM-yyyy}" />
                                        <asp:BoundField DataField="InvoiceAmount" HeaderText="Invoice Amount" />
                                        <asp:BoundField DataField="PaidAmount" HeaderText="Paid Amount" />
                                        <asp:BoundField HeaderText="Balance Amount" DataField="BalanceAmount" />
                                        <asp:TemplateField HeaderText="Amount Paid">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtPaid" CssClass="text-field" runat="server" AutoPostBack="true" Text='<%# Eval("AmountPaid") %>'
                                                    OnTextChanged="txtPaid_TextChanged"></asp:TextBox>
                                                <asp:FilteredTextBoxExtender ID="dsls" runat="server" FilterType="Numbers,Custom"
                                                    ValidChars="." TargetControlID="txtPaid" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:ImageButton ID="btn_del" runat="server" CausesValidation="false" CommandName="Delete"
                                                    ImageUrl="~/images/delete-icon.png" OnClick="btn_del_Click" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" align="center">
                                <asp:HiddenField ID="hdntotal" runat="server" />
                                <asp:HiddenField ID="hdnCollectionId" runat="server" />
                                <asp:HiddenField ID="hdnbalance" runat="server" />
                                <asp:HiddenField ID="hdnClientId" runat="server" />
                                <asp:ImageButton ID="btninsert" runat="server" ValidationGroup="RHR" ImageUrl="~/images/insert-button.png"
                                    OnClick="btninsert_Click" />
                                <asp:ImageButton ID="btnEdit" Visible="false" ValidationGroup="RHR" runat="server"
                                    Text="Update" OnClick="btnEdit_Click" ImageUrl="~/images/update-button.png" />
                                <asp:ImageButton ID="btncanel" runat="server" ImageUrl="~/images/cancel-button.png"
                                    OnClick="btncanel_Click" />
                                <asp:Button ID="btnShowPopup" runat="server" Style="display: none" />
                                <asp:ModalPopupExtender ID="ModalPopupExtender1" runat="server" CancelControlID="ImageButton2"
                                    TargetControlID="btnview" PopupControlID="Panel1" PopupDragHandleControlID="PopupHeader"
                                    Drag="true" BackgroundCssClass="modalBackground">
                                </asp:ModalPopupExtender>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="4">
                                <asp:Label ID="lblerror" runat="server" ForeColor="Red" Visible="false" Text="Master Amount should be equal to the Detail Amount!"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:UpdatePanel ID="updData" runat="server">
            <ContentTemplate>
                <asp:Panel ID="Panel1" runat="server" CssClass="modalPopup" Width="600px" Height="400px"
                    Style="display: none">
                    <div style="overflow: scroll; height: 400px; width: 600px; background: White">
                        <table width="100%" cellpadding="10" cellspacing="10">
                            <tr>
                                <td align="right" colspan="2">
                                    <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/images/delete-icon.png"
                                        nClick="btn_back_Click" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <label style="background-color: White">
                                        Search By&nbsp; Reference Code or Description:
                                    </label>
                                </td>
                                <td valign="top" align="left">
                                    <asp:TextBox ID="txt_search" runat="server" AutoPostBack="true" Width="250" OnTextChanged="txt_search_TextChanged"></asp:TextBox>
                                    <asp:AutoCompleteExtender ID="ace_search" TargetControlID="txt_search" ServiceMethod="GetCollection"
                                        MinimumPrefixLength="1" CompletionInterval="1" CompletionSetCount="2" runat="server"
                                        Enabled="True" ServicePath="~/BFBSS/BFGM/BFGMWebService.asmx">
                                    </asp:AutoCompleteExtender>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    <asp:GridView ID="gvCollectionView" runat="server" AutoGenerateColumns="false" Width="100%"
                                        CssClass="grid-body" OnRowCommand="gvCollectionView_RowCommand">
                                        <Columns>
                                            <asp:BoundField DataField="ReferenceCode" HeaderText="Reference Code" ItemStyle-Width="15%" />
                                            <asp:BoundField DataField="description" ItemStyle-HorizontalAlign="Left" HeaderText="Description" />
                                            <asp:BoundField DataField="CollectionDate" HeaderText="Collection Date" ItemStyle-Width="15%"
                                                DataFormatString="{0:dd-MMM-yyyy}" />
                                            <asp:BoundField DataField="ClientName" HeaderText="Client Name" />
                                            <asp:TemplateField HeaderText="Select">
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="Img_Select" runat="server" CommandArgument='<%# Eval("CollectionID") %>'
                                                        CommandName="Editrow" ImageUrl="~/images/edit-icon.png" ToolTip="Edit" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <PagerSettings Position="Bottom" />
                                        <HeaderStyle />
                                        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                        <EditRowStyle BackColor="#999999" />
                                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                        <AlternatingRowStyle BackColor=" Silver" ForeColor="#284775" />
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                    </div>
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>
    </fieldset>
</asp:Content>
