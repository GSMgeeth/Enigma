package Action;

import Core.Database;
import Common.Email;
import Common.Password;
import Core.SqlConnection;

import javax.mail.internet.AddressException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.mail.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.ResultSet;
import java.util.Random;

@WebServlet(name = "CustomerUpdating")
public class PasswordRecovery extends HttpServlet
{
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        if (req.getParameter("recoveryCode") != null)
        {
            Password rescueCode = new Password();

            String code = req.getParameter("recoveryCode");
            String email = req.getParameter("email");

            try
            {
                ResultSet rs = SqlConnection.getData("SELECT * FROM customer WHERE email='" + email + "'");

                if (rs.next() && rs.getBoolean("status"))
                {
                    if (rescueCode.authenticate(code.toCharArray(), rs.getString("pw_rescue_code")))
                    {
                        HttpSession session = req.getSession();

                        session.setAttribute("usernameTmp", rs.getString("uname"));
                        session.setAttribute("rescue", "rescued");
                        req.getRequestDispatcher("/updateCustomerPassword.jsp").forward(req,resp);
                    }
                    else
                    {
                        req.setAttribute("status", "sent");
                        req.setAttribute("mail", req.getParameter("email"));
                        req.setAttribute("error", "Code isn't correct!");
                        req.getRequestDispatcher("/passwordRecovery.jsp").forward(req,resp);
                    }
                }
                else
                {
                    req.setAttribute("error", "This account may be Deactivated or Deleted!");
                    req.getRequestDispatcher("/passwordRecovery.jsp").forward(req,resp);
                }
            }
            catch (Exception e)
            {
                e.printStackTrace();
            }
        }
        else
        {
            try
            {
                ResultSet rs = SqlConnection.getData("SELECT * FROM customer WHERE email='" + req.getParameter("email") + "'");

                if (rs.first())
                {
                    String to = req.getParameter("email"); // recipient email address

                    Random rand = new Random();

                    String code = "";

                    for (int i = 0; i < 5; i++)
                        code = code + "" + rand.nextInt(10);

                    String rescueCode = code;
                    Password pwRescueCode = new Password();
                    Database db = new Database();

                    String subject = "password recovery code";
                    String body = "Your recovery code  :  " + rescueCode + "\nPlease submit the code now!";

                    db.savePasswordRescueCode(pwRescueCode.hash(rescueCode.toCharArray()), to);

                    Email.sendFromGMail(to, subject, body);

                    req.setAttribute("status", "sent");
                    req.setAttribute("mail", req.getParameter("email"));
                    req.setAttribute("successful", "Email sent successfully to " + req.getParameter("email"));
                    req.getRequestDispatcher("/passwordRecovery.jsp").forward(req,resp);
                }
                else
                {
                    req.setAttribute("error", "Email address is not registered!");
                    req.getRequestDispatcher("/passwordRecovery.jsp").forward(req,resp);
                }
            }
            catch (AddressException ae)
            {
                req.setAttribute("error", "Email sent error to " + req.getParameter("email"));
                req.getRequestDispatcher("/passwordRecovery.jsp").forward(req,resp);

                ae.printStackTrace();
            }
            catch (MessagingException me)
            {
                req.setAttribute("error", "Email sent error to " + req.getParameter("email"));
                req.getRequestDispatcher("/passwordRecovery.jsp").forward(req,resp);

                me.printStackTrace();
            }
            catch (Exception e)
            {
                e.printStackTrace();
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {

    }
}
