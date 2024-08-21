using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AfriStore_Code
{
    public partial class frmFreeHoldItem : System.Web.UI.Page
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

                string qry = "  Select ID, TicketNo, ItemRegNo, BarCodeNo, Hold_Quantity, convert(varchar(10), CreateON, 103) as CreateON ,UserName,CompID,StoreID " +
                " From vw_ItemFreeHold where  Hold_Quantity > 0 and compid = '" + dt_login_details.Rows[0]["Com_ID"].ToString() + "' and storeid = '" + dt_login_details.Rows[0]["Br_id"].ToString() + "' " +
                " order by year(CreateON), month(CreateON), day(CreateON) ";

                //string qry = " Select distinct(X.Ticket), X.Status, Convert(varchar(10), X.CreatedOn) AS CreateON From " +
                //" (Select X1.TicketNo as Ticket, CASE WHEN X1.isVerify = 1 THEN 'Verified' WHEN X1.isVerify = 0  THEN 'Pending' END as status, X1.CreateON as CreatedOn from tbl_ItemTransferBranch X1, tbl_UserMaster X2 " +
                //" where X1.StoreID = X2.Br_id and X1.StoreID = '" + dt_login_details.Rows[0]["Br_id"].ToString() + "' and  X1.isTransfer = 1 and X1.isVerify = 0) X    group by X.Ticket, X.status, X.CreatedOn order by CreateON desc ";

                DataTable dt = new DataTable();
                dt = CommonFunctions.fetchdata(qry);

                if (dt.Rows.Count > 0)
                {
                    Session["grdFreeHold"] = dt;
                    lbl_total.Text = dt.Rows.Count.ToString();
                    grdFreeHold.DataSource = dt;
                    grdFreeHold.DataBind();
                    pnlFreeHold.Attributes.Add("style", "display:block;");
                }
                else
                {
                    lbl_total.Text = dt.Rows.Count.ToString();
                    grdFreeHold.DataSource = null;
                    grdFreeHold.DataBind();
                    pnlFreeHold.Attributes.Add("style", "display:none;");
                }

                pnlMain.Attributes.Add("style", "display:block;");               
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

                string qry = "  Select ID, TicketNo, ItemRegNo, BarCodeNo, Hold_Quantity, convert(varchar(10), CreateON, 103) as CreateON ,UserName,CompID,StoreID " +
                " From vw_ItemFreeHold where Hold_Quantity > 0 and  BarCodeNo like '" + txtSearch.Value.Trim() + "%'  and compid = '" + dt_login_details.Rows[0]["Com_ID"].ToString() + "' and storeid = '" + dt_login_details.Rows[0]["Br_id"].ToString() + "' " +
                " order by year(CreateON), month(CreateON), day(CreateON) ";


                //string qry = " Select ItemRegNo, ItemName, ItemSpecification  ,Brand, BarCodeNo, Quantity, Hold_Quantity, CostPrice, SalesPrice, Discount, DiscountAmount, SupplierCode,CategoryCode,Mfgdate,Expdate,Warranty,Image,isTransfer,isVerify    " +
                //" From  tbl_ItemTransferBranch where isTransfer=1 and isVerify=0 and TicketNo like '" + txtSearch.Value.Trim() + "%'  and StoreID = '" + dt_login_details.Rows[0]["Br_id"].ToString() + "' " +
                //" order by TicketNo,  year(CreateON) , month(CreateON)  , day(CreateON) asc ";

                DataTable dt = new DataTable();
                dt = CommonFunctions.fetchdata(qry);

                if (dt.Rows.Count > 0)
                {
                    Session["grdFreeHold"] = dt;
                    lbl_total.Text = dt.Rows.Count.ToString();
                    grdFreeHold.DataSource = dt;
                    grdFreeHold.DataBind();
                }
                else
                {
                    lbl_total.Text = dt.Rows.Count.ToString();
                    grdFreeHold.DataSource = null;
                    grdFreeHold.DataBind();
                }

                pnlMain.Attributes.Add("style", "display:none;");
                pnlFreeHold.Attributes.Add("style", "display:block;");
                lblloginmsg.Attributes.Add("style", "display:none;");
            }
            catch (Exception ex)
            {
                lblloginmsg.Attributes.Add("class", "active");
                lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
                lblloginmsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Please find correct details !" + " </h4>";
            }


        }


        protected void BtnFreeItem_Click(object sender, EventArgs e)
        {
            int Count = 0;
            foreach (GridViewRow r in grdFreeHold.Rows)
            {
                CheckBox ctl = (CheckBox)r.FindControl("ChkVerify");
                if (ctl.Checked)
                {
                  //  Label lblTicketNo = (Label)grdFreeHold.SelectedRow.FindControl("lblTicketNo");
                    Label lblTicketNo = (Label)r.FindControl("lblTicketNo");
                    Label lblItemRegNo = (Label)r.FindControl("lblItemRegNo");
                    Label lblBarcodeNo = (Label)r.FindControl("lblBarCodeNo");
                    Label lblHoldQunatity = (Label)r.FindControl("lblHoldQunatity");

                    //----Func Update flag isVerify--------
                    //---------Trafer Ticker Details to Branch / Store---------------------
                    SqlCommand cmdI = new SqlCommand();
                    cmdI.Connection = cn1;
                    cmdI.CommandText = "SP_AF_ItemFreeHold";
                    cmdI.CommandType = CommandType.StoredProcedure;

                    cmdI.Parameters.AddWithValue("@TicketNo", lblTicketNo.Text.Trim().ToString());
                    cmdI.Parameters.AddWithValue("@ItemRegNo", lblItemRegNo.Text.Trim().ToString());
                    cmdI.Parameters.AddWithValue("@BarcodeNo", lblBarcodeNo.Text.Trim().ToString());               
                    cmdI.Parameters.AddWithValue("@HoldQunatity", lblHoldQunatity.Text.Trim().ToString());
                    cmdI.Parameters.AddWithValue("@Userid", dt_login_details.Rows[0]["Userid"].ToString());
                    cmdI.Parameters.AddWithValue("@Flag", "ItemFree");
                    SqlParameter output = new SqlParameter("@Success", SqlDbType.Int);
                    output.Direction = ParameterDirection.Output;
                    cmdI.Parameters.Add(output);
                    cn1.Open();
                    cmdI.ExecuteNonQuery();
                    string RI = output.Value.ToString();
                    cn1.Close();
                    if (RI == "1")
                        Count++;

                }
            }
            if (Count > 0)
            {
                pnlMain.Attributes.Add("style", "display:none;");
                pnlFreeHold.Attributes.Add("style", "display:none;");

                lblloginmsg.Attributes.Add("style", "display:block;");
                lblloginmsg.Attributes["style"] = "color:green; font-weight:bold; background-color:white; ";
                lblloginmsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Item Verified Successful !" + " </h4>";
                Response.Redirect("frmFreeHoldItem.aspx");
             
            }
        }

        protected void BtnBackVerify_Click(object sender, EventArgs e)
        {
            try
            {
                pnlMain.Attributes.Add("style", "display:block;");
                pnlFreeHold.Attributes.Add("style", "display:none;");
            }
            catch (Exception ex)
            {

                lblloginmsg.Attributes.Add("class", "active");
                lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
                lblloginmsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Please find correct details !" + " </h4>";
            }
        }

        protected void grdFreeHold_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdFreeHold.PageIndex = e.NewPageIndex;
            this.bindgrid();
        }
    }
}