using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class repItemInword : System.Web.UI.Page
{
    SqlConnection cn1 = new SqlConnection(CommonFunctions.connection.ToString());
    DataTable dt_login_details = new DataTable();


    protected DataTable objDs = new DataTable();
    protected DataTable objDsRep = new DataTable();

    protected DataTable objSDs = new DataTable();
    protected DataTable objSDsRep = new DataTable();

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

            //-------------Bind Store Master----------------
            String qry1 = " Select Br_ID, Br_Name From tbl_BranchMaster where Com_ID='" + dt_login_details.Rows[0]["Com_ID"].ToString() + "' and Br_id='" + dt_login_details.Rows[0]["Br_id"].ToString() + "' order by Br_Name ";
            DataTable dt1 = new DataTable();
            dt1 = CommonFunctions.fetchdata(qry1);

            drpStore.DataSource = dt1;
            drpStore.DataValueField = "Br_ID";
            drpStore.DataTextField = "Br_Name";
            drpStore.DataBind();
            drpStore.SelectedIndex = 0;
           // drpStore.Items.Insert(0, new ListItem("-Store Name-", "0"));



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
                pnlSummary.Visible = false;
                pnlSummary.Attributes.Remove("class");

                var val = hfProduct.Value.ToString();
                //--------------Split Date----------
                if (val.ToString() != String.Empty)
                {
                    var dt = val.ToString();
                    var da = dt.Split('-');
                    var dt1 = da[0].Substring(0, da[0].Length - 1).Trim(); ;
                    var dt2 = da[1].Substring(0, da[1].Length - 1).Trim(); ;

                    //-----------Convert date format------
                    string joinstring = "-";

                    string[] tempsplitF = dt1.Split('/');
                    string dateF = tempsplitF[2] + joinstring + tempsplitF[1] + joinstring + tempsplitF[0];
                    string YearF = tempsplitF[2];
                    string MonthF = tempsplitF[1];

                    string[] tempsplitT = dt2.Split('/');
                    string dateT = tempsplitT[2] + joinstring + tempsplitT[1] + joinstring + tempsplitT[0];
                    string YearT = tempsplitT[2];
                    string MonthT = tempsplitT[1];

                    //DateTime dtF = Convert.ToDateTime(dt1);
                    //string F1 = dtF.ToString("yyyy/MM/dd");
                    string F1 = dateF.ToString();

                    //DateTime dtS = Convert.ToDateTime(dt2);
                    //string F2 = dtS.ToString("yyyy/MM/dd"); 
                    string F2 = dateT.ToString();

                    //------------Filter Conditions-----------------

                    string condition = "", Case = "", Heading = "";
                    //drp_status.Tex
                    if (drpReportType.SelectedValue == "Summary")
                        Case = "1";
                    else if (drpReportType.SelectedValue == "Details")
                        Case = "2";

                    if (drpStore.SelectedIndex == 0)
                    {
                        condition = " and isnull(Br_ID,'0')   = '" + drpStore.SelectedValue + "'";
                        Heading = Heading + " Store Name :  '" + drpStore.SelectedItem + "'";
                    }
                    if (drpCategory.SelectedValue != "0")
                    {
                        condition = condition + " and CID = '" + drpCategory.SelectedValue.ToString() + "'";
                        Heading = Heading + " Categrory Name '" + drpCategory.SelectedItem + "'";
                    }

                    if (drpBrand.SelectedIndex != 0)
                    {
                        condition = condition + " and isnull(Brand,'0')  ='" + drpBrand.SelectedValue + "'"; ;
                        Heading = Heading + " Brand Name : '" + drpCategory.SelectedItem + "'";
                    }

                    lblfilter.Text = Heading.ToString().ToUpper();
                    lblRFilter.Text = Heading.ToString().ToUpper();
                    lblRSFilter.Text = Heading.ToString().ToUpper();
                    lblRDFilter.Text = Heading.ToString().ToUpper();

                    if (Case == "1")
                    {
                        //string qry = " Select Convert(varchar(10),CreatedOn,103) as CreatedOn,  RP_Name,  Count(*) as Count  " + Heading + " " +
                        //" from vw_AppRegistrtionReport where ( year(CreatedOn)  between  " + YearF + " and " + YearT + " )  and  ( month(CreatedOn) between  " + MonthF + " and " + MonthT + " ) " + condition + " " +
                        //" group by year(CreatedOn) , Month(CreatedOn), day(CreatedOn) , Convert(varchar(10),CreatedOn,103), RP_Name    " + Heading + " " +
                        //" order by year(CreatedOn) desc , Month(CreatedOn) desc, day(CreatedOn) desc ";

                        string qry = " Select TicketNo, Convert(varchar(10), TicketDate, 103) as TicketDate, Com_Name, BranchName, Brand, CategoryName, SupplierName, (Quantity) As Quantity,  Br_ID, CID, Brand " +
                        " from vw_ItemInward  where Com_id='"+ dt_login_details.Rows[0]["Com_ID"].ToString() + "' and  Br_id='" + dt_login_details.Rows[0]["Br_id"].ToString() + "' and  TicketDate  between '" + dateF.ToString() + "  00:00:00.000' and '" + dateT.ToString() + " 23:59:59.000' " + condition + " " +
                        "group by TicketNo, TicketDate, Com_id, Com_Name, Br_id, BranchName, Brand, CID, CategoryName, SID, SupplierName, Quantity ,  Br_ID, CID, Brand" +
                        " order by year(TicketDate) desc , Month(TicketDate) desc, day(TicketDate) desc ";


                        DataTable dtR = new DataTable();
                        dtR = CommonFunctions.fetchdata(qry);
                        objSDs = dtR;

                        if (dtR.Rows.Count > 0)
                        {
                            Session["RegReportS"] = dtR;
                            lbl_total.Text = dtR.Rows.Count.ToString();
                            lblSDateF.Text = dt1.ToString();
                            lblSDateD.Text = dt2.ToString();

                            pnlMain.Attributes.Add("style", "display:block;");

                            pnlSummary.Visible = true;
                            pnlSummary.Attributes.Add("class", "active");

                            Session["RegReportD"] = null;
                        }
                        else
                        {

                            lbl_total.Text = dtR.Rows.Count.ToString();
                            lblSDateF.Text = dt1.ToString();
                            lblSDateD.Text = dt2.ToString();
                        }

                    }

                    if (Case == "2")
                    {


                        //string qry = "  Select Applicant_Id, Title + ' ' + FirstName + ' ' + LastName as AppName, Gender, Passport_No, CountryName, ZoneName, RP_Name from vw_AppRegistrtionReport where isCompleted=1 and isPaid=1 and CreatedOn between '" + dateF.ToString() + "  00:00:00.000' and '" + dateT.ToString() + " 23:59:59.000' " + condition + "  order by year(CreatedOn) desc , month(CreatedOn) desc , day(CreatedOn) desc";
                        string qry = " Select TicketNo, ItemName,ItemSpecification, Brand,BarCodeNo,Quantity,Hold_Quantity,CostPrice,SalesPrice,UserName,CreateON,SID,SupplierName,CID,CategoryName, Com_ID,Com_Name,Br_ID,Br_Name,TicketDate ,  Br_ID, CID, Brand" +
                            " from vw_ItemInward where Com_id='" + dt_login_details.Rows[0]["Com_ID"].ToString() + "' and  Br_id='" + dt_login_details.Rows[0]["Br_id"].ToString() + "'  and istransfer = 1 and CreateOn  between '" + dateF.ToString() + "  00:00:00.000' and '" + dateT.ToString() + " 23:59:59.000' " + condition + " " +
                            " order by year(CreateOn) desc , month(CreateOn) desc , day(CreateOn) desc";


                        DataTable dtR = new DataTable();
                        dtR = CommonFunctions.fetchdata(qry);
                        objDs = dtR;

                        if (dtR.Rows.Count > 0)
                        {
                            Session["RegReportD"] = dtR;
                            lbl_total.Text = dtR.Rows.Count.ToString();
                            lblFDate.Text = dt1.ToString();
                            lblTDate.Text = dt2.ToString();


                            pnlMain.Attributes.Add("style", "display:block;");

                            pnlDetails.Visible = true;
                            pnlDetails.Attributes.Add("class", "active");
                            Session["RegReportS"] = null;
                        }
                        else
                        {

                            lbl_total.Text = dtR.Rows.Count.ToString();
                            lblFDate.Text = dt1.ToString();
                            lblTDate.Text = dt2.ToString();
                        }

                    }


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

        if (Session["RegReportD"] != null)
        {
            lblFDateR.Text = lblFDate.Text;
            lblTDateR.Text = lblTDate.Text;
            objDs = (DataTable)Session["RegReportD"];
            objDsRep = (DataTable)Session["RegReportD"];

            ScriptManager.RegisterStartupScript(this, GetType(), "key", "PrintContent();", true);
        }


        if (Session["RegReportS"] != null)
        {
            lblSDateFRep.Text = lblSDateF.Text;
            lblSDateDRep.Text = lblSDateD.Text;
            objSDs = (DataTable)Session["RegReportS"];
            objSDsRep = (DataTable)Session["RegReportS"];
            ScriptManager.RegisterStartupScript(this, GetType(), "key", "PrintContentSummary();", true);
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
                lblSDateFRep.Text = lblSDateF.Text;
                lblSDateDRep.Text = lblSDateD.Text;
                objSDs = (DataTable)Session["RegReportS"];
                objSDsRep = (DataTable)Session["RegReportS"];

                string html = HdnValue.Value;
                ExportToExcel(ref html, "Inword_Summary_Report");
            }
            if (Session["RegReportD"] != null)
            {
                lblFDateR.Text = lblFDate.Text;
                lblTDateR.Text = lblTDate.Text;
                objDs = (DataTable)Session["RegReportD"];
                objDsRep = (DataTable)Session["RegReportD"];

              

                string html = HdnValue.Value;
                ExportToExcel(ref html, "Inword_Details_Report");
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
