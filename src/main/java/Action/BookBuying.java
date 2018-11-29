package Action;

import Common.BookFactory;
import Common.CustomerFactory;
import Common.ObjFactory;
import Core.Database;
import Core.SqlConnection;
import Role.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;

public class BookBuying extends HttpServlet
{
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        HttpSession session = req.getSession();
        Customer cus;
        ObjFactory bFactory = new BookFactory();
        ObjFactory cFactory = new CustomerFactory();

        int cus_id = Integer.parseInt(session.getAttribute("cusId").toString());

        try
        {
            cus = cFactory.getCustomer(session.getAttribute("username").toString());

            if (req.getParameter("from").equals("cart"))
            {
                ArrayList<Integer> qtyList = new ArrayList<>();

                ResultSet rsQty = SqlConnection.getData("select * from shopping_cart where cus_id=" + cus_id);

                int i = 0;

                while (rsQty.next())
                {
                    qtyList.add(Integer.parseInt(req.getParameter("qty" + i)));
                    i++;
                }

                Iterator<Integer> itr = qtyList.iterator();
                ResultSet rs = SqlConnection.getData("select * from shopping_cart where cus_id=" + cus_id);

                String status = "enough";
                int book_id = 0;

                while (rs.next() && itr.hasNext())
                {
                    ResultSet rsCount = SqlConnection.getData("SELECT * FROM book_count WHERE book_id=" + rs.getInt("book_id"));

                    if (rsCount.first())
                    {
                        if (rsCount.getInt("count") < itr.next())
                        {
                            status = "not enough";
                            book_id = rsCount.getInt("book_id");
                        }
                    }
                }

                if (status.equals("enough"))
                {
                    session.setAttribute("qtyList", qtyList);
                    req.getRequestDispatcher("/buyBook.jsp").forward(req,resp);
                }
                else
                {
                    req.setAttribute("error", "Book ID " + book_id + " is not enough! We are sorry!");
                    req.getRequestDispatcher("/viewShoppingCart.jsp").forward(req, resp);
                }
            }
            else if (req.getParameter("from").equals("info"))
            {
                Invoice inv = new Invoice();
                InvoiceCopy invCopy = new InvoiceCopy();
                BookCopy isbn = new BookCopy();
                ShoppingCart item = new ShoppingCart();
                Date dateAndTime = new Date();
                Database db = new Database();

                String cardNo = req.getParameter("cardNo");
                String cvc = req.getParameter("cvcNo");

                ArrayList<Integer> qtyList = (ArrayList<Integer>) session.getAttribute("qtyList");

                // check card details validity and make the payment here

                inv.setCus_id(cus_id);
                inv.setDiscount(0.0f);
                inv.setDateAndTime(dateAndTime);

                db.saveInvoice(inv);

                String date = new SimpleDateFormat("yyyy/MM/dd").format(dateAndTime);
                String time = new SimpleDateFormat("hh:mm:ss").format(dateAndTime);

                ResultSet rsInvId = SqlConnection.getData("SELECT inv_id FROM invoice WHERE cus_id=" + cus_id + " AND date='" + date + "' AND time='" + time + "'");

                if (rsInvId.next())
                {
                    invCopy.setInv_id(rsInvId.getInt("inv_id"));
                }

                Iterator<Integer> itr = qtyList.iterator();
                ResultSet rs = SqlConnection.getData("select * from shopping_cart where cus_id=" + cus_id);

                item.setCustomer(cus);

                while (rs.next() && itr.hasNext())
                {
                    ResultSet rsISBN = SqlConnection.getData("SELECT * FROM book_copy WHERE book_id=" + rs.getInt("book_id") + " AND availability=1");

                    int i = 0;
                    int j = itr.next();

                    while (rsISBN.next() && (i < j))
                    {
                        isbn.setISBN(rsISBN.getString("ISBN"));
                        isbn.setBookId(rsISBN.getInt("book_id"));
                        isbn.setGrnId(rsISBN.getInt("grn_id"));
                        isbn.setAvailability(false);

                        invCopy.setISBN(isbn);

                        db.saveInvoiceCopy(invCopy);
                        db.updateBookCopy(isbn);

                        i++;
                    }
/*
                    Book bk = factory.getBook(rs.getInt("book_id"));
                    assert bk != null;
                    bk.setRating(bk.getRating() + 1);
*/
                    item.setBook(bFactory.getBook(rs.getInt("book_id")));

                    db.removeShoppingCart(item);
                    //db.updateBook(bk);
                }

                req.setAttribute("successful", "Your books are on the way!");
                req.getRequestDispatcher("/viewShoppingCart.jsp").forward(req, resp);
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {

    }
}
