using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AfriStore_Code
{
    public partial class frmItemReturn : System.Web.UI.Page
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
                    Session["AddToCard"] = null;
                    bindgrid();
                }

                lblloginmsg.InnerHtml = "";

                DivMain.Attributes.Add("style", "display:block;");
                DivGrid.Attributes.Add("style", "display:block;");
                DivAdd.Attributes.Add("style", "display:none;");


                hdnComID.Value = dt_login_details.Rows[0]["Com_Id"].ToString();
                hdnBrID.Value = dt_login_details.Rows[0]["Br_Id"].ToString();
            }

            catch (Exception ex)
            {
                lblloginmsg.Attributes.Add("class", "active");
                lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
                lblloginmsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Please find correct details !" + " </h4>";
            }
        }



        //-------------- Get BarCode in Autoresponse fun -----------------------
        [System.Web.Services.WebMethod]
        public static List<itemResult> GetBarcode(string BarCode, string ComID, string BrID)
        {
            List<itemResult> dataList = new List<itemResult>();
            string sqlStatment = " Select   ItemName,ItemSpecification,BarCodeNo,Quantity, CAST(CostPrice AS DECIMAL(11, 2)) AS CostPrice , CAST(SalesPrice AS DECIMAL(11, 2)) AS SalesPrice, ItemRegNo, TicketNo From vw_ItemStock where Com_ID='" + ComID.ToString() + "' and Br_ID='" + BrID.ToString() + "' and  BarCodeNo  LIKE '" + BarCode + "%'  and Quantity > 0 and isVerify=1   order by ItemName asc";

            using (SqlConnection con = new SqlConnection(CommonFunctions.connection))
            {
                using (System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(sqlStatment, con))
                {
                    cmd.Connection.Open();
                    System.Data.SqlClient.SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        itemResult detail = new itemResult();
                        detail.Name = reader[0].ToString();
                        detail.Specification = reader[1].ToString();
                        detail.BarCodeNo = reader[2].ToString();
                        int Q = Convert.ToInt32(reader[3].ToString());
                        //detail.Quantity = Convert.ToInt32( reader[3].ToString());
                        if (Q >= 1)
                            detail.Quantity = Q;
                        else
                            detail.Quantity = 0;
                        detail.CostPrice = Convert.ToDecimal(reader[4].ToString());
                        detail.SalesPrice = Convert.ToDecimal(reader[5].ToString());

                        detail.ItemRegNo = reader[6].ToString();
                        detail.TicketNo = reader[7].ToString();
                        dataList.Add(detail);
                    }
                    reader.Close();
                    cmd.Connection.Close();
                }
            }
            return dataList;

        }


        //-------------- Get ItemName in Autoresponse fun -----------------------
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static List<itemResult> GetitemName(string ItemName, string ComID, string BrID)
        {

            List<itemResult> dataList = new List<itemResult>();
            string sqlStatment = " Select   ItemName,ItemSpecification,BarCodeNo,Quantity,  CAST(CostPrice AS DECIMAL(11, 2)) AS CostPrice , CAST(SalesPrice AS DECIMAL(11, 2)) AS SalesPrice, ItemRegNo, TicketNo From vw_ItemStock where Com_ID='" + ComID.ToString() + "' and Br_ID='" + BrID.ToString() + "' and  ItemName  LIKE '" + ItemName + "%'  and Quantity > 0 and isVerify=1    order by ItemName asc";

            using (SqlConnection con = new SqlConnection(CommonFunctions.connection))
            {
                using (System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(sqlStatment, con))
                {
                    cmd.Connection.Open();
                    System.Data.SqlClient.SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        itemResult detail = new itemResult();
                        detail.Name = reader[0].ToString();
                        detail.Specification = reader[1].ToString();
                        detail.BarCodeNo = reader[2].ToString();
                        int Q = Convert.ToInt32(reader[3].ToString());
                        //detail.Quantity = Convert.ToInt32( reader[3].ToString());
                        if (Q >= 1)
                            detail.Quantity = Q;
                        else
                            detail.Quantity = 0;

                        detail.CostPrice = Convert.ToDecimal(reader[4].ToString());
                        detail.SalesPrice = Convert.ToDecimal(reader[5].ToString());
                        detail.ItemRegNo = reader[6].ToString();
                        detail.TicketNo = reader[7].ToString();
                        dataList.Add(detail);



                    }
                    reader.Close();
                    cmd.Connection.Close();
                }
            }
            return dataList;
        }


        public class itemResult
        {
            public string Name { get; set; }
            public string Specification { get; set; }
            public string BarCodeNo { get; set; }
            public int Quantity { get; set; }
            public decimal SalesPrice { get; set; }
            public decimal CostPrice { get; set; }
            public string ItemRegNo { get; set; }
            public string TicketNo { get; set; }


        }



        //--------------Display Serach -----------------------
        protected void btnReturnAddOpt(object sender, EventArgs e)
        {
            try
            {
                Session["AddToCard"] = null;
                BindBillNo();

                DivMain.Attributes.Add("style", "display:none;");
                DivGrid.Attributes.Add("style", "display:none;");
                DivAdd.Attributes.Add("style", "display:block;");




            }
            catch (Exception ex)
            {
                lblloginmsg.Attributes.Add("class", "active");
                lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
                lblloginmsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Please find correct details !" + " </h4>";
            }


        }

        //-------------- Bill No Generate -----------------------
        private void BindBillNo()
        {
            try
            {
                SqlCommand cmd1 = new SqlCommand();
                cmd1.Connection = con;
                cmd1.CommandText = "SP_Get_NewBillNo";
                cmd1.CommandType = CommandType.StoredProcedure;
                cmd1.Parameters.AddWithValue("@Flag", "ItemReturn");
                DataSet ds = new DataSet();
                con.Open();
                SqlDataAdapter Adp = new SqlDataAdapter(cmd1);
                Adp.Fill(ds);
                con.Close();

                if (ds.Tables[0].Rows.Count > 0)
                {
                    txtBillNo.Text = ds.Tables[0].Rows[0]["BillNo"].ToString();

                }

            }
            catch (Exception ex)
            {
                lblloginmsg.Attributes.Add("class", "active");
                lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
                lblloginmsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Please correction internet connectivity, Page binding dependent showing error !" + " </h4>";
            }
        }

        //----------Bind Data Grid-----------------
        public void bindgrid()
        {

            try
            {


                //SELECT Name, Specification, BarCodeNo, Quantity, CostPrice, SalesPrice, Discount, isTax, Tax
                //, SupplierName, SupplierCompany, CategoryName, Image, UserName, CreateON
                //FROM AfriSmart.dbo.vw_ItemDetails

                string qry = "   Select  RTicketNo,ItemName,ItemSpecification ,Brand,BarCodeNo, Quantity, Status FROM vw_ItemRequestReturn where isReturn=1 and isReturnVerify<>1  order by year(isReturnOn) desc,  month(isReturnOn) desc,   day(isReturnOn) desc ";


                DataTable dt = new DataTable();
                dt = CommonFunctions.fetchdata(qry);

                if (dt.Rows.Count > 0)
                {
                    Session["grdIteamDetails"] = dt;
                    grdIteamDetails.DataSource = dt;
                    grdIteamDetails.DataBind();
                }
                else
                {

                    grdIteamDetails.DataSource = null;
                    grdIteamDetails.DataBind();
                }

            }
            catch (Exception ex)
            {
                lblloginmsg.Attributes.Add("class", "active");
                lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
                lblloginmsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Please find correct details !" + " </h4>";
            }
        }



        protected void btnRequestOpt(object sender, EventArgs e)
        {
            //----------Save Country Master Details-----------------
            try
            {


                if (txtCurrentQty.Text.ToString() != string.Empty && txtReturnQty.Text.ToString() != string.Empty && txtSalesPrice.Text.ToString() != string.Empty)
                {
                    if (Convert.ToInt32(txtReturnQty.Text) > Convert.ToInt32(txtCurrentQty.Text) || Convert.ToInt32(txtReturnQty.Text) == 0 || Convert.ToInt32(txtCurrentQty.Text) == 0)
                    {

                        lblloginmsg.Attributes.Add("class", "active");
                        lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
                        lblloginmsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Item return request quantity always less then or equal to current stock quanity !" + " </h4>";

                        return;
                    }

                    String R = "0", RI = "0";

                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = con;
                    cmd.CommandText = "SP_AF_ReturnRequest";
                    cmd.CommandType = CommandType.StoredProcedure;

                    //ID,ItemRegNo,InvoiceNo,ItemName,ItemSpecification,Brand,BarCodeNo,Quantity,CostPriceOld,SalesPriceOld,CostPrice
                    //,SalesPrice,Image,isCreated,CreateBy,CreateON,isApproved,AppID,AppDate,isComp,CompID,CompON,isStore,StoreID
                    //,StoreON,UpdateBy,UpdateON,flag,isActive
                    //FROM AfriSmartA.dbo.tbl_PriceCorrection


                    cmd.Parameters.AddWithValue("@InvoiceNo", txtBillNo.Text.Trim().ToString());
                    cmd.Parameters.AddWithValue("@TicketNo", txtTicketNo.Text.Trim().ToString());
                    cmd.Parameters.AddWithValue("@ItemRegNo", txtItemRegNo.Text.Trim().ToString());
                    cmd.Parameters.AddWithValue("@BarCodeNo", txtBarCodeNo.Text.Trim().ToString());
                    cmd.Parameters.AddWithValue("@ItemName", txtItemName.Text.Trim().ToString());
                    cmd.Parameters.AddWithValue("@ItemSpecification", txtItemSpecification.Text.Trim().ToString());
                    cmd.Parameters.AddWithValue("@CurrentQty", Convert.ToInt32(txtCurrentQty.Text).ToString());
                    cmd.Parameters.AddWithValue("@RequestQty", Convert.ToInt32(txtReturnQty.Text).ToString());
                    cmd.Parameters.AddWithValue("@Userid", dt_login_details.Rows[0]["Userid"].ToString().Trim());
                    cmd.Parameters.AddWithValue("@Flag", "IReturnRequest");
                    SqlParameter output = new SqlParameter("@Success", SqlDbType.Int);
                    output.Direction = ParameterDirection.Output;
                    cmd.Parameters.Add(output);
                    con.Open();
                    cmd.ExecuteNonQuery();
                    R = output.Value.ToString();
                    con.Close();

                    if (R != String.Empty)
                    {
                        Response.Redirect("frmItemReturn.aspx");
                    }

                }
                else
                {
                    //pnlAddDiv.Visible = false;
                    //pnlEdit.Visible = false;
                    //pnlViewDiv.Visible = false;


                    DivMain.Attributes.Add("style", "display:none;");
                    DivGrid.Attributes.Add("style", "display:none;");
                    DivAdd.Attributes.Add("style", "display:block;");

                    lblloginmsg.Attributes.Add("class", "active");
                    lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
                    lblloginmsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Please fill details on all the require fields !" + " </h4>";
                }

            }
            catch (Exception ex)
            {
                lblloginmsg.Attributes.Add("class", "active");
                lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
                lblloginmsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Please check database connection details !" + " </h4>";

                return;
            }
        }

        protected void grdIteamDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdIteamDetails.PageIndex = e.NewPageIndex;
            this.bindgrid();
        }
    }
}