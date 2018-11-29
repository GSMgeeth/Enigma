package Action;

import Common.BookFactory;
import Common.CustomerFactory;
import Common.ObjFactory;
import Core.Database;
import Core.SqlConnection;
import Role.Book;
import Role.Customer;
import Role.ShoppingCart;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.ResultSet;
import java.util.Date;

public class ShoppingCartAdding extends HttpServlet
{
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        HttpSession session = req.getSession();

        if (session.getAttribute("cusId") == null)
        {
            req.setAttribute("from", "/shop.jsp");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        }
        else
        {
            Database db = new Database();
            ObjFactory bFactory = new BookFactory();
            ObjFactory cFactory = new CustomerFactory();
            ShoppingCart cart = new ShoppingCart();
            Date dateAndTime = new Date();

            int book_id = Integer.parseInt(req.getParameter("bookId"));

            try
            {
                ResultSet rsCheck = SqlConnection.getData("SELECT * FROM shopping_cart WHERE book_id=" + book_id + " AND cus_id=" + session.getAttribute("cusId"));

                if (!rsCheck.first())
                {
                    ResultSet rs = SqlConnection.getData("select * from book left outer join category on book.cat_id=category.cat_id where book.book_id=" + book_id);

                    if (rs.first())
                    {
                        Book book = bFactory.getBook(rs.getInt("book_id"));
                        Customer cus = cFactory.getCustomer(session.getAttribute("username").toString());

                        cart.setBook(book);
                        cart.setCustomer(cus);
                        cart.setDateAndTime(dateAndTime);
                    }

                    db.saveShoppingCart(cart);
                }
            }
            catch (Exception e)
            {
                e.printStackTrace();
            }
            finally
            {
                req.getRequestDispatcher("/shop.jsp").forward(req, resp);
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {

    }
}
