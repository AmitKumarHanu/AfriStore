using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.IO.Compression;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using Newtonsoft.Json;



public class CommonFunctions
{
    public static string connection = System.Configuration.ConfigurationManager.ConnectionStrings["constring"].ToString();

    public static DataTable fetchdata(string query)
    {
        SqlConnection con = new SqlConnection(connection);
        con.Open();
        SqlDataAdapter da = new SqlDataAdapter(query, con);
        DataTable dt = new DataTable();
        da.Fill(dt);
        con.Close();
        con.Dispose();
        return dt;
    }




    public static int insertupdateordelete(string query)
    {
        SqlConnection con = new SqlConnection(connection);
        SqlCommand cmd = new SqlCommand(query, con);
        con.Open();
        int status = cmd.ExecuteNonQuery();
        con.Close();
        return status;
    }


    public static int SendMail(string lbl_EmployeeID, string lblPassport_No, string txtComment, string frmName, string Opt)
    {
        //-------------------Configuration settings details-------------------      

        //string sender = ConfigurationManager.AppSettings["userName"].ToString();
        //string senderPassword = ConfigurationManager.AppSettings["password"].ToString();
        //string senderHost = ConfigurationManager.AppSettings["host"].ToString();
        //int senderPort = Convert.ToInt16(ConfigurationManager.AppSettings["port"]);
        //Boolean isSSL = Convert.ToBoolean(ConfigurationManager.AppSettings["enableSsl"]);

        ////-------------------Get Applicant details-------------------      
        //string qry = "", Email = "", txtName = "";
        //qry = "Select top 1 Applicant_Id ,LoginPassportNo,Email_Id,Y.Title,FirstName,LastName,Maritial,Gender,passport_no,Applicant_Image,Passport_No FROM tbl_Registration X, tbl_TitleMaster Y where X.Title =Y.Id and   Applicant_Id='" + lbl_EmployeeID.Trim() + "' and Passport_No = '" + lblPassport_No.Trim() + "' and ISNULL(isPersonal, 0)=1   ";
        //DataTable dt = new DataTable();
        //dt = fetchdata(qry);

        //if (dt.Rows.Count > 0)
        //{
        //    txtName = dt.Rows[0]["Title"].ToString() + " " + dt.Rows[0]["FirstName"].ToString() + " " + dt.Rows[0]["LastName"].ToString();
        //    Email = dt.Rows[0]["Email_Id"].ToString();

        //    //-------------------Get Mail Formate details-------------------      
        //    string body = string.Empty;

        //    qry = "Select Subject, Title, Header, Body, Footer ,Opt from tbl_MailTempMaster W, tbl_FormMaster F where W.FormID = F.FormID and  F.formurl = '~/" + frmName.ToString() + "' and W.Opt='" + Opt.ToString() + "' ";
        //    DataTable dtM = new DataTable();
        //    dtM = fetchdata(qry);
        //    if (dtM.Rows.Count > 0)
        //    {


        //        //---------Read Teamplate and Pass data to teamplate string-------------
        //        //using streamreader for reading my htmltemplate   

        //        using (StreamReader reader = new StreamReader(HttpContext.Current.Server.MapPath("~/WebTemplate.html")))
        //        {
        //            {
        //                body = reader.ReadToEnd();
        //            }
        //            body = body.Replace("{UserName}", txtName); //replacing the required things  
        //            body = body.Replace("{Title}", dtM.Rows[0]["Title"].ToString());
        //            body = body.Replace("{Header}", dtM.Rows[0]["Header"].ToString());
        //            body = body.Replace("{Body}", dtM.Rows[0]["Body"].ToString());
        //            body = body.Replace("{message}", txtComment);
        //            body = body.Replace("{footer}", dtM.Rows[0]["Footer"].ToString());
        //        }

        //    }
        //    string subject = dtM.Rows[0]["Subject"].ToString();

        //    //------------------Configure the Email Body----------------------------
        //    MailMessage msg = new MailMessage();
        //    msg.IsBodyHtml = true;
        //    msg.From = new MailAddress(sender);
        //    msg.To.Add(Email.ToString());
        //    msg.Subject = subject;
        //    msg.Body = body;

        //    //---------------- Create a SMTP server to send the email -------------------
        //    SmtpClient smtpServer = new SmtpClient();
        //    smtpServer.Host = senderHost;
        //    smtpServer.Port = senderPort;
        //    smtpServer.EnableSsl = isSSL;

        //    //------------------Passing the credentials of the user---------------------
        //    smtpServer.DeliveryMethod = SmtpDeliveryMethod.Network;
        //    NetworkCredential credentials = new NetworkCredential(sender, senderPassword);
        //    smtpServer.Credentials = credentials;
        //    smtpServer.Send(msg);
        return 1;
        //}

        //return 0;
    }


    //--------------------Password EncryotString------------
    public static string EncryptString(string password)
    {
        string salt = "ContecS";
        bool compressText = false;
        byte[] baPwd = Encoding.UTF8.GetBytes(salt);

        // Hash the password with SHA256
        byte[] baPwdHash = SHA256Managed.Create().ComputeHash(baPwd);

        byte[] baText = Encoding.UTF8.GetBytes(password);

        if (compressText)
            baText = Compress(baText);

        byte[] baSalt = GetRandomBytes();
        byte[] baEncrypted = new byte[baSalt.Length + baText.Length];

        // Combine Salt + Text
        for (int i = 0; i < baSalt.Length; i++)
            baEncrypted[i] = baSalt[i];
        for (int i = 0; i < baText.Length; i++)
            baEncrypted[i + baSalt.Length] = baText[i];

        baEncrypted = AES_Encrypt(baEncrypted, baPwdHash);

        string result = Convert.ToBase64String(baEncrypted);
        string newresult;
        if (result.Contains("+"))
        {
            newresult = EncryptString(password);
            return newresult;
        }
        else
            return result;
    }

    // [System.Web.Http.HttpGet]
    public static string DecryptString(string password)
    {
        string salt = "ContecS";
        bool decompressText = false;
        byte[] baPwd = Encoding.UTF8.GetBytes(salt);

        // Hash the password with SHA256
        byte[] baPwdHash = SHA256Managed.Create().ComputeHash(baPwd);

        byte[] baText = Convert.FromBase64String(password);

        byte[] baDecrypted = AES_Decrypt(baText, baPwdHash);

        // Remove salt
        int saltLength = GetSaltLength();
        byte[] baResult = new byte[baDecrypted.Length - saltLength];
        for (int i = 0; i < baResult.Length; i++)
            baResult[i] = baDecrypted[i + saltLength];

        if (decompressText)
            baResult = Decompress(baResult);

        string result = Encoding.UTF8.GetString(baResult);
        return result;
    }

    public static byte[] AES_Encrypt(byte[] bytesToBeEncrypted, byte[] passwordBytes)
    {
        byte[] encryptedBytes = null;

        // Set your salt here, change it to meet your flavor:
        // The salt bytes must be at least 8 bytes.
        byte[] saltBytes = new byte[] { 1, 2, 3, 4, 5, 6, 7, 8 };

        using (MemoryStream ms = new MemoryStream())
        {
            using (RijndaelManaged AES = new RijndaelManaged())
            {
                AES.KeySize = 256;
                AES.BlockSize = 128;

                var key = new Rfc2898DeriveBytes(passwordBytes, saltBytes, 1000);
                AES.Key = key.GetBytes(AES.KeySize / 8);
                AES.IV = key.GetBytes(AES.BlockSize / 8);

                AES.Mode = CipherMode.CBC;

                using (var cs = new CryptoStream(ms, AES.CreateEncryptor(), CryptoStreamMode.Write))
                {
                    cs.Write(bytesToBeEncrypted, 0, bytesToBeEncrypted.Length);
                    cs.Close();
                }
                encryptedBytes = ms.ToArray();
            }
        }

        return encryptedBytes;
    }

    public static byte[] AES_Decrypt(byte[] bytesToBeDecrypted, byte[] passwordBytes)
    {
        byte[] decryptedBytes = null;

        // Set your salt here, change it to meet your flavor:
        // The salt bytes must be at least 8 bytes.
        byte[] saltBytes = new byte[] { 1, 2, 3, 4, 5, 6, 7, 8 };

        using (MemoryStream ms = new MemoryStream())
        {
            using (RijndaelManaged AES = new RijndaelManaged())
            {
                AES.KeySize = 256;
                AES.BlockSize = 128;

                var key = new Rfc2898DeriveBytes(passwordBytes, saltBytes, 1000);
                AES.Key = key.GetBytes(AES.KeySize / 8);
                AES.IV = key.GetBytes(AES.BlockSize / 8);

                AES.Mode = CipherMode.CBC;

                using (var cs = new CryptoStream(ms, AES.CreateDecryptor(), CryptoStreamMode.Write))
                {
                    cs.Write(bytesToBeDecrypted, 0, bytesToBeDecrypted.Length);
                    cs.Close();
                }
                decryptedBytes = ms.ToArray();
            }
        }

        return decryptedBytes;
    }

    public static byte[] GetRandomBytes()
    {
        int saltLength = GetSaltLength();
        byte[] ba = new byte[saltLength];
        RNGCryptoServiceProvider.Create().GetBytes(ba);
        return ba;
    }

    public static int GetSaltLength()
    {
        return 8;
    }

    public static byte[] Compress(byte[] data)
    {
        MemoryStream output = new MemoryStream();
        using (DeflateStream dstream = new DeflateStream(output, CompressionLevel.Optimal))
        {
            dstream.Write(data, 0, data.Length);
        }
        return output.ToArray();
    }

    public static byte[] Decompress(byte[] data)
    {
        MemoryStream input = new MemoryStream(data);
        MemoryStream output = new MemoryStream();
        using (DeflateStream dstream = new DeflateStream(input, CompressionMode.Decompress))
        {
            dstream.CopyTo(output);
        }
        return output.ToArray();
    }
}

