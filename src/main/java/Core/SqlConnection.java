package Core;

import java.sql.*;

public class SqlConnection
{
    private static Connection conn = null;

    public static Connection getConnection() throws Exception
    {
        if (conn == null)
        {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/enigma?verifyServerCertificate=false&useSSL=true", "root", "");
        }

        return conn;
    }

    public static ResultSet getData(String qry) throws Exception
    {
        return SqlConnection.getConnection().prepareStatement(qry).executeQuery();
    }

    public static void updateDB(String q,Injecterble inject) throws Exception
    {
        PreparedStatement ps = SqlConnection.getConnection().prepareStatement(q);
        ps=inject.inject(ps);
        ps.execute();
    }
}
