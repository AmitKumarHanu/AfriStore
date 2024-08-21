
<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="True" EnableEventValidation="false"  CodeBehind="frmDuplicatBillPrint.aspx.cs" Inherits="frmDuplicatBillPrint" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     <%--    --%>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js" type="text/javascript"></script> 
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.8.2.js"></script>
 
      <!--Autocompile dropbox design -->
    <style>
        .ui-autocomplete  
        {
        font-size:11px;
        text-align:left;         
        width: 50px;
        max-height: 300px;
        overflow-y: auto;
        prevent horizontal scrollbar 
        overflow-x: hidden;
        border:1px solid #ccc;
        }

        .ui-autocomplete-row
        {
        max-height: 100px;
        overflow-y: auto;
        prevent horizontal scrollbar
        overflow-x: hidden;
        padding:8px;
        background-color: #f4f4f4;
        border-bottom:1px solid #ccc;
        font-weight:bold;          
        }
        .ui-autocomplete-row:hover
        { 
              
        background-color: #f05223;   
        color:#fff;
        cursor:pointer;
        }

    </style>

        
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
    -moz-osx-font-smoothing:grayscale;

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

    <!-- Receipt CSS -->
    <style type="text/css">

        #invoice-POS{
  box-shadow: 0 0 1in -0.25in rgba(0, 0, 0, 0.5);
  padding:5mm;
  margin: 0 auto;
  width: 95mm;
  background: #FFF;
  
  
::selection {background: #f31544; color: #FFF;}
::moz-selection {background: #f31544; color: #FFF;}
h1{
  font-size: 1.5em;
  color: #222;
}
h2{font-size: .9em;}
h3{
  font-size: 1.2em;
  font-weight: 300;
  line-height: 2em;
}
p{
  font-size: .7em;
  color: #666;
  line-height: 1.2em;
}
 
#top, #mid,#bot{ /* Targets all id with 'col-' */
  border-bottom: 1px solid #EEE;
}

#top{min-height: 100px;}
#mid{min-height: 80px;} 
#bot{ min-height: 50px;}

#top .logo{
  //float: left;
	height: 60px;
	width: 60px;
	background: url(http://michaeltruong.ca/images/logo1.png) no-repeat;
	background-size: 60px 60px;
}
.clientlogo{
  float: left;
	height: 60px;
	width: 60px;
	background: url(http://michaeltruong.ca/images/client.jpg) no-repeat;
	background-size: 60px 60px;
  border-radius: 50px;
}
.info{
  display: block;
  //float:left;
  margin-left: 0;

}
.title{
  float: right;
}
.title p{text-align: right;} 
table{
  width: 80%;
  border-collapse: collapse;
}
td{
  padding: 5px 0 5px 15px;
  border: 1px solid #EEE
}
.tabletitle{
  padding: 5px;
  font-size: .5em;
  background: #EEE;
}
.service{border-bottom: 1px solid #EEE;}
.item{width: 24mm;}
.itemtext{font-size: .5em;}

#legalcopy{
  margin-top: 5mm;
}

  
  
}
    </style>

    <!-- Div  Central CSS -->
    <style type="text/css">
    .container {   
    top:20%;  left:20%;  z-index:1000;  position:absolute;   display:compact;  margin-left: 5%; margin-top: 5%;    width: 500px; height: 250px;
    /*outline: dashed 1px black;*/
    }

   
    </style>
    
   <!--  Vildate Date fun-->
    <script type="text/Jscript"> 
        function getPrice() {

            $("#hdfSalesPrice").val($("#txtSalesPrice").text());
            $("#hdfDiscountAmount").val($("#txtDiscountAmount").text());

            //alert('h1' + $("#txtSalesPrice").val());
            //alert('h2' + $("#txtDiscountAmount").val());
        }
    </script>
       <!-- ------------Autocomplete function----------------- -->
  <link rel="stylesheet" href="http://localhost:63262/code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css"/>
  <script src="//code.jquery.com/jquery-1.10.2.js"></script>
  <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
 
 
    <!--   Printer  fun -->
    <script type="text/javascript" >
     function PrintContent() {
         var html = "<html>";
         html += document.getElementById("DivPrint").innerHTML;
         html += "</html>";

         var printWin = window.open('', '', 'location=no,width=1000,height=1000,left=50,top=50,toolbar=no,scrollbars=no,status=0,titlebar=no');

         printWin.document.write(html);
         printWin.document.close();
         printWin.focus();
         printWin.print();
         printWin.close();
     }

     </script>



    

<div class="emov-page-container emov-step-wrapper">


<!-- Main Panel -->
<asp:Panel ID="Panel1" runat="server" > 
<div id="DivMain" runat="server" class="emov-page-main emov-page-main-no-top-padding" style="display:block;">   
<!-- Header Menu-->
<div class="emov-a-rc-header emov-a-rc-header-seun">
<!-- Page Title-->
<div class="emov-header-page-title emov-header-page-title-table-vigo" id="emov-application-title">
<h3 style="font-size: 25px;" class="emov-applications-title">Print Duplicate Receipt</h3>
<!-- Total Count-->
           
</div>

<div class="emov-a-header-action-group">
<div class="emov-t-actions-group" style="display:block;">

<table id="btnOpt" runat="server" style="width: 100%; display: block">
<tr>
<td>
<input type="text" id="txtBillNo" runat="server" class="emov-a-header-input" placeholder="Ticket No./Mobile No./Customer Name" /></td>
<td></td>
<td>
<button id="btnSearch" type="button" runat="server" class="emov-dash-icon-cover1" style="margin-right: 10px;" onserverclick="BtnSearchOpt">SEARCH <i class="fa fa-search" aria-hidden="true"></i></button>
</td>
                      
</tr>
</table>


</div>
</div>

</div>
    </div>

    
    <!-- Data Grid Design-->
    <div id="DivDetails" runat="server" class="emov-a-rc-table-cover" style="display:block;">
                          
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
        <asp:GridView ID="grdDupBill" runat="server" AllowPaging="true" AllowSorting="true" AutoGenerateColumns="False" Border="0px" BorderColor="White" CssClass="emov-a-table-data" 
        OnPageIndexChanging="grdDupBill_PageIndexChanging" PageSize="10" ShowHeaderWhenEmpty="true" Width="100%" 
        OnRowCommand="grdDupBill_RowCommand" 
        OnRowDataBound="grdDupBill_RowDataBound"
        OnSelectedIndexChanged="grdDupBill_SelectedIndexChanged">
        <AlternatingRowStyle />
        <Columns>
        <asp:TemplateField HeaderStyle-CssClass="emov-a-table-heading" HeaderText="Ticket No.">
        <ItemTemplate>
        <asp:Label ID="lblTicketNo" runat="server" Text='<%# Bind("TicketNo") %>'></asp:Label>
        </ItemTemplate>
        <ItemStyle HorizontalAlign="Left" />
        </asp:TemplateField>

        <asp:TemplateField HeaderStyle-CssClass="emov-a-table-heading" HeaderText="Customer Name">
        <ItemTemplate>
        <asp:Label ID="lblCustomerName" runat="server" Text='<%# Bind("CustomerName") %>'></asp:Label>
        </ItemTemplate>
        <ItemStyle HorizontalAlign="Center" />
        </asp:TemplateField>

        <asp:TemplateField HeaderStyle-CssClass="emov-a-table-heading" HeaderText="Mobile No">
        <ItemTemplate>
        <asp:Label ID="lblMobile" runat="server" Text='<%# Bind("Mobile") %>'></asp:Label>
        </ItemTemplate>
        <ItemStyle HorizontalAlign="Center" />
        </asp:TemplateField>
        <asp:TemplateField HeaderStyle-CssClass="emov-a-table-heading" HeaderText="Date">
        <ItemTemplate>
        <asp:Label ID="lblBDate" runat="server" Text='<%# Bind("TicketDate") %>'></asp:Label>
        </ItemTemplate>
        <ItemStyle HorizontalAlign="Left" />
        </asp:TemplateField>

      

        <asp:TemplateField HeaderStyle-CssClass="emov-a-table-heading" HeaderText="Total Item">
        <ItemTemplate>
        <asp:Label ID="lblTotalitem" runat="server" Text='<%# Bind("Totalitem") %>'></asp:Label>
        </ItemTemplate>
        <ItemStyle HorizontalAlign="Center" />
        </asp:TemplateField>
      
        <asp:TemplateField HeaderStyle-CssClass="emov-a-table-heading" HeaderText="Total Amount">
        <ItemTemplate>
        <asp:Label ID="lblPaidAmount" runat="server" Text='<%# Bind("PaidAmount") %>'></asp:Label>
        </ItemTemplate>
        <ItemStyle HorizontalAlign="Center" />
        </asp:TemplateField>
       
        <asp:TemplateField HeaderStyle-CssClass="emov-a-table-heading" HeaderText="Payment Mode">
        <ItemTemplate>
        <asp:Label ID="lblPaymentMode" runat="server" Text='<%# Bind("PaymentMode") %>'></asp:Label>
        </ItemTemplate>
        <ItemStyle HorizontalAlign="Center" />
        </asp:TemplateField>
      
        <asp:TemplateField HeaderStyle-CssClass="emov-a-table-heading" HeaderText="Staff Name">
        <ItemTemplate>
        <asp:Label ID="lblPaymentReceivedBy" runat="server" Text='<%# Bind("PaymentReceivedBy") %>'></asp:Label>
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


</asp:Panel>


<!-- Message Div -->
<div id="lblloginmsg" runat="server" class="emov-page-main emov-page-main-no-top-padding" width="50%" align="center"   style="display:none;">      </div>

    
<!-- Receipt  Panel --> 
<asp:Panel ID="Panel4" runat="server" >  
<div id="DivReceipt" runat="server"  class="emov-page-main emov-page-main-no-top-padding" width="100%" align="center"   style="display:block;">   
        
<!-- White Div -->
<div class="emov-a-profile-full-info" style="background: white">
<div class="emov-a-single-user-card-cover">
<%--  User Data ---%>
<div class="emov-a-single-user-card-header" >   <h2 class="h2label"> <asp:Label ID="Label1" runat="server" Font-Bold="true" Font-Size="XX-Large" Height="1px" Text="0" > Payment Receipt </asp:Label></h2>   </div>
<table><tr><td > <button id="btnPrint" type="button" runat="server" class="emov-dash-icon-cover1" style="margin-right: 10px;"  onserverclick="BtnPrinter" ><i class="fa fa-print" aria-hidden="true"></i>PRINTER </button></td>     </tr></table>
<div class="emov-a-single-user-card-inner-info">    

<div id="DivPrint">

<asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Always">
<ContentTemplate>        


<table class="emov-a-table-data1"  >            
      
<tr>   
<td colspan="5" style="height:8px; text-align:center"></td>
</tr>
<tr>   
<td colspan="5" style="height:8px; width:100%; text-align:center">
    
<div id="invoice-POS">
    
<center id="top">
<div class="logo">
<img src="Content/assets/images/logo2.png" alt="" style="height: 44px;" />
</div>
<!--End Info-->
</center><!--End InvoiceTop-->
    
<div id="mid">
<div class="info" >
<%-- <h2>Contact Info</h2>   --%>    
<p> <h4 style="text-transform:uppercase"> <asp:Label ID="lblBrName" runat="server"  Text="Label"></asp:Label> </h4>  
    <p>
    </p>
    <p>
        <h4 style="text-transform:capitalize">Address :
            <asp:Label ID="lblBrAddress" runat="server" Text="Label"></asp:Label>
        </h4>
        <br />
        Email :
        <asp:Label ID="lblBrEmail" runat="server" Text="Label"></asp:Label>
        <br />
        Phone :
        <asp:Label ID="lblBrPhone" runat="server" Text="Label"></asp:Label>
        <p>
        </p>
        <p>
        </p>
        <p>
        </p>
        <p>
        </p>
        <p>
        </p>
        <p>
        </p>
        <p>
        </p>
        <p>
        </p>
        <p>
        </p>
        <p>
        </p>
        <p>
        </p>
        <p>
        </p>
        <p>
        </p>
        <p>
        </p>
        <p>
        </p>
        <p>
        </p>
        <p>
        </p>
        <p>
        </p>
        <p>
        </p>
        <p>
        </p>
        <p>
        </p>
    </p>
</p>
         
</div>
</div><!--End Invoice Mid-->
    
<div id="bot">   

					
            <table  id="table" style="height:auto; width:100%; font-size:small; text-align:left;">
                    <tr> <td colspan="3" style="height:10px;" ></td> </tr>
                <tr class="tabletitle" style="width: 100%; height:auto;">
                              
                    <td><h4>Ticket  No. </h4></td>
                        <td></td>
                    <td><h4> <asp:Label ID="lblRecInvoice" runat="server" Text=""></asp:Label></h4></td>
                               
                    </tr>
                    <tr class="tabletitle" style="width: 100%; height:auto;">
                                  
                        <td><h4>Date.  </h4> </td>
                            <td></td>
                        <td><h4> <asp:Label ID="lblRecDate" runat="server" Text=""></asp:Label></h4> </td>
                               
                    </tr>

                    <tr> <td colspan="3" style="height:25px;" ></td> </tr>

                <tr >
                    <td  class="item" colspan="3" >
            <%--   Data Grid --%>                    
                                     
                                      

            <asp:GridView ID="grdPayGrid" runat="server" AllowSorting="true" AutoGenerateColumns="False" Border="0px" BorderColor="White" width="100%" ShowHeaderWhenEmpty="true" >
            <AlternatingRowStyle />
            <Columns>

            <asp:TemplateField HeaderStyle-CssClass="Smaller" HeaderText="Item Name">
            <ItemTemplate>
            <asp:Label ID="lblItemName" Font-Size="Smaller" runat="server" Text='<%# Bind("ItemName") %>'></asp:Label>
            </ItemTemplate>
            <ItemStyle HorizontalAlign="Right" />
            </asp:TemplateField>
                       
      
            <asp:TemplateField HeaderStyle-CssClass="Smaller"  HeaderText="Quantity">
            <ItemTemplate>
            <asp:Label ID="lblQuantity" Font-Size="Smaller"  runat="server" Text='<%# Bind("Quantity") %>'></asp:Label>
            </ItemTemplate>
            <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
                            
            <asp:TemplateField HeaderStyle-CssClass="Smaller" HeaderText="Discount">
            <ItemTemplate>
            <asp:Label ID="lblDiscount" Font-Size="Smaller" runat="server" Text='<%# Bind("DiscountAmount") %>'></asp:Label>
            </ItemTemplate>
            <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>


            <asp:TemplateField HeaderStyle-CssClass="Smaller"  HeaderText="Amount">
            <ItemTemplate>
            <asp:Label ID="lblTotalAmount"  Font-Size="Smaller" runat="server" Text='<%# Bind("TotalAmount") %>'></asp:Label>
            </ItemTemplate>
            <ItemStyle HorizontalAlign="Left" />
            </asp:TemplateField>
       
            </Columns>
            <HeaderStyle CssClass="" />
            <PagerStyle Height="10px" />
            <RowStyle CssClass="" />
            <EditRowStyle CssClass="" />
            <EmptyDataTemplate>
            <div style="text-align:center;">
            No records found.</div>
            </EmptyDataTemplate>
            </asp:GridView>   

                                  
                      
            </td>
                        <tr> <td colspan="3" style="height:25px;" ></td> </tr>
                                
                </tr>
                    <tr >
							
					<td class=""><h4>Sales Price</h4></td>
                        <td></td>
					<td class="" style="text-align:right; float:right;"><h4><asp:Label ID="lblRSalesPrice"  runat="server" Width="100%" Text="0"  ></asp:Label></h4></td>
				</tr>
                <tr>
								
					<td ><h4>Discount </h4></td>
                    <td></td>
					<td style="text-align:right; float:right;"><h4><asp:Label ID="lblRDiscount"  runat="server" Width="100%" Text="0"  ></asp:Label></h4></td>
				</tr>
                          
                <%--<tr class="tabletitle">
					<td></td>
					<td class="Rate"><h2>tax</h2></td>
					<td class="payment"><h2><asp:Label ID="lblRVATax" runat="server" Width="100%" Text="0"  ></asp:Label></h2></td>
				</tr>--%>

				<tr >
								
					<td ><h4>Total Amount</h4></td>
                    <td></td>
					<td style="text-align:right; float:right; font-weight:bold; "><h4><asp:Label ID="lblRTotal" runat="server" Width="100%" Text="0"  ></asp:Label></h4></td>
				</tr>
                <tr>
                    <td ><h5>Refered By:</h5></td>
                    <td></td>
                    <td style="text-align:right; float:right;"> <h5><asp:Label ID="lblRReferedBy" runat="server" Width="100%" Text=""  ></asp:Label></h5> </td>
                </tr>
                    <tr>
                    <td ><h5>Payment Mode:</h5></td>
                    <td></td>
                    <td style="text-align:right; float:right;"><h5>  <asp:Label ID="lblRPaymentMode" runat="server" Width="100%" Text=""  ></asp:Label> </h5> </td>
                </tr>
            </table>
						
				
<br />
		<div id="legalcopy">
			<p class="legal"><strong>Thank you for your business!</strong>  Payment is expected within 31 days; please process this Ticket  within that time. There will be a 5% interest charge per month on late Ticket s. 
			</p>
		</div>

	</div><!--End InvoiceBot-->
</div><!--End Invoice-->


</td>
</tr>
<tr>   
<td colspan="5" style="height:8px;"></td>
</tr>
</table>
</div>

  
</ContentTemplate>

</asp:UpdatePanel>
  
</div>

</div></div>
  
</div>
        
</div>
</asp:Panel>




    <!-- Payment   Panel --> 
<asp:Panel ID="Panel5" runat="server"    >  

<div id="DivPrintOpt" runat="server"  class="emov-page-main emov-page-main-no-top-padding" width="50%" align="center"   style="display:none;">   
  <div class="container"  >
<!-- White Div -->
    
<div class="emov-a-single-user-card-cover" >
<%--  User Data ---%>
<div class="emov-a-single-user-card-header" >   <h2 class="h2label"> Receipt Print Successful </h2>   </div>
<div class="emov-a-single-user-card-inner-info"> 

    <table align="Center" >
    <tr>  
    <td style="width: 50%;">   <button id="btnSuccessful" type="button" runat="server" class="login-btn click"  style="float: right;"     onserverclick="BtnPrintYes"> Yes </button></td>
    <td style="width: 50%;">   <button id="btnReprint" type="button" runat="server" class="login-btn click"  style="float: right;"     onserverclick="BtnPrintNo"> No </button></td>

    </tr> 
    </table>

    </div></div>
   </div>
</div>
 
</asp:Panel>

    <asp:HiddenField ID="hdnChangeAmount" runat="server" ClientIDMode="Static" Value=""  />
<asp:HiddenField ID="hdnDueAmount" runat="server" ClientIDMode="Static" Value=""  />

</div>  
</asp:Content>
