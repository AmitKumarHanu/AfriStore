using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class repStoreSalesSummary : System.Web.UI.Page
{
    SqlConnection cn1 = new SqlConnection(CommonFunctions.connection.ToString());
    DataTable dt_login_details = new DataTable();


    protected DataTable objDs = new DataTable();
    protected DataTable objDsRep = new DataTable();

    

    protected DataTable objDDs = new DataTable();
    protected DataTable objDDsRep = new DataTable();

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
            //drpflags.SelectedIndex = 3;

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

        try
        {

            //-------------Bind Store User Master----------------
            String qry1 = " Select  UserName, EmployeeID from tbl_usermaster where GroupCode='BLST' and Com_ID='" + dt_login_details.Rows[0]["Com_ID"].ToString() + "' and Br_id='" + dt_login_details.Rows[0]["Br_id"].ToString() + "' order by UserName ";
            DataTable dt1 = new DataTable();
            dt1 = CommonFunctions.fetchdata(qry1);

            drpBillingLogin.DataSource = dt1;
            drpBillingLogin.DataValueField = "UserName";
            drpBillingLogin.DataTextField = "UserName";
            drpBillingLogin.DataBind();
            drpBillingLogin.Items.Insert(0, new ListItem("-Billing by-", "0"));

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

                    string condition = "", Case = "", Heading="";

                    if (drpReportType.SelectedValue == "Summary")
                        Case = "1";
                    else if (drpReportType.SelectedValue == "Details")
                        Case = "2";

                    if (drpBillingLogin.SelectedIndex != 0)
                    {
                        condition = " and isnull(HoldBy,'0')   = '" + drpBillingLogin.SelectedValue + "'";
                        Heading = Heading + "Login Officer : '" + drpBillingLogin.SelectedItem + "'";

                    }
                    if (drpflags.SelectedValue == "1")
                    {
                        condition = condition + "and isTrans=1 and isnull(isPayment,0)=0 and isnull(isReceipt,0)=0 and isnull(isPrint,0)=0 ";
                        Heading = Heading + "Payment Type : Waiting for Payment ";
                    }
                    if (drpflags.SelectedValue == "2")
                    {
                        condition = condition + "and isTrans=1 and isnull(isPayment,0)=1 and isnull(isReceipt,0)=0 and isnull(isPrint,0)=0 ";
                        Heading = Heading + "Payment Type : Waiting for Print Receipt ";
                    }
                    if (drpflags.SelectedValue == "3")
                    {
                        condition = condition + "and isTrans=1 and isnull(isPayment,0)=1 and isnull(isReceipt,0)=1 and isnull(isPrint,0)=1 ";
                        Heading = Heading + "Payment Type : Payment Completed ";
                    }

                    lblfilter.Text = Heading.ToString().ToUpper();
                    lblRFilter.Text = Heading.ToString().ToUpper();
                    lblRSFilter.Text = Heading.ToString().ToUpper();
                    lblRDFilter.Text = Heading.ToString().ToUpper();

                    if (Case == "1")
                    {
                        string qry = "SELECT TicketNo, convert(varchar(10),TicketDate,103) as TicketDate, BranchName, CustomerName,  sum(Quantity) as Quantity, CompID,StoreID,Status, (isnull(PaidAmount,0)) as PaidAmount, isnull(ChangeAmount,0) as ChangeAmount ,isnull(DueAmount,0)  as DueAmount    ,PaymentMode,PaymentReceivedBy, ReceiptedPrintedBy,isPrint  " +
                            "FROM vw_StoreSalesSummary where CompID='" + dt_login_details.Rows[0]["Com_ID"].ToString() + "' and  StoreID='" + dt_login_details.Rows[0]["Br_id"].ToString() + "' and  TicketDate  between '" + dateF.ToString() + "  00:00:00.000' and '" + dateT.ToString() + " 23:59:59.000' " + condition + " " +
                            "GROUP BY TicketNo, TicketDate, BranchName,  CustomerName, CompID,StoreID,Status, PaidAmount,ChangeAmount,DueAmount,PaymentMode, PaymentReceivedBy,ReceiptedPrintedBy,isPrint " +
                            "order by TicketNo, year(TicketDate), month(TicketDate), day(TicketDate)"; 

                        DataTable dtR = new DataTable();
                        dtR = CommonFunctions.fetchdata(qry);

                        objDs = dtR;
                        if (dtR.Rows.Count > 0)
                        {
                            Session["RegReportS"] = dtR;
                            lbl_total.Text = dtR.Rows.Count.ToString();
                            lblFDate.Text = dt1.ToString();
                            lblTDate.Text = dt2.ToString();

                                                    

                            pnlSummary.Visible = true;
                            pnlSummary.Attributes.Add("class", "active");

                            Session["RegReportD"] = null;
                        }
                        else
                        {

                            lbl_total.Text = dtR.Rows.Count.ToString();
                            lblFDate.Text = dt1.ToString();
                            lblTDate.Text = dt2.ToString();
                        }

                    }
                    if (Case == "2")
                    {

                        //string qry = "SELECT TicketNo, BranchName, CustomerName, Count(TicketNo) as Quantity, CompID,StoreID,Status, isnull(PaidAmount,0) as PaidAmount, isnull(ChangeAmount,0) as ChangeAmount ,isnull(DueAmount,0)  as DueAmount    ,PaymentMode,PaymentReceivedBy, ReceiptedPrintedBy,isPrint  " +
                        //    "FROM vw_StoreSalesSummary where CompID='" + dt_login_details.Rows[0]["Com_ID"].ToString() + "' and  StoreID='" + dt_login_details.Rows[0]["Br_id"].ToString() + "' and  ( year(TicketDate)  between  " + YearF + " and " + YearT + " )  and  ( month(TicketDate) between  " + MonthF + " and " + MonthT + " ) " + condition + " " +
                        //    "GROUP BY TicketNo, BranchName,  CustomerName, CompID,StoreID,Status, PaidAmount,ChangeAmount,DueAmount,PaymentMode, PaymentReceivedBy,ReceiptedPrintedBy,isPrint " +
                        //    "order by TicketNo";

                        string qry = " SELECT TicketNo,  convert(varchar(10),TicketDate,103) as TicketDate, BranchName, ItemRegNo, CustomerName, CompID, StoreID, Totalitem, TicketDate, ItemName,ItemSpecification,Brand,BarCodeNo,Quantity, isnull(SalesPrice,0) AS SalesPrice, isnull(CostPrice,0) AS CostPrice, isnull(Discount, 0) AS Discount,  isnull(DiscountAmount, 0) AS DiscountAmount, isnull(TotalAmount, 0)  AS TotalAmount" +
                        ", Status as Remark,isnull(PaidAmount, 0) as PaidAmount,isnull(ChangeAmount, 0) as ChangeAmount,isnull(DueAmount, 0) as DueAmount,PaymentMode,PaymentedOn,ReceiptedOn,PaymentReceivedBy,ReceiptedPrintedBy,PrinttedOn , PLAmount, PL, CategoryName " +
                        " FROM vw_StoreSalesSummary  where CompID='" + dt_login_details.Rows[0]["Com_ID"].ToString() + "' and  StoreID='" + dt_login_details.Rows[0]["Br_id"].ToString() + "' and TicketDate  between '" + dateF.ToString() + "  00:00:00.000' and '" + dateT.ToString() + " 23:59:59.000' " + condition + " " +
                        " order by TicketNo, year(TicketDate), month(TicketDate), day(TicketDate), BranchName, CategoryName, ItemRegNo ";

                        
                        DataTable dtR = new DataTable();
                        dtR = CommonFunctions.fetchdata(qry);
                        objDDs = dtR;

                        if (dtR.Rows.Count > 0)
                        {
                            Session["RegReportD"] = dtR;
                            lbl_total.Text = dtR.Rows.Count.ToString();
                            lblDFDate.Text = dt1.ToString();
                            lblDTDate.Text = dt2.ToString();

                          
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

        if (Session["RegReportS"] != null)
        {
            lblSFDateR.Text = lblFDate.Text;
            lblSTDateR.Text = lblTDate.Text;
            objDs = (DataTable)Session["RegReportS"];
            objDsRep = (DataTable)Session["RegReportS"];

            ScriptManager.RegisterStartupScript(this, GetType(), "key", "PrintContentSummary();", true);
        }
        if (Session["RegReportD"] != null)
        {
            lblDDateFRep.Text = lblFDate.Text;
            lblDDateDRep.Text = lblTDate.Text;
            objDDs = (DataTable)Session["RegReportD"];
            objDDsRep = (DataTable)Session["RegReportD"];

            ScriptManager.RegisterStartupScript(this, GetType(), "key", "PrintContentDetails();", true);


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

    protected void btnExcel_Click(object sender, EventArgs e)
    {
        Label LabelMessage = (Label)this.Page.Master.FindControl("lblmsg");
        string Message = string.Empty;


        try
        {

            if (Session["RegReportS"] != null)
            {
                lblSFDateR.Text = lblFDate.Text;
                lblSTDateR.Text = lblTDate.Text;
                objDs = (DataTable)Session["RegReportS"];
                objDsRep = (DataTable)Session["RegReportS"];

               // ScriptManager.RegisterStartupScript(this, GetType(), "key", "PrintContentSummary();", true);
                string html = HdnValue.Value;
                ExportToExcel(ref html, "Store_Sales_Summary_Report");
            }
            if (Session["RegReportD"] != null)
            {
                lblDDateFRep.Text = lblFDate.Text;
                lblDDateDRep.Text = lblTDate.Text;
                objDDs = (DataTable)Session["RegReportD"];
                objDDsRep = (DataTable)Session["RegReportD"];

                //ScriptManager.RegisterStartupScript(this, GetType(), "key", "PrintContentDetails();", true);

                string html = HdnValue.Value;
                ExportToExcel(ref html, "Store_Sales_Details_Report");
            }

        }   
        
        catch (Exception ex)
        {

        }
    }
}
