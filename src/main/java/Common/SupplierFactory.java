package Common;

import Core.SqlConnection;
import Role.*;

import java.sql.ResultSet;

public class SupplierFactory implements ObjFactory
{
    private static Supplier sup;

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
        return null;
    }

    public Staff getStaff() throws Exception
    {
        return null;
    }

    public Supplier getSupplier(int sup_id) throws Exception
    {
        if (sup == null)
        {
            ResultSet rs = SqlConnection.getData("SELECT * FROM supplier WHERE sup_id=" + sup_id);

            if (rs.first())
            {
                sup = getSupplier();

                sup.setId(rs.getInt("sup_id"));
                sup.setName(rs.getString("company"));
                sup.setAgentName(rs.getString("agent_name"));
                sup.setAddress(rs.getString("address"));
                sup.setTel(rs.getString("tel"));
                sup.setEmail(rs.getString("email"));
                sup.setDateAndTime(rs.getDate("reg_date"));
                sup.setStaff(getStaff(rs.getInt("stf_id")));
                sup.setStatus(rs.getBoolean("status"));
            }
            else
                return null;
        }
        else
        {
            ResultSet rs = SqlConnection.getData("SELECT * FROM supplier WHERE sup_id=" + sup_id);

            if (rs.first())
            {
                sup.setId(rs.getInt("sup_id"));
                sup.setName(rs.getString("company"));
                sup.setAgentName(rs.getString("agent_name"));
                sup.setAddress(rs.getString("address"));
                sup.setTel(rs.getString("tel"));
                sup.setEmail(rs.getString("email"));
                sup.setDateAndTime(rs.getDate("reg_date"));
                sup.setStaff(getStaff(rs.getInt("stf_id")));
                sup.setStatus(rs.getBoolean("status"));
            }
            else
                return null;
        }

        return sup;
    }

    public Supplier getSupplier() throws Exception
    {
        if (sup == null)
            sup = new Supplier();

        return sup;
    }
}
