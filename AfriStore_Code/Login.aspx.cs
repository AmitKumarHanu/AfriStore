using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    protected void btn_login_Click(object sender, EventArgs e)
    {
        if (txt_username.Text == "" || txt_password.Text == "")
        {
            lblloginmsg.Visible = true;
            lblloginmsg.InnerText = "Please enter username or password.";
            return;
        }


        string qry = "Select * from tbl_UserMaster where UserName=@LoginId and (Level = 0   or Level=3 ) ";
        DataTable dt = new DataTable();


        using (SqlConnection con = new SqlConnection(CommonFunctions.connection))
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.Parameters.AddWithValue("@LoginId", txt_username.Text.Trim());
                    cmd.Connection = con;
                    cmd.CommandText = qry;
                    con.Open();
                    sda.SelectCommand = cmd;
                    sda.Fill(dt);
                    con.Close();

                }
            }
        }

        if (dt.Rows.Count > 0)
        {
            if (dt.Rows[0]["isActive"].ToString() == "0")
            {
                lblloginmsg.Visible = true;
                lblloginmsg.InnerText = "The application login credential has deactivated now.";
                return;
            }

            String P = CommonFunctions.DecryptString(dt.Rows[0]["Password"].ToString().Trim());
            if (txt_password.Text.Trim() == P)
            {
                Session["LoginId"] = txt_username.Text;
                Session["LoginDetails"] = dt;
                lblloginmsg.Visible = false;

                if (dt.Rows[0]["GroupCode"].ToString() == "ADST")
                {
                    Response.Redirect("~/Default.aspx");
                }
                if (dt.Rows[0]["GroupCode"].ToString() == "MGST" || dt.Rows[0]["GroupCode"].ToString() == "RPST")
                {
                    Response.Redirect("~/DefaultStore.aspx");
                }
                if (dt.Rows[0]["GroupCode"].ToString() == "BLST" || dt.Rows[0]["GroupCode"].ToString() == "CAST")
                {
                    Response.Redirect("~/DefaultCountor.aspx");
                }

            }
            else
            {
                lblloginmsg.Visible = true;
                lblloginmsg.InnerText = "The password that you've entered is incorrect.";
                return;
            }
        }
        else
        {
            lblloginmsg.Visible = true;
            lblloginmsg.InnerText = "The username or password that you've entered is incorrect.";
            return;
        }
    }


}
