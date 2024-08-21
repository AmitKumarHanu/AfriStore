<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="frmTest.aspx.cs" Inherits="AfriStore_Code.frmTest" %>
    <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">



ript src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>

<!-- jQuery Modal -->
<script src="Scripts/jquery.min.js"></script>
<script src="Scripts/jquery.modal.min.js"></script>
<link rel="stylesheet" href="Scripts/jquery.modal.min.css" />

    

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


    <!-- Modal HTML embedded directly into document -->
<div id="ex1" class="modal">
 <asp:Panel ID="Panel1" runat="server"  CssClass="container"  >  

<div id="DivPrintOpt" runat="server"  class="emov-page-main emov-page-main-no-top-padding" width="50%" align="center"   style="display:block;">   
    
<!-- White Div -->
    
<div class="emov-a-single-user-card-cover">
<%--  User Data ---%>
<div class="emov-a-single-user-card-header" >   <h2 class="h2label"> Receipt Print Successful </h2>   </div>
<div class="emov-a-single-user-card-inner-info"> 

    <table align="Center" >
    <tr>  
    <td style="width: 50%;"><asp:Button ID="btnSuccessful" runat="server" Text="Yes" Visible="true" class="login-btn"  />   </td>
    <td style="width: 50%;"> <asp:Button ID="btnReprint" runat="server" Text="No" Visible="true" class="login-btn"   />   </td> 
    </tr> 
    </table>

    </div></div>
      
</div>
 
</asp:Panel>
</div>
    <br /><br /><br /><br />
<!-- Link to open the modal -->

    <p><a href="#ex1" rel="modal:open">Open Modal</a></p>

 <%--   ---------------------%>
           
<!-- Receipt  Panel --> 
<asp:Panel ID="Panel4" runat="server" >  
    <div id="DivReceipt" runat="server"  class="emov-page-main emov-page-main-no-top-padding" width="100%" align="center"   style="display:block;">   
        
<!-- White Div -->
<div class="emov-a-profile-full-info" style="background: white">
<div class="emov-a-single-user-card-cover">
<%--  User Data ---%>
<div class="emov-a-single-user-card-header" >   <h2 class="h2label"> <asp:Label ID="Label1" runat="server" Font-Bold="true" Font-Size="XX-Large" Height="1px" Text="0" > Payment Receipt </asp:Label></h2>   </div>
     <table><tr><td > <button id="btnPrint" type="button" runat="server" class="emov-dash-icon-cover1" style="margin-right: 10px;"  onserverclick="BtnPrinter"> <a href="#ex1" rel="modal:open"> <i class="fa fa-print" aria-hidden="true" style="color:black;"></i>PRINTER </button></td> </a>    </tr></table>


<div class="emov-a-single-user-card-inner-info">    
    
<div id="DivPrint">

    <p>Hello ! How are you? </p>
    

</div>

</div></div>
   
</div>
        
    </div>
</asp:Panel>
  <%--  -------------------------%>







</asp:Content>
