using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class frmBillCounter : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(CommonFunctions.connection);
    DataTable dt_login_details = new DataTable();

    String SPrice, DPrice, Currency;
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
                SPrice = hdfSalesPrice.Value.ToString();
                DPrice = hdfDiscountAmount.Value.ToString();


                BindStoreDetails();
            }


            //---------Find Currency Symbole---------------
            string qry = " Select LoginStatus,Com_Country,Currency FROM vw_UserDetails where  Com_ID like  '" + dt_login_details.Rows[0]["Com_ID"].ToString() + "%' and Br_ID like '" + dt_login_details.Rows[0]["Br_ID"].ToString() + "' and  EmployeeID like '" + dt_login_details.Rows[0]["EmployeeID"].ToString() + "'";
            DataTable dtR = new DataTable();
            dtR = CommonFunctions.fetchdata(qry);

            if (dtR.Rows.Count > 0)
            {
                Currency = dtR.Rows[0]["Currency"].ToString();
            }


            lblloginmsg.InnerHtml = "";
            hdnComID.Value = dt_login_details.Rows[0]["Com_Id"].ToString();
            hdnBrID.Value = dt_login_details.Rows[0]["Br_Id"].ToString();
            txtSearch.Focus();
        }

        catch (Exception ex)
        {
            lblloginmsg.Attributes.Add("class", "active");
            lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
            lblloginmsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Please find correct details !" + " </h4>";
        }

    }
    //--------------New Add Bill display div ----------------------      
    protected void BtnNewOpt(object sender, EventArgs e)
    {
        try
        {

            Session["AddToCard"] = null;
            BindBillNo();
            DivMain.Attributes.Add("style", "display:none;");
            DivAdd.Attributes.Add("style", "display:block;");
            DvPayment.Attributes.Add("style", "display:none;");
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



    //-------------- Get BarCode in Autoresponse fun -----------------------
    [System.Web.Services.WebMethod]
    public static List<itemResult> GetBarcode(string BarCode, string ComID, string BrID)
    {
        List<itemResult> dataList = new List<itemResult>();
        string sqlStatment = " Select  ItemName,ItemSpecification,BarCodeNo,Quantity,SalesPrice,CostPrice, ItemRegNo, TicketNo  From vw_ItemStock where Com_ID='" + ComID.ToString() + "' and Br_ID='" + BrID.ToString() + "'  and  BarCodeNo  LIKE '" + BarCode + "%' and Quantity > 0 and isVerify=1  order by ItemName asc";

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
                    detail.SalesPrice = Convert.ToDecimal(reader[4].ToString() );
                    detail.CostPrice = Convert.ToDecimal( reader[5].ToString() );
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
        string sqlStatment = " Select   ItemName,ItemSpecification,BarCodeNo,Quantity,SalesPrice, CostPrice, ItemRegNo, TicketNo From vw_ItemStock where Com_ID='" + ComID.ToString() + "' and Br_ID='" + BrID.ToString() + "' and  ItemName  LIKE '" + ItemName + "%' and Quantity > 0 and isVerify=1 order by ItemName asc";

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
                    detail.SalesPrice = Convert.ToDecimal( reader[4].ToString() );
                    detail.CostPrice = Convert.ToDecimal( reader[5].ToString() );
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


    //-------------- Get ReferedBy in Autoresponse fun -----------------------

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static List<ReferedBy> GetReferedBy(string ItemName, string ComID)
    {

        List<ReferedBy> dataList = new List<ReferedBy>();
        string sqlStatment = " Select  R_ID,Name,ContactNo,Company From tbl_Referedby where Com_ID='" + ComID.ToString() + "' and R_ID  LIKE '" + ItemName + "%' and isActive=1 order by R_ID, Name ,Company asc";

        using (SqlConnection con = new SqlConnection(CommonFunctions.connection))
        {
            using (System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(sqlStatment, con))
            {
                cmd.Connection.Open();
                System.Data.SqlClient.SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    ReferedBy detail = new ReferedBy();
                    detail.R_ID = reader[0].ToString();
                    detail.Name = reader[1].ToString();
                    detail.ContactNo = reader[2].ToString();                   
                    detail.Company = reader[2].ToString();
            
                    dataList.Add(detail);

                }
                reader.Close();
                cmd.Connection.Close();
            }
        }
        return dataList;
    }

    //-------------- Get Customer Details in Autoresponse fun -----------------------
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static List<CutomerDetails> GetCustomer(string ItemName, string ComID)
    {

        List<CutomerDetails> dataList = new List<CutomerDetails>();
        string sqlStatment = "   Select CustomerMobile, CustomerName, customerEmail from tbl_ItemTransaction where CompID ='" + ComID.ToString() + "' and CustomerMobile  LIKE '" + ItemName + "%'  and Quantity > 0  order by CustomerName asc";

        using (SqlConnection con = new SqlConnection(CommonFunctions.connection))
        {
            using (System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(sqlStatment, con))
            {
                cmd.Connection.Open();
                System.Data.SqlClient.SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    CutomerDetails detail = new CutomerDetails();
                    detail.MobileNo = reader[0].ToString();
                    detail.Name = reader[1].ToString();
                    detail.Email = reader[2].ToString();
                   

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




    public class ReferedBy
    {
        public string R_ID { get; set; }
        public string Name { get; set; }
        public string ContactNo { get; set; }
        public string Company { get; set; }
        
    }



    public class CutomerDetails
    {
        public string MobileNo { get; set; }
        public string Name { get; set; }
        public string Email { get; set; }
       

    }



    //--------------Display Serach Div-----------------------
    protected void BtnSearchOpt(object sender, EventArgs e)
    {
        try
        {

            string qry = "  Select * From  vw_UserDetails where UserName like '" + txtSearch.Value.Trim() + "%' or First_Name like '" + txtSearch.Value.Trim() + "%' or Last_Name like '" + txtSearch.Value.Trim() + "%' order by First_Name, Last_Name ";


            DataTable dt = new DataTable();
            dt = CommonFunctions.fetchdata(qry);

            if (dt.Rows.Count > 0)
            {
                Session["grdCompanyDetails"] = dt;
                lbl_total.Text = dt.Rows.Count.ToString();
                // grdUserDetails.DataSource = dt;
                //grdUserDetails.DataBind();
            }
            else
            {
                lbl_total.Text = dt.Rows.Count.ToString();
                // grdUserDetails.DataSource = null;
                // grdUserDetails.DataBind();
            }

            DivMain.Attributes.Add("style", "display:block;");
            DivAdd.Attributes.Add("style", "display:none;");
            DvPayment.Attributes.Add("style", "display:none;");
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

    //-------------- Bill No Generate -----------------------
    private void BindBillNo()
    {
        try
        {
            SqlCommand cmd1 = new SqlCommand();
            cmd1.Connection = con;
            cmd1.CommandText = "SP_Get_NewBillNo";
            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Parameters.AddWithValue("@Flag", "New");
            DataSet ds = new DataSet();
            con.Open();
            SqlDataAdapter Adp = new SqlDataAdapter(cmd1);
            Adp.Fill(ds);
            con.Close();

            if (ds.Tables[0].Rows.Count > 0)
            {
                txtBillNo.Text = ds.Tables[0].Rows[0]["BillNo"].ToString();
                lblRecInvoice.Text = txtBillNo.Text;

            }

        }
        catch (Exception ex)
        {
            lblloginmsg.Attributes.Add("class", "active");
            lblloginmsg.Attributes["style"] = "color:red; font-weight:bold;";
            lblloginmsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Please correction internet connectivity, Page binding dependent showing error !" + " </h4>";
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

    //-------------- AddtoCard DataGrid -----------------------
    protected void btnAddProduct_Click(object sender, EventArgs e)
    {
        if (txtBarCodeNo.Text != string.Empty)
        {
         

            string qry = " Select Quantity,  CostPrice, SalesPrice FROM tbl_ItemStock where  BarCodeNo  like  '" + txtBarCodeNo.Text.Trim() + "%' and itemRegNo='" + txtItemRegNo.Text.Trim() + "' and TicketNo='" + htnStockTicketNo.Value.Trim() +"' and " +
                "  CompID='" + dt_login_details.Rows[0]["Com_ID"].ToString() + "' and StoreID='"+ dt_login_details.Rows[0]["Br_id"].ToString() + "' ";

            DataTable dtR = new DataTable();
            dtR = CommonFunctions.fetchdata(qry);

            if (Convert.ToInt32(dtR.Rows[0]["Quantity"].ToString()) > 0  )
            {

                lblMessage.Attributes.Add("style", "display:none;");

                if (Convert.ToDecimal(dtR.Rows[0]["CostPrice"].ToString()) <=  Convert.ToDecimal(txtDiscountAmount.Text) )
                {
                    lblMessage.Attributes.Add("style", "display:block;");
                    lblMessage.Attributes["style"] = "color:red; font-weight:bold; background-color:white; ";
                    lblMessage.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Discount amount always less then cost price !! </h4>";

                    return;
                }
                // Check if the Session has a data assoiciated within it.If
                if (Session["AddToCard"] != null )
                {
                    DataTable dt = (DataTable)Session["AddToCard"];
                    int count = dt.Rows.Count;
                    BindGrid(count);
                }
                else
                {
                    BindGrid(1);

                }

                if (Session["AddToCard"] != null)
                {
                    DataTable dt = (DataTable)Session["AddToCard"];
                    int count = dt.Rows.Count;


                    if (count >= 1)
                    {
                        txtBarCodeNo.Text = " ";
                        txtItemName.Text = " ";
                        txtItemSpecification.Text = " ";
                        txtSalesPrice.Value = " ";
                        txtDiscountAmount.Text = " ";
                        txtItemQuantity.Text = " ";
                        txtItemRegNo.Text = " ";

                        decimal Subtotal = 0, disAmt = 0, VatAmt = 0, FinalTotal=0;
                        int TotalItem = 0;
                        for (int i = 0; i < count; i++)
                        {
                      
                      
                            TotalItem = TotalItem + Convert.ToInt32(dt.Rows[i]["Quantity"].ToString());
                            Subtotal = Subtotal + Convert.ToDecimal(dt.Rows[i]["SalesPrice"].ToString());
                            disAmt = disAmt + Convert.ToDecimal(dt.Rows[i]["Discount"].ToString());
                            FinalTotal = FinalTotal + Convert.ToDecimal(dt.Rows[i]["TotalAmount"].ToString());
                        }

                        txtitemCount.Text = TotalItem.ToString();
                        txtTDiscount.Text = disAmt.ToString("#0.00");
                        txtSubTotal.Text = Subtotal.ToString("#0.00");                   
                        decimal TPayment = FinalTotal;

                     

                        //------------Receipt Details

                        lblTotalPayment.Text = Currency.ToString() + " " + TPayment.ToString("#0.00");
                        lblRTotal.Text = Currency.ToString() + " " + TPayment.ToString("#0.00");

                    }
                }

            }
            else
            {
                lblMessage.Attributes.Add("style", "display:block;");
                lblMessage.Attributes["style"] = "color:red; font-weight:bold; background-color:white; ";
                lblMessage.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Item Out Of Stock !! </h4>";

            }


        }
    }



    private void BindGrid(int rowcount)
    {
       

        DataTable dt = new DataTable();
        DataRow dr;
        dt.Columns.Add(new System.Data.DataColumn("Name", typeof(String)));
        dt.Columns.Add(new System.Data.DataColumn("Specification", typeof(String)));
        dt.Columns.Add(new System.Data.DataColumn("Quantity", typeof(String)));
        dt.Columns.Add(new System.Data.DataColumn("SalesPrice", typeof(String)));
        dt.Columns.Add(new System.Data.DataColumn("Discount", typeof(String)));
        dt.Columns.Add(new System.Data.DataColumn("TotalAmount", typeof(String)));
        dt.Columns.Add(new System.Data.DataColumn("ItemRegNo", typeof(String)));
        dt.Columns.Add(new System.Data.DataColumn("BarcodeNo", typeof(String)));
        dt.Columns.Add(new System.Data.DataColumn("TicketNo", typeof(String)));

        if (Session["AddToCard"] != null)
        {
            int flag = 0;
            for (int i = 0; i < rowcount; i++)
            {

                dt = (DataTable)Session["AddToCard"];
                if (dt.Rows.Count > 0)
                {
                    //---itemRegNo already exist Update Qty-------
                    if ( dt.Rows[i][8].ToString().Trim() == htnStockTicketNo.Value.Trim())
                    {
                        int Qty = Convert.ToInt32(dt.Rows[i][2].ToString().Trim()) + Convert.ToInt32(txtItemQuantity.Text);
                        dt.Rows[i][2] = Qty.ToString();

                        decimal q = (Qty) * Convert.ToDecimal(dt.Rows[i][3].ToString().Trim());
                        dt.Rows[i][5] = q.ToString();

                        decimal d = Convert.ToDecimal(dt.Rows[i][4].ToString().Trim()) + Convert.ToDecimal(txtDiscountAmount.Text);
                        dt.Rows[i][4]= d.ToString("#0.00");

                        flag = 2;
                    }

                    //-----Add next item----
                    if ( dt.Rows[i][8].ToString().Trim() != htnStockTicketNo.Value.Trim() && flag == 0)
                    {
                        flag = 1;
                    }
                }
            }

            if (flag == 1)
            {
                dr = dt.NewRow();
                dr[0] = txtItemName.Text;
                dr[1] = txtItemSpecification.Text;
                dr[2] = txtItemQuantity.Text;
                dr[3] = txtSalesPrice.Value;
                decimal d = Convert.ToDecimal( txtDiscountAmount.Text);
                dr[4] = d.ToString("#0.00");
                decimal q = ( Convert.ToInt32(txtItemQuantity.Text) * Convert.ToDecimal(txtSalesPrice.Value) ) - Convert.ToDecimal(txtDiscountAmount.Text) ;
                dr[5] = q.ToString("#0.00");
                dr[6] = txtItemRegNo.Text;
                dr[7] = txtBarCodeNo.Text;
                dr[8] = htnStockTicketNo.Value;
                dt.Rows.Add(dr);
            }

        }
        else
        {
            //----------New First time Item Add------
            dr = dt.NewRow();
            dr[0] = txtItemName.Text;
            dr[1] = txtItemSpecification.Text;
            dr[2] = txtItemQuantity.Text;
            dr[3] = txtSalesPrice.Value;
            decimal d = Convert.ToDecimal(txtDiscountAmount.Text);
            dr[4] = d.ToString("#0.00");
            decimal q = (Convert.ToInt32(txtItemQuantity.Text) * Convert.ToDecimal(txtSalesPrice.Value)) - Convert.ToDecimal(txtDiscountAmount.Text);
            dr[5] = q.ToString("#0.00");
            dr[6] = txtItemRegNo.Text;
            dr[7] = txtBarCodeNo.Text;
            dr[8] = htnStockTicketNo.Value;
            dt.Rows.Add(dr);
        }

        // If Session has a data then use the value as the DataSource
        if (Session["AddToCard"] != null)
        {
            grdAddToCard.DataSource = (DataTable)Session["AddToCard"];
            grdAddToCard.DataBind();
            grdPayGrid.DataSource = (DataTable)Session["AddToCard"];
            grdPayGrid.DataBind();
        }
        else
        {
            // Bind GridView with the initial data assocaited in the DataTable
            grdAddToCard.DataSource = dt;
            grdAddToCard.DataBind();
            grdPayGrid.DataSource = (DataTable)Session["AddToCard"];
            grdPayGrid.DataBind();

        }
        // Store the DataTable in Session to retain the values
        Session["AddToCard"] = dt;


        if (dt.Rows.Count > 0)
        {

            //---------Update Select Quantity in tbl_itemmaster-------------------- -
            SqlCommand cmdI = new SqlCommand();
            cmdI.Connection = con;
            cmdI.CommandText = "SP_AF_ItemQty";
            cmdI.CommandType = CommandType.StoredProcedure;
            cmdI.Parameters.AddWithValue("@Qty", Convert.ToInt32(txtItemQuantity.Text));
            cmdI.Parameters.AddWithValue("@BarCodeNo", txtBarCodeNo.Text.Trim().ToString());
            cmdI.Parameters.AddWithValue("@itemRegNo", txtItemRegNo.Text.Trim().ToString());

            cmdI.Parameters.AddWithValue("@TicketNo", txtBillNo.Text.Trim().ToString());
            cmdI.Parameters.AddWithValue("@StockTicketNo", htnStockTicketNo.Value.Trim().ToString());    
            cmdI.Parameters.AddWithValue("@Userid", dt_login_details.Rows[0]["Userid"].ToString());
            cmdI.Parameters.AddWithValue("@Flag", "IitemQty");
            SqlParameter output = new SqlParameter("@Success", SqlDbType.Int);
            output.Direction = ParameterDirection.Output;
            cmdI.Parameters.Add(output);
            con.Open();
            cmdI.ExecuteNonQuery();
            string RI = output.Value.ToString();
            con.Close();
        }

    }


    protected void btnPaymentOpt(object sender, EventArgs e)
    {
        try
        {
            //---------Split---------------
            var P = lblTotalPayment.Text.Split(' ');
            lblTotalPayment.Text = P[1].ToString();

            if (Convert.ToDecimal(lblTotalPayment.Text) > 0)
            {
                lblPayamount.Text = Convert.ToDecimal(lblTotalPayment.Text).ToString();

                //----------Insert Details in tbl_itemtransaction-------------
                int Count = 0;
                foreach (GridViewRow r in grdAddToCard.Rows)
                {

                    Label lblItemName = (Label)r.FindControl("lblItemName");
                    Label lblItemDetails = (Label)r.FindControl("lblItemDetails");
                    Label lblPrice = (Label)r.FindControl("lblPrice");
                    Label lblQuantity = (Label)r.FindControl("lblQuantity");
                    Label lblDiscount = (Label)r.FindControl("lblDiscount");
                    Label lblTotalAmount = (Label)r.FindControl("lblTotalAmount");
                    Label lblActions = (Label)r.FindControl("lblActions");
                    Label lblBarcode = (Label)r.FindControl("lblBarcode");
                    Label lblStockTicketNo = (Label)r.FindControl("lblTicketNo");
                    


                    //----Func Update flag isVerify--------
                    //---------Trafer Ticker Details to Branch / Store---------------------
                    SqlCommand cmdI = new SqlCommand();
                    cmdI.Connection = con;
                    cmdI.CommandText = "SP_AF_ItemTransaction";
                    cmdI.CommandType = CommandType.StoredProcedure;

                    cmdI.Parameters.AddWithValue("@TicketNo", txtBillNo.Text.Trim().ToString());
                    cmdI.Parameters.AddWithValue("@TicketDate", txtBillDate.Text.Trim().ToString());
                    cmdI.Parameters.AddWithValue("@Currency", txtCurrency.Text.Trim().ToString());

                    cmdI.Parameters.AddWithValue("@ItemName", lblItemName.Text.Trim().ToString());
                    cmdI.Parameters.AddWithValue("@ItemDetails", lblItemDetails.Text.Trim().ToString());
                    cmdI.Parameters.AddWithValue("@SalesPrice", lblPrice.Text.Trim().ToString());
                    cmdI.Parameters.AddWithValue("@Quantity", lblQuantity.Text.Trim().ToString());
                    cmdI.Parameters.AddWithValue("@TotalAmount", lblTotalAmount.Text.Trim().ToString());
                    cmdI.Parameters.AddWithValue("@ItemRegNo", lblActions.Text.Trim().ToString());
                    cmdI.Parameters.AddWithValue("@BarcodeNo", lblBarcode.Text.Trim().ToString());
                    cmdI.Parameters.AddWithValue("@DisAmount", lblDiscount.Text.Trim().ToString());

                    cmdI.Parameters.AddWithValue("@CustomerName", txtCustName.Text.Trim().ToString());
                    cmdI.Parameters.AddWithValue("@CustomerMobile", txtCusMobileNo.Text.Trim().ToString());
                    cmdI.Parameters.AddWithValue("@CustomerEmail", txtCustEmailId.Text.Trim().ToString());
                    cmdI.Parameters.AddWithValue("@StockTicketNo", lblStockTicketNo.Text.Trim().ToString());
                    cmdI.Parameters.AddWithValue("@ReferedBy", txtReferetBy.Text.Trim().ToString());
                    cmdI.Parameters.AddWithValue("@Userid", dt_login_details.Rows[0]["Userid"].ToString());

                   // htnStockTicketNo

                    cmdI.Parameters.AddWithValue("@Flag", "ItemTrans_Step1");
                    SqlParameter output = new SqlParameter("@Success", SqlDbType.Int);
                    output.Direction = ParameterDirection.Output;
                    cmdI.Parameters.Add(output);
                    con.Open();
                    cmdI.ExecuteNonQuery();
                    string RI = output.Value.ToString();
                    con.Close();
                    if (RI == "1")
                        Count++;

                    lblRReferedBy.Text = txtReferetBy.Text.Trim().ToString();
                    lblRDiscount.Text = txtTDiscount.Text.Trim().ToString();
                    lblRSalesPrice.Text = txtSubTotal.Text.Trim().ToString();
                }
                if (Count > 0)
                {
                    txtPaidAmount.Text = "0";
                    lblChangeAmount.Text = "0";
                    lblDueAmount.Text = "0";
                    lblSalesDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
                    lblRecDate.Text = DateTime.Now.ToString("dd/MM/yyyy");

                  
                    //lblloginmsg.Attributes.Add("style", "display:block;");
                    //lblloginmsg.Attributes["style"] = "color:green; font-weight:bold; background-color:white; ";
                    //lblloginmsg.InnerHtml = " <strong>Warning!</strong> <h4 >" + " Item Verified Successful !" + " </h4>";

                    DivMain.Attributes.Add("style", "display:none;");
                    DivAdd.Attributes.Add("style", "display:none;");
                    DvPayment.Attributes.Add("style", "display:block;");
                    DivReceipt.Attributes.Add("style", "display:none;");
                    DivReceipt.Attributes.Add("style", "display:none;");
                    DivPrintOpt.Attributes.Add("style", "display:none;");
             
                }
                //-----------End------------------
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

            if (Session["AddToCard"] != null)
            {



                //---------Update Remove Quantity in tbl_itemmaster---------------------
                SqlCommand cmdI = new SqlCommand();
                cmdI.Connection = con;
                cmdI.CommandText = "SP_AF_ItemTransactionPayment";
                cmdI.CommandType = CommandType.StoredProcedure;
                cmdI.Parameters.AddWithValue("@TicketNo", txtBillNo.Text.Trim().ToString());

                cmdI.Parameters.AddWithValue("@PaidAmount", txtPaidAmount.Text.Trim().ToString());
                cmdI.Parameters.AddWithValue("@ChangeAmount", lblChangeAmount.Text.Trim().ToString());
                cmdI.Parameters.AddWithValue("@DueAmount", lblDueAmount.Text.Trim().ToString());
                cmdI.Parameters.AddWithValue("@PaymentMode", drpPayby.SelectedValue.Trim().ToString());

                cmdI.Parameters.AddWithValue("@Userid", dt_login_details.Rows[0]["Userid"].ToString());
                cmdI.Parameters.AddWithValue("@Flag", "ItemTrans_Step3");
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
                    DivAdd.Attributes.Add("style", "display:none;");
                    DvPayment.Attributes.Add("style", "display:none;");
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

    protected void btnPreviewReceipt_Click(object sender, EventArgs e)
    {
        try
        {
            Label lblChangeAmount = new Label();
            lblChangeAmount.Text = hdnChangeAmount.Value.ToString();

            Label lblDueAmount = new Label();
            lblDueAmount.Text = hdnDueAmount.Value.ToString();


                if (Session["AddToCard"] != null)
                {

                    //---------Update Remove Quantity in tbl_itemmaster---------------------
                    SqlCommand cmdI = new SqlCommand();
                    cmdI.Connection = con;
                    cmdI.CommandText = "SP_AF_ItemTransactionPayment";
                    cmdI.CommandType = CommandType.StoredProcedure;
                    cmdI.Parameters.AddWithValue("@TicketNo", txtBillNo.Text.Trim().ToString());

                    cmdI.Parameters.AddWithValue("@PaidAmount", txtPaidAmount.Text.Trim().ToString());
                    cmdI.Parameters.AddWithValue("@ChangeAmount", lblChangeAmount.Text.Trim().ToString());
                    cmdI.Parameters.AddWithValue("@DueAmount", lblDueAmount.Text.Trim().ToString());
                    cmdI.Parameters.AddWithValue("@PaymentMode", drpPayby.SelectedValue.Trim().ToString());

                    cmdI.Parameters.AddWithValue("@Userid", dt_login_details.Rows[0]["Userid"].ToString());
                    cmdI.Parameters.AddWithValue("@Flag", "ItemTrans_Step2");
                    SqlParameter output = new SqlParameter("@Success", SqlDbType.Int);
                    output.Direction = ParameterDirection.Output;
                    cmdI.Parameters.Add(output);
                    con.Open();
                    cmdI.ExecuteNonQuery();
                    string RI = output.Value.ToString();
                    con.Close();

                    if (RI == "1")
                    {
                        grdPayGrid.DataSource = (DataTable)Session["AddToCard"];
                        grdPayGrid.DataBind();



                        if (Session["grdBrDetails"] != null)
                        {
                            DataTable dtBr = new DataTable();
                            dtBr = (DataTable)Session["grdBrDetails"];

                            lblBrName.Text = dtBr.Rows[0]["Br_Name"].ToString();
                            lblBrAddress.Text = dtBr.Rows[0]["Br_Address"].ToString();
                            lblBrEmail.Text = dtBr.Rows[0]["Br_Email"].ToString();
                            lblBrPhone.Text = dtBr.Rows[0]["Br_PhoneNo"].ToString();

                            lblRPaymentMode.Text = drpPayby.SelectedItem.ToString();
                        }

                        DivMain.Attributes.Add("style", "display:none;");
                        DivAdd.Attributes.Add("style", "display:none;");
                        DvPayment.Attributes.Add("style", "display:none;");
                        DivReceipt.Attributes.Add("style", "display:block;");
                        DivPrintOpt.Attributes.Add("style", "display:none;");
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

            if (Session["AddToCard"] != null)
            {



                //---------Update Remove Quantity in tbl_itemmaster---------------------
                SqlCommand cmdI = new SqlCommand();
                cmdI.Connection = con;
                cmdI.CommandText = "SP_AF_ItemTransactionPayment";
                cmdI.CommandType = CommandType.StoredProcedure;
                cmdI.Parameters.AddWithValue("@TicketNo", txtBillNo.Text.Trim().ToString());

                cmdI.Parameters.AddWithValue("@PaidAmount", txtPaidAmount.Text.Trim().ToString());
                cmdI.Parameters.AddWithValue("@ChangeAmount", lblChangeAmount.Text.Trim().ToString());
                cmdI.Parameters.AddWithValue("@DueAmount", lblDueAmount.Text.Trim().ToString());
                cmdI.Parameters.AddWithValue("@PaymentMode", drpPayby.SelectedValue.Trim().ToString());

                cmdI.Parameters.AddWithValue("@Userid", dt_login_details.Rows[0]["Userid"].ToString());
                cmdI.Parameters.AddWithValue("@Flag", "ItemTrans_Step4");
                SqlParameter output = new SqlParameter("@Success", SqlDbType.Int);
                output.Direction = ParameterDirection.Output;
                cmdI.Parameters.Add(output);
                con.Open();
                cmdI.ExecuteNonQuery();
                string RI = output.Value.ToString();
                con.Close();

                if (RI == "1")
                {

                    Response.Redirect("frmBillCounter.aspx");

                    Session["AddToCard"] = null;

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

    protected void linkDelete_Click(object sender, EventArgs e)
    {
        try
        {
            //---------Delete Row from date set and bind with datagrid
            String id = ((sender as LinkButton).CommandArgument);
            DataTable dt = (DataTable)Session["AddToCard"];
            int HQty = 0; string BarCodeNo = "";

            if (Session["AddToCard"] != null)
            {

                int count = dt.Rows.Count;

                for (int i = dt.Rows.Count - 1; i >= 0; i--)
                {
                    DataRow dr = dt.Rows[i];
                    if (dr["ItemRegNo"].ToString() == id.ToString() && dr["TicketNo"].ToString() == htnStockTicketNo.Value.Trim())
                    {
                        HQty = Convert.ToInt32(dr["Quantity"].ToString());
                        BarCodeNo = dr["BarcodeNo"].ToString();
                        dr.Delete();
                    }
                }

                int count1 = dt.Rows.Count;
                if (Session["AddToCard"] != null)
                {
                    grdAddToCard.DataSource = (DataTable)Session["AddToCard"];
                    grdAddToCard.DataBind();

                    grdPayGrid.DataSource = (DataTable)Session["AddToCard"];
                    grdPayGrid.DataBind();

                }
                else
                {
                    // Bind GridView with the initial data assocaited in the DataTable
                    grdAddToCard.DataSource = dt;
                    grdAddToCard.DataBind();
                    grdPayGrid.DataSource = (DataTable)Session["AddToCard"];
                    grdPayGrid.DataBind();

                }
                Session["AddToCard"] = dt;

            }
            if (Session["AddToCard"] != null)
            {
                //DataTable dt = (DataTable)Session["AddToCard"];
                int count = dt.Rows.Count;


                if (count >= 1)
                {
                    txtBarCodeNo.Text = " ";
                    txtItemName.Text = " ";
                    txtItemSpecification.Text = " ";
                    txtSalesPrice.Value = " ";
                    txtDiscountAmount.Text = " ";
                    txtItemQuantity.Text = " ";
                    txtItemRegNo.Text = " ";

                    decimal Subtotal = 0, disAmt = 0, VatAmt = 0, FinalTotal = 0;
                    int TotalItem = 0;
                    for (int i = 0; i < count; i++)
                    {
                        TotalItem = TotalItem + Convert.ToInt32(dt.Rows[i]["Quantity"].ToString());
                        disAmt = disAmt + Convert.ToDecimal(dt.Rows[i]["Discount"].ToString());
                        Subtotal = Subtotal + Convert.ToDecimal(dt.Rows[i]["SalesPrice"].ToString());
                        FinalTotal = FinalTotal + Convert.ToDecimal(dt.Rows[i]["TotalAmount"].ToString());
                    
                    }

                    txtitemCount.Text = TotalItem.ToString();
                    txtTDiscount.Text = disAmt.ToString("#0.00");
                    txtSubTotal.Text = Subtotal.ToString("#0.00");
                    decimal TPayment = FinalTotal;
                    ////--discount--
                    //if (txtDiscount.Text != "0")
                    //{
                    //    decimal DRate = Convert.ToDecimal(txtDiscount.Text);

                    //    disAmt = ((Subtotal * DRate) / 100);
                    //    txtDiscountAmount.Text = disAmt.ToString();
                    //    AfterDisAmi = Subtotal - disAmt;
                    //}
                    ////---Vat--------

                    //if (txtVAT.Text != "0")
                    //{
                    //    decimal VRate = Convert.ToDecimal(txtVAT.Text);

                    //    VatAmt = ((AfterDisAmi * VRate) / 100);
                    //    txtVatAmount.Text = VatAmt.ToString();
                    //}
                    //decimal SAmt = Convert.ToDecimal(txtSubTotal.Text);
                    //decimal DAmt = Convert.ToDecimal(txtDiscountAmount.Text);
                    //decimal VAmt = Convert.ToDecimal(txtVatAmount.Text);
                    // decimal TPayment = SAmt;


                    //------------Receipt Details
                    //lblRDiscount.Text = "₦ " + DAmt.ToString();
                    //lblRVATax.Text = "₦ " + VAmt.ToString();
                    lblTotalPayment.Text = Currency.ToString() + " " + TPayment.ToString("#0.00");
                    lblRTotal.Text = Currency.ToString() + " " + TPayment.ToString("#0.00");

                }
                if (count < 1)
                {
                    txtBarCodeNo.Text = " ";
                    txtItemName.Text = " ";
                    txtItemSpecification.Text = " ";
                    txtSalesPrice.Value = " ";
                    txtDiscountAmount.Text = " ";
                    txtItemQuantity.Text = " ";
                    txtItemRegNo.Text = " ";
                    txtitemCount.Text = "";
                    txtSubTotal.Text = "0";
                    //txtDiscountAmount.Text = "0";
                    //txtVatAmount.Text = "0";
                    lblTotalPayment.Text = "0";
                    //lblRDiscount.Text = "0";
                    //lblRVATax.Text = "0";
                    lblRTotal.Text = "0";
                    Session["AddToCard"] = null;
                }


                //---------Update Remove Quantity in tbl_itemmaster---------------------
                SqlCommand cmdI = new SqlCommand();
                cmdI.Connection = con;
                cmdI.CommandText = "SP_AF_ItemQty";
                cmdI.CommandType = CommandType.StoredProcedure;
                cmdI.Parameters.AddWithValue("@Qty", HQty);
                cmdI.Parameters.AddWithValue("@BarCodeNo", BarCodeNo.ToString());
                cmdI.Parameters.AddWithValue("@itemRegNo", id.ToString());
                cmdI.Parameters.AddWithValue("@TicketNo", txtBillNo.Text.Trim().ToString());
                cmdI.Parameters.AddWithValue("@StockTicketNo", htnStockTicketNo.Value.Trim().ToString());
                cmdI.Parameters.AddWithValue("@Userid", dt_login_details.Rows[0]["Userid"].ToString());
                cmdI.Parameters.AddWithValue("@Flag", "RitemQty");
                SqlParameter output = new SqlParameter("@Success", SqlDbType.Int);
                output.Direction = ParameterDirection.Output;
                cmdI.Parameters.Add(output);
                con.Open();
                cmdI.ExecuteNonQuery();
                string RI = output.Value.ToString();
                con.Close();

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


            if (Session["AddToCard"] != null)
            {
                DivMain.Attributes.Add("style", "display:none;");
                DivAdd.Attributes.Add("style", "display:none;");
                DvPayment.Attributes.Add("style", "display:none;");
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

}
