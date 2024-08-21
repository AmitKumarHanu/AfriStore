using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class stUserMaster : System.Web.UI.Page
{
    SqlConnection cn1 = new SqlConnection(CommonFunctions.connection.ToString());
    DataTable dt_login_details = new DataTable();

    protected void Page_Load(object sender, EventArgs e)
    {
        //----------Load Fun-----------------
        try
        {
            if (Session["LoginId"] == null)
            {
                Server.Transfer("Login.aspx", false);
            }

            dt_login_details = (DataTable)Session["LoginDetails"];

            if (!IsPostBack)
            {
                bindgrid();
            }

            DivMsg.InnerHtml = "";
        }

        catch (Exception ex)
        {
            DivMsg.Attributes.Add("class", "active");
            DivMsg.Attributes["style"] = "color:red; font-weight:bold;";
            DivMsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Please find correct details !" + " </h4>";
        }
    }


    public void bindgrid()
    {
        //----------Bind Data Grid-----------------
        try
        {
            string qry = " Select * from vw_UserDetails where  Com_ID='" + dt_login_details.Rows[0]["Com_ID"].ToString() + "' and Br_ID = '" + dt_login_details.Rows[0]["Br_ID"].ToString() + "' and (Level= 0 or Level=3)  order by First_Name, Last_Name  ";


            DataTable dt = new DataTable();
            dt = CommonFunctions.fetchdata(qry);

            if (dt.Rows.Count > 0)
            {
                Session["grdUserDetails"] = dt;
                lbl_total.Text = dt.Rows.Count.ToString();
                grdUserDetails.DataSource = dt;
                grdUserDetails.DataBind();
            }
            else
            {
                lbl_total.Text = dt.Rows.Count.ToString();
                grdUserDetails.DataSource = null;
                grdUserDetails.DataBind();
            }

            //-------------Bind GroupMaster----------------
            string qry1 = " Select GroupID ,GroupName  from tbl_GroupMaster where (Level= 0 or Level=3)  order by GroupName";
            DataTable dt1 = new DataTable();
            dt1 = CommonFunctions.fetchdata(qry1);

            drpGroupName.DataSource = dt1;
            drpGroupName.DataValueField = "GroupID";
            drpGroupName.DataTextField = "GroupName";
            drpGroupName.DataBind();
            drpGroupName.Items.Insert(0, new ListItem("--Select Group--", "0"));

            drpEGroupName.DataSource = dt1;
            drpEGroupName.DataValueField = "GroupID";
            drpEGroupName.DataTextField = "GroupName";
            drpEGroupName.DataBind();
            drpEGroupName.Items.Insert(0, new ListItem("--Select Group--", "0"));


        }
        catch (Exception ex)
        {
            DivMsg.Attributes.Add("class", "active");
            DivMsg.Attributes["style"] = "color:red; font-weight:bold;";
            DivMsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Please find correct details !" + " </h4>";
        }
    }

    //--------------Add Option display div ----------------------
    protected void BtnAddOpt(object sender, EventArgs e)
    {
        try
        {
            pnlMain.Attributes.Add("style", "display:none;");
            pnlAddDiv.Attributes.Add("style", "display:block;");
            pnlViewDiv.Attributes.Add("style", "display:none;");
            pnlEdit.Attributes.Add("style", "display:none;");
        }
        catch (Exception ex)
        {
            DivMsg.Attributes.Add("class", "active");
            DivMsg.Attributes["style"] = "color:red; font-weight:bold;";
            DivMsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Please find correct details !" + " </h4>";
        }

    }

    //--------------Display Serach Div-----------------------
    protected void BtnSearchOpt(object sender, EventArgs e)
    {
        try
        {

            string qry = "";
            qry = "  Select * From  vw_UserDetails where ( UserName like '" + txtSearch.Value.Trim() + "%' or First_Name like '" + txtSearch.Value.Trim() + "%' or Last_Name like '" + txtSearch.Value.Trim() + "%' )  and Level=3  and Com_ID='" + dt_login_details.Rows[0]["Com_ID"].ToString() + "' and Br_ID = '" + dt_login_details.Rows[0]["Br_ID"].ToString() + "' and (Level= 0 or Level=3) order by First_Name, Last_Name ";


            DataTable dt = new DataTable();
            dt = CommonFunctions.fetchdata(qry);

            if (dt.Rows.Count > 0)
            {
                Session["grdUserDetails"] = dt;
                lbl_total.Text = dt.Rows.Count.ToString();
                grdUserDetails.DataSource = dt;
                grdUserDetails.DataBind();
            }
            else
            {
                lbl_total.Text = dt.Rows.Count.ToString();
                grdUserDetails.DataSource = null;
                grdUserDetails.DataBind();
            }

            pnlMain.Attributes.Add("style", "display:block;");
            pnlAddDiv.Attributes.Add("style", "display:none;");
            pnlViewDiv.Attributes.Add("style", "display:none;");
            pnlEdit.Attributes.Add("style", "display:none;");

        }
        catch (Exception ex)
        {
            DivMsg.Attributes.Add("class", "active");
            DivMsg.Attributes["style"] = "color:red; font-weight:bold;";
            DivMsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Please find correct details !" + " </h4>";
        }


    }

    //--------------Add Option display div -----------------------
    protected void BtnEditOpt(object sender, EventArgs e)
    {
        try
        {
            if (txtSearch.Value.Trim() != String.Empty)
            {
                string qry = "";
                qry = "  Select * From  tbl_UserMaster where UserName = '" + txtSearch.Value.Trim() + "' and  Level=3 and Com_ID='" + dt_login_details.Rows[0]["Com_ID"].ToString() + "' and Br_ID = '" + dt_login_details.Rows[0]["Br_ID"].ToString() + "'  order by First_Name, Last_Name  "; 
                

                DataTable dt = new DataTable();
                dt = CommonFunctions.fetchdata(qry);

                if (dt.Rows.Count > 0)
                {
                    //----User Images---------------
                    if ((dt.Rows[0]["UserImage"].ToString()) != "")
                    {
                        byte[] imagem = (byte[])(dt.Rows[0]["UserImage"]);
                        string PROFILE_PIC = Convert.ToBase64String(imagem);
                        Session["img"] = imagem;
                        ImgEdit.Src = String.Format("data:image/jpg;base64,{0}", PROFILE_PIC);
                    }
                    else
                    {
                        string imgPath1 = "Content/assets/images/UserImage.gif";
                        ImgEdit.Src = "~/" + imgPath1;
                    }

                    lblEEmployeeID.Text = dt.Rows[0]["EmployeeID"].ToString();
                    txtEFirstName.Text = dt.Rows[0]["First_Name"].ToString();
                    txtELastName.Text = dt.Rows[0]["Last_Name"].ToString();
                    txtELoginID.Text = dt.Rows[0]["UserName"].ToString();
                    txtEPassword.Text = CommonFunctions.DecryptString(dt.Rows[0]["Password"].ToString()); ;
                    drpEGender.SelectedIndex = drpEGender.Items.IndexOf(drpEGender.Items.FindByValue(dt.Rows[0]["Gender"].ToString()));
                    drpEStatus.SelectedIndex = drpEStatus.Items.IndexOf(drpEStatus.Items.FindByValue(dt.Rows[0]["isActive"].ToString()));

                    txtEMobileNo.Text = dt.Rows[0]["MobileNo"].ToString();
                    txtEEmail.Text = dt.Rows[0]["Email"].ToString();
                    txtEDesignation.Text = dt.Rows[0]["Designation"].ToString();
                    txtELocation.Text = dt.Rows[0]["Location"].ToString();
                    drpEGroupName.SelectedIndex = drpEGroupName.Items.IndexOf(drpEGroupName.Items.FindByValue(dt.Rows[0]["GroupID"].ToString()));
                    //drpEZoneName.SelectedIndex = drpEZoneName.Items.IndexOf(drpEZoneName.Items.FindByValue(dt.Rows[0]["ZoneCode"].ToString()));



                    pnlMain.Attributes.Add("style", "display:none;");
                    pnlAddDiv.Attributes.Add("style", "display:none;");
                    pnlViewDiv.Attributes.Add("style", "display:none;");
                    pnlEdit.Attributes.Add("style", "display:block;");
                }
            }

        }
        catch (Exception ex)
        {
            DivMsg.Attributes.Add("class", "active");
            DivMsg.Attributes["style"] = "color:red; font-weight:bold;";
            DivMsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Please find correct details !" + " </h4>";
        }

    }

    //--------------Data Grid -----------------------

    protected void grdUserDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdUserDetails.PageIndex = e.NewPageIndex;
        this.bindgrid();
    }

    protected void grdUserDetails_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            int rowIndex = Convert.ToInt32(e.CommandArgument);

            //Reference the GridView Row.
            GridViewRow row = grdUserDetails.Rows[rowIndex];
        }
        catch (Exception ex)
        {
            DivMsg.Attributes.Add("class", "active");
            DivMsg.Attributes["style"] = "color:red; font-weight:bold;";
            DivMsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Please find correct details !" + " </h4>";
        }
    }

    protected void grdUserDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(grdUserDetails, "Select$" + e.Row.RowIndex);
                e.Row.Attributes["style"] = "cursor:pointer";
            }
        }
        catch (Exception ex)
        {
            DivMsg.Attributes.Add("class", "active");
            DivMsg.Attributes["style"] = "color:red; font-weight:bold;";
            DivMsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Please find correct details !" + " </h4>";
        }
    }

    protected void grdUserDetails_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            Label lblUserName = (Label)grdUserDetails.SelectedRow.FindControl("lblUserName");
            string qry = "";

            qry = "  Select top 1 * From  vw_UserDetails where UserName = '" + lblUserName.Text.Trim() + "'  order by First_Name, Last_Name ";

            DataTable dt = new DataTable();
            dt = CommonFunctions.fetchdata(qry);

            if (dt.Rows.Count > 0)
            {
                //----User Images---------------
                if ((dt.Rows[0]["UserImage"].ToString()) != "")
                {
                    byte[] imagem = (byte[])(dt.Rows[0]["UserImage"]);
                    string PROFILE_PIC = Convert.ToBase64String(imagem);
                    Session["img"] = imagem;
                    UserImage.Src = String.Format("data:image/jpg;base64,{0}", PROFILE_PIC);
                }
                else
                {
                    string imgPath1 = "Content/assets/images/UserImage.gif";
                    UserImage.Src = "~/" + imgPath1;
                }

                lblLoginID.Text = "Reg No. " + dt.Rows[0]["EmployeeID"].ToString();
                lblFirst_Name.Text = dt.Rows[0]["First_Name"].ToString();
                lblLast_Name.Text = dt.Rows[0]["Last_Name"].ToString();
                lblUserName1.Text = dt.Rows[0]["UserName"].ToString();

                lblPassword.Text = dt.Rows[0]["Password"].ToString();
                //lblConfirmPassword.Text = dt.Rows[0]["EmployeeID"].ToString();

                String Status = dt.Rows[0]["isActive"].ToString();
                if (Status == "1")
                    lblSatatus.Text = "Active";
                else if (Status == "0")
                    lblSatatus.Text = "Deactive";


                string Sex = dt.Rows[0]["Gender"].ToString();
                if (Sex == "M")
                    lblGender.Text = "Male";
                else if (Sex == "F")
                    lblGender.Text = "Female";

                lblMobileNo.Text = dt.Rows[0]["MobileNo"].ToString();
                lblEmail.Text = dt.Rows[0]["Email"].ToString();
                lblDesignation.Text = dt.Rows[0]["Designation"].ToString();
                lblLocation.Text = dt.Rows[0]["Location"].ToString();
                lblGroupName.Text = dt.Rows[0]["GroupName"].ToString();
                //lblZoneName.Text = dt.Rows[0]["ZoneName"].ToString();




                pnlMain.Attributes.Add("style", "display:none;");
                pnlAddDiv.Attributes.Add("style", "display:none;");
                pnlViewDiv.Attributes.Add("style", "display:block;");
                pnlEdit.Attributes.Add("style", "display:none;");
            }


        }
        catch (Exception ex)
        {
            DivMsg.Attributes.Add("class", "active");
            DivMsg.Attributes["style"] = "color:red; font-weight:bold;";
            DivMsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Please find correct details !" + " </h4>";
        }
    }

    protected void btnBackAddUser_Click(object sender, EventArgs e)
    {
        try
        {

            pnlMain.Attributes.Add("style", "display:block;");
            pnlAddDiv.Attributes.Add("style", "display:none;");
            pnlViewDiv.Attributes.Add("style", "display:none;");
            pnlEdit.Attributes.Add("style", "display:none;");


        }
        catch (Exception ex)
        {

            DivMsg.Attributes.Add("class", "active");
            DivMsg.Attributes["style"] = "color:red; font-weight:bold;";
            DivMsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Please find correct details !" + " </h4>";
        }


    }

    protected void BtnBackFind_Click(object sender, EventArgs e)
    {
        try
        {
            pnlMain.Attributes.Add("style", "display:block;");
            pnlAddDiv.Attributes.Add("style", "display:none;");
            pnlViewDiv.Attributes.Add("style", "display:none;");
            pnlEdit.Attributes.Add("style", "display:none;");
        }
        catch (Exception ex)
        {

            DivMsg.Attributes.Add("class", "active");
            DivMsg.Attributes["style"] = "color:red; font-weight:bold;";
            DivMsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Please find correct details !" + " </h4>";
        }
    }

    protected void BtnEBack_Click(object sender, EventArgs e)
    {
       

        try
        {

            pnlMain.Attributes.Add("style", "display:block;");
            pnlAddDiv.Attributes.Add("style", "display:none;");
            pnlViewDiv.Attributes.Add("style", "display:none;");
            pnlEdit.Attributes.Add("style", "display:none;");


        }
        catch (Exception ex)
        {

            DivMsg.Attributes.Add("class", "active");
            DivMsg.Attributes["style"] = "color:red; font-weight:bold;";
            DivMsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Please find correct details !" + " </h4>";
        }

    }

    protected void btnSaveAddUser_Click(object sender, EventArgs e)
    {
        //----------Save Country Master Details-----------------
        try
        {

            if (txtFirstName.Text.ToString() != string.Empty && txtLoginID.Text.ToString() != string.Empty)
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = cn1;
                cmd.CommandText = "SP_AF_UserMaster";
                cmd.CommandType = CommandType.StoredProcedure;

                //SELECT[UserID] ,[EmployeeID],[First_Name],[Last_Name],[UserName],[Password],[Gender],[MobileNo],[Email],[Designation],[Location]
                //,[CreatedOn],[UpdatedOn],[CreatedBy],[UpdatedBy],[IFlag],[UserImage],[GroupID],[GroupCode],[ZoneCode]
                //FROM[tbl_UserMaster]

                //cmd.Parameters.AddWithValue("@EmployeeID", txtEmployeeID.Text.Trim().ToString());
                cmd.Parameters.AddWithValue("@First_Name", txtFirstName.Text.Trim().ToString());
                cmd.Parameters.AddWithValue("@Last_Name", txtLastName.Text.ToString());
                cmd.Parameters.AddWithValue("@UserName", txtLoginID.Text.Trim().ToString());
                cmd.Parameters.AddWithValue("@Password", CommonFunctions.EncryptString(txtPassword.Text.Trim().ToString()));
                cmd.Parameters.AddWithValue("@Gender", drpGender.SelectedValue.Trim());

                cmd.Parameters.AddWithValue("@MobileNo", txtMobileNo.Text.Trim().ToString());
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim().ToString());
                cmd.Parameters.AddWithValue("@Designation", txtDesignation.Text.ToString());
                cmd.Parameters.AddWithValue("@Location", txtLocation.Text.Trim().ToString());
                cmd.Parameters.AddWithValue("@isActive", Convert.ToInt32(drpStatus.SelectedValue.Trim()));
                cmd.Parameters.AddWithValue("@GroupID", drpGroupName.SelectedValue.Trim());
                cmd.Parameters.AddWithValue("@GroupCode", drpGroupName.SelectedItem.Text.Trim());
                cmd.Parameters.AddWithValue("@Com_ID", dt_login_details.Rows[0]["Com_ID"].ToString());
                cmd.Parameters.AddWithValue("@Br_id", dt_login_details.Rows[0]["Br_id"].ToString());
                cmd.Parameters.AddWithValue("@Userid", dt_login_details.Rows[0]["Userid"].ToString());
                cmd.Parameters.AddWithValue("@Flag", "Add");
                SqlParameter output = new SqlParameter("@EmpID", System.Data.SqlDbType.VarChar, 30);
                output.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(output);
                cn1.Open();
                cmd.ExecuteNonQuery();
                String R = output.Value.ToString();
                cn1.Close();

                if (R != String.Empty)
                {

                    //------------Save tab 1 details-------------           
                    if (FileUpload1.HasFile)
                    {
                        string filename = System.IO.Path.GetFileName(FileUpload1.PostedFile.FileName);
                        string contentType = FileUpload1.PostedFile.ContentType;
                        using (Stream fs = FileUpload1.PostedFile.InputStream)
                        {
                            using (BinaryReader br = new BinaryReader(fs))
                            {
                                byte[] bytes = br.ReadBytes((Int32)fs.Length);

                                Session["UserImage1"] = bytes;
                                SqlCommand cmd1 = new SqlCommand();
                                cmd1.Connection = cn1;
                                cmd1.CommandText = "SP_AF_UserImage";
                                cmd1.CommandType = CommandType.StoredProcedure;
                                cmd1.Parameters.AddWithValue("@UserImage", bytes);
                                cmd1.Parameters.AddWithValue("@UserName", txtLoginID.Text.Trim().ToString());
                                cmd1.Parameters.AddWithValue("@EmpID", R.ToString());

                                cmd1.Parameters.AddWithValue("@Flag", "AddImage");
                                SqlParameter output1 = new SqlParameter("@Success", SqlDbType.Int);
                                output1.Direction = ParameterDirection.Output;
                                cmd1.Parameters.Add(output1);
                                cn1.Open();
                                cmd1.ExecuteNonQuery();
                                String R1 = output1.Value.ToString();
                                cn1.Close();
                            }
                        }
                    }
                    if (R != String.Empty)
                    {

                        Response.Redirect("stUserMaster.aspx");
                    }
                    else
                    {
                        pnlMain.Attributes.Add("style", "display:block;");
                        pnlAddDiv.Attributes.Add("style", "display:none;");

                        DivMsg.Attributes.Add("class", "active");
                        DivMsg.Attributes["style"] = "color:red; font-weight:bold;";
                        DivMsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Application user photo image have error !" + " </h4>";
                    }

                       
                }
                else
                {
                    pnlMain.Attributes.Add("style", "display:block;");
                    pnlAddDiv.Attributes.Add("style", "display:none;");

                    DivMsg.Attributes.Add("class", "active");
                    DivMsg.Attributes["style"] = "color:red; font-weight:bold;";
                    DivMsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Application user details all ready exist !" + " </h4>";
                }
            }
            else
            {
                pnlMain.Attributes.Add("style", "display:block;");
                pnlAddDiv.Attributes.Add("style", "display:none;");

                DivMsg.Attributes.Add("class", "active");
                DivMsg.Attributes["style"] = "color:red; font-weight:bold;";
                DivMsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Please fill details on all the require fields !" + " </h4>";
            }

        }
        catch (Exception ex)
        {
            pnlMain.Attributes.Add("style", "display:block;");
            pnlAddDiv.Attributes.Add("style", "display:none;");

            DivMsg.Attributes.Add("class", "active");
            DivMsg.Attributes["style"] = "color:red; font-weight:bold;";
            DivMsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Please check database connection details !" + " </h4>";
        }
    }

    protected void btnEUpdate_Click(object sender, EventArgs e)
    {
        //----------Save Country Master Details-----------------
        try
        {

            if (txtEFirstName.Text.ToString() != string.Empty && txtELoginID.Text.ToString() != string.Empty)
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = cn1;
                cmd.CommandText = "SP_AF_UserMaster";
                cmd.CommandType = CommandType.StoredProcedure;



                //cmd.Parameters.AddWithValue("@EmployeeID", txtEmployeeID.Text.Trim().ToString());
                cmd.Parameters.AddWithValue("@First_Name", txtEFirstName.Text.Trim().ToString());
                cmd.Parameters.AddWithValue("@Last_Name", txtELastName.Text.ToString());
                cmd.Parameters.AddWithValue("@UserName", txtELoginID.Text.Trim().ToString());
                cmd.Parameters.AddWithValue("@Password", CommonFunctions.EncryptString(txtEPassword.Text.Trim().ToString()));
                cmd.Parameters.AddWithValue("@Gender", drpEGender.SelectedValue.Trim());

                cmd.Parameters.AddWithValue("@MobileNo", txtEMobileNo.Text.Trim().ToString());
                cmd.Parameters.AddWithValue("@Email", txtEEmail.Text.Trim().ToString());
                cmd.Parameters.AddWithValue("@Designation", txtEDesignation.Text.ToString());
                cmd.Parameters.AddWithValue("@Location", txtELocation.Text.Trim().ToString());
                cmd.Parameters.AddWithValue("@isActive", Convert.ToInt32(drpEStatus.SelectedValue.Trim()));
                cmd.Parameters.AddWithValue("@GroupID", drpEGroupName.SelectedValue.Trim());
                cmd.Parameters.AddWithValue("@GroupCode", drpEGroupName.SelectedItem.Text.Trim());
                cmd.Parameters.AddWithValue("@Com_ID", dt_login_details.Rows[0]["Com_ID"].ToString());
                cmd.Parameters.AddWithValue("@Br_id", dt_login_details.Rows[0]["Br_id"].ToString());
                cmd.Parameters.AddWithValue("@Userid", dt_login_details.Rows[0]["Userid"].ToString());
                cmd.Parameters.AddWithValue("@Flag", "Update");
                SqlParameter output = new SqlParameter("@EmpID", System.Data.SqlDbType.VarChar, 30);
                output.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(output);
                cn1.Open();
                cmd.ExecuteNonQuery();
                String R = output.Value.ToString();
                cn1.Close();

                if (R != String.Empty)
                {
                    Response.Redirect("stUserMaster.aspx");
                }
                else
                {
                    pnlMain.Attributes.Add("style", "display:block;");                   
                    pnlEdit.Attributes.Add("style", "display:none;");

                    DivMsg.Attributes.Add("class", "active");
                    DivMsg.Attributes["style"] = "color:red; font-weight:bold;";
                    DivMsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Application user details all ready exist !" + " </h4>";
                }
            }
            else
            {
                pnlMain.Attributes.Add("style", "display:block;");
                pnlEdit.Attributes.Add("style", "display:none;");

                DivMsg.Attributes.Add("class", "active");
                DivMsg.Attributes["style"] = "color:red; font-weight:bold;";
                DivMsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Please fill details on all the require fields !" + " </h4>";
            }

        }
        catch (Exception ex)
        {
            pnlMain.Attributes.Add("style", "display:block;");
            pnlEdit.Attributes.Add("style", "display:none;");

            DivMsg.Attributes.Add("class", "active");
            DivMsg.Attributes["style"] = "color:red; font-weight:bold;";
            DivMsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Please check database connection details !" + " </h4>";
        }
    }
}
