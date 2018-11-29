package Common;

import Core.SqlConnection;
import Role.*;

import java.sql.ResultSet;

public class StaffFactory implements ObjFactory
{
    private static Staff stf;

    public Book getBook(int book_id) throws Exception
    {
        return null;
    }

    public Book getBook() throws Exception
    {
        return null;
    }

    public Customer getCustomer(String uname) throws Exception
    {
        return null;
    }

    public Customer getCustomer() throws Exception
    {
        return null;
    }

    public Staff getStaff(int stf_id) throws Exception
    {
        if (stf == null)
        {
            ResultSet rs = SqlConnection.getData("SELECT * FROM staff WHERE stf_id=" + stf_id);

            if (rs.first())
            {
                stf = getStaff();

                stf.setId(rs.getInt("sup_id"));
                stf.setName(rs.getString("company"));
                stf.setTel(rs.getString("tel"));
                stf.setEmail(rs.getString("email"));
                stf.setNic(rs.getString("nic"));
                stf.setUname(rs.getString("uname"));
                stf.setType(rs.getString("type"));
                stf.setDateAndTime(rs.getDate("reg_date"));
            }
            else
                return null;
        }
        else
        {
            ResultSet rs = SqlConnection.getData("SELECT * FROM staff WHERE stf_id=" + stf_id);

            if (rs.first())
            {
                stf.setId(rs.getInt("sup_id"));
                stf.setName(rs.getString("company"));
                stf.setTel(rs.getString("tel"));
                stf.setEmail(rs.getString("email"));
                stf.setNic(rs.getString("nic"));
                stf.setUname(rs.getString("uname"));
                stf.setType(rs.getString("type"));
                stf.setDateAndTime(rs.getDate("reg_date"));
            }
            else
                return null;
        }

        return stf;
    }

    public Staff getStaff() throws Exception
    {
        if (stf == null)
            stf = new Staff();

        return stf;
    }

    public Supplier getSupplier(int sup_id) throws Exception
    {
        return null;
    }

    public Supplier getSupplier() throws Exception
    {
        return null;
    }
}
