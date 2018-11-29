package Action;

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

@WebServlet(name = "CustomerPasswordUpdating")
public class CustomerPasswordUpdating extends HttpServlet
{
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        try
        {
            if (req.getParameter("from").equals("rescue"))
            {
                Password pw = new Password();
                Customer cus = new Customer();
                HttpSession session = req.getSession();
                Database db = new Database();

                String hashedPword = pw.hash(req.getParameter("pword").toCharArray());

                cus.setPword(hashedPword);
                cus.setUname(session.getAttribute("usernameTmp").toString());

                db.updateCustomerPassword(cus);

                session.invalidate();
                req.removeAttribute("from");
                req.getRequestDispatcher("/login.jsp").forward(req,resp);
            }
            else if (req.getParameter("from").equals("update"))
            {
                Password pw = new Password();
                Customer cus = new Customer();
                HttpSession session = req.getSession();
                Database db = new Database();

                ResultSet rs = SqlConnection.getData("SELECT * FROM customer WHERE uname='" + session.getAttribute("username") + "'");

                if (rs.first())
                {
                    if (pw.authenticate(req.getParameter("oldPword").toCharArray(), rs.getString("pw")))
                    {
                        String hashedPword = pw.hash(req.getParameter("newPword").toCharArray());

                        cus.setPword(hashedPword);
                        cus.setUname(session.getAttribute("username").toString());

                        db.updateCustomerPassword(cus);

                        session.removeAttribute("username");
                        req.getRequestDispatcher("/login.jsp").forward(req,resp);
                    }
                    else
                    {
                        req.setAttribute("errorMessagePW", "Current Password is wrong!");
                        req.getRequestDispatcher("/updateCustomerPassword.jsp").forward(req,resp);
                    }
                }
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
