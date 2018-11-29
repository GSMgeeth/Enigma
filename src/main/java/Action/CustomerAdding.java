package Action;

import Common.*;
import Core.Database;
import Role.Customer;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.*;

@WebServlet(name = "CustomerAdding")
public class CustomerAdding extends HttpServlet
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
                        if (!req.getParameter("uname").isEmpty())
                        {
                            if (!req.getParameter("pw").isEmpty())
                            {
                                Customer cus = new Customer();
                                Date DateAndTime = new Date();
                                Database db = new Database();
                                ObjFactory factory = new CustomerFactory();
                                Password pw = new Password();

                                try
                                {
                                    cus.setName(req.getParameter("name"));
                                    cus.setAddress(req.getParameter("address"));
                                    cus.setTel(req.getParameter("tel"));
                                    cus.setEmail(req.getParameter("email"));
                                    cus.setUname(req.getParameter("uname"));
                                    cus.setPword(pw.hash(req.getParameter("pw").toCharArray()));
                                    cus.setDateAndTime(DateAndTime);

                                    db.saveCustomer(cus);

                                    cus = factory.getCustomer(req.getParameter("uname"));
                                }
                                catch (Exception e)
                                {
                                    e.printStackTrace();
                                }

                                HttpSession session = req.getSession();

                                session.setAttribute("username", cus.getUname());
                                session.setAttribute("cusId", cus.getId());
                                session.setAttribute("email", cus.getEmail());
                                session.setAttribute("name", cus.getName());
                                session.setAttribute("customer", cus);

                                try
                                {
                                    Email.sendFromGMail(cus.getEmail(), "Welcome to Enigma", "An account was made on this email at Enigma!");
                                }
                                catch (AddressException ae)
                                {
                                    ae.printStackTrace();
                                }
                                catch (MessagingException me)
                                {
                                    me.printStackTrace();
                                }
                                catch (Exception e)
                                {
                                    e.printStackTrace();
                                }
                                finally
                                {
                                    req.setAttribute("username", req.getParameter("uname"));
                                    req.getRequestDispatcher("/index.jsp").forward(req,resp);
                                }
                            }
                            else
                            {
                                req.setAttribute("errorMessagePw", "Password must be set!");
                                req.getRequestDispatcher("/signup.jsp").forward(req, resp);
                            }
                        }
                        else
                        {
                            req.setAttribute("errorMessageUname", "User name must be set!");
                            req.getRequestDispatcher("/signup.jsp").forward(req, resp);
                        }
                    }
                    else
                    {
                        req.setAttribute("errorMessageEmail", "Provide a valid email!");
                        req.getRequestDispatcher("/signup.jsp").forward(req, resp);
                    }
                }
                else
                {
                    req.setAttribute("errorMessageTel", "Provide a valid telephone number!");
                    req.getRequestDispatcher("/signup.jsp").forward(req, resp);
                }
            }
            else
            {
                req.setAttribute("errorMessageAdd", "Address must be set!");
                req.getRequestDispatcher("/signup.jsp").forward(req, resp);
            }
        }
        else
        {
            req.setAttribute("errorMessageName", "Name must be set!");
            req.getRequestDispatcher("/signup.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {

    }
}
