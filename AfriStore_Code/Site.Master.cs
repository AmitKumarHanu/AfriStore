using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class SiteMaster : MasterPage
{

    DataTable dt_login_details = new DataTable();


    public string LabelMessage
    {
        get { return this.lblZoneCode.Text; }
        set { this.lblZoneCode.Text = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        //DataTable dt_login_details = new DataTable();
        dt_login_details = (DataTable)Session["LoginDetails"];

        if (dt_login_details != null && dt_login_details.Rows.Count > 0)
        {
            lbl_UserName.Text = dt_login_details.Rows[0]["First_Name"].ToString() + " " + dt_login_details.Rows[0]["Last_Name"].ToString();
            lbl_UserName_header.Text = dt_login_details.Rows[0]["First_Name"].ToString() + " " + dt_login_details.Rows[0]["Last_Name"].ToString();


            BindLeftMenu();



            //----User Images---------------
            if ((dt_login_details.Rows[0]["UserImage"].ToString()) != "")
            {
                byte[] imagem = (byte[])(dt_login_details.Rows[0]["UserImage"]);
                string PROFILE_PIC = Convert.ToBase64String(imagem);
                Session["img"] = imagem;
                ImgLogin.Src = String.Format("data:image/jpg;base64,{0}", PROFILE_PIC);
                ImgMobile.Src = String.Format("data:image/jpg;base64,{0}", PROFILE_PIC);
            }
            else
            {
                string imgPath1 = "Content/assets/images/UserImage.gif";
                ImgLogin.Src = "~/" + imgPath1;
                ImgMobile.Src = "~/" + imgPath1;
            }


        }
    }


    public void BindLeftMenu()
    {
        TVLeftMenu.Nodes.Clear();
        TreeNode CurrentNode = null;
        TreeNode tn = null;

        try
        {
            string fetchforms = "select FormName, FormURL from tbl_UserMaster a, tbl_GroupFormRelation b, tbl_FormMaster c where a.GroupID=b.GroupID and b.FormID=c.FormID and  a.UserId='" + dt_login_details.Rows[0]["UserId"].ToString() + "'  and b.status=1  order by FormURL ";

            //string fetchforms = "select FormName, FormURL from vw_formuserlink where UserTypeId='" + dt_login_details.Rows[0]["UserTypeId"].ToString() + "'  and IsActive=1  order by FormURL ";
            DataTable DtFormInfo = new DataTable();
            DtFormInfo = CommonFunctions.fetchdata(fetchforms);

            if (DtFormInfo == null)
                return;

            if (DtFormInfo != null)
            {
                if (DtFormInfo.Rows.Count > 0)
                {
                    //strSubmenu = DtFormInfo.Rows[0]["SUBMENU"].ToString();
                }
            }

            foreach (DataRow dr in DtFormInfo.Rows)
            {
                TreeNode rootNode = null;
                if (dr != null)
                {

                    tn = new TreeNode();
                    tn.Text = dr["FormName"].ToString();
                    tn.NavigateUrl = (string)(dr.IsNull("FormUrl") ? "" : dr["FormUrl"]);
                    string[] StrNavigateURL = new string[1];
                    StrNavigateURL = tn.NavigateUrl.Split(new char[] { '/' });
                    string[] StrCurrentURL = new string[1];
                    StrCurrentURL = HttpContext.Current.Request.Path.Split(new char[] { '/' });
                    if (StrNavigateURL[StrNavigateURL.Length - 1].Equals(StrCurrentURL[StrCurrentURL.Length - 1]))
                    {
                        CurrentNode = rootNode;
                    }
                    if (rootNode != null)
                    {
                        rootNode.ChildNodes.Add(tn);

                    }
                    else
                    {
                        TVLeftMenu.Nodes.Add(tn);

                    }

                }
            }
        }
        catch (Exception ex)
        {
            //LabelMessageCss = "errormsg";
            //LabelMessage = ex.Message.ToString();
        }
    }



    protected void lblLogout_ServerClick(object sender, EventArgs e)
    {
        Response.Redirect("Login.aspx");
    }
}
