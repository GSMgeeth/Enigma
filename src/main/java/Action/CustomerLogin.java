package Action;

import Common.CustomerFactory;
import Common.ObjFactory;
import Core.Database;
import Common.Password;
import Core.SqlConnection;
import Role.Customer;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.ResultSet;

@WebServlet(name = "CustomerLogin")
public class CustomerLogin extends HttpServlet
{
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        Customer cus;
        ObjFactory factory = new CustomerFactory();

        try
        {
            if (customerLogin(req.getParameter("uname"), req.getParameter("pw")))
            {
                cus = factory.getCustomer(req.getParameter("uname"));
                HttpSession session = req.getSession();

                assert cus != null;
                req.setAttribute("username", cus.getName());

                session.setAttribute("username", cus.getUname());
                session.setAttribute("cusId", cus.getId());
                session.setAttribute("name", cus.getName());
                session.setAttribute("customer", cus);

                if (req.getParameter("from") == null)
                    req.getRequestDispatcher("/index.jsp").forward(req,resp);
                else
                    req.getRequestDispatcher(req.getParameter("from")).forward(req, resp);
            }
            else
            {
                req.setAttribute("errorMessage", "Invalid login and password");
                req.getRequestDispatcher("/login.jsp").forward(req, resp);
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

    private boolean customerLogin(String uname, String pword)
    {
        boolean valid = false;
        Password pw = new Password();

        try
        {
            ResultSet rs = SqlConnection.getData("SELECT * FROM customer WHERE uname='" + uname + "'");

            if (rs.next() && rs.getBoolean("status"))
            {
                if (pw.authenticate(pword.toCharArray(), rs.getString("pw")))
                {
                    valid = true;
                }
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        finally
        {
            return valid;
        }
    }
}
