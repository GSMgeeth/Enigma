package Common;

import Core.SqlConnection;
import Role.*;

import java.sql.ResultSet;

public class BookFactory implements ObjFactory
{
    private static Book bk;
    private static Category cat;

    public Book getBook(int book_id) throws Exception
    {
        if (bk == null)
        {
            ResultSet rs = SqlConnection.getData("SELECT * FROM book WHERE book_id='" + book_id + "'");

            if (rs.first())
            {
                bk = getBook();
                cat = getCategory(rs.getInt("cat_id"));

                bk.setBookId(rs.getInt("book_id"));
                bk.setBookName(rs.getString("book_name"));
                bk.setAuthorName(rs.getString("author_name"));
                bk.setDes(rs.getString("description"));
                bk.setCat(cat);
                bk.setImg(rs.getString("img"));
                bk.setRating(rs.getInt("rating"));
            }
            else
                return null;
        }
        else
        {
            ResultSet rs = SqlConnection.getData("SELECT * FROM book WHERE book_id='" + book_id + "'");

            if (rs.first())
            {
                cat = getCategory(rs.getInt("cat_id"));

                bk.setBookId(rs.getInt("book_id"));
                bk.setBookName(rs.getString("book_name"));
                bk.setAuthorName(rs.getString("author_name"));
                bk.setDes(rs.getString("description"));
                bk.setCat(cat);
                bk.setImg(rs.getString("img"));
                bk.setRating(rs.getInt("rating"));
            }
            else
                return null;
        }

        return bk;
    }

    public Book getBook() throws Exception
    {
        if (bk == null)
            bk = new Book();

        return bk;
    }

    public Category getCategory(int cat_id) throws Exception
    {
        if (cat == null)
        {
            ResultSet rs = SqlConnection.getData("SELECT * FROM category WHERE cat_id='" + cat_id + "'");

            if (rs.first())
            {
                cat = getCategory();

                cat.setCatId(rs.getInt("cat_id"));
                cat.setCatName(rs.getString("cat_name"));
            }
            else
                return null;
        }
        else
        {
            ResultSet rs = SqlConnection.getData("SELECT * FROM category WHERE cat_id='" + cat_id + "'");

            if (rs.first())
            {
                cat.setCatId(rs.getInt("cat_id"));
                cat.setCatName(rs.getString("cat_name"));
            }
            else
                return null;
        }

        return cat;
    }

    public Category getCategory() throws Exception
    {
        if (cat == null)
            cat = new Category();

        return cat;
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
        return null;
    }

    public Supplier getSupplier() throws Exception
    {
        return null;
    }
}
