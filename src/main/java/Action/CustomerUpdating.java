package Action;

import Common.CustomerFactory;
import Common.ObjFactory;
import Core.Database;
import Common.Validations;
import Role.Customer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "CustomerUpdating")
public class CustomerUpdating extends HttpServlet
{
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        Validations vl = new Validations();

        if (!req.getParameter("name").isEmpty())
        {
            if (!req.getParameter("address").isEmpty())
            {
                if (!req.getParameter("tel").isEmpty())
                {
                    if ((!req.getParameter("email").isEmpty()) && (vl.validateEmailAddress(req.getParameter("email"))))
                    {
                        Customer cus = new Customer();
                        Database db = new Database();
                        ObjFactory factory = new CustomerFactory();
                        HttpSession session = req.getSession();

                        try
                        {
                            cus.setName(req.getParameter("name"));
                            cus.setAddress(req.getParameter("address"));
                            cus.setTel(req.getParameter("tel"));
                            cus.setEmail(req.getParameter("email"));
                            cus.setUname(session.getAttribute("username").toString());

                            db.updateCustomer(cus);
                            cus = factory.getCustomer(session.getAttribute("username").toString());
                        }
                        catch (Exception e)
                        {
                            e.printStackTrace();
                        }

                        assert cus != null;
                        session.setAttribute("name", cus.getName());
                        session.removeAttribute("customer");
                        session.setAttribute("customer", cus);
                        req.setAttribute("username", session.getAttribute("uname"));


                        req.setAttribute("successful", session.getAttribute("name") + " successfully updated!");
                        req.getRequestDispatcher("/updateCustomer.jsp").forward(req,resp);
                    }
                    else
                    {
                        req.setAttribute("errorMessageEmail", "Provide a valid email!");
                        req.getRequestDispatcher("/updateCustomer.jsp").forward(req, resp);
                    }
                }
                else
                {
                    req.setAttribute("errorMessageTel", "Provide a valid telephone number!");
                    req.getRequestDispatcher("/updateCustomer.jsp").forward(req, resp);
                }
            }
            else
            {
                req.setAttribute("errorMessageAdd", "Address must be set!");
                req.getRequestDispatcher("/updateCustomer.jsp").forward(req, resp);
            }
        }
        else
        {
            req.setAttribute("errorMessageName", "Name must be set!");
            req.getRequestDispatcher("/updateCustomer.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {

    }
}
