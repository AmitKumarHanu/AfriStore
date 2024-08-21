<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="True" EnableEventValidation="false"  CodeBehind="frmItemReturn.aspx.cs" Inherits="AfriStore_Code.frmItemReturn" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

      <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js" type="text/javascript"></script> 
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.8.2.js"></script>
    <!--Current Date -->
    <script type="text/javascript">
        $(document).ready(function () {
            var today = new Date();
            var dd = String(today.getDate()).padStart(2, '0');
            var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
            var yyyy = today.getFullYear();

            today = dd + '/' + mm + '/' + yyyy;

            $('#<%= txtBillDate.ClientID %>').val(today)


        });

    </script>  
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


    <!--Javascript function for popup box  -->
    <script type='text/javascript'>
        $(function () {
            var overlay = $('<div id="overlay"></div>');
            $('.close').click(function () {
                $('.popup').hide();
                overlay.appendTo(document.body).remove();
                return false;
            });

            $('.x').click(function () {
                $('.popup').hide();
                overlay.appendTo(document.body).remove();
                return false;
            });

            $('.click').click(function () {
                overlay.show();
                overlay.appendTo(document.body);
                $('.popup').show();
                return false;
            });
        });
    </script>
    
       <!-- ------------Autocomplete function----------------- -->
  <link rel="stylesheet" href="http://localhost:63262/code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css"/>
  <script src="//code.jquery.com/jquery-1.10.2.js"></script>
  <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>

       <!-- Get Item Details by Barcode -->
    <script language="javascript" type="text/javascript">
        $(function () {
            var hv = $("#<%=hdnComID.ClientID %>").val();
            var Br = $("#<%=hdnBrID.ClientID %>").val();
            $('#<%=txtBarCodeNo.ClientID%>').autocomplete({
                source: function (request, response) {
                    $.ajax({
                        url: "frmItemReturn.aspx/GetBarcode",
                        data: "{ 'BarCode':'" + request.term + "', 'ComID':'" + hv + "', 'BrID': '" + Br + "'}",
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            response($.map(data.d, function (item) {
                                return {
                                    Name: item.Name,
                                    Industry: item.Industry,
                                    Specification: item.Specification,
                                    BarCodeNo: item.BarCodeNo,
                                    Quantity: item.Quantity,
                                    SalesPrice: item.SalesPrice,
                                    CostPrice: item.CostPrice,
                                    ItemRegNo: item.ItemRegNo,
                                    TicketNo: item.TicketNo,
                                    json: item
                                }
                            }))
                        },
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                            alert(textStatus);
                        }
                    });
                },
                focus: function (event, ui) {
                    $('#<%=txtBarCodeNo.ClientID%>').val(ui.item.BarCodeNo);
                    $('#<%=txtItemName.ClientID%>').val(ui.item.Name);
                    $('#<%=txtItemSpecification.ClientID%>').val(ui.item.Specification);
                    $('#<%=txtCostPrice.ClientID%>').val(ui.item.CostPrice);
                    $('#<%=txtSalesPrice.ClientID%>').val(ui.item.SalesPrice);
                    $('#<%=txtItemRegNo.ClientID%>').val(ui.item.ItemRegNo);
                    $('#<%=txtCurrentQty.ClientID%>').val(ui.item.Quantity);
                    $('#<%=txtTicketNo.ClientID%>').val(ui.item.TicketNo);
                    
                    return false;
                },
                select: function (event, ui) {
                    $('#<%=txtBarCodeNo.ClientID%>').val(ui.item.BarCodeNo);
                    $('#<%=txtItemName.ClientID%>').val(ui.item.Name);
                    $('#<%=txtItemSpecification.ClientID%>').val(ui.item.Specification);
                    $('#<%=txtCostPrice.ClientID%>').val(ui.item.CostPrice);
                    $('#<%=txtSalesPrice.ClientID%>').val(ui.item.SalesPrice);
                    $('#<%=txtItemRegNo.ClientID%>').val(ui.item.ItemRegNo);
                    $('#<%=txtCurrentQty.ClientID%>').val(ui.item.Quantity);
                    $('#<%=txtTicketNo.ClientID%>').val(ui.item.TicketNo);
                    return false;
                },
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li class='ui-autocomplete-row'></li>")
                    .append("<a>BarCodeNo:" + item.BarCodeNo + "<br>Name: " + item.Name + "<br>Specification: " + item.Specification + "<br>Current Quanity: " + item.Quantity + "</a>")
                    .appendTo(ul);
            };
        });
    </script>

    <!-- Get Item Details by item Name -->
     <script language="javascript" type="text/javascript">
         $(function () {
             var hv = $("#<%=hdnComID.ClientID %>").val();
             var Br = $("#<%=hdnBrID.ClientID %>").val();
             $('#<%=txtItemName.ClientID%>').autocomplete({
                 source: function (request, response) {
                     $.ajax({
                         url: "frmItemReturn.aspx/GetitemName",
                         data: "{ 'ItemName':'" + request.term + "', 'ComID':'" + hv + "', 'BrID': '" + Br + "'}",
                         dataType: "json",
                         type: "POST",
                         contentType: "application/json; charset=utf-8",
                         success: function (data) {
                             response($.map(data.d, function (item) {
                                 return {
                                     Name: item.Name,
                                     Industry: item.Industry,
                                     Specification: item.Specification,
                                     BarCodeNo: item.BarCodeNo,
                                     Quantity: item.Quantity,
                                     SalesPrice: item.SalesPrice,
                                     CostPrice: item.CostPrice,
                                     ItemRegNo: item.ItemRegNo,         
                                     TicketNo: item.TicketNo,
                                     json: item
                                 }
                             }))
                         },
                         error: function (XMLHttpRequest, textStatus, errorThrown) {
                             alert(textStatus);
                         }
                     });
                 },
                 focus: function (event, ui) {
                     $('#<%=txtBarCodeNo.ClientID%>').val(ui.item.BarCodeNo);
                     $('#<%=txtItemName.ClientID%>').val(ui.item.Name);
                     $('#<%=txtItemSpecification.ClientID%>').val(ui.item.Specification);                 
                     $('#<%=txtCostPrice.ClientID%>').val(ui.item.CostPrice);
                     $('#<%=txtSalesPrice.ClientID%>').val(ui.item.SalesPrice);
                     $('#<%=txtItemRegNo.ClientID%>').val(ui.item.ItemRegNo);
                     $('#<%=txtCurrentQty.ClientID%>').val(ui.item.Quantity);
                     $('#<%=txtTicketNo.ClientID%>').val(ui.item.TicketNo);
                     return false;
                 },
                 select: function (event, ui) {
                     $('#<%=txtBarCodeNo.ClientID%>').val(ui.item.BarCodeNo);
                    $('#<%=txtItemName.ClientID%>').val(ui.item.Name);
                    $('#<%=txtItemSpecification.ClientID%>').val(ui.item.Specification);                  
                     $('#<%=txtCostPrice.ClientID%>').val(ui.item.CostPrice);
                    $('#<%=txtSalesPrice.ClientID%>').val(ui.item.SalesPrice);
                     $('#<%=txtItemRegNo.ClientID%>').val(ui.item.ItemRegNo);
                     $('#<%=txtCurrentQty.ClientID%>').val(ui.item.Quantity);
                     $('#<%=txtTicketNo.ClientID%>').val(ui.item.TicketNo);
                    return false;
                },
             }).data("ui-autocomplete")._renderItem = function (ul, item) {
                 return $("<li class='ui-autocomplete-row'></li>")
                     .append("<a>BarCodeNo:" + item.BarCodeNo + "<br>Name: " + item.Name + "<br>Specification: " + item.Specification + "<br>Current Quanity: " + item.Quantity + "</a>")
                     .appendTo(ul);
             };
         });
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

    <!-- Receipt CSS -->
    <style type="text/css">

        #invoice-POS{
  box-shadow: 0 0 1in -0.25in rgba(0, 0, 0, 0.5);
  padding:11mm;
  margin: 0 auto;
  width: 82mm;
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
  width: 100%;
  border-collapse: collapse;
}
td{
  //padding: 5px 0 5px 15px;
  //border: 1px solid #EEE
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


<!-- Main Panel -->
<asp:Panel ID="pnlMain" runat="server" > 
<div id="DivMain" runat="server" class="emov-page-main emov-page-main-no-top-padding" style="display:block;">   
    <!-- Header Menu-->
    <div class="emov-a-rc-header emov-a-rc-header-seun">
        <!-- Page Title-->
        <div class="emov-header-page-title emov-header-page-title-table-vigo" id="emov-application-title">
            <h3 style="font-size: 25px;" class="emov-applications-title">Item Stock Return</h3>
  
        </div>

        <div class="emov-a-header-action-group">
            <div class="emov-t-actions-group" style="display:block;">

                <table id="btnOpt" runat="server" style="width: 100%; display: block">
                    <tr>
                        <td>
                           </td>

                        <td></td>
                         <td>
                            <button id="btnReturnAdd" type="button" runat="server" class="emov-dash-icon-cover1" style="margin-right: 10px;" ReadOnly="true"  onserverclick="btnReturnAddOpt">Add <i class="fa fa-plus" aria-hidden="true"></i></button>

                        </td>
                       
                    </tr>
                </table>


            </div>
        </div>

        

    </div>


</div>
    <!-- Data Grid Menu-->
<div class="emov-a-rc-table-cover">
                          
    <div id="DivGrid" runat="server" style="display:none;">

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
        <asp:GridView ID="grdIteamDetails" runat="server" AllowPaging="true" AllowSorting="true" AutoGenerateColumns="False" Border="0px" BorderColor="White" CssClass="emov-a-table-data" 
         PageSize="10" OnPageIndexChanging="grdIteamDetails_PageIndexChanging" ShowHeaderWhenEmpty="true" Width="100%" >
        <AlternatingRowStyle />
        <Columns>
     
        <asp:TemplateField HeaderStyle-CssClass="emov-a-table-heading" HeaderText="Return ID.">
        <ItemTemplate>
        <asp:Label ID="lblRTicketNo" runat="server" Text='<%# Bind("RTicketNo") %>'></asp:Label>
        </ItemTemplate>
        <ItemStyle HorizontalAlign="Center" />
        </asp:TemplateField>

        <asp:TemplateField HeaderStyle-CssClass="emov-a-table-heading" HeaderText="BarCode No.">
        <ItemTemplate>
        <asp:Label ID="lblBarCodeNo" runat="server" Text='<%# Bind("BarCodeNo") %>'></asp:Label>
        </ItemTemplate>
        <ItemStyle HorizontalAlign="Center" />
        </asp:TemplateField>

        <asp:TemplateField HeaderStyle-CssClass="emov-a-table-heading" HeaderText="Item Name">
        <ItemTemplate>
        <asp:Label ID="lblItemName" runat="server" Text='<%# Bind("ItemName") %>'></asp:Label>
        </ItemTemplate>
        <ItemStyle HorizontalAlign="Center" />
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
          

</asp:Panel>


        <!-- Message Div -->
<div id="lblloginmsg" runat="server" class="my-notify-error" style="display:none;">   </div>      




<!-- Add New Bill Details -->
<asp:Panel ID="Panel1" runat="server" > 
<div id="DivAdd" runat="server"  class="emov-page-main emov-page-main-no-top-padding" width="100%" style="display:none;">      
    <!-- Pofile Blue Div -->

    <div class="emov-a-single-user-card-header">   <h2 class="h2label">Item Stock Return</h2>  </div> 
       
    <div class="emov-a-single-user-card-cover">
            <!--changes -->    
         
             <div class="emov-a-profile-full-info" style="background: white">
                <table class="emov-a-table-data1">
                <tr>
                <td colspan="6">
                <div class="emov-a-single-user-uid-box">  
              
                <table class="emov-a-table-data1">
                 

                <%--Bill Infor --%>
                <tr>
                <td style="width: 15%;">  <p>Ticket No.:</p>   </td>
                <td style="width: auto;"> <p>    <asp:TextBox runat="server" class="emov-a-slot-creation-time-input emov-a-header-input-mob"  AutoPostBack="false" type="text" ID="txtBillNo" />                            </p>
                </td>
                <td style="width: auto;">   <p>Date.:&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</p>   </td>

                <td style="width: auto;">      <p> <asp:TextBox runat="server" class="emov-a-slot-creation-time-input emov-a-header-input-mob" AutoPostBack="false" type="text" ID="txtBillDate" />                            </p>
                </td>
                <td style="width: auto;">     <p>Currency:</p>   </td>
                <td style="width:  auto;">   <p>   <asp:TextBox runat="server" class="emov-a-slot-creation-time-input emov-a-header-input-mob" AutoPostBack="false" Text="NGN" type="text"  ID="txtCurrency" /> </p></td>                    </tr>
                     

                </table>
                </div>

                </td>
                </tr>
                  
                <tr>
                <td colspan="6" style="height: 8px;"></td>
                </tr>

                <%--BarCode No & ItemRegNo--%>
                <tr>
                <td style="width: 15%;"><p>BarCode/SKU No. :</p>   </td>
                <td >      <asp:TextBox runat="server" class="emov-a-slot-creation-time-input emov-a-header-input-mob"  AutoPostBack="false" type="text" ID="txtBarCodeNo" />       </td>                      
                <td colspan="2" style="width: 15%;"></td>
                <td style="width: 15%;"> <p>Item RegNo.:</p>    </td>
                <td>   <p>  <asp:TextBox runat="server" class="emov-a-slot-creation-time-input emov-a-header-input-mob" Width="100%" AutoPostBack="false" type="text" ID="txtItemRegNo" ReadOnly="false" /> </p>      </td>                      
                </tr>
                    
                <%--item Name  --%>
                <tr>
                <td>  <p>Item Name :</p>    </td>
                <td colspan="5">   <p>   <asp:TextBox runat="server" class="emov-a-slot-creation-time-input" Width="100%"  AutoPostBack="false" type="text" ID="txtItemName" /></p>       </td>                     
                </tr>

                   
                <%-- Specification --%>
                <tr>
                <td> <p>Item Specification:</p>    </td>
                <td colspan="5">    <p>   <asp:TextBox runat="server" class="emov-a-slot-creation-time-input" Width="100%" AutoPostBack="false" type="text" ID="txtItemSpecification" />  </p>            </td>
                </tr>


                <%--Unit Sales & Cost Price  --%>
                <tr> 
                <td style="width: 15%;"><p><span>Cost Price :</span></p>     </td>
                <td>
                <p>
                <asp:TextBox runat="server" class="emov-a-slot-creation-time-input emov-a-header-input-mob" AutoPostBack="false"   Width="100%"  type="text" ID="txtCostPrice" />
                </p>
                </td>
                <td colspan="2" style="width: 15%;"></td>
                <td style="width: 15%;">     <p><span>Sales Price :</span></p>      </td>
                <td>                           
                <p>
                <asp:TextBox runat="server" class="emov-a-slot-creation-time-input emov-a-header-input-mob" AutoPostBack="false"  Width="100%"  type="text" ID="txtSalesPrice" />
                </p>
                </td> 
                </tr>
                    
                  
                <%--Currect Quanity & Return Quanity --%>
                <tr> 
                <td style="width: 15%;"><p><span>Current Quantity :</span></p>     </td>
                <td>
                <p>
                <asp:TextBox runat="server" class="emov-a-slot-creation-time-input emov-a-header-input-mob" AutoPostBack="false"   Width="100%"  type="text" ID="txtCurrentQty" />
                </p>
                </td>
                <td colspan="2" style="width: 15%;"></td>
                <td style="width: 15%;">     <p><span>Return Quantity :</span></p>      </td>
                <td>                           
                <p>
                <asp:TextBox runat="server" class="emov-a-slot-creation-time-input emov-a-header-input-mob" AutoPostBack="false"  Width="100%"  type="text" ID="txtReturnQty" />
                </p>
                </td> 
                </tr>     
                    
                <tr> 
                <td style="width: 15%;"><p><span>Inword Ticket No. :</span></p>     </td>
                <td>
                <p>
                <asp:TextBox runat="server" class="emov-a-slot-creation-time-input emov-a-header-input-mob" AutoPostBack="false"  Width="100%"  type="text" ID="txtTicketNo" />
                </p>
                </td>
                <td colspan="2" style="width: 15%;"></td>
                <td style="width: 15%;">  </td>
                <td>  </td> 
                </tr>     




                <tr>
                    <td colspan="5">  </td>
                </tr>
                
                </table>

                <table class="emov-a-table-data1">       
                <tr>                   
                <td colspan="5" ></td>                    
                <td > <button id="btnRequest" type="button" runat="server" class="login-btn click"  style="float: right;"  ValidationGroup="AddSign"  onserverclick="btnRequestOpt"> Request </button></td>
                </tr>
                </table>    

                          
              </div>

        </div>

</div>

    </asp:Panel>
    <asp:HiddenField ID="hdnComID" runat="server" ClientIDMode="Static" Value=""  />
 <asp:HiddenField ID="hdnBrID" runat="server" ClientIDMode="Static" Value=""  />
   
</div>


</asp:Content>
