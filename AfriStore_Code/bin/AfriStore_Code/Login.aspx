
<%@ Page Language="C#" AutoEventWireup="true" Inherits="Login" Codebehind="Login.aspx.cs" %>


<!DOCTYPE html>
<html lang="en">
   <head runat="server">
      <meta charset="UTF-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <title><%: Page.Title %> </title>
  
    <link href="Content/assets/style.css" rel="stylesheet" />
      <link
         rel="stylesheet"
         href="https://maxst.icons8.com/vue-static/landings/line-awesome/line-awesome/1.3.0/css/line-awesome.min.css"
      />

       <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />

       <style type="text/css">
        .lblmsg {
            padding-top:10px;
            padding-bottom:10px;
            padding-left:80px;
            padding-right:90px;
           
            font-size: 150%;
        }
    </style>

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
   </head>

   <body>
      <div class="emov-a-login-header">
        <%-- <img src="Content/assets/images/admin_logo.svg" alt="" />--%>
          <img src="Content/assets/images/logo.png" alt="" />
           
         <div class="emov-a-login-header-actions">
                        
           <%--<img src="Content/assets/images/logo2.png" alt="" />--%>
           <%-- <a href="Faq.aspx">FAQs</a>--%>
           <%-- <a href="Contact.aspx">Contact</a>--%>
            <%--<a href="Login.aspx">LOGIN</a>--%>
           <%-- <a href="#">APPLY NOW</a>--%>
         </div>
      </div>
      <div class="emov-a-login-main">
         <%--<img src="https://res.cloudinary.com/tobby/image/upload/f_auto,q_auto:best/v1613997822/login_bg.png" alt="" />--%>
         <img src="Content/assets/images/loginn_bg.png"  alt="" />
          
         <form runat="server" class="emov-a-login-form">
              <asp:ScriptManager runat="server" ID="scr" EnablePageMethods="true"></asp:ScriptManager>
             
            <div class="emov-a-login-headings" style="margin-top:-2%;">
               <h2>Welcome!</h2>
               <p>Login to your account</p>
            </div>
            <div
               class="emov-a-slot-form-group emov-a-slot-form-group-flex emov-a-slot-form-group-flex-login"
            >
               <label for="username" class="emov-a-slot-creation-time-label"
                  >Enter Username</label
               >

                
               <asp:TextBox runat="server"
                  
                  name="username"
                  id="txt_username"
                  class="emov-a-slot-creation-time-input"
               />
            </div>
            <div
               class="emov-a-slot-form-group emov-a-slot-form-group-flex emov-a-slot-form-group-flex-login"
            >
               <label for="
                   " class="emov-a-slot-creation-time-label"
                  >Enter Password</label
               >
               <asp:TextBox runat="server" type="password" name="password" id="txt_password" class="emov-a-slot-creation-time-input"
               />
            </div>

             <div style="font-size:14px;text-align:right;margin-top:5%;">
                 <asp:Label runat="server">Forgot	<a href="#" style="color:#f05223;">	Password?
						</a></asp:Label>
					</div>

              <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                       
                       <ContentTemplate>
            <div
               class="emov-a-single-user-final-actions-box emov-a-single-user-final-actions-box-login" style="margin-top:0px;"
            >
                <asp:Button ID="btn_login" Text="Sign in" runat="server" class="login-btn" OnClick="btn_login_Click"/>
            <%--   <button type="submit">sign in</button>--%>
            </div>


                     
                 <div style="margin-top:5%;width:100%;text-align:left; ">	<span>   
                     <div id="lblloginmsg" runat="server" class="my-notify-error" Visible="false"></div></span>
                 <a href="#" class="txt3">		</a>		</div>
                           </ContentTemplate></asp:UpdatePanel>
                           
         </form>
      </div>
   </body>

<script src="Content/app.js"></script>
    <script>
        window.onload = function () {
                document.querySelector("body").style.overflow = 'hidden';     
        };
    </script>
</html>

