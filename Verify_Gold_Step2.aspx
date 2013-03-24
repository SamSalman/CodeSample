<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/ProfileView_NoAdd.master" AutoEventWireup="true" CodeBehind="Verify_Gold_Step2.aspx.cs" Inherits="ShiaSpouse.Verify_Gold_Step2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Level2_Menu" runat="server">

    <div style="padding-left:20px">
                <ul  class="tabs_l2Menu" >
                    <li class="" style="border-left:1px solid #6ac3e3"><a href="Mng_photo.aspx">Photo Album</a></li>
                    <li class=""><a href="My_privacy_settings.aspx">Privacy Settings</a></li>
                    <li class=""><a href="Acc_Settings.aspx">Account Settings</a></li>
                    <li class="active"><a href="Verification_Wizard.aspx">ShiaSpouse SEAL</a></li>
                    <li class=""><a href="Membership_Subscription_Profile.aspx">Membership</a></li>
                </ul>
     </div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Content" runat="server">
<script src="js/jquery.min.js" type="text/javascript"></script>
    <link href="CSS/Shia_Innerpage.css" rel="stylesheet" type="text/css" />
  <script type="text/javascript">

      function ValidateS1(sender, args) {
          args.IsValid = false;

          jQuery(".Veri_Silvr_chkbox_pr_ID").find(":checkbox").each(function () {
              if (jQuery(this).attr("checked")) {
                  args.IsValid = true;
                  return;
              }
          });
      }

      function ValidateS2(sender, args) {
          args.IsValid = false;

          jQuery(".Veri_Silvr_chkbox_sl_ID").find(":checkbox").each(function () {
              if (jQuery(this).attr("checked")) {
                  args.IsValid = true;
                  return;
              }
          });
      }

      function ValidateAddress(sender, args) {

          var Adress = document.getElementById('ctl00_Content_txt_verisilver_address1').value;
          var City = document.getElementById('ctl00_Content_txt_verisilver_address2').value;
          var Country = document.getElementById('ctl00_Content_txt_verisilver_address3').value;
          if ((Adress == "") || (City == "") || (Country == "")) {
              args.IsValid = false;
          }
          else {
              args.IsValid = true;
          }
      }



      $(document).ready(function () {

          if ($('#ctl00_Content_chk_verigold_address').attr('checked')) {
              $('#ctl00_Content_txt_verisilver_address1').attr("readonly", "readonly")
              $('#ctl00_Content_txt_verisilver_address1').css({ "background-color": "#ebebe4" });
              $('#ctl00_Content_txt_verisilver_address2').attr("readonly", "readonly")
              $('#ctl00_Content_txt_verisilver_address2').css({ "background-color": "#ebebe4" });
              $('#ctl00_Content_txt_verisilver_address3').attr("readonly", "readonly")
              $('#ctl00_Content_txt_verisilver_address3').css({ "background-color": "#ebebe4" });
          }
          else {
              $('#ctl00_Content_txt_verisilver_address1').removeAttr("readonly");
              $('#ctl00_Content_txt_verisilver_address1').css({ "background-color": "#ffffff" });
              $('#ctl00_Content_txt_verisilver_address2').removeAttr("readonly");
              $('#ctl00_Content_txt_verisilver_address2').css({ "background-color": "#ffffff" });
              $('#ctl00_Content_txt_verisilver_address3').removeAttr("readonly");
              $('#ctl00_Content_txt_verisilver_address3').css({ "background-color": "#ffffff" });
          }

          $('#ctl00_Content_chk_verigold_address').click(function () {
              if ($('#ctl00_Content_chk_verigold_address').attr('checked')) {
                  $('#ctl00_Content_txt_verisilver_address1').attr("readonly", "readonly")
                  $('#ctl00_Content_txt_verisilver_address1').css({ "background-color": "#ebebe4" });
                  $('#ctl00_Content_txt_verisilver_address2').attr("readonly", "readonly")
                  $('#ctl00_Content_txt_verisilver_address2').css({ "background-color": "#ebebe4" });
                  $('#ctl00_Content_txt_verisilver_address3').attr("readonly", "readonly")
                  $('#ctl00_Content_txt_verisilver_address3').css({ "background-color": "#ebebe4" });
              }
              else {
                  $('#ctl00_Content_txt_verisilver_address1').removeAttr("readonly");
                  $('#ctl00_Content_txt_verisilver_address1').css({ "background-color": "#ffffff" });
                  $('#ctl00_Content_txt_verisilver_address2').removeAttr("readonly");
                  $('#ctl00_Content_txt_verisilver_address2').css({ "background-color": "#ffffff" });
                  $('#ctl00_Content_txt_verisilver_address3').removeAttr("readonly");
                  $('#ctl00_Content_txt_verisilver_address3').css({ "background-color": "#ffffff" });
              }
          });


      });

        
  </script>

  <div style="height:1200px">
    <div>
        <ul class="tabs">
             <li class="active" ><a href="#tab1">ShiaSpouse SEAL</a></li>
        </ul>
    </div>
    
    <div class="VerifySilver_main">
        <div class="VerifyBlue_Heading"><span class="VWH_NavyBlue">Gold</span> <span class="VWH_LightBlue">Seal</span></div>
        <div class="Verifyblue_heading_content">
            Follow the 4 steps below to confirm your ID. You will have to provide a minimum 
            of 2 different supporting documents to confirm your ID</div>
        <div class="VeriBlue_Icon">
            <div style="text-align:center"><img src="images/Veri_Gold.gif" /></div>
            <div class="Ver_Side_Unactive">Completed profile&nbsp<asp:Image ID="img_step0" ImageUrl="~/images/Approve_arrow.jpg" runat="server" /></div>
            <div class="Ver_Side_Unactive">Confirm Contact Details&nbsp<asp:Image ID="img_step1" ImageUrl="~/images/Approve_arrow.jpg" runat="server" /></div>
            <div class="Ver_Side_Active">Confirm Id</div>
            <div class="Ver_Side_Unactive">Paid Member</div>
        </div>
        
         <div class="Veri_Silver_GreyBox">
          <div style="height:220px;width:650px">
                <div style="margin:45px 0 0 25px">      
                         <ul>
                            <li class="veri_list1"> <span class="Veri_Blue_Brown_pointer">Confirm your photo and details of your ID:</span></li>
                        </ul>       
                </div>
                <div style="display:block; float:left; width:338px; margin-left:80px; margin-top:10px;">
                    <table>
                        <tr>
                            <td class="Veri_Blue_box_questions">
                                Full name
                            </td>
                            <td>
                                <asp:TextBox ID="txt_verigold_name" Enabled="false" CssClass="Veri_txt_box" runat="server" Width="170px"></asp:TextBox>
                                &nbsp<asp:LinkButton ID="li_edit_name" runat="server" CausesValidation="false"
                                    onclick="li_edit_name_Click">edit</asp:LinkButton> 
                            </td>
                        </tr>
                       
                         
                        <tr>
                            <td class="Veri_Blue_box_questions">
                                Date of birth
                            </td>
                            <td>
                                <asp:TextBox ID="txt_verisilver_dob_day" Enabled="false" CssClass="Veri_txt_box_dob" runat="server" Width="52px"></asp:TextBox> 
                                <asp:TextBox ID="txt_verisilver_dob_MM" Enabled="false" CssClass="Veri_txt_box_dob" runat="server" Width="52px"></asp:TextBox> 
                                <asp:TextBox ID="txt_verisilver_dob_YY" Enabled="false" CssClass="Veri_txt_box_dob" runat="server" Width="54px"></asp:TextBox>
                                 &nbsp<asp:LinkButton ID="li_edit_dob" runat="server" CausesValidation="false"
                                    onclick="li_edit_dob_Click">edit</asp:LinkButton> 
                            </td>
                         </tr>
                  
                        <tr>
                            <td class="Veri_Blue_box_questions">
                                Address
                            </td>
                            <td>
                                <asp:TextBox ID="txt_verisilver_address1" CssClass="Veri_txt_box" runat="server" Width="170px"></asp:TextBox>
                                <asp:CheckBox ID="chk_verigold_address" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="Veri_Blue_box_questions">
                            City
                            </td>
                            <td>
                               <asp:TextBox ID="txt_verisilver_address3" CssClass="Veri_txt_box" runat="server" Width="170px"></asp:TextBox>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td class="Veri_Blue_box_questions">
                            Country
                            </td>
                                <td>
                                    <asp:TextBox ID="txt_verisilver_address2" CssClass="Veri_txt_box" runat="server" Width="170px"></asp:TextBox> 
                                </td>
                            <td>
                            </td>
                        </tr>
                           <tr>
                            <td class="Veri_Blue_box_questions">
                           
                            </td>
                                <td>
                                    <asp:CustomValidator ID="Val_Add" runat="server" ClientValidationFunction="ValidateAddress" Display="Dynamic" ErrorMessage="'Address required'"  CssClass="reg_validation" ForeColor="#0C528D"></asp:CustomValidator>
                                    <asp:Label ID="lbl_confirm_address" Visible="false" CssClass="reg_validation" runat="server" Text="Label"></asp:Label>
                                </td>
                            <td>
                            </td>
                        </tr>
                    </table> 
                </div>
                <div style="display:block; float:left; width:200px; margin-top:15px">
            
                <table>
                    <tr>
                       <td class="Veri_Blue_box_questions" style="padding-left:27px;">
                                Photo ID
                       </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Image ID="imgDP" runat="server" BorderColor="White" BorderStyle="Solid" BorderWidth="5px" ImageAlign="Left" ImageUrl="images/veriSilver_photoID.jpg" 
                                Height="130px" Width="100px" /><asp:HiddenField ID="H_photoid" runat="server" />
                        </td>
                    </tr>
                     <tr>
                        <td>
                             <asp:FileUpload ID="selectfile" runat="server" Width="171px" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:ImageButton ID="btnupload" ImageAlign="Left" ImageUrl="images/MP_Upl_Upload_btn.jpg" CausesValidation="false" OnClick="btnupload_Click" runat="server" />
                         <asp:ImageButton ID="btnremove" runat="server" 
                                ImageUrl="images/MP_Upl_Remove_btn.jpg" CausesValidation="false" onclick="btnremove_Click"   />
                        
                        </td>
                   </tr>
                   <tr>
                   
                      <td><asp:Label ID="lb_photo_er_type" Visible="false" CssClass="reg_validation" runat="server" Text="Label"></asp:Label></td>
                   </tr>
                </table>
            
                </div>
            </div>
            
            <div style="border-bottom: 1px solid #ffffff; margin-top: 70px">
            </div>
            <table style="margin: 18px 0 0 25px">
                <tr>
                    <td colspan="3" style="margin-left: 25px">
                        <ul>
                            <li class="veri_list2"> <span class="Veri_Blue_Brown_pointer">Tick the ID information for which you will be providing supporting <br /> documentation for:</span></li>
                        </ul>
                    </td>
                </tr>
                <tr>
                    <td style="padding: 8px 0 0 80px">
                        <asp:CheckBoxList ID="chk_verisilver_step2" CssClass="Veri_Silvr_chkbox_pr_ID" runat="server"
                            CellPadding="2" CellSpacing="6" RepeatDirection="Horizontal" >
                            <asp:ListItem Value="1">Full name</asp:ListItem>
                            <asp:ListItem Value="2">Date of birth</asp:ListItem>
                            <asp:ListItem Value="3">Address</asp:ListItem>
                            <asp:ListItem Value="4">Photo ID</asp:ListItem>
                        </asp:CheckBoxList>
                    </td>
                </tr>
                <tr>
                    <td style="padding: 8px 0 0 80px">
                         <asp:CustomValidator id="cvEventsValidator" Display="static"  runat="server" CssClass="reg_validation" ForeColor="#0C528D" ErrorMessage="‘Tick the ID information below for which you will be providing'" ClientValidationFunction="ValidateS1"></asp:CustomValidator>
                        <br /><asp:Label ID="lbl_photoid_err" CssClass="reg_validation" Visible="false" ForeColor="#0C528D" runat="server" Text="Label"></asp:Label>
                    </td>
                </tr>
            </table>
            <div style="border-bottom: 1px solid #ffffff; margin-top: 16px">
            </div>
            <table style="margin: 18px 0 0 25px">
                <tr>
                    <td colspan="3">
                          <ul>
                            <li class="veri_list3"><span class="Veri_Blue_Brown_pointer">Select the 2 documents that you will upload as supporting documents <br /> for the proof of your ID:</span></li>
                        </ul>
                    </td>
                </tr>
                <tr>
                    <td style="padding: 8px 0 0 80px">
                        <asp:CheckBoxList ID="Chk_verisilver_step3" CssClass="Veri_Silvr_chkbox_sl_ID" runat="server"
                            CellPadding="2" CellSpacing="6" RepeatDirection="Horizontal" RepeatColumns="4">
                            <asp:ListItem Value="1">ID Card</asp:ListItem>
                            <asp:ListItem Value="2">Passport</asp:ListItem>
                            <asp:ListItem Value="3">Birth certificate</asp:ListItem>
                            <asp:ListItem Value="4">Driving license</asp:ListItem>
                            <asp:ListItem Value="5">Bank statement</asp:ListItem>
                            <asp:ListItem Value="6">Utility Bills</asp:ListItem>
                            <asp:ListItem Value="7">Others</asp:ListItem>
                        </asp:CheckBoxList>
                       </td> </tr>

                <tr>
                    <td style="padding: 8px 0 0 80px"> 
                      <asp:Label ID="lbl_er_st3" Visible="false"  CssClass="reg_validation" runat="server" Text="Label"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="height: 15px">
                    </td>
                </tr>
            </table>
            <div style="border-bottom: 1px solid #ffffff; margin-top: 16px">
            </div>
            <div style="height:220px;width:650px">
                <div style="margin:45px 0 0 25px">      
                       <ul>
                            <li class="veri_list4"><span class="Veri_Blue_Brown_pointer">  <span class="Veri_Blue_Brown_pointer">Upload the 2 
                                parts of information that you have
                            chosen above:</span></li>
                        </ul>
                </div>
                <div style="display:block; float:left; width:338px; margin-left:150px; margin-top:10px;">
                    <table>
                        <tr>
                            <td colspan="3"> <asp:FileUpload ID="selectfile2" runat="server" /></td>
                        </tr>
                        <tr>
                            <td><asp:ImageButton ID="btnupload2" OnClick="btnupload2_Click" CausesValidation="false" ImageAlign="Middle" ImageUrl="~/images/Upload_File_Btn.jpg"
                            runat="server"/></td>
                            <td><asp:TextBox ID="txt_file_1" ReadOnly="true" CssClass="Veri_txt_box" runat="server"></asp:TextBox></td>
                              <td><asp:ImageButton ID="btn_remove1" ImageAlign="Middle" ImageUrl="~/images/Remove_File_Btn.jpg" OnClick="btn_remove1_Click" runat="server"/></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td><asp:TextBox ID="txt_file_2" ReadOnly="true" CssClass="Veri_txt_box" runat="server"></asp:TextBox></td>
                            <td><asp:ImageButton ID="btn_remove2" ImageAlign="Middle" ImageUrl="~/images/Remove_File_Btn.jpg" OnClick="btn_remove2_Click" runat="server"/></td>
                        </tr>
                          <tr>
                            <td></td>
                            <td><asp:TextBox ID="txt_file_3" ReadOnly="true" CssClass="Veri_txt_box" runat="server"></asp:TextBox></td>
                             <td><asp:ImageButton ID="btn_remove3" ImageAlign="Middle" ImageUrl="~/images/Remove_File_Btn.jpg" OnClick="btn_remove3_Click" runat="server"/></td>
                        </tr>
                          <tr>
                            <td></td>
                            <td><asp:TextBox ID="txt_file_4" ReadOnly="true" CssClass="Veri_txt_box" runat="server"></asp:TextBox></td>
                            <td><asp:ImageButton ID="btn_remove4" ImageAlign="Middle" ImageUrl="~/images/Remove_File_Btn.jpg" OnClick="btn_remove4_Click" runat="server"/></td>
                        </tr>
                    </table>
                      <asp:HiddenField ID="H_f_1" runat="server" />
                    <asp:HiddenField ID="H_f_2" runat="server" />
                    <asp:HiddenField ID="H_f_3" runat="server" />
                    <asp:HiddenField ID="H_f_4" runat="server" />
                      
                      <asp:Label ID="lbl_er_st4" Visible="false" CssClass="reg_validation" runat="server" Text="Label"></asp:Label>
                </div>



             </div>
            
        </div>
        <div class="verisilver_submit_btn">
            <%--<img src="images/verisilver_submit_btn.jpg" />--%>
            <asp:ImageButton ID="btn_slver_next" OnClick="btn_slver_next_Click" ImageUrl="~/images/Next.png" runat="server" />
        </div>
        <div style="float:left;margin:35px 0px 0px 500px; ">
             
        </div>
    </div>
   </div>


</asp:Content>
