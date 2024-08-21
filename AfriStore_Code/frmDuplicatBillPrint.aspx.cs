using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class frmDuplicatBillPrint : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(CommonFunctions.connection);
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
                    Session["grdDupBill"] = null;
                  
                }

            DivMain.Attributes.Add("style", "display:block;");
            DivDetails.Attributes.Add("style", "display:none;");
            DivReceipt.Attributes.Add("style", "display:none;");
            DivPrintOpt.Attributes.Add("style", "display:none;");

        }

            catch (Exception ex)
            {
                lblloginmsg.Attributes.Add("class", "active");
                lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
                lblloginmsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Please find correct details !" + " </h4>";
            }
        }



    //--------------Display Serach Div-----------------------
    protected void BtnSearchOpt(object sender, EventArgs e)
    {
        try
        {
            if (txtBillNo.Value != String.Empty)
            {

                string qry = " Select sum(Quantity) as Totalitem, TicketNo, CustomerName, Mobile, TicketDate,  PaidAmount, PaymentMode, PaymentReceivedBy " +
            " From (Select  Quantity, TicketNo, CustomerName, Mobile, convert(varchar(10), TicketDate, 103) as TicketDate, PaidAmount, PaymentMode, PaymentReceivedBy from vw_StoreSalesSummary Where compid = '" + dt_login_details.Rows[0]["Com_ID"].ToString() + "' and storeid = '" + dt_login_details.Rows[0]["Br_id"].ToString() + "'  and isPayment=1 ) X where X.TicketNo = '" + txtBillNo.Value.Trim() + "' or X.Mobile = '" + txtBillNo.Value.Trim() + "' or X.CustomerName like '" + txtBillNo.Value.Trim() + "%' " +
            " group by  TicketNo, CustomerName, Mobile, TicketDate,  PaidAmount, PaymentMode, PaymentReceivedBy ";




                DataTable dt = new DataTable();
                dt = CommonFunctions.fetchdata(qry);

                if (dt.Rows.Count > 0)
                {
                    Session["grdDupBill"] = dt;

                    grdDupBill.DataSource = dt;
                    grdDupBill.DataBind();
                }
                else
                {

                    grdDupBill.DataSource = null;
                    grdDupBill.DataBind();
                }

                DivMain.Attributes.Add("style", "display:block;");
                DivDetails.Attributes.Add("style", "display:block;");
                DivReceipt.Attributes.Add("style", "display:none;");
                DivPrintOpt.Attributes.Add("style", "display:none;");

            }
        }
        catch (Exception ex)
        {
            lblloginmsg.Attributes.Add("class", "active");
            lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
            lblloginmsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Please find correct details !" + " </h4>";
        }


    }



    public void bindgrid()
    {
        try
        {

            if (txtBillNo.Value != String.Empty)
            {
                string qry = " Select sum(Quantity) as Totalitem, TicketNo, CustomerName, Mobile, TicketDate,  PaidAmount, PaymentMode, PaymentReceivedBy " +
                " From (Select  Quantity, TicketNo, CustomerName, Mobile, convert(varchar(10), TicketDate, 103) as TicketDate, PaidAmount, PaymentMode, PaymentReceivedBy from vw_StoreSalesSummary Where compid = '" + dt_login_details.Rows[0]["Com_ID"].ToString() + "' and storeid = '" + dt_login_details.Rows[0]["Br_id"].ToString() + "' and isPayment=1 ) X where X.TicketNo = '" + txtBillNo.Value.Trim() + "' or X.Mobile = '" + txtBillNo.Value.Trim() + "' or X.CustomerName like '" + txtBillNo.Value.Trim() + "%' " +
                " group by  TicketNo, CustomerName, Mobile, TicketDate,  PaidAmount, PaymentMode, PaymentReceivedBy ";




                DataTable dt = new DataTable();
                dt = CommonFunctions.fetchdata(qry);

                if (dt.Rows.Count > 0)
                {
                    Session["grdDupBill"] = dt;

                    grdDupBill.DataSource = dt;
                    grdDupBill.DataBind();
                }
                else
                {

                    grdDupBill.DataSource = null;
                    grdDupBill.DataBind();
                }

                DivMain.Attributes.Add("style", "display:none;");
                DivDetails.Attributes.Add("style", "display:block;");
                DivReceipt.Attributes.Add("style", "display:none;");
                DivPrintOpt.Attributes.Add("style", "display:none;");

            }
        }
        catch (Exception ex)
        {
            lblloginmsg.Attributes.Add("class", "active");
            lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
            lblloginmsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Please find correct details !" + " </h4>";
        }
    }


    protected void BtnPrinter(object sender, EventArgs e)
        {
            try
            {

                if (Session["grdDupBill"] != null)
                {



                    //---------Update Remove Quantity in tbl_itemmaster---------------------
                    SqlCommand cmdI = new SqlCommand();
                    cmdI.Connection = con;
                    cmdI.CommandText = "SP_AF_DuplicatePrint";
                    cmdI.CommandType = CommandType.StoredProcedure;
                    cmdI.Parameters.AddWithValue("@TicketNo", lblRecInvoice.Text.Trim().ToString());
                    cmdI.Parameters.AddWithValue("@PaymentMode", lblRPaymentMode.Text.Trim().ToString());
                    cmdI.Parameters.AddWithValue("@Userid", dt_login_details.Rows[0]["Userid"].ToString());
                    cmdI.Parameters.AddWithValue("@Flag", "Step1");
                    SqlParameter output = new SqlParameter("@Success", SqlDbType.Int);
                    output.Direction = ParameterDirection.Output;
                    cmdI.Parameters.Add(output);
                    con.Open();
                    cmdI.ExecuteNonQuery();
                    string RI = output.Value.ToString();
                    con.Close();

                    if (RI == "1")
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "key", "PrintContent();", true);

                        DivMain.Attributes.Add("style", "display:none;");
                      
                       // DvPayment.Attributes.Add("style", "display:none;");
                        DivReceipt.Attributes.Add("style", "display:block;");

                        // Thread.SpinWait(10000);
                        DivPrintOpt.Attributes.Add("style", "display:block;");


                    }

                }

            }
            catch (Exception ex)
            {
                lblloginmsg.Attributes.Add("class", "active");
                lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
                lblloginmsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Please find correct details !" + " </h4>";
            }

        }


        //-------------- Print Yes Function -----------------------
        protected void BtnPrintYes(object sender, EventArgs e)
        {
            try
            {

                if (Session["grdDupBill"] != null)
                {



                    //---------Update Remove Quantity in tbl_itemmaster---------------------
                    SqlCommand cmdI = new SqlCommand();
                    cmdI.Connection = con;
                    cmdI.CommandText = "SP_AF_DuplicatePrint";
                    cmdI.CommandType = CommandType.StoredProcedure;
                    cmdI.Parameters.AddWithValue("@TicketNo", lblRecInvoice.Text.Trim().ToString());
                    cmdI.Parameters.AddWithValue("@PaymentMode", lblRPaymentMode.Text.Trim().ToString());
                    cmdI.Parameters.AddWithValue("@Userid", dt_login_details.Rows[0]["Userid"].ToString());
                    cmdI.Parameters.AddWithValue("@Flag", "StepY");
                    SqlParameter output = new SqlParameter("@Success", SqlDbType.Int);
                    output.Direction = ParameterDirection.Output;
                    cmdI.Parameters.Add(output);
                    con.Open();
                    cmdI.ExecuteNonQuery();
                    string RI = output.Value.ToString();
                    con.Close();

                    if (RI == "1")
                    {

                        Response.Redirect("frmDuplicatBillPrint.aspx");

                        Session["grdDupBill"] = null;

                    }

                }


            }
            catch (Exception ex)
            {
                lblloginmsg.Attributes.Add("class", "active");
                lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
                lblloginmsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Please find correct details !" + " </h4>";
            }
        }


        //-------------- Print Yes Function -----------------------
        protected void BtnPrintNo(object sender, EventArgs e)
        {
            try
            {


                if (Session["grdDupBill"] != null)
                {
                    DivMain.Attributes.Add("style", "display:none;");
                   
                   // DvPayment.Attributes.Add("style", "display:none;");
                    DivReceipt.Attributes.Add("style", "display:block;");
                    DivPrintOpt.Attributes.Add("style", "display:none;");
                }
            }
            catch (Exception ex)
            {
                lblloginmsg.Attributes.Add("class", "active");
                lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
                lblloginmsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Please find correct details !" + " </h4>";
            }
        }

    protected void grdDupBill_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdDupBill.PageIndex = e.NewPageIndex;
        this.bindgrid();
    }

    protected void grdDupBill_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            int rowIndex = Convert.ToInt32(e.CommandArgument);

            //Reference the GridView Row.
            GridViewRow row = grdDupBill.Rows[rowIndex];
        }
        catch (Exception ex)
        {
            lblloginmsg.Attributes.Add("class", "active");
            lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
            lblloginmsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Please find correct details !" + " </h4>";
        }
    }

    protected void grdDupBill_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(grdDupBill, "Select$" + e.Row.RowIndex);
                e.Row.Attributes["style"] = "cursor:pointer";
            }
        }
        catch (Exception ex)
        {
            lblloginmsg.Attributes.Add("class", "active");
            lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
            lblloginmsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Please find correct details !" + " </h4>";
        }
    }

    protected void grdDupBill_SelectedIndexChanged(object sender, EventArgs e)
    {

        try
        {
            Label lblTicketNo = (Label)grdDupBill.SelectedRow.FindControl("lblTicketNo");
            Label lblCustomerName = (Label)grdDupBill.SelectedRow.FindControl("lblCustomerName");
            Label lblMobile = (Label)grdDupBill.SelectedRow.FindControl("lblMobile");


            if (lblTicketNo.Text != String.Empty && lblMobile.Text != String.Empty)
            {
                string qry = " Select TicketNo, ItemName, Quantity, DiscountAmount, TotalAmount,  convert(varchar(10), TicketDate, 103) as TicketDate, TotalAmount,  PaidAmount, PaymentMode, PaymentReceivedBy" +
                " From  vw_StoreSalesSummary Where compid = '" + dt_login_details.Rows[0]["Com_ID"].ToString() + "' and storeid = '" + dt_login_details.Rows[0]["Br_id"].ToString() + "' and TicketNo = '" + lblTicketNo.Text.Trim() + "' and Mobile = '" + lblMobile.Text.Trim() + "' and CustomerName = '" + lblCustomerName.Text.Trim() + "'  and isPayment=1 " +
                " order by  TicketNo, ItemRegNo, BarCodeNo ";




                DataTable dt = new DataTable();
                dt = CommonFunctions.fetchdata(qry);

                if (dt.Rows.Count > 0)
                {
                    BindStoreDetails();

                    Session["grdPayGrid"] = dt;
                    grdPayGrid.DataSource = dt;
                    grdPayGrid.DataBind();

                    lblRecInvoice.Text = dt.Rows[0]["TicketNo"].ToString();
                    lblRecDate.Text = dt.Rows[0]["TicketDate"].ToString();                  
                    lblRTotal.Text = dt.Rows[0]["PaidAmount"].ToString();
                    lblRPaymentMode.Text = dt.Rows[0]["PaymentMode"].ToString();

                }
                else
                {

                    grdPayGrid.DataSource = null;
                    grdPayGrid.DataBind();
                }

                string qry1 = " Select  Sum(TotalAmount) as TotalAmount , Sum(Totalitem) as Totalitem, isnull(Sum(DiscountAmount),'0.00') as DiscountAmount " +
               " From  vw_StoreSalesSummary Where compid = '" + dt_login_details.Rows[0]["Com_ID"].ToString() + "' and storeid = '" + dt_login_details.Rows[0]["Br_id"].ToString() + "' and TicketNo = '" + lblTicketNo.Text.Trim() + "' and Mobile = '" + lblMobile.Text.Trim() + "' and CustomerName = '" + lblCustomerName.Text.Trim() + "' ";


                DataTable dt1 = new DataTable();
                dt1 = CommonFunctions.fetchdata(qry1);

                if (dt1.Rows.Count > 0)
                {
                    lblRSalesPrice.Text = dt1.Rows[0]["TotalAmount"].ToString(); ;
                   // lblRTotal.Text = dt1.Rows[0]["PaidAmount"].ToString();
                    lblRDiscount.Text = dt1.Rows[0]["DiscountAmount"].ToString();

                }
                DivMain.Attributes.Add("style", "display:none;");
                DivDetails.Attributes.Add("style", "display:none;");
                DivReceipt.Attributes.Add("style", "display:block;");
                DivPrintOpt.Attributes.Add("style", "display:none;");

            }
        }
        catch (Exception ex)
        {
            lblloginmsg.Attributes.Add("class", "active");
            lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
            lblloginmsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Please find correct details !" + " </h4>";
        }

    }

    //-------------- Store Details -----------------------
    private void BindStoreDetails()
    {
        try
        {

            string qry = " Select X.Br_ID, X.Br_Name, X.Br_Address, X.Br_PhoneNo, X.Br_Email, X.Br_Website From  tbl_BranchMaster X, tbl_UserMaster Y where X.Br_ID=Y.Br_id and X.Com_ID=Y.Com_Id and  Y.Com_ID='" + dt_login_details.Rows[0]["Com_ID"].ToString() + "' and Y.Br_id='" + dt_login_details.Rows[0]["Br_id"].ToString() + "' ";


            DataTable dt = new DataTable();
            dt = CommonFunctions.fetchdata(qry);

            if (dt.Rows.Count > 0)
            {
                Session["grdBrDetails"] = dt;
                lblBrName.Text = dt.Rows[0]["Br_Name"].ToString();
                lblBrAddress.Text = dt.Rows[0]["Br_Address"].ToString();
                lblBrEmail.Text = dt.Rows[0]["Br_Email"].ToString();
                lblBrPhone.Text = dt.Rows[0]["Br_PhoneNo"].ToString();
            }

        }
        catch (Exception ex)
        {
            lblloginmsg.Attributes.Add("class", "active");
            lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
            lblloginmsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Please find correct details !" + " </h4>";
        }

    }
}

