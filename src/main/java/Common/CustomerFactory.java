package Common;

import Core.SqlConnection;
import Role.*;

import java.sql.ResultSet;

public class CustomerFactory implements ObjFactory
{
    private static Customer cus;

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
        if (cus == null)
        {
            ResultSet rs = SqlConnection.getData("SELECT * FROM customer WHERE uname='" + uname + "'");

            if (rs.first())
            {
                cus = getCustomer();

                cus.setId(rs.getInt("cus_id"));
                cus.setName(rs.getString("name"));
                cus.setEmail(rs.getString("email"));
                cus.setAddress(rs.getString("address"));
                cus.setTel(rs.getString("tel"));
                cus.setDateAndTime(rs.getDate("reg_date"));
                cus.setUname(uname);
            }
            else
                return null;
        }
        else
        {
            ResultSet rs = SqlConnection.getData("SELECT * FROM customer WHERE uname='" + uname + "'");

            if (rs.first())
            {
                cus.setId(rs.getInt("cus_id"));
                cus.setName(rs.getString("name"));
                cus.setEmail(rs.getString("email"));
                cus.setAddress(rs.getString("address"));
                cus.setTel(rs.getString("tel"));
                cus.setDateAndTime(rs.getDate("reg_date"));
                cus.setUname(uname);
            }
            else
                return null;
        }

        return cus;
    }

    public Customer getCustomer() throws Exception
    {
        if (cus == null)
            cus = new Customer();

        return cus;
    }

    public Staff getStaff(int stf_id) throws Exception
    {
        return null;
    }

    public Staff getStaff() throws Exception
    {
        return null;
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
