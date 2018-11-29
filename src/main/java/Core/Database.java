package Core;

import java.sql.*;
import java.text.*;

import Role.*;

public class Database
{
    public void saveCustomer(Customer newCus) throws Exception
    {
        String sql = "INSERT INTO customer (name, address, tel, email, uname, pw, reg_date) VALUES (?,?,?,?,?,?,?)";
        SqlConnection.updateDB(sql, ps -> {
            int i = 0;
            ps.setString(++i, newCus.getName());
            ps.setString(++i, newCus.getAddress());
            ps.setString(++i, newCus.getTel());
            ps.setString(++i, newCus.getEmail());
            ps.setString(++i, newCus.getUname());
            ps.setString(++i, newCus.getPword());
            ps.setString(++i, new SimpleDateFormat("yyyy/MM/dd").format(newCus.getDateAndTime()));
            return ps;
        });
    }

    public void updateCustomer(Customer newCus) throws Exception
    {
        String sql = "UPDATE customer SET name=?, address=?, tel=?, email=? WHERE uname=?";
        SqlConnection.updateDB(sql, ps -> {
            int i = 0;
            ps.setString(++i, newCus.getName());
            ps.setString(++i, newCus.getAddress());
            ps.setString(++i, newCus.getTel());
            ps.setString(++i, newCus.getEmail());
            ps.setString(++i, newCus.getUname());
            return ps;
        });
    }

    public void updateCustomerPassword(Customer newCus) throws Exception
    {
        String sql = "UPDATE customer SET pw=? WHERE uname=?";
        SqlConnection.updateDB(sql, ps -> {
            int i = 0;
            ps.setString(++i, newCus.getPword());
            ps.setString(++i, newCus.getUname());
            return ps;
        });
    }

    public void saveCategory(Category newCat) throws Exception
    {
        String sql = "INSERT INTO category (cat_name) VALUES (?)";
        SqlConnection.updateDB(sql, ps -> {
            int i = 0;
            ps.setString(++i, newCat.getCatName());
            return ps;
        });
    }

    public void saveBook(Book newbk) throws Exception
    {
        String sql = "INSERT INTO book (book_name,author_name,description,cat_id,img) VALUES (?,?,?,?,?)";
        SqlConnection.updateDB(sql, ps -> {
            int i = 0;
            ps.setString(++i, newbk.getBookName());
            ps.setString(++i, newbk.getAuthorName());
            ps.setString(++i, newbk.getDes());
            ps.setInt(++i, newbk.getCat().getCatId());
            ps.setString(++i, newbk.getImg());
            return ps;
        });
    }

    public void updateBook(Book bk) throws Exception
    {
        String sql = "UPDATE book SET book_name=?, author_name=?, description=?, cat_id=?, img=?, rating=? WHERE book_id=?";
        SqlConnection.updateDB(sql, ps -> {
            int i = 0;
            ps.setString(++i, bk.getBookName());
            ps.setString(++i, bk.getAuthorName());
            ps.setString(++i, bk.getDes());
            ps.setInt(++i, bk.getCat().getCatId());
            ps.setString(++i, bk.getImg());
            ps.setInt(++i, bk.getRating());
            ps.setInt(++i, bk.getBookId());
            return ps;
        });
    }

    public void saveStaff(Staff newStf) throws Exception
    {
        String sql = "INSERT INTO staff (name, tel, email, nic, uname, pw, type, reg_date) VALUES (?,?,?,?,?,?,?,?)";
        SqlConnection.updateDB(sql, ps -> {
            int i = 0;
            ps.setString(++i, newStf.getName());
            ps.setString(++i, newStf.getTel());
            ps.setString(++i, newStf.getEmail());
            ps.setString(++i, newStf.getNic());
            ps.setString(++i, newStf.getUname());
            ps.setString(++i, newStf.getPword());
            ps.setString(++i, newStf.getType());
            ps.setString(++i, new SimpleDateFormat("yyyy/MM/dd").format(newStf.getDateAndTime()));
            return ps;
        });
    }

    public void saveSupplier(Supplier newSup) throws Exception
    {
        String sql = "INSERT INTO supplier (company, agent_name, address, tel, email, reg_date, stf_id) VALUES (?,?,?,?,?,?,?)";
        SqlConnection.updateDB(sql, ps -> {
            int i = 0;
            ps.setString(++i, newSup.getName());
            ps.setString(++i, newSup.getAgentName());
            ps.setString(++i, newSup.getAddress());
            ps.setString(++i, newSup.getTel());
            ps.setString(++i, newSup.getEmail());
            ps.setString(++i, new SimpleDateFormat("yyyy/MM/dd").format(newSup.getDateAndTime()));
            ps.setInt(++i, newSup.getStaff().getId());
            return ps;
        });
    }

    public void saveBatch(Batch newBatch) throws Exception
    {
        String sql = "INSERT INTO batch (buying_price, selling_price, stf_id) VALUES (?,?,?)";
        SqlConnection.updateDB(sql, ps -> {
            int i = 0;
            ps.setFloat(++i, newBatch.getBuying_price());
            ps.setFloat(++i, newBatch.getSelling_price());
            ps.setInt(++i, newBatch.getStf_id());
            return ps;
        });
    }

    public void saveGrn(Grn newGrn) throws Exception
    {
        String sql = "INSERT INTO grn (discount, sup_id, veh_no, date, time, stf_id) VALUES (?,?,?,?,?,?)";
        SqlConnection.updateDB(sql, ps -> {
            int i = 0;
            ps.setDouble(++i, newGrn.getDiscount());
            ps.setInt(++i, newGrn.getSup_id());
            ps.setString(++i, newGrn.getVeh_no());
            ps.setString(++i, new SimpleDateFormat("yyyy/MM/dd").format(newGrn.getDateAndTime()));
            ps.setString(++i, new SimpleDateFormat("hh:mm:ss").format(newGrn.getDateAndTime()));
            ps.setInt(++i, newGrn.getStf_id());
            return ps;
        });
    }

    public void saveGrnCopy(GrnCopy newGrnCopy) throws Exception
    {
        String sql = "INSERT INTO grn_copy (grn_id, book_id, batch_id, qty, to_add) VALUES (?,?,?,?,?)";
        SqlConnection.updateDB(sql, ps -> {
            int i = 0;
            ps.setInt(++i, newGrnCopy.getGrn_id());
            ps.setInt(++i, newGrnCopy.getBook().getBookId());
            ps.setInt(++i, newGrnCopy.getBatch().getBatch_id());
            ps.setInt(++i, newGrnCopy.getQty());
            ps.setInt(++i, newGrnCopy.getTo_add());
            return ps;
        });
    }

    public void saveBookCopy(BookCopy newBookCopy) throws Exception
    {
        String sql = "INSERT INTO book_copy (ISBN, book_id, grn_id) VALUES (?,?,?)";
        SqlConnection.updateDB(sql, ps -> {
            int i = 0;
            ps.setString(++i, newBookCopy.getISBN());
            ps.setInt(++i, newBookCopy.getBookId());
            ps.setInt(++i, newBookCopy.getGrnId());
            return ps;
        });
    }

    public void updateBookCopy(BookCopy newBookCopy) throws Exception
    {
        String sql = "UPDATE book_copy SET availability=? WHERE ISBN=?";
        SqlConnection.updateDB(sql, ps -> {
            int i = 0;
            ps.setBoolean(++i, newBookCopy.getAvailability());
            ps.setString(++i, newBookCopy.getISBN());
            return ps;
        });
    }

    public void updateGrnCopy(GrnCopy newGrnCopy) throws Exception
    {
        String sql = "UPDATE grn_copy SET to_add=? WHERE grn_copy_id=?";
        SqlConnection.updateDB(sql, ps -> {
            int i = 0;
            ps.setInt(++i, newGrnCopy.getTo_add());
            ps.setInt(++i, newGrnCopy.getGrn_copy_id());
            return ps;
        });
    }

    public void saveShoppingCart(ShoppingCart newCart) throws Exception
    {
        String sql = "INSERT INTO shopping_cart (book_id, cus_id, date) VALUES (?,?,?)";
        SqlConnection.updateDB(sql, ps -> {
            int i = 0;
            ps.setInt(++i, newCart.getBook().getBookId());
            ps.setInt(++i, newCart.getCustomer().getId());
            ps.setString(++i, new SimpleDateFormat("yyyy/MM/dd").format(newCart.getDateAndTime()));
            return ps;
        });
    }

    public void removeShoppingCart(ShoppingCart item) throws Exception
    {
        String sql = "DELETE FROM shopping_cart WHERE book_id=? AND cus_id=?;";
        SqlConnection.updateDB(sql, ps -> {
            int i = 0;
            ps.setInt(++i, item.getBook().getBookId());
            ps.setInt(++i, item.getCustomer().getId());
            return ps;
        });
    }

    public void saveInvoice(Invoice newInv) throws Exception
    {
        String sql = "INSERT INTO invoice (discount,date,time,cus_id) VALUES (?,?,?,?)";
        SqlConnection.updateDB(sql, ps -> {
            int i = 0;
            ps.setFloat(++i, newInv.getDiscount());
            ps.setString(++i, new SimpleDateFormat("yyyy/MM/dd").format(newInv.getDateAndTime()));
            ps.setString(++i, new SimpleDateFormat("hh:mm:ss").format(newInv.getDateAndTime()));
            ps.setInt(++i, newInv.getCus_id());
            return ps;
        });
    }

    public void saveInvoiceCopy(InvoiceCopy newInvCopy) throws Exception
    {
        String sql = "INSERT INTO invoice_copy (inv_id,ISBN) VALUES (?,?)";
        SqlConnection.updateDB(sql, ps -> {
            int i = 0;
            ps.setInt(++i, newInvCopy.getInv_id());
            ps.setString(++i, newInvCopy.getISBN().getISBN());
            return ps;
        });
    }

    public void updateInvoiceCopy(InvoiceCopy newInvCopy) throws Exception
    {
        String sql = "UPDATE invoice_copy SET status=? WHERE ISBN=?";
        SqlConnection.updateDB(sql, ps -> {
            int i = 0;
            ps.setBoolean(++i, newInvCopy.getStatus());
            ps.setString(++i, newInvCopy.getISBN().getISBN());
            return ps;
        });
    }

    public void savePasswordRescueCode(String code, String email) throws Exception
    {
        String sql = "UPDATE customer SET pw_rescue_code=? WHERE email=?";
        SqlConnection.updateDB(sql, ps -> {
            int i = 0;
            ps.setString(++i, code);
            ps.setString(++i, email);
            return ps;
        });
    }

    public static Batch getFirstAvailableIsbnBatch(int book_id) throws Exception
    {
        ResultSet rs = SqlConnection.getData("SELECT DISTINCT(g.batch_id) AS batch_id FROM grn_copy g INNER JOIN book_copy b ON b.book_id=g.book_id WHERE" +
                " g.book_id=" + book_id + " AND b.availability=1;");

        if (rs.first())
        {
            ResultSet rsBatch = SqlConnection.getData("SELECT * FROM batch WHERE batch_id=" + rs.getInt("batch_id"));

            if (rsBatch.first())
            {
                Batch b = new Batch();

                b.setBatch_id(rsBatch.getInt("batch_id"));
                b.setBuying_price(rsBatch.getFloat("buying_price"));
                b.setSelling_price(rsBatch.getFloat("selling_price"));
                b.setStf_id(rsBatch.getInt("stf_id"));

                return b;
            }
            else
                return null;
        }
        else
            return null;
    }
}







