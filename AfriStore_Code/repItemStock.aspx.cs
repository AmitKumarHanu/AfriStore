using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class repItemStock : System.Web.UI.Page
{
    SqlConnection cn1 = new SqlConnection(CommonFunctions.connection.ToString());
    DataTable dt_login_details = new DataTable();


    protected DataTable objDs = new DataTable();
    protected DataTable objDsRep = new DataTable();

    

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
            //-------------- Suppiler Details------------------
            String qry1 = " Select SID, SupplierName from tbl_SupplierMaster where Com_ID='" + dt_login_details.Rows[0]["Com_ID"].ToString() + "' order by SupplierName";
            DataTable dt1 = new DataTable();
            dt1 = CommonFunctions.fetchdata(qry1);

            drpSupplier.DataSource = dt1;
            drpSupplier.DataValueField = "SID";
            drpSupplier.DataTextField = "SupplierName";
            drpSupplier.DataBind();
            drpSupplier.Items.Insert(0, new ListItem("--Supplier Name-", "0"));


            //-------------Bind Item Category Master----------------
            String qry2 = " Select CID, CategoryName from tbl_ItemCategory where Com_ID='" + dt_login_details.Rows[0]["Com_ID"].ToString() + "' order by CategoryName";
            DataTable dt2 = new DataTable();
            dt2 = CommonFunctions.fetchdata(qry2);

            drpCategory.DataSource = dt2;
            drpCategory.DataValueField = "CID";
            drpCategory.DataTextField = "CategoryName";
            drpCategory.DataBind();           
            drpCategory.Items.Insert(0, new ListItem("-Category Name-", "0"));




            //-------------Bind Item Brand Master----------------
            String qry3 = " Select distinct(Brand) From tbl_ItemTransferBranch  where CompID='" + dt_login_details.Rows[0]["Com_ID"].ToString() + "'  order by Brand ";
            DataTable dt3 = new DataTable();
            dt3 = CommonFunctions.fetchdata(qry3);

            drpBrand.DataSource = dt3;
            drpBrand.DataValueField = "Brand";
            drpBrand.DataTextField = "Brand";
            drpBrand.DataBind();
            drpBrand.Items.Insert(0, new ListItem("-Brand Name-", "0"));


        }
        catch (Exception ex)
        {
            DivMsg.Attributes.Add("class", "active");
            DivMsg.Attributes["style"] = "color:red; font-weight:bold;";
            DivMsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Please find correct details !" + " </h4>";
        }
    }



    protected void BtnSearchOpt(object sender, EventArgs e)
    {
        try
        {
            if (IsPostBack)
            {
                pnlDetails.Visible = false;
                pnlDetails.Attributes.Remove("class");


                //------------Filter Conditions-----------------

                string condition = "", Case = "", Heading = "";

                if (drpSupplier.SelectedIndex != 0)
                {
                    condition = condition + " and  SID  ='" + drpSupplier.SelectedValue + "' ";
                    Heading = Heading  + " SUPPLER : " + drpSupplier.SelectedItem + " ";
                }

                if (drpCategory.SelectedValue != "0")
                {
                    condition = condition + "  and CID = '" + drpCategory.SelectedValue.ToString() + "' ";
                    Heading = Heading + "  PORDUCT CATEGORY : " + drpCategory.SelectedItem + " ";
                }

                if (drpBrand.SelectedIndex != 0)
                {
                    condition = condition + " and  isnull(Brand,'0')  ='" + drpBrand.SelectedValue + "' ";
                    Heading = Heading +  "  PRODUCT BRAND : " + drpBrand.SelectedItem + " ";
                }

                lblfilter.Text = Heading.ToString();
                lblRFilter.Text = Heading.ToString();

                string qry = " Select ItemName, ItemSpecification, CategoryName, Brand,  CostPrice, Quantity, (Quantity* CostPrice)  AS Amount   from vw_ItemStockReport where Com_ID='" + dt_login_details.Rows[0]["Com_ID"].ToString() +
                "' and Br_ID='" + dt_login_details.Rows[0]["Br_ID"].ToString() + "'" + condition + "  order by  CategoryName, Brand  ";


                DataTable dtR = new DataTable();
                dtR = CommonFunctions.fetchdata(qry);
                objDs = dtR;

                if (dtR.Rows.Count > 0)
                {
                    Session["RegReportS"] = dtR;
                    lbl_total.Text = dtR.Rows.Count.ToString();
                    pnlMain.Attributes.Add("style", "display:block;");

                    pnlDetails.Visible = true;
                    pnlDetails.Attributes.Add("class", "active");

                }
                else
                {

                    lbl_total.Text = dtR.Rows.Count.ToString();

                }


            }
        }
        catch (Exception ex)
        {
            DivMsg.Attributes.Add("class", "active");
            DivMsg.Attributes["style"] = "color:red; font-weight:bold;";
            DivMsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Please check database connection details !" + " </h4>";
        }


    }


    protected void BtnPrinter(object sender, EventArgs e)
    {

        if (Session["RegReportS"] != null)
        {
            
            objDs = (DataTable)Session["RegReportS"];
            objDsRep = (DataTable)Session["RegReportS"];

            ScriptManager.RegisterStartupScript(this, GetType(), "key", "PrintContent();", true);
        }
       
    }

    protected void btnExcel_Click(object sender, EventArgs e)
    {
        Label LabelMessage = (Label)this.Page.Master.FindControl("lblmsg");
        string Message = string.Empty;


        try
        {

            if (Session["RegReportS"] != null)
            {
                //lblSFDateR.Text = lblFDate.Text;
                //lblSTDateR.Text = lblTDate.Text;
                objDs = (DataTable)Session["RegReportS"];
                objDsRep = (DataTable)Session["RegReportS"];

                // ScriptManager.RegisterStartupScript(this, GetType(), "key", "PrintContentSummary();", true);
                string html = HdnValue.Value;
                ExportToExcel(ref html, "Store_Summary_Report");
            }
           

        }

        catch (Exception ex)
        {

        }
    }

    public void ExportToExcel(ref string html, string fileName)
    {
        Label LabelMessage = (Label)this.Page.Master.FindControl("lblmsg");
        string Message = string.Empty;

        try
        {
            html = html.Replace("&gt;", ">");
            html = html.Replace("&lt;", "<");
            HttpContext.Current.Response.ClearContent();
            HttpContext.Current.Response.AddHeader("content-disposition", "attachment;filename=" + fileName + "_" + DateTime.Now.ToString("M_dd_yyyy_H_M_s") + ".xls");
            HttpContext.Current.Response.ContentType = "application/xls";
            HttpContext.Current.Response.Write(html);
            HttpContext.Current.Response.End();
        }
        catch (Exception ex)
        {

        }
    }
}
