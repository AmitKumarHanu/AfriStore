<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="True" EnableEventValidation="false" CodeBehind="stOrderVerification.aspx.cs" Inherits="stOrderVerification" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js" type="text/javascript"></script> 
   
       <!-- ------------Autocomplete function----------------- -->
  <link rel="stylesheet" href="http://localhost:63262/code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css"/>
  <script src="//code.jquery.com/jquery-1.10.2.js"></script>
  <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
   
  <%--  https://www.c-sharpcorner.com/article/select-all-checkboxes-in-gridview-using-jquery-in-Asp-Net-C-Sharp/--%>
    
    <!-- Select Order Details Row Checkbox -->
    <script type = "text/javascript">
        function ChkOrderVerify_Click(objRef) {

            //Get the reference of GridView
            var GridView = row.parentNode;

            //Get all input elements in Gridview
            var inputList = GridView.getElementsByTagName("input");

            for (var i = 0; i < inputList.length; i++) {
                //The First element is the Header Checkbox
                var headerCheckBox = inputList[0];

                //Based on all or none checkboxes
                //are checked check/uncheck Header Checkbox
                var checked = true;
                if (inputList[i].type == "checkbox" && inputList[i] != headerCheckBox) {
                    if (!inputList[i].checked) {
                        checked = false;
                        break;
                    }
                }
            }
            headerCheckBox.checked = checked;

        }
    </script>
    <!-- Select Order Details All Checkbox -->  
    <script type = "text/javascript">
        function checkOrderAll(objRef) {
            var GridView = objRef.parentNode.parentNode.parentNode;
            var inputList = GridView.getElementsByTagName("input");
            for (var i = 0; i < inputList.length; i++) {
                //Get the Cell To find out ColumnIndex
                var row = inputList[i].parentNode.parentNode;
                if (inputList[i].type == "checkbox" && objRef != inputList[i]) {
                    if (objRef.checked) {

                        inputList[i].checked = true;
                    }
                    else {
                        inputList[i].checked = false;
                    }
                }
            }
        }
</script>   


    <!-- Alert Msg CSS -->
    <style type="text/css">
       
 /*@import url('//maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css');*/
 
.my-notify-info, .my-notify-success, .my-notify-warning, .my-notify-error {
    padding:10px;
    margin:10px 0;
 
}
.my-notify-info:before, .my-notify-success:before, .my-notify-warning:before, .my-notify-error:before {
    font-family:FontAwesome;
    font-style:normal;
    font-weight:400;
    speak:none;
    display:inline-block;
    text-decoration:inherit;
    width:1em;
    margin-right:.2em;
    text-align:center;
    font-variant:normal;
    text-transform:none;
    line-height:1em;
    margin-left:.2em;
    -webkit-font-smoothing:antialiased;
    -moz-osx-font-smoothing:grayscale
}
.my-notify-info:before {
    content:"\f05a";
}
.my-notify-success:before {
    content:'\f00c';
}
.my-notify-warning:before {
    content:'\f071';
}
.my-notify-error:before {
    content:'\f057';
}
.my-notify-info {
    color: #00529B;
    background-color: #BDE5F8;
     font-size:14px;
}
.my-notify-success {
    color: #4F8A10;
    background-color: #DFF2BF;
     font-size:14px;
}
.my-notify-warning {
    color: #9F6000;
    background-color: #FEEFB3;
     font-size:14px;
}
.my-notify-error {
    color: #D8000C;
    background-color: #FFD2D2;
    font-size:14px;
}
    </style>
   
    <!--   Printer  fun -->
    <script type="text/javascript" >
        function PrintContent() {
            var html = "<html>";
            html += document.getElementById("DivPrint").innerHTML;
            html += "</html>";

            var printWin = window.open('', '', 'location=no,width=10,height=10,left=50,top=50,toolbar=no,scrollbars=no,status=0,titlebar=no');

            printWin.document.write(html);
            printWin.document.close();
            printWin.focus();
            printWin.print();
            printWin.close();
        }

     </script>

   

<div class="emov-page-container emov-step-wrapper">

<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
<ContentTemplate>  
                 
     <!-- Main Panel -->
     <asp:Panel ID="pnlMain" runat="server"   style="display:block">

     <div id="div_main" runat="server" class="emov-page-main emov-page-main-no-top-padding">
     <!-- Header Menu-->
    <div class="emov-a-rc-header emov-a-rc-header-seun">
     <!-- Page Title-->
    <div  class="emov-header-page-title emov-header-page-title-table-vigo"   id="emov-application-title">
        <h3 style="font-size:25px;" class="emov-applications-title">Order Details</h3>
        <!-- Total Count-->
        <div class="emov-a-header-counter">  <p><asp:Label ID="lbl_total" runat="server"></asp:Label> Total</p>   </div>  
    </div>

    <div class="emov-a-header-action-group">
    <div class="emov-t-actions-group" style="display:block;">
  
    <table id="btnOpt" runat="server" style="width:100%; display:block">
    <tr> 
    <td><input type="text" id="txtSearch" runat="server" class="emov-a-header-input" placeholder="Ticket No." /></td>
    <td></td>
    <td><button id="btnSearch" type="button" runat="server" class="emov-dash-icon-cover1" style="margin-right: 10px;"   onserverclick="BtnSearchOpt" >SEARCH <i class="fa fa-search" aria-hidden="true"></i></button></td>      
    
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
    <tr> 
    <td>  
    <br />
  
    <div>
    <table style="width:100%;">
    <tr>
    <td>
    <div style="overflow-x:scroll; text-align:center">
       <%-- ----%>
        <asp:GridView ID="grdOrder" runat="server" AllowPaging="true" AllowSorting="true" AutoGenerateColumns="False" Border="0px" BorderColor="White" CssClass="emov-a-table-data" 
         PageSize="10" ShowHeaderWhenEmpty="true" Width="100%" OnPageIndexChanging="grdOrder_PageIndexChanging"
         OnRowCommand="grdOrder_RowCommand"   OnRowDataBound="grdOrder_RowDataBound"   OnSelectedIndexChanged="grdOrder_SelectedIndexChanged">
        <AlternatingRowStyle />
        <Columns>
     
        <asp:TemplateField HeaderStyle-CssClass="emov-a-table-heading" HeaderText="Ticket No">
        <ItemTemplate>
        <asp:Label ID="lblTicketNo" runat="server" Text='<%# Bind("Ticket") %>'></asp:Label>
        </ItemTemplate>
        <ItemStyle HorizontalAlign="Center" />
        </asp:TemplateField>
        <asp:TemplateField HeaderStyle-CssClass="emov-a-table-heading" HeaderText="Date">
        <ItemTemplate>
        <asp:Label ID="lblDate" runat="server" Text='<%# Bind("CreateON") %>'></asp:Label>
        </ItemTemplate>
        <ItemStyle HorizontalAlign="Center" />
        </asp:TemplateField>
        <asp:TemplateField HeaderStyle-CssClass="emov-a-table-heading" HeaderText="Status">
        <ItemTemplate>
        <asp:Label ID="lblStatus" runat="server" Text='<%# Bind("Status") %>'></asp:Label>
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
<div id="lblloginmsg" runat="server" class="emov-page-main emov-page-main-no-top-padding" width="50%" align="center"   style="display:none;">      </div>

               
<asp:Panel ID="pnlOrderDetails" runat="server"  class="emov-page-main emov-page-main-no-top-padding" width="100%"    style="display:block">    
    
  <div class="emov-a-single-user-card-header">   <h2 class="h2label">Received Item Details </h2>  </div> 
         
    <!-- Data Grid Design-->
  <div class="emov-a-rc-table-cover">                          
   
    <!-- table within data grid-->
        
    <table style="width:100%; margin-top:-4%;" >                              
    <caption>
    <tr> 
    <td>  
    <br />
  
    <div>
    <table style="width:100%;">
    <tr>
    <td>
    <div style="overflow-x:scroll; text-align:center">
       <%-- ----%>
        <asp:GridView ID="grdOrderDetails" runat="server" AllowPaging="true" AllowSorting="true" AutoGenerateColumns="False" Border="0px" BorderColor="White" CssClass="emov-a-table-data" 
         PageSize="10" ShowHeaderWhenEmpty="true" Width="100%" >
        <AlternatingRowStyle />
        <Columns>
     
        <asp:TemplateField HeaderStyle-CssClass="emov-a-table-heading" HeaderText="Item Name">
        <ItemTemplate>
        <asp:Label ID="lblItemName" runat="server" Text='<%# Bind("ItemName") %>'></asp:Label>
        </ItemTemplate>
        <ItemStyle HorizontalAlign="Center" />
        </asp:TemplateField>

        <asp:TemplateField HeaderStyle-CssClass="emov-a-table-heading" HeaderText="Brand Name">
        <ItemTemplate>
        <asp:Label ID="lblBrand" runat="server" Text='<%# Bind("Brand") %>'></asp:Label>
        </ItemTemplate>
        <ItemStyle HorizontalAlign="Left" />
        </asp:TemplateField>

        <asp:TemplateField HeaderStyle-CssClass="emov-a-table-heading" HeaderText="Item Details">
        <ItemTemplate>
        <asp:Label ID="lblItemSpecification" runat="server" Text='<%# Bind("ItemSpecification") %>'></asp:Label>
        </ItemTemplate>
        <ItemStyle HorizontalAlign="Center" />
        </asp:TemplateField>        


        <asp:TemplateField HeaderStyle-CssClass="emov-a-table-heading" HeaderText="Quantity">
        <ItemTemplate>
        <asp:Label ID="lblQuantity" runat="server" Text='<%# Bind("Quantity") %>'></asp:Label>
        </ItemTemplate>
        <ItemStyle HorizontalAlign="Left" />
        </asp:TemplateField>

        <asp:TemplateField HeaderStyle-CssClass="emov-a-table-heading" HeaderText="Cost Price">
        <ItemTemplate>
        <asp:Label ID="lblCostPrice" runat="server" Text='<%# Bind("CostPrice") %>'></asp:Label>
        </ItemTemplate>
        <ItemStyle HorizontalAlign="Center" />
        </asp:TemplateField>
        

            
        <asp:TemplateField HeaderStyle-CssClass="emov-a-table-heading" HeaderText="Sales Price">
        <ItemTemplate>
        <asp:Label ID="lblSalesPrice" runat="server" Text='<%# Bind("SalesPrice") %>'></asp:Label>
        </ItemTemplate>
        <ItemStyle HorizontalAlign="Center" />
        </asp:TemplateField>

        <asp:TemplateField HeaderStyle-CssClass="emov-a-table-heading" HeaderText="Warranty (Months)">
        <ItemTemplate>
        <asp:Label ID="lblWarranty" runat="server" Text='<%# Bind("Warranty") %>'></asp:Label>
        </ItemTemplate>
        <ItemStyle HorizontalAlign="Left" />
        </asp:TemplateField>


            
        <asp:TemplateField HeaderStyle-CssClass="emov-a-table-heading" HeaderText="BarcodeNo" Visible="false" >
        <ItemTemplate>
        <asp:Label ID="lblBarcodeNo" runat="server" Text='<%# Bind("BarCodeNo") %>'></asp:Label>
        </ItemTemplate>
        <ItemStyle HorizontalAlign="Left" />
        </asp:TemplateField>

                   
        <asp:TemplateField HeaderStyle-CssClass="emov-a-table-heading" HeaderText="ItemRegNo" Visible="false" >
        <ItemTemplate>
        <asp:Label ID="lblItemRegNo" runat="server" Text='<%# Bind("ItemRegNo") %>'></asp:Label>
        </ItemTemplate>
        <ItemStyle HorizontalAlign="Left" />
        </asp:TemplateField>



        <asp:TemplateField>
        <HeaderTemplate>
        <asp:CheckBox ID="checkAll" runat="server" onclick = "checkOrderAll(this);" />
        </HeaderTemplate> 
        <ItemTemplate>
        <asp:CheckBox ID="ChkVerify" runat="server" onclick = "ChkOrderVerify_Click(this)" />
        </ItemTemplate> 
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
        <tr><td>
        <asp:Button ID="BtnBackVerify" runat="server" Text="BACK" Visible="true" class="login-btn"    style="float: right;"   OnClick="BtnBackVerify_Click"/>   
        <asp:Button ID="BtnRetrun" runat="server" Text="RETURN" Visible="true" class="login-btn"    style="float: right;"   OnClick="BtnRetrun_Click"/>   
        <asp:Button ID="btnVerifyOrderDetails" runat="server" Text="VERIFY" Visible="true" class="login-btn"   style="float: right;"    OnClick="btnVerifyOrderDetails_Click"/>   
      
    
        </td></tr>
    </table>

    </div> 

</asp:Panel>


</ContentTemplate>
<Triggers>
<asp:AsyncPostBackTrigger ControlID="btnVerifyOrderDetails" EventName="Click" /> 
</Triggers>
</asp:UpdatePanel>

</div>
   


</asp:Content>
