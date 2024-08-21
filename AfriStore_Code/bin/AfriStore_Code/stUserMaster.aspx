<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" EnableEventValidation="false"  CodeBehind="stUserMaster.aspx.cs" Inherits="stUserMaster" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    

<script type="text/javascript">

         function ShowImage(input) {
             if (input.files && input.files[0]) {

                 var reader = new FileReader();
                 reader.onload = function (e) {
                     $('#<%=ImgUser.ClientID%>').prop('src', e.target.result)
                        .width(125)
                        .height(160);
                };
                 reader.readAsDataURL(input.files[0]);
                
                }
         }
</script>

<asp:UpdatePanel runat ="server" ID="UpdatePanel1">       
<Triggers> <asp:PostBackTrigger ControlID="btnSaveAddUser" /></Triggers>
<Triggers>  <asp:AsyncPostBackTrigger ControlID="grdUserDetails" />   </Triggers>
<ContentTemplate>


 <div class="emov-page-container emov-step-wrapper">
  
                 
     <!-- Main Panel -->
     <asp:Panel ID="pnlMain" runat="server"   style="display:block">

     <div id="div_main" runat="server" class="emov-page-main emov-page-main-no-top-padding">
     <!-- Header Menu-->
    <div class="emov-a-rc-header emov-a-rc-header-seun">
     <!-- Page Title-->
    <div  class="emov-header-page-title emov-header-page-title-table-vigo"   id="emov-application-title">
        <h3 style="font-size:25px;" class="emov-applications-title">Application Users Details</h3>
        <!-- Total Count-->
        <div class="emov-a-header-counter">  <p><asp:Label ID="lbl_total" runat="server"></asp:Label> Total</p>   </div>  
    </div>

    <div class="emov-a-header-action-group">
    <div class="emov-t-actions-group" style="display:block;">
  
    <table id="btnOpt" runat="server" style="width:100%; display:block">
    <tr> 
    <td><input type="text" id="txtSearch" runat="server" class="emov-a-header-input" placeholder="Login ID / First Name / Last Name" /></td>
    <td></td>
    <td><button id="btnSearch" type="button" runat="server" class="emov-dash-icon-cover1" style="margin-right: 10px;"   onserverclick="BtnSearchOpt" >SEARCH <i class="fa fa-search" aria-hidden="true"></i></button></td>      
    <td><button id="btnAddCountry" type="button" runat="server" class="emov-dash-icon-cover1" style="margin-right: 10px;" onserverclick="BtnAddOpt" >ADD <i class="fa fa-plus" aria-hidden="true"></i> </button></td>      
    <td><button id="btnUpdate" type="button" runat="server"  class="emov-dash-icon-cover1" style="margin-right: 10px;"   onserverclick="BtnEditOpt"  >Edit <i class="fa fa-edit" aria-hidden="true"></i></button></td> 
    </tr>
    </table>
                   

    </div> </div>

    </div>

    <!-- Data Grid Design-->
    <div class="emov-a-rc-table-cover">
                          
    <div id="div_search_results" runat="server">
    <!-- table within data grid-->
    <table style="width:100%; margin-top:-4%;" >
                              
    <caption>
    <br />
    <tr>
    <td></td>
    </tr>
    <tr>
    <td>
    <br />
    </td>
    </tr>
    <tr>
    <td>
    <div>
    <table style="width:100%;">
    <tr>
    <td>
    <div style="overflow-x:scroll; text-align:center">
       <%-- --[CountryCode] ,[CountryName],[Nationality],[Ncode]--%>
        <asp:GridView ID="grdUserDetails" runat="server" AllowPaging="true" AllowSorting="true" AutoGenerateColumns="False" Border="0px" BorderColor="White" CssClass="emov-a-table-data" 
        OnPageIndexChanging="grdUserDetails_PageIndexChanging" PageSize="10" ShowHeaderWhenEmpty="true" Width="100%" 
        OnRowCommand="grdUserDetails_RowCommand" 
        OnRowDataBound="grdUserDetails_RowDataBound"
        OnSelectedIndexChanged="grdUserDetails_SelectedIndexChanged">
        <AlternatingRowStyle />
        <Columns>
        <asp:TemplateField HeaderStyle-CssClass="emov-a-table-heading" HeaderText="First Name">
        <ItemTemplate>
        <asp:Label ID="lblFirst_Namee" runat="server" Text='<%# Bind("First_Name") %>'></asp:Label>
        </ItemTemplate>
        <ItemStyle HorizontalAlign="Center" />
        </asp:TemplateField>
        <asp:TemplateField HeaderStyle-CssClass="emov-a-table-heading" HeaderText="Last Name">
        <ItemTemplate>
        <asp:Label ID="lblLast_Name" runat="server" Text='<%# Bind("Last_Name") %>'></asp:Label>
        </ItemTemplate>
        <ItemStyle HorizontalAlign="Center" />
        </asp:TemplateField>
        <asp:TemplateField HeaderStyle-CssClass="emov-a-table-heading" HeaderText="Login ID">
        <ItemTemplate>
        <asp:Label ID="lblUserName" runat="server" Text='<%# Bind("UserName") %>'></asp:Label>
        </ItemTemplate>
        <ItemStyle HorizontalAlign="Left" />
        </asp:TemplateField>
       
        <asp:TemplateField HeaderStyle-CssClass="emov-a-table-heading" HeaderText="Gender">
        <ItemTemplate>
        <asp:Label ID="lblGender" runat="server" Text='<%# Bind("Gender") %>'></asp:Label>
        </ItemTemplate>
        <ItemStyle HorizontalAlign="Center" />
        </asp:TemplateField>
        <asp:TemplateField HeaderStyle-CssClass="emov-a-table-heading" HeaderText="Login Status">
        <ItemTemplate>
        <asp:Label ID="lblLoginStatus" runat="server" Text='<%# Bind("LoginStatus") %>'></asp:Label>
        </ItemTemplate>
        <ItemStyle HorizontalAlign="Center" />
        </asp:TemplateField>
        <asp:TemplateField HeaderStyle-CssClass="emov-a-table-heading" HeaderText="Group Name">
        <ItemTemplate>
        <asp:Label ID="lblGroupName" runat="server" Text='<%# Bind("GroupName") %>'></asp:Label>
        </ItemTemplate>
        <ItemStyle HorizontalAlign="Left" />
        </asp:TemplateField>


        </Columns>
        <HeaderStyle CssClass="emov-a-home-table" />
        <PagerStyle Height="100px" />
        <RowStyle CssClass="emov-a-table-data" />
        <EditRowStyle CssClass="emov-a-table-data" />
        <EmptyDataTemplate>
        <div style="text-align:center;">
        No records found.</div>
        </EmptyDataTemplate>
        </asp:GridView>

    </div>
    </td>
    </tr>
  
    </table>
    </div>
    </td>
    </tr>
    </caption>
    </table>
    </div>

    </div>
          
            </div>
     </asp:Panel>    
     
      <!-- Message Div -->
      <div  class="my-notify-error"  runat="server" id="DivMsg" style="margin-top:1%;width:100%;text-align:left; display:none;">   </div>

     <!-- Add Add Name -->      
        <asp:Panel ID="pnlAddDiv" runat="server"   style="display:none">
            
        <div id="DivAdd" runat="server"  class="emov-page-main emov-page-main-no-top-padding"  width="100%"    >
          <!-- Pofile Blue Div -->
        <div class="emov-a-single-profile-cover">
       
        <!-- Pofile Photo -->
        <img id="ImgUser" src="Content/assets/images/UserImage.gif" runat="server" alt="" style="margin-bottom:11px; border-radius:12px; width:125px; height:155px;" />
        <!-- ApplicantID Photo -->                                     
        <div class="emov-a-single-user-uid-box">                         
        <p>  <label class="btn btn-info btn-lg" >
        <i class="fas fa-folder-open"></i> Upload Photo <asp:FileUpload ID="FileUpload1"  runat="server" Style="display: none;" onchange="ShowImage(this);"></asp:FileUpload>
      <%--  <asp:RequiredFieldValidator ErrorMessage="Required" ControlToValidate="FileUpload1"   runat="server" Display="Dynamic" ForeColor="Red" EnableClientScript="true" ValidationGroup="File" />    --%>
        <asp:RegularExpressionValidator ID="ValidateEx" runat="server"   ForeColor="Red"  ValidationExpression="^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w].*))(.jpg|.JPG|.gif|.GIF|.png|.PNG|.jpeg|.JPEG)$" ControlToValidate="FileUpload1" ValidationGroup="File" ErrorMessage="Please select a Photo Jpegs, Pdf, png, and Gifs only"></asp:RegularExpressionValidator>
        </label> </p> 
        </div>  
        </div>


        <!-- White Div -->
        <div class="emov-a-profile-full-info" style="background: white">
         <%--  Add User Master ---%>
        <div class="emov-a-single-user-card-cover">   
            <!--changes -->
        <div class="emov-a-single-user-card-header" >    <h2 class="h2label">Add User Master Details</h2>   </div>
        <div class="emov-a-single-user-card-inner-info">          
         
        <table class="emov-a-table-data1" >            
        <tr>   
            <td colspan="5" style="height:8px;"></td>
        </tr>
        
        <%--FirstName & LastName--%>
        <tr>
        <td style="width:20%;"><p>First Name* :</p></td>
        <td style="width:20%;"><p><asp:TextBox runat="server" class="emov-a-slot-creation-time-input emov-a-header-input-mob"  AutoPostBack="false"  type="text"   ID="txtFirstName" />
              <asp:RequiredFieldValidator ID="RequiredFieldValidator11" ErrorMessage="First Name is required!" Display="Dynamic" ForeColor="Red"   ControlToValidate="txtFirstName" ValidationGroup="AddSign" runat="server" />   </p></td>
        <td style="width:20%"></td>
        <td style="width:20%;"><p>Last Name* :</p></td>
        <td style="width:20%;"><p><asp:TextBox runat="server" class="emov-a-slot-creation-time-input emov-a-header-input-mob"  AutoPostBack="false"  type="text"   ID="txtLastName" /> 
              <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ErrorMessage="Last Name is required!" Display="Dynamic" ForeColor="Red"   ControlToValidate="txtLastName" ValidationGroup="AddSign" runat="server" />   </p></td>
        </tr>
        
        <tr>
        <td colspan="5" style="height:8px;"></td>
        </tr>
        <%--Login ID & Gender--%>
        <tr>
        <td><p>Login ID* :</p></td>
        <td><p><asp:TextBox runat="server" class="emov-a-slot-creation-time-input emov-a-header-input-mob"  AutoPostBack="false"  type="text"   ID="txtLoginID" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ErrorMessage="Login ID is required!" Display="Dynamic" ForeColor="Red"   ControlToValidate="txtLoginID" ValidationGroup="AddSign" runat="server" /></p></td>
         <td style="width:20%"></td>      
        <td><p>Gender* :</p></td>
        <td><p><asp:DropDownList class="emov-a-slot-creation-time-input emov-a-header-input-mob" name="Gender" width="100%"  ID="drpGender" runat="server">
        <asp:ListItem Value="0" Selected disabled>--Select Gender--</asp:ListItem>
        <asp:ListItem Value="M">Male</asp:ListItem>
        <asp:ListItem Value="F">Female</asp:ListItem>
        </asp:DropDownList>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ErrorMessage="Gender is required!" Display="Dynamic" ForeColor="Red"  ControlToValidate="drpGender" InitialValue="0"  ValidationGroup="AddSign" runat="server" />
        </p></td>
        </tr>

        <tr>
        <td colspan="5" style="height:8px;"></td>                                              
        </tr>
         <%--Passpord & Status--%>
        <tr>
        <td><p>Passowrd* :</p></td>
        <td><p><asp:TextBox runat="server" class="emov-a-slot-creation-time-input emov-a-header-input-mob"  AutoPostBack="false"  type="password"   ID="txtPassword" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" ErrorMessage="Password ID is required!" Display="Dynamic" ForeColor="Red"   ControlToValidate="txtPassword" ValidationGroup="AddSign" runat="server" /> </p></td>
        <td style="width:51px;"></td>
        <td><p>Status* :</p></td>
        <td><p><asp:DropDownList class="emov-a-slot-creation-time-input emov-a-header-input-mob" name="Gender" width="100%"  ID="drpStatus" runat="server">
        <asp:ListItem Value="2" Selected disabled>--Select Status--</asp:ListItem>
        <asp:ListItem Value="1">Active</asp:ListItem>
        <asp:ListItem Value="0">Deactive</asp:ListItem>
        </asp:DropDownList>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ErrorMessage="Login status is required!" Display="Dynamic" ForeColor="Red"  ControlToValidate="drpStatus" InitialValue="2"  ValidationGroup="AddSign" runat="server" />
        </p></td>
        </tr>


        <tr>   
            <td colspan="5" style="height:8px;"></td>
        </tr>
        <%--Designation No & Location --%>
        <tr>
        <td><p><span>Designation*:</span></p></td>
        <td><p><asp:TextBox runat="server" class="emov-a-slot-creation-time-input emov-a-header-input-mob"  AutoPostBack="false"  type="text"   ID="txtDesignation" /> 
             <asp:RequiredFieldValidator ID="RequiredFieldValidator12" ErrorMessage="Designation is required!" Display="Dynamic" ForeColor="Red"   ControlToValidate="txtDesignation" ValidationGroup="AddSign" runat="server" />  </p></td>
        <td style="width:51px;"></td>
        <td><p>Location* :</p></td>
        <td><p><asp:TextBox runat="server" class="emov-a-slot-creation-time-input emov-a-header-input-mob"  AutoPostBack="false"  type="text"   ID="txtLocation" /> 
             <asp:RequiredFieldValidator ID="RequiredFieldValidator13" ErrorMessage="Location is required!" Display="Dynamic" ForeColor="Red"   ControlToValidate="txtLocation" ValidationGroup="AddSign" runat="server" />  </p></td>
        </tr>       

        <tr>   
            <td colspan="5" style="height:8px;"></td>
        </tr>
    
        <%--Group Name  --%>
        <tr>
        <td><p><span>Group Name* :</span></p></td>
        <td><p><asp:DropDownList class="emov-a-slot-creation-time-input emov-a-header-input-mob"  width="100%"   ID="drpGroupName" runat="server">   </asp:DropDownList>
               <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ErrorMessage="Country is required!" Display="Dynamic" ForeColor="Red"  ControlToValidate="drpGroupName" InitialValue="0"  ValidationGroup="AddSign" runat="server" /> </p></td>
        <td style="width:51px;"></td>
        <td><p></p></td>
        <td><p>  </p></td>
        </tr> 

            
        <tr>
        <td colspan="5" style="height:8px;"></td>                                              
        </tr>
        <%--Mobile No & Email --%>
        <tr>
        <td><p  style="margin-left: 5px;position: relative;top: -15px;">Mobile No* :</p></td>
        <td><p><asp:TextBox runat="server" class="emov-a-slot-creation-time-input emov-a-header-input-mob"  AutoPostBack="false"  type="text"   ID="txtMobileNo" /> 
            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" ErrorMessage="Mobile No. is required!" Display="Dynamic" ForeColor="Red"   ControlToValidate="txtMobileNo" ValidationGroup="AddSign" runat="server" />  
              <asp:RegularExpressionValidator ID="rvDigits" runat="server" ControlToValidate="txtMobileNo" ErrorMessage="Enter numbers only till 11 digit" ValidationGroup="AddSign"   ForeColor="Red" ValidationExpression="[0-9]{11}" />   </p></td>
        <td style="width:51px;"></td>
        <td><p  style="margin-left: 5px;position: relative;top: -15px;">Email* :</p></td>
        <td><p><asp:TextBox runat="server" class="emov-a-slot-creation-time-input emov-a-header-input-mob"  AutoPostBack="false"  type="text"   ID="txtEmail" /> 
            <asp:RequiredFieldValidator ID="RequiredFieldValidator10" ErrorMessage="Emaild Address is required!" Display="Dynamic" ForeColor="Red"   ControlToValidate="txtEmail" ValidationGroup="AddSign" runat="server" />         
            <asp:RegularExpressionValidator ID="regexEmailValid" runat="server" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"  ControlToValidate="txtEmail"   ValidationGroup="AddSign"   ForeColor="Red" ErrorMessage="Invalid Email Format"></asp:RegularExpressionValidator>   </p></td>
        </tr>
            
        <tr>   
            <td colspan="5" style="height:8px;"></td>
        </tr>
            
        <tr>   
            <td colspan="3" style="height:8px;"></td>
            <td>  
            <div  class="emov-a-single-user-final-actions-box emov-a-single-user-final-actions-box-login" style="margin-top:0px;"  > 
                <asp:Button ID="btnBackAddUser" runat="server" Text="BACK" Visible="true" style="float: right;" class="login-btn"     OnClick="btnBackAddUser_Click"/>   </div> 
            </td>
            <td> 
            <div class="emov-a-single-user-final-actions-box emov-a-single-user-final-actions-box-login" style="margin-top:0px;"  > 
                <asp:Button ID="btnSaveAddUser" runat="server" Text="SAVE" Visible="true" style="float: right;" class="login-btn"   ValidationGroup="AddSign"   OnClick="btnSaveAddUser_Click"/> </div>
            </td>
        </tr>

        </table>
        
        </div>
            </div> </div> </div>
      
        </asp:Panel>    

     
        

         <!-- View UserDetails  Panel -->    
        <asp:Panel ID="pnlViewDiv" runat="server"   style="display:none;">
             <!-- Add USer SLIDE IN -->
       
        <div id="divView" runat="server"  class="emov-page-main emov-page-main-no-top-padding"  width="100%"    >
        <!-- Pofile Blue Div -->
        <div class="emov-a-single-profile-cover">       
        <!-- Pofile Photo -->
        <img id="UserImage" src="Content/assets/images/UserImage.gif" runat="server" alt="" style="margin-bottom:11px; border-radius:12px; width:125px; height:155px;" />
        <!-- EmployeeID Photo -->                                     
        <div class="emov-a-single-user-uid-box">   <p><asp:Label ID="lblLoginID" runat="server" Text="" ></asp:Label></p>   </div>  
        </div>

        <!-- White Div -->
        <div class="emov-a-profile-full-info" style="background: white">
        <div class="emov-a-single-user-card-cover">
        <%--  User Data ---%>
        <div class="emov-a-single-user-card-header" >    <h2 class="h2label">View User Master Details</h2>   </div>
        <div class="emov-a-single-user-card-inner-info">          
         
        <table class="emov-a-table-data1" >            
       
        <tr>
        <td colspan="5" style="height:8px;"></td>
        </tr>

        <tr>
        <td style="width:20%;"><p>First Name:</p></td>
        <td style="width:20%;"><p><asp:Label ID="lblFirst_Name" runat="server" Text=""  Height="1px"></asp:Label></p></td>
        <td style="width:20%"></td>
        <td style="width:20%;"><p>Last Name:</p></td>
        <td style="width:20%;"><p><asp:Label ID="lblLast_Name" runat="server" Text=""  Height="1px"></asp:Label></p></td>
        </tr>
     
        <tr>
        <td colspan="5" style="height:8px;"></td>
        </tr>

        <tr>
        <td><p>Login ID:</p></td>
        <td><p><asp:Label ID="lblUserName1" runat="server" Text="" Height="1px"></asp:Label></p></td>
        <td style="width:20%"></td>      
        <td><p>Gender:</p></td>
        <td><p><asp:Label ID="lblGender" runat="server" Text="" Height="1px"></asp:Label></p></td>
        </tr>

        <tr>
        <td colspan="5" style="height:8px;"></td>                                              
        </tr>
           
        <tr>
        <td><p>Passowrd:</p></td>
        <td style="width:120px;"><p><asp:Label ID="lblPassword" runat="server" Text="" Height="1px"></asp:Label> </p></td>
        <td style="width:51px;"></td>
        <td><p>Status:</p></td>
        <td><p><asp:Label ID="lblSatatus" runat="server" Text="" Height="1px"></asp:Label>  </p></td>
        </tr>


        <tr>   
            <td colspan="5" style="height:8px;"></td>
        </tr>
          <%--  ,Location,CreatedOn,UpdatedOn,CreatedBy,UpdatedBy,IFlag,UserImage,GroupID,GroupCode ,GroupName--%>
        <tr>
        <td><p><span>Designation</span></p></td>
        <td><p><asp:Label ID="lblDesignation" runat="server" Text="" Height="1px"></asp:Label></p></td>
        <td style="width:51px;"></td>
        <td><p>Location:</p></td>
        <td><p><asp:Label ID="lblLocation" runat="server" Text="" Height="1px"></asp:Label></p></td>
        </tr>       

        <tr>   
            <td colspan="5" style="height:8px;"></td>
        </tr>
    
        <tr>
        <td><p><span>Group Name</span></p></td>
        <td><p><asp:Label ID="lblGroupName" runat="server" Text="" Height="1px"></asp:Label></p></td>
        <td style="width:51px;"></td>
        <td><p></p></td>
        <td><p></p></td>
        </tr>  
            
            
        <tr>
        <td colspan="5" style="height:8px;"></td>                                              
        </tr>

        <tr>
        <td><p>Mobile No:</p></td>
        <td><p><asp:Label ID="lblMobileNo" runat="server" Text="" Height="1px"></asp:Label></p></td>
        <td style="width:51px;"></td>
        <td><p>Email:</p></td>
        <td><p><asp:Label ID="lblEmail" runat="server" Text="" Height="1px">  </asp:Label></p></td>
        </tr>

        <tr>   
            <td colspan="5" style="height:8px;"></td>
        </tr>

             
       <tr>   
        <td colspan="4" style="height:8px;"></td>
        <td> 
        <div  class="emov-a-single-user-final-actions-box emov-a-single-user-final-actions-box-login" style="margin-top:0px;"  > 
            <asp:Button ID="BtnBackFind" runat="server" Text="BACK" style="float: right;" Visible="true" class="login-btn"     OnClick="BtnBackFind_Click"/>   </div> 
        </td>
       </tr>

        </table>
        </div>             </div>       </div>
            
        </div> 
    
         </asp:Panel>



      
     <!-- Edit Add Name -->      
        <asp:Panel ID="pnlEdit" runat="server"   style="display:none">
            
        <div id="DivEdit" runat="server"  class="emov-page-main emov-page-main-no-top-padding"  width="100%"    >

        <!-- Pofile Blue Div -->
        <div class="emov-a-single-profile-cover">       
        <!-- Pofile Photo -->
        <img id="ImgEdit" src="Content/assets/images/UserImage.gif" runat="server" alt="" style="margin-bottom:11px; border-radius:12px; width:125px; height:155px;" />                                  
        <!-- EmployeeID Photo -->                                     
        <div class="emov-a-single-user-uid-box">   <p><asp:Label ID="lblEEmployeeID" runat="server" Text="" ></asp:Label></p>   </div>  
        </div>


        <!-- White Div -->
        <div class="emov-a-profile-full-info" style="background: white">

         <%--  Add User Master ---%>
        <div class="emov-a-single-user-card-cover">      
        <div class="emov-a-single-user-card-header" >    <h2>Edit User Master Details</h2>   </div>
        <div class="emov-a-single-user-card-inner-info">          
         
        <table class="emov-a-table-data1" >
            
        <tr>   
            <td colspan="5" style="height:8px;"></td>
        </tr>
        
        <%--FirstName & LastName--%>
        <tr>
        <td style="width:20%;"><p>First Name:</p></td>
        <td style="width:20%;"><p><asp:TextBox runat="server" class="emov-a-slot-creation-time-input emov-a-header-input-mob"  AutoPostBack="false"  type="text"   ID="txtEFirstName" />
              <asp:RequiredFieldValidator ID="RequiredFieldValidator15" ErrorMessage="First Name is required!" Display="Dynamic" ForeColor="Red"   ControlToValidate="txtEFirstName" ValidationGroup="AddSign1" runat="server" />   </p></td>
        <td style="width:20%"></td>
        <td style="width:20%;"><p>Last Name:</p></td>
        <td style="width:20%;"><p><asp:TextBox runat="server" class="emov-a-slot-creation-time-input emov-a-header-input-mob"  AutoPostBack="false"  type="text"   ID="txtELastName" /> 
              <asp:RequiredFieldValidator ID="RequiredFieldValidator16" ErrorMessage="Last Name is required!" Display="Dynamic" ForeColor="Red"   ControlToValidate="txtELastName" ValidationGroup="AddSign1" runat="server" />   </p></td>
        </tr>
        
        <tr>
        <td colspan="5" style="height:8px;"></td>
        </tr>
        <%--Login ID & Gender--%>
        <tr>
        <td><p>Login ID:</p></td>
        <td><p><asp:TextBox runat="server" class="emov-a-slot-creation-time-input emov-a-header-input-mob"  AutoPostBack="false"  type="text"   ID="txtELoginID" readonly="true"/>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator17" ErrorMessage="Login ID is required!" Display="Dynamic" ForeColor="Red"   ControlToValidate="txtELoginID" ValidationGroup="AddSign1" runat="server" /></p></td>
         <td style="width:20%"></td>      
        <td><p>Gender:</p></td>
        <td><p><asp:DropDownList class="emov-a-slot-creation-time-input emov-a-header-input-mob" name="Gender" width="100%"  ID="drpEGender" runat="server">
        <asp:ListItem Value="0" Selected disabled>--Select Gender--</asp:ListItem>
        <asp:ListItem Value="M">Male</asp:ListItem>
        <asp:ListItem Value="F">Female</asp:ListItem>
        </asp:DropDownList>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator18" ErrorMessage="Gender is required!" Display="Dynamic" ForeColor="Red"  ControlToValidate="drpEGender" InitialValue="0"  ValidationGroup="AddSign1" runat="server" />
        </p></td>
        </tr>

        <tr>
        <td colspan="5" style="height:8px;"></td>                                              
        </tr>
         <%--Passpord & Status--%>
        <tr>
        <td><p>Passowrd:</p></td>
        <td ><p><asp:TextBox runat="server" class="emov-a-slot-creation-time-input emov-a-header-input-mob"  AutoPostBack="false"  type="password"   ID="txtEPassword" readonly="true" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator19" ErrorMessage="Password ID is required!" Display="Dynamic" ForeColor="Red"   ControlToValidate="txtEPassword" ValidationGroup="AddSign1" runat="server" /> </p></td>
        <td style="width:51px;"></td>
        <td><p>Status:</p></td>
        <td><p><asp:DropDownList class="emov-a-slot-creation-time-input emov-a-header-input-mob" name="Gender" width="100%"  ID="drpEStatus" runat="server">
        <asp:ListItem Value="2" Selected disabled>--Select Status--</asp:ListItem>
        <asp:ListItem Value="1">Active</asp:ListItem>
        <asp:ListItem Value="0">Deactive</asp:ListItem>
        </asp:DropDownList>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator20" ErrorMessage="Login status is required!" Display="Dynamic" ForeColor="Red"  ControlToValidate="drpEStatus" InitialValue="2"  ValidationGroup="AddSign1" runat="server" />
        </p></td>
        </tr>


        <tr>   
            <td colspan="5" style="height:8px;"></td>
        </tr>
        <%--Designation No & Location --%>
        <tr>
        <td><p><span>Designation</span></p></td>
        <td><p><asp:TextBox runat="server" class="emov-a-slot-creation-time-input emov-a-header-input-mob"  AutoPostBack="false"  type="text"   ID="txtEDesignation" /> 
             <asp:RequiredFieldValidator ID="RequiredFieldValidator23" ErrorMessage="Designation is required!" Display="Dynamic" ForeColor="Red"   ControlToValidate="txtEDesignation" ValidationGroup="AddSign1" runat="server" />  </p></td>
        <td style="width:51px;"></td>
        <td><p>Location:</p></td>
        <td><p><asp:TextBox runat="server" class="emov-a-slot-creation-time-input emov-a-header-input-mob"  AutoPostBack="false"  type="text"   ID="txtELocation" /> 
             <asp:RequiredFieldValidator ID="RequiredFieldValidator24" ErrorMessage="Location is required!" Display="Dynamic" ForeColor="Red"   ControlToValidate="txtELocation" ValidationGroup="AddSign1" runat="server" />  </p></td>
        </tr>       

        <tr>   
            <td colspan="5" style="height:8px;"></td>
        </tr>
    
        <%--Group Name  --%>
        <tr>
        <td><p><span>Group Name</span></p></td>
        <td><p><asp:DropDownList class="emov-a-slot-creation-time-input emov-a-header-input-mob"  width="100%"   ID="drpEGroupName" runat="server">   </asp:DropDownList>
               <asp:RequiredFieldValidator ID="RequiredFieldValidator25" ErrorMessage="Country is required!" Display="Dynamic" ForeColor="Red"  ControlToValidate="drpEGroupName" InitialValue="0"  ValidationGroup="AddSign1" runat="server" /> </p></td>
        <td style="width:51px;"></td>
        <td><p></p></td>
        <td><p></p></td>
        </tr> 
            
            
        <tr>
        <td colspan="5" style="height:8px;"></td>                                              
        </tr>
        <%--Mobile No & Email --%>
        <tr>
        <td><p  style="margin-left: 5px;position: relative;top: -15px;">Mobile No:</p></td>
        <td><p><asp:TextBox runat="server" class="emov-a-slot-creation-time-input emov-a-header-input-mob"  AutoPostBack="false"  type="text"   ID="txtEMobileNo" /> 
            <asp:RequiredFieldValidator ID="RequiredFieldValidator21" ErrorMessage="Mobile No. is required!" Display="Dynamic" ForeColor="Red"   ControlToValidate="txtEMobileNo" ValidationGroup="AddSign1" runat="server" />  
             <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtEMobileNo" ErrorMessage="Enter numbers only till 11 digit" ValidationGroup="AddSign1"   ForeColor="Red" ValidationExpression="[0-9]{11}" />   </p></td>
        <td style="width:51px;"></td>
        <td><p  style="margin-left: 5px;position: relative;top: -15px;">Email:</p></td>
        <td><p><asp:TextBox runat="server" class="emov-a-slot-creation-time-input emov-a-header-input-mob"  AutoPostBack="false"  type="text"   ID="txtEEmail" /> 
            <asp:RequiredFieldValidator ID="RequiredFieldValidator22" ErrorMessage="Emaild Address is required!" Display="Dynamic" ForeColor="Red"   ControlToValidate="txtEEmail" ValidationGroup="AddSign1" runat="server" />  
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"  ControlToValidate="txtEEmail"   ValidationGroup="AddSign1"   ForeColor="Red" ErrorMessage="Invalid Email Format"></asp:RegularExpressionValidator>   </p></td>

        </tr>

        <tr>   
            <td colspan="5" style="height:8px;"></td>
        </tr>
            
        <tr>   
            <td colspan="3" style="height:8px;"></td>
            <td>  
            <div  class="emov-a-single-user-final-actions-box emov-a-single-user-final-actions-box-login" style="margin-top:0px;"  >  
                <asp:Button ID="BtnEBack" runat="server" Text="BACK" Visible="true" style="float: right;" class="login-btn"     OnClick="BtnEBack_Click"/>   </div> 
            </td>
            <td> 
            <div class="emov-a-single-user-final-actions-box emov-a-single-user-final-actions-box-login" style="margin-top:0px;"  > 
                <asp:Button ID="btnEUpdate" runat="server" Text="UPDATE" Visible="true" style="float: right;" class="login-btn"   ValidationGroup="AddSign1"   OnClick="btnEUpdate_Click"/> </div>
            </td>
        </tr>

        </table>
        
        </div>    </div> </div> 

        </div>
      
        </asp:Panel>  

        </div>
 </ContentTemplate>
 </asp:UpdatePanel>

</asp:Content>
