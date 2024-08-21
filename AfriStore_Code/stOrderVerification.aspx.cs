using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class stOrderVerification : System.Web.UI.Page
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

                lblloginmsg.InnerHtml = "";
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
            //----------Bind Data Grid-----------------
            try
            {     
            

                string qry = " Select distinct(X.Ticket), X.Status, Convert(varchar(10), X.CreatedOn) AS CreateON From " +
                " (Select X1.TicketNo as Ticket, CASE WHEN X1.isVerify = 1 THEN 'Verified' WHEN X1.isVerify = 0  THEN 'Pending' END as status, X1.CreateON as CreatedOn from tbl_ItemTransferBranch X1, tbl_UserMaster X2 " +
                " where X1.StoreID = X2.Br_id and X1.StoreID = '" + dt_login_details.Rows[0]["Br_id"].ToString() + "' and  X1.isTransfer = 1 and X1.isVerify = 0) X    group by X.Ticket, X.status, X.CreatedOn order by CreateON desc ";

                     DataTable dt = new DataTable();
                dt = CommonFunctions.fetchdata(qry);

                if (dt.Rows.Count > 0)
                {
                    Session["grdOrder"] = dt;
                    lbl_total.Text = dt.Rows.Count.ToString();
                    grdOrder.DataSource = dt;
                    grdOrder.DataBind();
                }
                else
                {
                    lbl_total.Text = dt.Rows.Count.ToString();
                    grdOrder.DataSource = null;
                    grdOrder.DataBind();
                }

                pnlMain.Attributes.Add("style", "display:block;");
                pnlOrderDetails.Attributes.Add("style", "display:none;");
                lblloginmsg.Attributes.Add("style", "display:none;");

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

                string qry = " Select ItemRegNo, ItemName, ItemSpecification  ,Brand, BarCodeNo, Quantity, Hold_Quantity, CostPrice, SalesPrice, Discount, DiscountAmount, SupplierCode,CategoryCode,Mfgdate,Expdate,Warranty,Image,isTransfer,isVerify    " +
                " From  tbl_ItemTransferBranch where isTransfer=1 and isVerify=0 and TicketNo like '" + txtSearch.Value.Trim() + "%'  and StoreID = '" + dt_login_details.Rows[0]["Br_id"].ToString() + "' " +
                " order by TicketNo,  year(CreateON) , month(CreateON)  , day(CreateON) asc ";                       

                DataTable dt = new DataTable();
                dt = CommonFunctions.fetchdata(qry);

                if (dt.Rows.Count > 0)
                {
                    Session["grdOrderDetails"] = dt;
                    lbl_total.Text = dt.Rows.Count.ToString();
                    grdOrderDetails.DataSource = dt;
                    grdOrderDetails.DataBind();
                }
                else
                {
                    lbl_total.Text = dt.Rows.Count.ToString();
                    grdOrderDetails.DataSource = null;
                    grdOrderDetails.DataBind();
                }

                pnlMain.Attributes.Add("style", "display:none;");
                pnlOrderDetails.Attributes.Add("style", "display:block;");
                lblloginmsg.Attributes.Add("style", "display:none;");
            }
            catch (Exception ex)
            {
                lblloginmsg.Attributes.Add("class", "active");
                lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
                lblloginmsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Please find correct details !" + " </h4>";
            }


        }


    protected void BtnBackVerify_Click(object sender, EventArgs e)
    {

        try
        {
            pnlMain.Attributes.Add("style", "display:block;");
            pnlOrderDetails.Attributes.Add("style", "display:none;");
        }
        catch (Exception ex)
        {

            lblloginmsg.Attributes.Add("class", "active");
            lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
            lblloginmsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Please find correct details !" + " </h4>";
        }
    }

    protected void btnVerifyOrderDetails_Click(object sender, EventArgs e)
    {
        int Count = 0;
        foreach (GridViewRow r in grdOrderDetails.Rows)
        {
            CheckBox ctl = (CheckBox)r.FindControl("ChkVerify");
            if (ctl.Checked)
            {
                Label lblTicketNo = (Label)grdOrder.SelectedRow.FindControl("lblTicketNo");
                Label lblItemRegNo = (Label)r.FindControl("lblItemRegNo");
                Label lblBarcodeNo = (Label)r.FindControl("lblBarcodeNo");

                //----Func Update flag isVerify--------
                //---------Trafer Ticker Details to Branch / Store---------------------
                SqlCommand cmdI = new SqlCommand();
                cmdI.Connection = cn1;
                cmdI.CommandText = "SP_AF_ItemTransferVerify";
                cmdI.CommandType = CommandType.StoredProcedure;

                cmdI.Parameters.AddWithValue("@TicketNo", lblTicketNo.Text.Trim().ToString());
                cmdI.Parameters.AddWithValue("@ItemRegNo", lblItemRegNo.Text.Trim().ToString());
                cmdI.Parameters.AddWithValue("@BarcodeNo", lblBarcodeNo.Text.Trim().ToString());
                cmdI.Parameters.AddWithValue("@Userid", dt_login_details.Rows[0]["Userid"].ToString());
                cmdI.Parameters.AddWithValue("@Flag", "ItemVerify");
                SqlParameter output = new SqlParameter("@Success", SqlDbType.Int);
                output.Direction = ParameterDirection.Output;
                cmdI.Parameters.Add(output);
                cn1.Open();
                cmdI.ExecuteNonQuery();
                string RI = output.Value.ToString();
                cn1.Close();
                if ( RI == "1")
                    Count++;

            }
        }
        if ( Count  > 0 )
        {
            pnlMain.Attributes.Add("style", "display:none;");
            pnlOrderDetails.Attributes.Add("style", "display:none;");

            lblloginmsg.Attributes.Add("style", "display:block;");
            lblloginmsg.Attributes["style"] = "color:green; font-weight:bold; background-color:white; ";
            lblloginmsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Item Verified Successful !" + " </h4>";
           // Response.Redirect("stOrderVerification.aspx");
        }
        
    }

    protected void grdOrder_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdOrder.PageIndex = e.NewPageIndex;
        this.bindgrid();
    }

    protected void grdOrder_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            int rowIndex = Convert.ToInt32(e.CommandArgument);

            //Reference the GridView Row.
            GridViewRow row = grdOrder.Rows[rowIndex];
        }
        catch (Exception ex)
        {
            lblloginmsg.Attributes.Add("class", "active");
            lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
            lblloginmsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Please find correct details !" + " </h4>";
        }
    }

    protected void grdOrder_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(grdOrder, "Select$" + e.Row.RowIndex);
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

    protected void grdOrder_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            Label lblTicketNo = (Label)grdOrder.SelectedRow.FindControl("lblTicketNo");           

            string qry = " Select X1.ItemRegNo, X1.ItemName, X1.ItemSpecification  , X1.Brand, X1.BarCodeNo, X1.Quantity, X1.Hold_Quantity, X1.CostPrice, X1.SalesPrice, X1.Discount, X1.DiscountAmount, X1.SupplierCode, X1.CategoryCode, X1.Mfgdate, X1.Expdate, X1.Warranty, X1.Image, X1.isTransfer, X1.isVerify    " +
             " From  tbl_ItemTransferBranch  X1, tbl_UserMaster X2 where X1.StoreID=X2.Br_id and X1.StoreID = '" + dt_login_details.Rows[0]["Br_id"].ToString() + "' and   X1.isTransfer=1 and X1.isVerify=0 and X1.TicketNo like '" + lblTicketNo.Text.Trim() + "%' " +
             "  and   X2.EmployeeID='" + dt_login_details.Rows[0]["EmployeeID"].ToString() +"' order by X1.TicketNo,  year(X1.CreateON) , month(X1.CreateON)  , day(X1.CreateON)  asc ";

            DataTable dt = new DataTable();
            dt = CommonFunctions.fetchdata(qry);

            if (dt.Rows.Count > 0)
            {
                Session["grdOrderDetails"] = dt;
                lbl_total.Text = dt.Rows.Count.ToString();
                grdOrderDetails.DataSource = dt;
                grdOrderDetails.DataBind();
            }
            else
            {
                lbl_total.Text = dt.Rows.Count.ToString();
                grdOrderDetails.DataSource = null;
                grdOrderDetails.DataBind();
            }

            pnlMain.Attributes.Add("style", "display:none;");
            pnlOrderDetails.Attributes.Add("style", "display:block;");
            lblloginmsg.Attributes.Add("style", "display:none;");

        }
        catch (Exception ex)
        {
            lblloginmsg.Attributes.Add("class", "active");
            lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
            lblloginmsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Please find correct details !" + " </h4>";
        }
    }
    
}
