<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="True"  CodeBehind="frmBillCounter.aspx.cs" Inherits="frmBillCounter" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">      

    <%--    --%>
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
  
    <!-- Get Item Details by Barcode -->
    <script language="javascript" type="text/javascript">
        $(function () {
            var hv = $("#<%=hdnComID.ClientID %>").val();
            var Br = $("#<%=hdnBrID.ClientID %>").val();

            $('#<%=txtBarCodeNo.ClientID%>').autocomplete({
                source: function (request, response) {
                    $.ajax({
                        url: "frmBillCounter.aspx/GetBarcode",
                        data: "{ 'BarCode':'" + request.term + "', 'ComID':'" + hv + "', 'BrID': '" + Br +"'}",
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
                                    TicketNo : item.TicketNo,
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
                    $('#<%=txtSalesPrice.ClientID%>').val(ui.item.SalesPrice.toFixed(2));
                    $('#<%=txtItemRegNo.ClientID%>').val(ui.item.ItemRegNo)                   
                    $("#<%=htnStockTicketNo.ClientID %>").val(ui.item.TicketNo);
                    return false;
                },
                select: function (event, ui) {
                    $('#<%=txtBarCodeNo.ClientID%>').val(ui.item.BarCodeNo);
                    $('#<%=txtItemName.ClientID%>').val(ui.item.Name);
                    $('#<%=txtItemSpecification.ClientID%>').val(ui.item.Specification);                
                    $('#<%=txtSalesPrice.ClientID%>').val(ui.item.SalesPrice.toFixed(2));
                    $('#<%=txtItemRegNo.ClientID%>').val(ui.item.ItemRegNo)
                    $("#<%=htnStockTicketNo.ClientID %>").val(ui.item.TicketNo);
                     return false;
                 },
             }).data("ui-autocomplete")._renderItem = function (ul, item) {
                 return $("<li class='ui-autocomplete-row'></li>")
                    .append("<a>BarCodeNo:" + item.BarCodeNo + "<br>Name: " + item.Name + "<br>Specification: " + item.Specification + "<br>Quantity: " + item.Quantity + "</a>")
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
                        url: "frmBillCounter.aspx/GetitemName",
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
                    
                     $('#<%=txtSalesPrice.ClientID%>').val(ui.item.SalesPrice.toFixed(2));
                     $('#<%=txtItemRegNo.ClientID%>').val(ui.item.ItemRegNo);
                     $("#<%=htnStockTicketNo.ClientID %>").val(ui.item.TicketNo);
                    return false;
                },
                select: function (event, ui) {
                    $('#<%=txtBarCodeNo.ClientID%>').val(ui.item.BarCodeNo);
                    $('#<%=txtItemName.ClientID%>').val(ui.item.Name);
                    $('#<%=txtItemSpecification.ClientID%>').val(ui.item.Specification);
           
                    $('#<%=txtSalesPrice.ClientID%>').val(ui.item.SalesPrice.toFixed(2));
                    $('#<%=txtItemRegNo.ClientID%>').val(ui.item.ItemRegNo);
                    $("#<%=htnStockTicketNo.ClientID %>").val(ui.item.TicketNo);
                    return false;
                },
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li class='ui-autocomplete-row'></li>")
                    .append("<a>BarCodeNo:" + item.BarCodeNo + "<br>Name: " + item.Name + "<br>Specification: " + item.Specification + "<br>Quantity: " + item.Quantity + "</a>")
                    .appendTo(ul);
            };
        });
     </script> 

    <!-- Get ReferedBy Details  -->
     <script language="javascript" type="text/javascript">
         $(function () {
             var hv = $("#<%=hdnComID.ClientID %>").val();
           
             $('#<%=txtReferetBy.ClientID%>').autocomplete({
                 source: function (request, response) {
                     $.ajax({
                         url: "frmBillCounter.aspx/GetReferedBy",
                         data: "{ 'ItemName':'" + request.term + "', 'ComID':'" + hv + "'}",
                         dataType: "json",
                         type: "POST",
                         contentType: "application/json; charset=utf-8",
                         success: function (data) {
                             response($.map(data.d, function (item) {
                                 return {
                                     R_ID: item.R_ID,
                                     Name: item.Name,
                                     ContactNo: item.ContactNo,
                                     Company: item.Company,                                    
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
                     $('#<%=txtReferetBy.ClientID%>').val(ui.item.R_ID);
              
                     return false;
                 },
                 select: function (event, ui) {
                     $('#<%=txtReferetBy.ClientID%>').val(ui.item.R_ID);
                    
                     return false;
                 },
             }).data("ui-autocomplete")._renderItem = function (ul, item) {
                 return $("<li class='ui-autocomplete-row'></li>")
                     .append("<a>ID:" + item.R_ID + "<br>Name: " + item.Name + "</a>")
                     .appendTo(ul);
             };
         });
     </script> 


    <!-- Get Customer Mobile No Details  -->
    
     <script language="javascript" type="text/javascript">
         $(function () {
             var hv = $("#<%=hdnComID.ClientID %>").val();

             $('#<%=txtCusMobileNo.ClientID%>').autocomplete({
                 source: function (request, response) {
                     $.ajax({
                         url: "frmBillCounter.aspx/GetCustomer",
                         data: "{ 'ItemName':'" + request.term + "', 'ComID':'" + hv + "'}",
                         dataType: "json",
                         type: "POST",
                         contentType: "application/json; charset=utf-8",
                         success: function (data) {
                             response($.map(data.d, function (item) {
                                 return {
                                     MobileNo: item.MobileNo,
                                     Name: item.Name,
                                     Email: item.Email,                                                                       
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
                     $('#<%=txtCusMobileNo.ClientID%>').val(ui.item.MobileNo);
                     $('#<%=txtCustName.ClientID%>').val(ui.item.Name);
                     $('#<%=txtCustEmailId.ClientID%>').val(ui.item.Email);

              
                     return false;
                 },
                 select: function (event, ui) {
                     $('#<%=txtCusMobileNo.ClientID%>').val(ui.item.MobileNo);
                     $('#<%=txtCustName.ClientID%>').val(ui.item.Name);
                     $('#<%=txtCustEmailId.ClientID%>').val(ui.item.Email);

                     return false;
                 },
             }).data("ui-autocomplete")._renderItem = function (ul, item) {
                 return $("<li class='ui-autocomplete-row'></li>")
                     .append("<a>Mobile No.:" + item.MobileNo + "<br>Name: " + item.Name + "</a>")
                     .appendTo(ul);
             };
         });
     </script> 


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

   
    <!--   Calculte Change and Due Amount -->
    <script type="text/javascript" >
        $(document).ready(function () {

            $(this).on("keypress", function (e) {

                /* if (e.keyCode == 13) {*/


                $('#<%=lblChangeAmount.ClientID%>').html();
                $('#<%=lblDueAmount.ClientID%>').html();

                $('#<%= txtPaidAmount.ClientID %>').change(function () {

                    var emp = $('#<%=txtPaidAmount.ClientID%>').val()

                    if (emp == "")
                        $('#<%=lblDueAmount.ClientID%>').html($('#<%=lblPayamount.ClientID%>').html())

                    if (emp == 0)
                        $('#<%=lblDueAmount.ClientID%>').html($('#<%=lblPayamount.ClientID%>').html())



                    var a = parseInt($('#<%=lblPayamount.ClientID%>').html(), 10);
                    var b = parseInt($('#<%=txtPaidAmount.ClientID%>').val(), 10);



                    var result = 0;
                    a = isNaN(a) ? 0 : a;

                    if (a > 0 && b > 0)
                        result = a - b;

                    if (result > 0) {
                        $('#<%=lblDueAmount.ClientID%>').html(Math.abs(+result).toFixed(2));
                        $('#<%=lblChangeAmount.ClientID%>').html(0.00);

                        $("#<%=hdnDueAmount.ClientID %>").val(Math.abs(+result).toFixed(2));
                        $("#<%=hdnChangeAmount.ClientID %>").val(0.00);

                    }
                    else {
                        $('#<%=lblChangeAmount.ClientID%>').html(Math.abs(+result).toFixed(2));
                        $('#<%=lblDueAmount.ClientID%>').html(0.00);


                        $("#<%=hdnChangeAmount.ClientID %>").val(Math.abs(+result).toFixed(2));
                        $("#<%=hdnDueAmount.ClientID %>").val(0.00);
                    }


                   
                    /*  alert("Hi Fun2 result " + result + "");*/

                });              

            });

        });

        //Allow only number 
        function Onnumber() {

            $('#<%= txtPaidAmount.ClientID %>').keypress(function (e) {

                var charCode = (e.which) ? e.which : event.keyCode

                if (String.fromCharCode(charCode).match(/[^0-9]/g))

                    return false;

            });

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
            <h3 style="font-size: 25px;" class="emov-applications-title">Ticket  Details</h3>
            <!-- Total Count-->
            <div class="emov-a-header-counter">
                <p>
                    <asp:Label ID="lbl_total" runat="server"></asp:Label>   Total
                </p>
            </div>
        </div>

        <div class="emov-a-header-action-group">
            <div class="emov-t-actions-group" style="display:block;">

                <table id="btnOpt" runat="server" style="width: 100%; display: block">
                    <tr>
                        <td>
                            <input type="text" id="txtSearch" runat="server" class="emov-a-header-input" placeholder="Ticket No." /></td>
                        <td></td>
                        <td>
                            <button id="btnSearch" type="button" runat="server" class="emov-dash-icon-cover1" style="margin-right: 10px;" onserverclick="BtnSearchOpt">SEARCH <i class="fa fa-search" aria-hidden="true"></i></button>
                        </td>
                        <td>
                            <button id="btnNew" type="button" runat="server" class="emov-dash-icon-cover1" style="margin-right: 10px;" onserverclick="BtnNewOpt">New <i class="fa fa-plus" aria-hidden="true"></i></button>
                        </td>
                       <%--  <td>
                            <button id="btnAdd" type="button" runat="server" class="emov-dash-icon-cover1" style="margin-right: 10px;" onserverclick="BtnAddOpt">Add <i class="fa fa-save" aria-hidden="true"></i></button>
                        </td>
                        <td>
                            <button id="btnEdit" type="button" runat="server" class="emov-dash-icon-cover1" style="margin-right: 10px;" onserverclick="BtnEditOpt">Edit <i class="fa fa-edit" aria-hidden="true"></i></button>
                        </td>--%>
                    </tr>
                </table>


            </div>
        </div>

    </div>


</div>
   </asp:Panel>

<!-- Message Div -->
<div id="lblloginmsg" runat="server" class="emov-page-main emov-page-main-no-top-padding" width="50%" align="center"   style="display:none;">      </div>

               
<!-- Add New Bill Details -->
<asp:Panel ID="Panel2" runat="server" > 
<div id="DivAdd" runat="server"  class="emov-page-main emov-page-main-no-top-padding" width="100%" style="display:none;">      
    <!-- Pofile Blue Div -->

    <div class="emov-a-single-user-card-header">   <h2 class="h2label">New Ticket  Details</h2>  </div> 
         
      
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
                        <td style="width: auto;"> <p>    <asp:TextBox runat="server" class="emov-a-slot-creation-time-input emov-a-header-input-mob" ReadOnly="true"  AutoPostBack="false" type="text" ID="txtBillNo" />                            </p>
                        </td>
                         <td style="width: auto;">   <p>Date.:&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</p>   </td>

                        <td style="width: auto;">      <p> <asp:TextBox runat="server" class="emov-a-slot-creation-time-input emov-a-header-input-mob" ReadOnly="true" AutoPostBack="false" type="text" ID="txtBillDate" />                            </p>
                        </td>
                        <td style="width: auto;">     <p>Currency:</p>   </td>
                        <td style="width:  auto;">   <p>   <asp:TextBox runat="server" class="emov-a-slot-creation-time-input emov-a-header-input-mob" ReadOnly="true" AutoPostBack="false" Text="NGN" type="text"  ID="txtCurrency" /> </p></td>                    </tr>
                     

                </table>
        </div></td>
                    </tr>
                  
                    <tr>
                        <td colspan="6" style="height: 8px;"></td>
                    </tr>

                    <%--BarCode No & ItemRegNo--%>
                    <tr>
                        <td style="width: 15%;"><p>BarCode/SKU No. :</p>   </td>
                        <td > <asp:TextBox runat="server" class="emov-a-slot-creation-time-input emov-a-header-input-mob"  AutoPostBack="false" type="text" ID="txtBarCodeNo" />       </td>                      
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

                 
                        <%--Unit Price & Quantity  --%>
                    <tr>
                       <td style="width: 15%;">     <p><span>Sales Price :</span></p>      </td>
                        <td>                           
                            <p>
                               <%--<asp:TextBox runat="server" class="emov-a-slot-creation-time-input emov-a-header-input-mob" AutoPostBack="false" type="text" ID="txtSalesPrice"  Placeholder="0.00" ReadOnly="true" />--%>
                                  <input type="text" id="txtSalesPrice" runat="server" class="emov-a-slot-creation-time-input emov-a-header-input-mob" style="  text-align:right;   float:right;"  AutoPostBack="false"  Placeholder="0.00" ReadOnly="readonly" />
                               </p> <asp:HiddenField runat="server" ID="hdfSalesPrice"  />
                        </td> 

                        <td  style="width: 15%;"><p>Discount Amount:</p>  </td>
                        <td style="width: 15%;"> 
                            <p><asp:TextBox runat="server" class="emov-a-slot-creation-time-input emov-a-header-input-mob"  Width="100%" style="  text-align:right;   float:right;" AutoPostBack="false" type="text" ID="txtDiscountAmount" Placeholder="0.00" Text="0" /></p>
                           <asp:HiddenField runat="server" ID="hdfDiscountAmount"  /></td>
                      
                      <td style="width: 15%;">     <p>Quantity:</p>     </td>
                        <td>
                            <p>
                                <asp:TextBox runat="server" class="emov-a-slot-creation-time-input emov-a-header-input-mob"  Width="100%"  style="  text-align:right;   float:right;"  AutoPostBack="false" type="text" ID="txtItemQuantity" Text="1" />
                             </p>
                        </td>
                        </tr>
                
                    <tr>
                         <td style="width: 15%;"> </td>
                         
                         <td style="width: 15%;"></td>
                        <td  colspan="4">
                          
                         <asp:Button ID="btnAddProduct" runat="server" class="login-btn" style="float: right;" onmousemove="getPrice()"  OnClick="btnAddProduct_Click" Text="Add" Visible="true" />
                            
                        </td>
                    </tr>

                    
                                      
                
                      </table>

<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
<ContentTemplate>    
       <div id="lblMessage" runat="server" class="my-notify-error" style="display:none;"> </div>
                        <table class="emov-a-table-data1" id="tgrid" runat="server"  width="100%;">
                        <tr>
                        <td   colspan="8"  style="border-color:antiquewhite;  border-width:2px" onscroll="ture">
                        <%--   Data Grid --%>                    
                            <fieldset style="  width: 100%; height: 320px;">
                            <legend> Items </legend>          
                        <div id="div_search_results" runat="server" style="max-height: 300px;  overflow-y: auto;   overflow-x: hidden;">                      

                        <asp:GridView ID="grdAddToCard" runat="server"  AllowSorting="true" AutoGenerateColumns="False" Border="0px" BorderColor="White" CssClass="emov-a-table-data" 
                        ShowHeaderWhenEmpty="true"  style="width: 100%;"   >
                        <AlternatingRowStyle />
                        <Columns>
                        <asp:TemplateField HeaderStyle-CssClass="emov-a-table-heading" HeaderText="item Name">
                        <ItemTemplate>
                        <asp:Label ID="lblItemName" runat="server" Text='<%# Bind("Name") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderStyle-CssClass="emov-a-table-heading" HeaderText="Item Details">
                        <ItemTemplate>
                        <asp:Label ID="lblItemDetails" runat="server" Text='<%# Bind("Specification") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderStyle-CssClass="emov-a-table-heading" HeaderText="Price">
                        <ItemTemplate>
                        <asp:Label ID="lblPrice" runat="server" Text='<%# Bind("SalesPrice") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderStyle-CssClass="emov-a-table-heading" HeaderText="Discount">
                        <ItemTemplate>
                        <asp:Label ID="lblDiscount" runat="server" Text='<%# Bind("Discount") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                        </asp:TemplateField>

       
                        <asp:TemplateField HeaderStyle-CssClass="emov-a-table-heading" HeaderText="Quantity">
                        <ItemTemplate>
                        <asp:Label ID="lblQuantity" runat="server" Text='<%# Bind("Quantity") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderStyle-CssClass="emov-a-table-heading" HeaderText="Total Amount">
                        <ItemTemplate>
                        <asp:Label ID="lblTotalAmount" runat="server" Text='<%# Bind("TotalAmount") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                      
                        <asp:TemplateField HeaderStyle-CssClass="emov-a-table-heading" HeaderText="Barcode" Visible="false">
                        <ItemTemplate>
                        <asp:Label ID="lblBarcode" runat="server" Text='<%# Bind("BarcodeNo") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderStyle-CssClass="emov-a-table-heading" HeaderText="TicketNo" Visible="false">
                        <ItemTemplate>
                        <asp:Label ID="lblTicketNo" runat="server" Text='<%# Bind("TicketNo") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>


                        <asp:TemplateField HeaderStyle-CssClass="emov-a-table-heading"  HeaderText="Action">
                        <HeaderStyle HorizontalAlign="Left" />
                        <ItemStyle HorizontalAlign="Left" />
                        <ItemTemplate>

                        <asp:Label runat="server" ID="lblActions" Text='<%# Bind("ItemRegNo") %>'  Visible="false"/>
                        <asp:LinkButton ID="linkDelete" runat="server" CommandArgument='<%# Eval("ItemRegNo") %>' OnClick="linkDelete_Click"><i class="fas fa-trash" style='color:red'></i> </asp:LinkButton>

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
                                  </fieldset>
                        </td>
                        </tr>
                    
                                <%--item count  --%>
                                <tr>
                                    <td style="width: 200px;">
                                        <p> Total item :</p>
                                    </td>
                                    <td >
                                        <p>    <asp:TextBox ID="txtitemCount" runat="server" style="width: 150px; text-align:right; float:right;" AutoPostBack="false" class="emov-a-slot-creation-time-input emov-a-header-input-mob" ReadOnly="true" type="text" Text="0"  />
                                        </p>
                                    </td>

                                    <td style="width: 200px;">
                                        <p>  Total Discount:</p>
                                    </td>
                                    <td >
                                        <p>
                                            <asp:TextBox ID="txtTDiscount" runat="server" style="width: 150px; text-align:right; float:right; " AutoPostBack="false" class="emov-a-slot-creation-time-input emov-a-header-input-mob" ReadOnly="true" type="text" Text="0"  />
                                        </p>
                                    </td>

                                    <td style="width: 200px;">
                                        <p> Sub Total:</p>
                                    </td>
                                    <td >
                                        <p> <asp:TextBox ID="txtSubTotal" runat="server" style="width: 150px; text-align:right; float:right; " AutoPostBack="false" class="emov-a-slot-creation-time-input emov-a-header-input-mob" ReadOnly="true" type="text" Text="0"  />
                                        </p>
                                    </td>
                                    <td colspan="2" class="auto-style1" style=" text-align:center; width: 250px; " > 
                                        <p><asp:Label ID="lblTotalPayment" runat="server"  style=" text-align:right; width: 250px; " Font-Bold="true" Font-Size="XX-Large" Height="1px" Text="0.00" > </asp:Label>
                                        </p>
                                    </td>
                                </tr>
                              
                               
                            </table>                      
</ContentTemplate>
<Triggers>
<asp:AsyncPostBackTrigger ControlID="btnAddProduct" EventName="Click" /> 

</Triggers>
</asp:UpdatePanel>

               <div class="emov-a-single-user-uid-box">  
                 <table id="tableOpt" class="emov-a-table-data1"  runat="server" width="100%" style="display:block;" >
                 
                    

                    <%--Customer Details Info --%>
                    <tr >
                  
                        <td  style="width: 140px;">   <p style="margin-left: 5px;position: relative;top: -15px; float: left;">Mobile No*:</p>   </td>
                        <td >      <p> <asp:TextBox runat="server" class="emov-a-slot-creation-time-input emov-a-header-input-mob"  style="width: 150px;" AutoPostBack="false" type="text" ID="txtCusMobileNo" /> </p>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ErrorMessage="Mobile No. is required!" Display="Dynamic" ForeColor="Red"   ControlToValidate="txtCusMobileNo" ValidationGroup="AddSign" runat="server" /> 
                                                    <asp:RegularExpressionValidator ID="rvDigits" runat="server" ControlToValidate="txtCusMobileNo" ErrorMessage="Enter numbers only till 11 digit" ValidationGroup="AddSign"    ForeColor="Red" ValidationExpression="[0-9]{11}" />   
                        </td>
                        <td style="width: 200px;">   <p style="margin-left: 5px;position: relative;top: -15px; float: left;">Customer Name*:</p>   </td>
                        <td > <p>    <asp:TextBox runat="server" class="emov-a-slot-creation-time-input emov-a-header-input-mob"  style="width: 150px;" AutoPostBack="false" type="text" ID="txtCustName"  />  </p>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator11" ErrorMessage="Customer Name is required!" Display="Dynamic" ForeColor="Red"   ControlToValidate="txtCustName" ValidationGroup="AddSign" runat="server" />   
                                                    <asp:RegularExpressionValidator ID="rvNumeric" runat="server" ControlToValidate="txtCustName" ErrorMessage="Enter only alpha and numeric character" ValidationGroup="AddSign"    ForeColor="Red" ValidationExpression="[a-zA-Z0-9\s]*$" />   
      
                        </td>
                        <td style="width: 140px;">     <p style="margin-left: 5px;position: relative;top: -15px; float: left;">Email ID*:</p>   </td>
                        <td>   <p>   <asp:TextBox runat="server" class="emov-a-slot-creation-time-input emov-a-header-input-mob"  style="width: 150px;" AutoPostBack="false" Text="" type="text"  ID="txtCustEmailId" /> </p>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ErrorMessage="E-Mail Address is required!" Display="Dynamic" ForeColor="Red"   ControlToValidate="txtCustEmailId" ValidationGroup="AddSign" runat="server" />   
                                                    <asp:RegularExpressionValidator ID="regexEmailValid" runat="server" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"    ControlToValidate="txtCustEmailId"     ValidationGroup="AddSign"   ForeColor="Red" ErrorMessage="Please enter valid email format"></asp:RegularExpressionValidator>
                            
                        </td>  
                       <td style="width: 140px;">   <p  style="margin-left: 5px;position: relative;top: -15px; float: left;">Refered By:</p>   </td>
                       <td> <p style="margin-left: 5px;position: relative;top: -15px; float: left;">  <asp:TextBox runat="server"  class="emov-a-slot-creation-time-input emov-a-header-input-mob"  style="width: 150px;" AutoPostBack="false" type="text" ID="txtReferetBy"  />  </p>
                       </td>     
                   

                    </tr>
                 </table>
                </div>
                 <table class="emov-a-table-data1" >
                     <tr>                       
                      <td  style="width: 40%;"></td>
                      <td colspan="4"  style="width: 60%;" > <button id="btnPayment" type="button" runat="server" class="login-btn click"  style="float: right;"  ValidationGroup="AddSign"     onserverclick="btnPaymentOpt"> Payment </button></td>
                      
                 </tr>

                 </table>
            
              </div>
        </div>

</div>

    </asp:Panel>

<!-- Payment Payment  Panel --> 
<asp:Panel ID="Panel3" runat="server" >  
<div id="DvPayment" runat="server"  class="emov-page-main emov-page-main-no-top-padding" width="100%"    style="display:none;">   

<!-- White Div -->

<div class="emov-a-single-user-card-cover">
<%--  User Data ---%>
<div class="emov-a-single-user-card-header" >   <h2 class="h2label"> Total Payable :<asp:Label ID="lblPayamount" runat="server" Font-Bold="true" Font-Size="XX-Large" Height="1px" Text="0" ></asp:Label></h2>   </div>
<div class="emov-a-single-user-card-inner-info">          
   
<asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Always">
<ContentTemplate>        


<table class="emov-a-table-data1" >            
      

<tr>   
   <td colspan="3" style="height:8px;"></td>
</tr>


<tr>
<td style="width:20%;"></td>
<td style="width:20%;"></td>
<td style="width:20%"></td>

</tr>
     


<tr>
<td><p>Paid Amount :</p></td>
<td><p><asp:TextBox runat="server" class="emov-a-slot-creation-time-input emov-a-header-input-mob"  Text="0" Width="100%" ID="txtPaidAmount"  onkeypress="Onnumber()"   />    </p>
     <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtCusMobileNo" ErrorMessage="Zero or Blank space not allow" ValidationGroup="AddSignP"    ForeColor="Red" ValidationExpression="^\d+(\.\d\d)?$" />   
</td>
<td style="width:20%"></td>  
</tr>  
<tr>
<td><p>Change Amount :</p></td>
<td><p><asp:Label ID="lblChangeAmount" class="emov-a-slot-creation-time-input emov-a-header-input-mob" runat="server" Width="100%" Text="0"></asp:Label></p></td>
<td style="width:51px;"></td>
</tr>
<tr>
<td><p>Due Amount :</p></td>
<td><p><asp:Label ID="lblDueAmount" class="emov-a-slot-creation-time-input emov-a-header-input-mob" runat="server" Width="100%" Text="0" ></asp:Label></p></td>
<td style="width:51px;"></td>
</tr>
<tr>
<td><p><span>Pay by :</span></p></td>
<td> <asp:DropDownList class="emov-a-slot-creation-time-input emov-a-header-input-mob"  ID="drpPayby" AutoPostBack="false" Width="100%" runat="server"  >
                                                        <asp:ListItem Value="0" Selected="True">--Payment Mode-- </asp:ListItem>
                                                        <asp:ListItem Value="1" >Cash</asp:ListItem>
                                                        <asp:ListItem Value="2">POS</asp:ListItem>
                                                        <asp:ListItem Value="3">Bank Transfer</asp:ListItem>
                                                        <asp:ListItem Value="4">QR Code Scan</asp:ListItem>
                                                    </asp:DropDownList>
     <asp:RequiredFieldValidator ID="RequiredFieldValidator8" ErrorMessage="Please Select Payment Module !" Display="Dynamic" ForeColor="Red"  ControlToValidate="drpPayby" InitialValue="0"  ValidationGroup="AddSignP" runat="server" />
               
</td>
<td style="width:51px;"></td>
</tr>   
<tr>
<td><p>Sales Date :</p></td>
<td><p><asp:Label ID="lblSalesDate" runat="server" class="emov-a-slot-creation-time-input emov-a-header-input-mob"  Width="100%"></asp:Label></p></td>
<td style="width:20%"></td>      
</tr>            
<tr>   
    <td colspan="3" style="height:8px;"></td>
</tr>

</table>


</ContentTemplate>
    <Triggers>   <asp:AsyncPostBackTrigger ControlID="txtPaidAmount" EventName="TextChanged" />    </Triggers>
    
</asp:UpdatePanel>


    <table align="Center" >
    <tr>        
    <td style="width: 20%;"></td>
    <td style="width: 20%;"><asp:Button ID="btnPreviewReceipt" runat="server" Text="Receipt" Visible="true" class="login-btn"  style="float: right;" ValidationGroup="AddSignP"   OnClick="btnPreviewReceipt_Click"/>   </td>
    <td style="width: 20%;">  </td> 

    </tr> 
    </table>

    </div></div>       

</div>


</asp:Panel>
        
<!-- Receipt  Panel --> 
<asp:Panel ID="Panel4" runat="server" >  
    <div id="DivReceipt" runat="server"  class="emov-page-main emov-page-main-no-top-padding" width="100%" align="center"   style="display:none;">   
        
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
                        <asp:Label ID="lblItemName" Font-Size="Smaller" runat="server" Text='<%# Bind("Name") %>'></asp:Label>
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
                        <asp:Label ID="lblDiscount" Font-Size="Smaller" runat="server" Text='<%# Bind("Discount") %>'></asp:Label>
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
<Triggers>

<asp:AsyncPostBackTrigger ControlID="btnAddProduct" EventName="Click" /> 
</Triggers>
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

<asp:HiddenField ID="hdnComID" runat="server" ClientIDMode="Static" Value=""  />
<asp:HiddenField ID="hdnBrID" runat="server" ClientIDMode="Static" Value=""  />
<asp:HiddenField ID="htnStockTicketNo" runat="server" ClientIDMode="Static" Value=""  />


<asp:HiddenField ID="hdnChangeAmount" runat="server" ClientIDMode="Static" Value=""  />
<asp:HiddenField ID="hdnDueAmount" runat="server" ClientIDMode="Static" Value=""  />
</div>


</asp:Content>
