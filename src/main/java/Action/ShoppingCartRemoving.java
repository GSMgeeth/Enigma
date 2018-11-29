package Action;

import Common.BookFactory;
import Common.CustomerFactory;
import Common.ObjFactory;
import Core.Database;
import Role.Book;
import Role.Customer;
import Role.ShoppingCart;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class ShoppingCartRemoving extends HttpServlet
{
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        Database db = new Database();
        ObjFactory bFactory = new BookFactory();
        ObjFactory cFactory = new CustomerFactory();
        ShoppingCart item = new ShoppingCart();
        HttpSession session = req.getSession();

        int book_id = Integer.parseInt(req.getParameter("bookId"));

        try
        {
            Book book = bFactory.getBook(book_id);
            Customer cus = cFactory.getCustomer(session.getAttribute("username").toString());

            item.setBook(book);
            item.setCustomer(cus);

            db.removeShoppingCart(item);

            req.setAttribute("successful", "Removed from cart");
            req.getRequestDispatcher("/viewShoppingCart.jsp").forward(req, resp);
        }
        catch (Exception e)
        {
            //req.setAttribute("error", "Exception occurred!");
            //req.getRequestDispatcher("/viewShoppingCart.jsp").forward(req, resp);
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {

    }
}
