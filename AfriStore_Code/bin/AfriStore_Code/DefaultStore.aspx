<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DefaultStore.aspx.cs" Inherits="DefaultStore" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    
       
 <%--Page design--%>

    <div class="emov-page-main">
          <br/>
            <br/>
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

         

           <!-- 1nd Chart-->
         <div class="emov-dash-stats-charts-wrapper" style="border-radius:20%;">
            <div class="donut-bg">
               <div id="piechart_store1" style="width: 100%; height: 400px">
               </div>
            </div>
            
            <div class="donut-bg">
               <div id="piechart_store2" style="width: 100%;height: 400px"></div>         
            </div>

              <div class="donut-bg">
               <div id="piechart_store3" style="width: 100%;height: 400px"></div>         
            </div>

        </div>

</div>

<%--         <!-- RECENT APPLICATIONS-->
         <div class="emov-a-rc-cover" style="display:block;">
            <div class="emov-a-rc-header" id="applications-table">
               <h4>Recent Application</h4>
              <p><asp:Label ID="lbl_total" runat="server"></asp:Label> </p>
            </div>
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

        <asp:GridView ID="grdLevel1" runat="server" AllowPaging="true" AllowSorting="true" AutoGenerateColumns="False" Border="0px" BorderColor="White" CssClass="emov-a-table-data" 
         PageSize="10" ShowHeaderWhenEmpty="true" Width="100%"   >
        <AlternatingRowStyle />
        <Columns>
        <asp:TemplateField HeaderStyle-CssClass="emov-a-table-heading" HeaderText="Applicant ID">
        <ItemTemplate>
        <asp:Label ID="lblApplicantId" runat="server" Text='<%# Bind("Applicant_Id") %>'></asp:Label>
        </ItemTemplate>
        <ItemStyle HorizontalAlign="Center" />
        </asp:TemplateField>
        <asp:TemplateField HeaderStyle-CssClass="emov-a-table-heading" HeaderText="First Name">
        <ItemTemplate>
        <asp:Label ID="lblFirstName" runat="server" Text='<%# Bind("FirstName") %>'></asp:Label>
        </ItemTemplate>
        <ItemStyle HorizontalAlign="Center" />
        </asp:TemplateField>
        <asp:TemplateField HeaderStyle-CssClass="emov-a-table-heading" HeaderText="Last Name">
        <ItemTemplate>
        <asp:Label ID="lblLast_Name" runat="server" Text='<%# Bind("LastName") %>'></asp:Label>
        </ItemTemplate>
        <ItemStyle HorizontalAlign="Left" />
        </asp:TemplateField>
        <asp:TemplateField HeaderStyle-CssClass="emov-a-table-heading" HeaderText="Passport No">
        <ItemTemplate>
        <asp:Label ID="lblPassport_No" runat="server" Text='<%# Bind("Passport_No") %>'></asp:Label>
        </ItemTemplate>
        <ItemStyle HorizontalAlign="Left" />
        </asp:TemplateField>

        <asp:TemplateField HeaderStyle-CssClass="emov-a-table-heading" HeaderText="Permit Type" ItemStyle-Width="14%" ItemStyle-Wrap="true">
        <ItemTemplate>
        <asp:Label ID="lblRP_Name" runat="server" Text='<%# Bind("RP_Name") %>'></asp:Label>
        </ItemTemplate>
        <ItemStyle HorizontalAlign="Left" />
        </asp:TemplateField>       

        <asp:TemplateField HeaderStyle-CssClass="emov-a-table-heading" HeaderText="Country" ItemStyle-Width="14%" ItemStyle-Wrap="true">
        <ItemTemplate>
        <asp:Label ID="lblCountryName" runat="server" Text='<%# Bind("CountryName") %>'></asp:Label>
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
         </div>--%>

</asp:Content>
