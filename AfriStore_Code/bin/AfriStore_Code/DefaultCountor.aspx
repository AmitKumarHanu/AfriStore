<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DefaultCountor.aspx.cs" Inherits="DefaultCountor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

     



       
 <%--Page design--%>

    <div class="emov-page-main">
         <div class="emov-page-heading">
            <h2>Welcome To <span><asp:Label ID="lblZoneName" runat="server" Text=""  Height="1px"></asp:Label></span><asp:Label ID="lblZoneCode" runat="server" Text=""  Visible="false" Height="1px"></asp:Label></h2>
         </div>
         <!-- CARD STATS -->
       <div class="emov-dash-stats-wrapper">
            <!-- Printed Card Count -->
            <div class="emov-dash-stats-card">
               <div class="emov-dash-icon-cover">
                  <img src="Content/assets/images/icons/local_printshop_icon.svg" alt="" style="   width: 30px;   height: 100%;">
               </div>
               <div class="emov-dash-stats-info">
                  <h6>TOTAL PRINT RECEIPT</h6>
                 <%-- <h3>20,000</h3>--%>
                  <h3> <asp:Label ID="lblReeciptCount" runat="server" Text=""  Height="1px"></asp:Label></h3>
               </div>
            </div>
             <!-- Printed Card Count -->
            <div class="emov-dash-stats-card">
                 
               <div class="emov-dash-icon-cover">
                  <img src="Content/assets/images/icons/text_snippet_icon.svg" alt="" style="  width: 30px;   height: 100%;" />
               </div>
               <div class="emov-dash-stats-info">
                  <h6>TOTAL ITEM SALES</h6>
                 <%-- <h3>35,000</h3>--%>
                  <h3> <asp:Label ID="lblItemSales" runat="server" Text=""  Height="1px"></asp:Label></h3>
               </div>
            </div>
             <!-- Sales Count -->
            <div class="emov-dash-stats-card">
               <div class="emov-dash-icon-cover">
                  <img src="Content/assets/images/icons/naira_icon.svg" alt="" style="   width: 30px;   height: 100%;" />
               </div>
               <div class="emov-dash-stats-info">
                  <h6>TOTAL SALES</h6>
                  <%--<h3>N250,000,000</h3>--%>
                   <h3><asp:Label ID="lblTotalSales" runat="server" Text=""  Height="1px"></asp:Label></h3>
               </div>
            </div>
          
            <!-- Profit Count -->
            <div class="emov-dash-stats-card">
               <div class="emov-dash-icon-cover">
                  <img src="Content/assets/images/icons/naira_icon.svg" alt="" style="   width: 30px;   height: 100%;" />
               </div>
               <div class="emov-dash-stats-info">
                  <h6>TOTAL PROFIT</h6>
                  <%--<h3>N250,000,000</h3>--%>
                   <h3><asp:Label ID="lblProfit" runat="server" Text=""  Height="1px"></asp:Label></h3>
               </div>
            </div>

         </div>

         
           <!-- 1st Chart-->
         <div class="emov-dash-stats-charts-wrapper" style="border-radius:20%;">
           
              
            <div class="donut-bg">
               <div id="piechart_Counter_Category" style="width: 100%;height: 400px"></div>         
            </div>

            <div class="donut-bg">
               <div id="piechart_Counter_Brand" style="width: 100%;height: 400px"></div>         
            </div>
           <div class="line-chart-bg">
               <div id="curve_counter_chart_store" style="width: 100%; height: 400px">
               </div>
            </div>
        </div>

      
          
        <!-- 2nd Chart-->
         <div class="emov-dash-stats-charts-wrapper" style="border-radius:20%;">
           
              <div class="line-chart-bg">
               <div id="LineChart_Counter" style="width: 100%; height: 400px">
               </div>
            </div>
          </div>
      
      </div>



</asp:Content>
