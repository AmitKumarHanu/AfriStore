<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="repStoreSalesSummary.aspx.cs" Inherits="repStoreSalesSummary" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


    
<link rel="stylesheet" type="text/css" href="Content/assets/css/daterangepicker.css" />

 <script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<%--<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />--%>
   
    <%-- JQuery Date Fun  --%>
<script type="text/javascript">
    $(function () {

        var start = moment().subtract(29, 'days');
        var end = moment();
        
        function cb(start, end) {
            //$('#txtSearch span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
            $('#txtSearch span').html(start.format('DD/MM/YYYY') + ' - ' + end.format('DD/MM/YYYY'));
        }

        $('#txtSearch').daterangepicker({
            startDate: start,
            endDate: end,
            ranges: {
                'Today': [moment(), moment()],
                'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
                'Last 7 Days': [moment().subtract(6, 'days'), moment()],
                'Last 30 Days': [moment().subtract(29, 'days'), moment()],
                'This Month': [moment().startOf('month'), moment().endOf('month')],
                'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
            }
        }, cb);

        cb(start, end);

    });

</script>
    <%--  Vildate Date fun--%>
<script type="text/Jscript"> 
    function getDtRange() {
        $("#hfProduct").val($("#txtSearch").text());
        // alert('Hi 2 ' + $("#hfProduct").val());
    }
</script>
    
    <%--  Printer  fun--%>
 <script type="text/javascript" >
     function PrintContentSummary() {
         var html = "<html>";
         html += document.getElementById("DivPrintSummary").innerHTML;
         html += "</html>";

         var printWin = window.open('', '', 'location=no,width=10,height=10,left=50,top=50,toolbar=no,scrollbars=no,status=0,titlebar=no');

         printWin.document.write(html);
         printWin.document.close();
         printWin.focus();
         printWin.print();
         printWin.close();
     }


     function PrintContentDetails() {
         var html = "<html>";
         html += document.getElementById("DivPrintDetails").innerHTML;
         html += "</html>";

         var printWin = window.open('', '', 'location=no,width=10,height=10,left=50,top=50,toolbar=no,scrollbars=no,status=0,titlebar=no');

         printWin.document.write(html);
         printWin.document.close();
         printWin.focus();
         printWin.print();
         printWin.close();
     }

 </script>
    <%--  Convert html to PDF  fun--%>
<%-- <script src="https://code.jquery.com/jquery-1.12.4.js"></script>--%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.3/jspdf.min.js"></script>
<script src="https://html2canvas.hertzen.com/dist/html2canvas.js"></script>
<script>
    function getPDF() {

        var HTML_Width = $(".canvas_div_pdf").width();
        var HTML_Height = $(".canvas_div_pdf").height();
        var top_left_margin = 15;
        var PDF_Width = HTML_Width + (top_left_margin * 2);
        var PDF_Height = (PDF_Width * 1.5) + (top_left_margin * 2);
        var canvas_image_width = HTML_Width;
        var canvas_image_height = HTML_Height;

        var totalPDFPages = Math.ceil(HTML_Height / PDF_Height) - 1;


        html2canvas($(".canvas_div_pdf")[0], { allowTaint: true }).then(function (canvas) {
            canvas.getContext('2d');

            console.log(canvas.height + "  " + canvas.width);


            var imgData = canvas.toDataURL("image/jpeg", 1.0);
            var pdf = new jsPDF('p', 'pt', [PDF_Width, PDF_Height]);
            pdf.addImage(imgData, 'JPG', top_left_margin, top_left_margin, canvas_image_width, canvas_image_height);


            for (var i = 1; i <= totalPDFPages; i++) {
                pdf.addPage(PDF_Width, PDF_Height);
                pdf.addImage(imgData, 'JPG', top_left_margin, -(PDF_Height * i) + (top_left_margin * 4), canvas_image_width, canvas_image_height);
            }
            var n = Date.now();
            pdf.save("Outward_Item_" + n + ".pdf");
        });
    };
</script>

    <%--Div Convert to Excel Download file--%>
    
               <script language="javascript" type="text/javascript">
                   function ExportDivDataToExcel() {
                             
                       var html = "<html>";
                       // alert('hi');
                       html += document.getElementById("DivReport").innerHTML;
                       html += "</html>";
                       //  alert(html);

                       html = html.replace(/>/g, '&gt;');
                       html = html.replace(/</g, '&lt;');

                       document.getElementById('<%=HdnValue.ClientID %>').value = html;
                     

                   }



               </script>

<div class="emov-page-container emov-step-wrapper">

      <!-- Main Div -->
     <asp:Panel ID="pnlMain" runat="server"  >

     <div id="div_main" runat="server" class="emov-page-main emov-page-main-no-top-padding">

     <!-- Header Menu-->
    <div class="emov-a-rc-header emov-a-rc-header-seun">
     <!-- Page Title-->
    <div  class="emov-header-page-title emov-header-page-title-table-vigo"   id="emov-application-title">
        <h3 style="font-size:25px;" class="emov-applications-title">Store Sales Report</h3>
        <!-- Total Count-->
        <div class="emov-a-header-counter">   <p><asp:Label ID="lbl_total" runat="server"></asp:Label> Total</p>  </div>  
    </div>

    <div class="emov-a-header-action-group">
        <div class="emov-t-actions-group" style="display:block;">  
        <table id="btnOpt" runat="server" style="width:100%; display:block">
        <tr>
       
        <td > <button id="btnSearch" type="button" runat="server" class="emov-dash-icon-cover1" style="margin-right: 10px;" onmousemove="getDtRange()"  onserverclick="BtnSearchOpt"   ><i class="fa fa-search" aria-hidden="true"></i> SEARCH </button></td>      
        <td > <button id="btnPrint" type="button" runat="server" class="emov-dash-icon-cover1" style="margin-right: 10px;"  onserverclick="BtnPrinter" ><i class="fa fa-print" aria-hidden="true"></i>PRINTER </button></td>  
        <td > <button id="btnDownload" type="button" runat="server" class="emov-dash-icon-cover1" style="margin-right: 10px;"  onclick="getPDF();"   ><i class="fa fa-download" aria-hidden="true"></i>PDF File </button></td> 
        <td > <i class="fa fa-file-excel-o"></i> <asp:Button ID="btnExcel" runat="server" CssClass="emov-dash-icon-cover1"   style="margin-right: 10px;" Text="Excel File"   OnClientClick="ExportDivDataToExcel()" OnClick="btnExcel_Click" /></td>  
       
        </tr>
        </table>
        </div>
        </div>

    </div>  
         
    <!-- Search Div Design-->
    <div class="emov-a-rc-table-cover">  

        <table>    
        <tr>               
        <td   width="30%" ><button id=""  class="emov-dash-icon-cover1" style="margin-right: 5px;" ><i class="fa fa-filter" aria-hidden="true"></i> FILTER BY :</button></td>        
        <td ><asp:DropDownList ID="drpReportType" runat="server" class="emov-a-header-input"  width="100%"    name="ReportType">
                <asp:ListItem Value="0" Selected disabled>--Report Type--</asp:ListItem>
                <asp:ListItem Text="Summary Report " Value="Summary"></asp:ListItem>
                <asp:ListItem Text="Details Report " Value="Details"></asp:ListItem>                   
                </asp:DropDownList>
        </td>
        <td ><asp:DropDownList class="emov-a-header-input"  width="100%"   ID="drpBillingLogin" runat="server">   </asp:DropDownList></td>
        <td >
            <asp:DropDownList class="emov-a-header-input"  width="100%"  ID="drpflags" runat="server">
            <asp:ListItem Value="0" Selected disabled>--Select Status--</asp:ListItem>
            <asp:ListItem Value="1">Wiating Payment</asp:ListItem>
            <asp:ListItem Value="2">Waiting Receipt</asp:ListItem>
            <asp:ListItem Value="3">Payment Completed</asp:ListItem>
            </asp:DropDownList>
        </td>
    
        <td >
            <div id="txtSearch" class="emov-a-header-input" width="100%" style="font-size:small; font-weight:lighter;"   ><i class="fa fa-calendar"></i>&nbsp;     <span></span> <i class="fa fa-caret-down"></i>    </div> 

        </td>

        <td></td>
        </tr>
        <tr>  
        <td colspan="6"><asp:HiddenField runat="server" ID="hfProduct" ClientIDMode="Static" /></td>
        </tr>
        </table>
       
         
    </div> 

    <!-- Data Grid Design-->
    <div class="emov-a-rc-table-cover">
                          
    <div id="div_Report" runat="server">
    <!-- table within data grid-->
  
        <div id="R1" align="center" style="overflow: scroll; height:350px;"  runat="server" >
    
        <div id="DivReport" style="width: 800px;">
          

         <div class="canvas_div_pdf">  

         <asp:panel id="pnlSummary" runat="server" Visible="false"  >
        <!-- Report Header-->
        <table style="width:100%;"  align="center">   
        <tr>
        <td align="center" colspan="8">&nbsp;</td>
        </tr>
        <tr>        
        <td align="center" colspan="8" class="h2label">STORE SALES REPORT</td>       
        </tr>     
       
        <tr>
      
        <td align="center" colspan="8" class="h2label">( FROM  <asp:Label ID="lblFDate" runat="server"></asp:Label>   &nbsp;TO&nbsp;<asp:Label ID="lblTDate" runat="server"></asp:Label>   )</td>   
        </tr>
         <tr>
             <!--Filter -->
            <td align="center" colspan="8" class="h3label">  
            <asp:Label ID="lblfilter" runat="server"></asp:Label>  </td>   
        </tr>

        <tr>
        <td align="center" colspan="8">&nbsp;</td>
        </tr>
                            
        </table>
           
       
        <!-- Report Details-->
        <% 
        if (objDs.Rows.Count > 0)
        { %>
 
        <table Class="emov-a-table-data"   border="1" cellspacing="1"  rules="all" style="width: 100%; overflow: scroll; clip: rect(auto, auto, auto, auto);">
        <tr class="emov-a-table-heading">
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">Sl.No.</th>                                                         
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">TicketNo</th>
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">Date</th>
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">CustomerName</th>  
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">Quantity</th>   
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">PaidAmount</th> 
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">ChangeAmount</th> 
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">DueAmount</th> 

        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">PaymentMode</th>  
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">Status</th>  
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">PaymentReceivedBy</th>       
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">StoreName</th>  
       
          
        </tr>
                           
        <%  int c = 1;
            int St = 0;
            float Sa=0, Sc=0, Sd=0, FinalAmount=0;
            for (int i = 0; i < objDs.Rows.Count; i++)
            {
                if (i>=0)
                {

        %>
        <tr class="Grid_Item_Alternaterow">
        <td align="center" valign="middle"> 
        <%=Convert.ToString(i+1)%>
        </td>
                                
        <td align="center" valign="middle">
        <%=Convert.ToString(objDs.Rows[i]["TicketNo"])%>
        </td>     
         
        <td align="center" valign="middle">
        <%=Convert.ToString(objDs.Rows[i]["TicketDate"])%>
        </td> 

        <td align="center" valign="middle">
        <%=Convert.ToString(objDs.Rows[i]["CustomerName"])%>
        </td>                               
        <td align="center" valign="middle">
        <%=Convert.ToString(objDs.Rows[i]["Quantity"])%>
        </td>
        <td align="center" valign="middle"> 
        <%=Convert.ToString  (objDs.Rows[i]["PaidAmount"]) %>
        </td>
        <td align="center" valign="middle"> 
        <%=Convert.ToString  (objDs.Rows[i]["ChangeAmount"]) %>
        </td>
         <td align="center" valign="middle"> 
        <%=Convert.ToString  (objDs.Rows[i]["DueAmount"]) %>
        </td>

        <td align="center" valign="middle"> 
        <%=Convert.ToString  (objDs.Rows[i]["PaymentMode"]) %>
        </td>      
         <td align="center" valign="middle"> 
        <%=Convert.ToString  (objDs.Rows[i]["Status"]) %>
        </td>
       
 
                  
        <td align="center" valign="middle"> 
        <%=Convert.ToString  (objDs.Rows[i]["PaymentReceivedBy"]) %>
        </td>      
        
        <td align="center" valign="middle"> 
        <%=Convert.ToString  (objDs.Rows[i]["BranchName"]) %>
        </td>   
       
        </tr>            
        <%      
                    St = St + Convert.ToInt32(objDs.Rows[i]["Quantity"]);
                    Sa = Sa + Convert.ToInt32(objDs.Rows[i]["PaidAmount"]);
                    Sc = Sc + Convert.ToInt32(objDs.Rows[i]["ChangeAmount"]);
                    Sd = Sd + Convert.ToInt32(objDs.Rows[i]["DueAmount"]);
                       
             
                }
            }
            FinalAmount = (Sa + Sd )- Sc;
            %>

       <tr class="Grid_Item_Alternaterow">
        <td colspan="4" align="right" valign="right" style="font-weight:bold" >Total &nbsp;  &nbsp;</td>
        <td  align="center" align="right" valign="right" style="font-weight:bold"> 
            <%=Convert.ToInt32(St)%>
        </td>
        <td  align="center" align="right" valign="right" style="font-weight:bold"> 
            <%=Convert.ToDecimal(Sa)%>
        </td>
        <td  align="center" align="right" valign="right" style="font-weight:bold"> 
            <%=Convert.ToDecimal(Sc)%>
        </td>
         <td  align="center" align="right" valign="right" style="font-weight:bold"> 
            <%=Convert.ToDecimal(Sd)%>
        </td>
        <td align="center"  align="left" valign="left" style="font-weight:bold"> 
            <%=Convert.ToDecimal(FinalAmount)%>
        </td>
           <td colspan="4"></td>
         </tr>
        </table>
         <%}     %>                    
        <br />
        </asp:panel> 



         <asp:panel id="pnlDetails" runat="server" Visible="false"  >
        <!-- Report Header-->
        <table style="width:100%;"  align="center">

   
        <tr>
        <td align="center" colspan="8">&nbsp;</td>
        </tr>
        <tr> 
       
        <td align="center" colspan="8" class="h2label">STORE SALES DETAIL REPORT</td>       
        </tr>
        
        <tr>
      
        <td align="center" colspan="8" class="h2label">( FROM  <asp:Label ID="lblDFDate" runat="server"></asp:Label>   &nbsp;TO&nbsp;<asp:Label ID="lblDTDate" runat="server"></asp:Label>   )</td>   
        </tr>
             <tr>
              <!--Filter -->
            <td align="center" class="h3label" colspan="8">
                <asp:Label ID="lblRFilter" runat="server"></asp:Label>
            </td>
            </tr>

        <tr>
        <td align="center" colspan="8">&nbsp;</td>
        </tr>
                            
        </table>
           
       
        <!-- Report Details-->
        <% 
        if (objDDs.Rows.Count > 0)
        { %>
 
        <table Class="emov-a-table-data"   border="1" cellspacing="1"  rules="all" style="width: 100%; overflow: scroll; clip: rect(auto, auto, auto, auto);">
        <tr class="emov-a-table-heading">
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">Sl.No.</th>                                                         
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">TicketNo</th>
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">Date</th>
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">CustomerName</th>  

        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">ItemName</th>  
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">ItemSpecification</th>  
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">Brand</th>  
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">item Category</th>  
   
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">BarCodeNo</th>  
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">Quantity</th>  

        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">SalesPrice</th>  
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">CostPrice</th>   
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">Discount</th> 
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">DiscountAmount</th> 
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">TotalAmount</th> 
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">Profile/Loss Amount</th> 
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">Status</th> 

        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">PaymentMode</th>  
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">Remark</th>  
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">PaymentReceivedBy</th>       
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">StoreName</th>  
       
          
        </tr>
                           
        <%  int c = 1;
            int St = 0;
            float Sa=0, Sc=0, Sd=0 , Cp=0, Pl=0;;
            for (int i = 0; i < objDDs.Rows.Count; i++)
            {
                if (i>=0)
                {

        %>
        <tr class="Grid_Item_Alternaterow">
        <td align="center" valign="middle"> 
        <%=Convert.ToString(i+1)%>
        </td>
                                
        <td align="center" valign="middle">
        <%=Convert.ToString(objDDs.Rows[i]["TicketNo"])%>
        </td> 
            
             
         <td align="center" valign="middle">
        <%=Convert.ToString(objDDs.Rows[i]["TicketDate"])%>
        </td> 

                               
        <td align="center" valign="middle">
        <%=Convert.ToString(objDDs.Rows[i]["CustomerName"])%>
        </td>  
            
            <td align="center" valign="middle">
        <%=Convert.ToString(objDDs.Rows[i]["ItemName"])%>
        </td>
            <td align="center" valign="middle">
        <%=Convert.ToString(objDDs.Rows[i]["ItemSpecification"])%>
        </td>
            <td align="center" valign="middle">
        <%=Convert.ToString(objDDs.Rows[i]["Brand"])%>
        </td>
        <td align="center" valign="middle"> 
        <%=Convert.ToString  (objDDs.Rows[i]["CategoryName"]) %>
        </td>

            <td align="center" valign="middle">
        <%=Convert.ToString(objDDs.Rows[i]["BarCodeNo"])%>
        </td>
            <td align="center" valign="middle">
        <%=Convert.ToString(objDDs.Rows[i]["Quantity"])%>
        </td>

        <td align="center" valign="middle">
        <%=Convert.ToString(objDDs.Rows[i]["SalesPrice"])%>
        </td>
              <td align="center" valign="middle">
        <%=Convert.ToString(objDDs.Rows[i]["CostPrice"])%>
        </td>

        <td align="center" valign="middle"> 
        <%=Convert.ToString  (objDDs.Rows[i]["Discount"]) %>
        </td>      

        <td align="center" valign="middle"> 
        <%=Convert.ToString  (objDDs.Rows[i]["DiscountAmount"]) %>
        </td>      
         <td align="center" valign="middle"> 
        <%=Convert.ToString  (objDDs.Rows[i]["TotalAmount"]) %>
        </td>
        <td align="center" valign="middle"> 
        <%=Convert.ToString  (objDDs.Rows[i]["PLAmount"]) %>
        </td>
            <td align="center" valign="middle"> 
        <%=Convert.ToString  (objDDs.Rows[i]["PL"]) %>
        </td>

        <td align="center" valign="middle"> 
        <%=Convert.ToString  (objDDs.Rows[i]["PaymentMode"]) %>
        </td>      
         <td align="center" valign="middle"> 
        <%=Convert.ToString  (objDDs.Rows[i]["Remark"]) %>
        </td>  
               <td align="center" valign="middle"> 
        <%=Convert.ToString  (objDDs.Rows[i]["PaymentReceivedBy"]) %>
        </td> 
        
            <td align="center" valign="middle"> 
        <%=Convert.ToString  (objDDs.Rows[i]["BranchName"]) %>
        </td>   
       
        </tr>            
        <%      
                    St = St + Convert.ToInt32(objDDs.Rows[i]["Quantity"]);
                    Sa = Sa + Convert.ToInt32(objDDs.Rows[i]["SalesPrice"]);
                    Sc = Sc + Convert.ToInt32(objDDs.Rows[i]["DiscountAmount"]);
                    Sd = Sd + Convert.ToInt32(objDDs.Rows[i]["TotalAmount"]);
                    Cp = Cp + Convert.ToInt32(objDDs.Rows[i]["CostPrice"]);    
                    Pl = Pl + Convert.ToInt32(objDDs.Rows[i]["PLAmount"]);
                }
            }
           
            %>

       <tr class="Grid_Item_Alternaterow">
        <td colspan="9" align="right" valign="right" style="font-weight:bold" >Total &nbsp;  &nbsp;</td>
        <td  align="center" align="right" valign="right" style="font-weight:bold"> 
            <%=Convert.ToInt32(St)%>
        </td>
        <td  align="center" align="right" valign="right" style="font-weight:bold"> 
            <%=Convert.ToDecimal(Sa)%>
        </td>
        <td  align="center" align="right" valign="right" style="font-weight:bold"> 
            <%=Convert.ToDecimal(Cp)%>
        </td>
           <td></td>
        <td  align="center" align="right" valign="right" style="font-weight:bold"> 
            <%=Convert.ToDecimal(Sc)%>
        </td>
         <td  align="center" align="right" valign="right" style="font-weight:bold"> 
            <%=Convert.ToDecimal(Sd)%>
        </td>
          
        <td align="center"  align="left" valign="left" style="font-weight:bold"> 
            <%=Convert.ToDecimal(Pl)%>
        </td>
           
         <td colspan="5"></td>
         </tr>
        </table>
         <%}     %>                    
        <br />
        </asp:panel>

        </div>
        </div>   

        </div>


    <!-- table within data grid-->
    </div>  </div>   

     </div>
     </asp:Panel>     
     
     <!-- Message Div -->
     <div  class="my-notify-error"  runat="server" id="DivMsg" style="margin-top:1%;width:100%;text-align:left; display:none;">   </div>



     <!-- Printing Div --> 
   
     <div id="DivPrintSummary" style="width: 800px; display:none;">
         
        <asp:panel id="pnlPrintSummary" runat="server"   >
          <!-- Reoirt Header-->
        <table id="ReportDetails" style="width:100%;" align="center">        
   
         <tr>
        <td align="center" colspan="8">&nbsp;</td>
        </tr>
        <tr>     
        
        <td align="center" colspan="8" class="h2label">STORE SALES REPORT</td>       
        </tr>        
        
        <tr>
        <td align="center" colspan="8" class="h2label">( FROM  <asp:Label ID="lblSFDateR" runat="server"></asp:Label>   &nbsp;TO&nbsp;<asp:Label ID="lblSTDateR" runat="server"></asp:Label>   )</td>   
        </tr>
             <tr>
              <!--Filter -->
            <td align="center" class="h3label" colspan="8">
                <asp:Label ID="lblRSFilter" runat="server"></asp:Label>
            </td>
            </tr>
        <tr>
        <td align="center" colspan="8">&nbsp;</td>
        </tr>
           
        </table>

         <!-- Report Details-->
        <% 
        if (objDsRep.Rows.Count > 0)
        { %>
       
       
        <table Class="emov-a-table-data"   border="1" cellspacing="1"  rules="all" style="width: 100%; overflow: scroll; clip: rect(auto, auto, auto, auto);">
        <tr class="emov-a-table-heading">
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">Sl.No.</th>                                                         
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">TicketNo</th>
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">CustomerName</th>  
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">Quantity</th>   
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">PaidAmount</th> 
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">ChangeAmount</th> 
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">DueAmount</th> 
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">PaymentMode</th>  
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">Status</th>  

        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">PaymentReceivedBy</th>  
     
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">StoreName</th>  
       
          
        </tr>
                           
        <%  int c = 1;
            int St = 0;
            float Sa=0, Sc=0, Sd=0, FinalAmount=0;
            for (int i = 0; i < objDsRep.Rows.Count; i++)
            {
                if (i>=0)
                {

        %>
        <tr class="Grid_Item_Alternaterow">
        <td align="center" valign="middle"> 
        <%=Convert.ToString(i+1)%>
        </td>
                                
        <td align="center" valign="middle">
        <%=Convert.ToString(objDsRep.Rows[i]["TicketNo"])%>
        </td>     
                               
        <td align="center" valign="middle">
        <%=Convert.ToString(objDsRep.Rows[i]["CustomerName"])%>
        </td>                               
        <td align="center" valign="middle">
        <%=Convert.ToString(objDsRep.Rows[i]["Quantity"])%>
        </td>
        <td align="center" valign="middle"> 
        <%=Convert.ToString  (objDsRep.Rows[i]["PaidAmount"]) %>
        </td>
        <td align="center" valign="middle"> 
        <%=Convert.ToString  (objDsRep.Rows[i]["ChangeAmount"]) %>
        </td>
         <td align="center" valign="middle"> 
        <%=Convert.ToString  (objDsRep.Rows[i]["DueAmount"]) %>
        </td>

        <td align="center" valign="middle"> 
        <%=Convert.ToString  (objDsRep.Rows[i]["PaymentMode"]) %>
        </td>      
         <td align="center" valign="middle"> 
        <%=Convert.ToString  (objDsRep.Rows[i]["Status"]) %>
        </td>
       
        <td align="center" valign="middle"> 
        <%=Convert.ToString  (objDsRep.Rows[i]["PaymentReceivedBy"]) %>
        </td>      
        
        <td align="center" valign="middle"> 
        <%=Convert.ToString  (objDsRep.Rows[i]["BranchName"]) %>
        </td>   
       
        </tr>            
        <%      
                    St = St + Convert.ToInt32(objDsRep.Rows[i]["Quantity"]);
                    Sa = Sa + Convert.ToInt32(objDsRep.Rows[i]["PaidAmount"]);
                    Sc = Sc + Convert.ToInt32(objDsRep.Rows[i]["ChangeAmount"]);
                    Sd = Sd + Convert.ToInt32(objDsRep.Rows[i]["DueAmount"]);
                  }
              
            }
            FinalAmount = (Sa + Sd )- Sc;
           
                %>
            

       <tr class="Grid_Item_Alternaterow">
        <td colspan="3" align="right" valign="right" style="font-weight:bold" >Total &nbsp;  &nbsp;</td>
        <td  align="center" align="right" valign="right" style="font-weight:bold"> 
            <%=Convert.ToInt32(St)%>
        </td>
        <td  align="center" align="right" valign="right" style="font-weight:bold"> 
            <%=Convert.ToDecimal(Sa)%>
        </td>
        <td  align="center" align="right" valign="right" style="font-weight:bold"> 
            <%=Convert.ToDecimal(Sc)%>
        </td>
        <td  align="center" align="right" valign="right" style="font-weight:bold"> 
            <%=Convert.ToDecimal(Sd)%>
        </td>

        <td  align="center"  align="left" valign="left" style="font-weight:bold"> 
            <%=Convert.ToDecimal(FinalAmount)%>
        </td>
            <td colspan="3"></td>
         </tr>
        </table>
         <%}     %>                    
        <br />
        </asp:panel>  

        </div>


     <div id="DivPrintDetails" style="width: 800px; display:none;">
     
        <asp:panel id="pnlPrintDetails" runat="server" >
         <!-- Report Summary Header-->
        <table style="width:100%;" align="center" >   
        <tr>
        <td align="center" colspan="8">&nbsp;</td>
        </tr>
        <tr> 
            <!--changes -->
        <td align="center" colspan="8" class="h2label">STORE SALES DETAILS REPORT</td>       
        </tr>
        
        <tr>
            <!--changes -->
        <td align="center" colspan="8"class="h2label">( FROM  <asp:Label ID="lblDDateFRep" runat="server"></asp:Label>   &nbsp;TO&nbsp;<asp:Label ID="lblDDateDRep" runat="server"></asp:Label>   )</td>   
        </tr>
             <tr>
              <!--Filter -->
            <td align="center" class="h3label" colspan="8">
                <asp:Label ID="lblRDFilter" runat="server"></asp:Label>
            </td>
            </tr>
        <tr>
        <td align="center" colspan="8">&nbsp;</td>
        </tr>
                            
        </table>
       <!-- Report Summary Display-->
        
        <% 
        if (objDDsRep.Rows.Count > 0)
        { %>
=        
       
        <table Class="emov-a-table-data"   border="1" cellspacing="1"  rules="all" style="width: 100%; overflow: scroll; clip: rect(auto, auto, auto, auto);">
        <tr class="emov-a-table-heading">
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">Sl.No.</th>                                                         
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">TicketNo</th>
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">CustomerName</th>  

        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">ItemName</th>  
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">ItemSpecification</th>  
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">Brand</th>  
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">item Category</th>  

        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">BarCodeNo</th>  
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">Quantity</th>  

        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">SalesPrice</th>  
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">CostPrice</th>   
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">Discount</th> 
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">DiscountAmount</th> 
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">TotalAmount</th> 
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">Profile/Loss Amount</th> 
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">Status</th> 

        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">PaymentMode</th>  
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">Remark</th>  
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">PaymentReceivedBy</th>       
        <th align="center" scope="col" style="white-space: nowrap;" valign="middle">StoreName</th>  
       
          
        </tr>
                           
        <%  int c = 1;
            int St = 0;
            float Sa=0, Sc=0, Sd=0, Cp=0, Pl=0;
            for (int i = 0; i < objDDsRep.Rows.Count; i++)
            {
                if (i>=0)
                {

        %>
        <tr class="Grid_Item_Alternaterow">
        <td align="center" valign="middle"> 
        <%=Convert.ToString(i+1)%>
        </td>
                                
        <td align="center" valign="middle">
        <%=Convert.ToString(objDDsRep.Rows[i]["TicketNo"])%>
        </td>     
                               
        <td align="center" valign="middle">
        <%=Convert.ToString(objDDsRep.Rows[i]["CustomerName"])%>
        </td>  
            
            <td align="center" valign="middle">
        <%=Convert.ToString(objDDsRep.Rows[i]["ItemName"])%>
        </td>
            <td align="center" valign="middle">
        <%=Convert.ToString(objDDsRep.Rows[i]["ItemSpecification"])%>
        </td>
            <td align="center" valign="middle">
        <%=Convert.ToString(objDDsRep.Rows[i]["Brand"])%>
        </td>
        <td align="center" valign="middle"> 
        <%=Convert.ToString  (objDDsRep.Rows[i]["CategoryName"]) %>
        </td>

            <td align="center" valign="middle">
        <%=Convert.ToString(objDDsRep.Rows[i]["BarCodeNo"])%>
        </td>
            <td align="center" valign="middle">
        <%=Convert.ToString(objDDsRep.Rows[i]["Quantity"])%>
        </td>

        <td align="center" valign="middle">
        <%=Convert.ToString(objDDsRep.Rows[i]["SalesPrice"])%>
        </td>
              <td align="center" valign="middle">
        <%=Convert.ToString(objDDsRep.Rows[i]["CostPrice"])%>
        </td>

        <td align="center" valign="middle"> 
        <%=Convert.ToString  (objDDsRep.Rows[i]["Discount"]) %>
        </td>      

        <td align="center" valign="middle"> 
        <%=Convert.ToString  (objDDsRep.Rows[i]["DiscountAmount"]) %>
        </td>      
         <td align="center" valign="middle"> 
        <%=Convert.ToString  (objDDsRep.Rows[i]["TotalAmount"]) %>
        </td>
        <td align="center" valign="middle"> 
        <%=Convert.ToString  (objDDsRep.Rows[i]["PLAmount"]) %>
        </td>
            <td align="center" valign="middle"> 
        <%=Convert.ToString  (objDDsRep.Rows[i]["PL"]) %>
        </td>

        <td align="center" valign="middle"> 
        <%=Convert.ToString  (objDDsRep.Rows[i]["PaymentMode"]) %>
        </td>      
         <td align="center" valign="middle"> 
        <%=Convert.ToString  (objDDsRep.Rows[i]["Remark"]) %>
        </td>  
               <td align="center" valign="middle"> 
        <%=Convert.ToString  (objDDsRep.Rows[i]["PaymentReceivedBy"]) %>
        </td> 
        
            <td align="center" valign="middle"> 
        <%=Convert.ToString  (objDDsRep.Rows[i]["BranchName"]) %>
        </td>   
       
        </tr>            
        <%      
                    St = St + Convert.ToInt32(objDDsRep.Rows[i]["Quantity"]);
                    Sa = Sa + Convert.ToInt32(objDDsRep.Rows[i]["SalesPrice"]);
                    Sc = Sc + Convert.ToInt32(objDDsRep.Rows[i]["DiscountAmount"]);
                    Sd = Sd + Convert.ToInt32(objDDsRep.Rows[i]["TotalAmount"]);
                    Cp = Cp + Convert.ToInt32(objDDsRep.Rows[i]["CostPrice"]);    
                    Pl = Pl + Convert.ToInt32(objDDsRep.Rows[i]["PLAmount"]);
             
                }
            }
           
            %>

              <tr class="Grid_Item_Alternaterow">
        <td colspan="9" align="right" valign="right" style="font-weight:bold" >Total &nbsp;  &nbsp;</td>
        <td  align="center" align="right" valign="right" style="font-weight:bold"> 
            <%=Convert.ToInt32(St)%>
        </td>
        <td  align="center" align="right" valign="right" style="font-weight:bold"> 
            <%=Convert.ToDecimal(Sa)%>
        </td>
        <td  align="center" align="right" valign="right" style="font-weight:bold"> 
            <%=Convert.ToDecimal(Cp)%>
        </td>
           <td></td>
        <td  align="center" align="right" valign="right" style="font-weight:bold"> 
            <%=Convert.ToDecimal(Sc)%>
        </td>
         <td  align="center" align="right" valign="right" style="font-weight:bold"> 
            <%=Convert.ToDecimal(Sd)%>
        </td>
          
        <td align="center"  align="left" valign="left" style="font-weight:bold"> 
            <%=Convert.ToDecimal(Pl)%>
        </td>
    
         <td colspan="5"></td>
         </tr>
        </table>
         <%}     %>                    
        <br />
        </asp:panel> 

        </div>

       <asp:HiddenField ID="HdnValue" runat="server" /> 
</div>




</asp:Content>
