using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AfriStore_Code
{
    public partial class frmTest : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }



        protected void BtnPrinter(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "key", "PrintContent();", true);
        }
    }
}