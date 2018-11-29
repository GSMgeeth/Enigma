package Action.Staff;

import Action.MultiTaskable;
import Common.Enum;
import Common.ObjFactory;
import Common.StaffFactory;
import Core.Database;
import Common.Password;
import Common.Validations;
import Role.Staff;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;

public class AdminStaffManagement extends HttpServlet implements MultiTaskable
{
    public static final String FORM_TYPE_ADD_STAFF = "ft01";

    @Override
    public void renderPage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        req.getRequestDispatcher("/Staff/adManageStaff.jsp").forward(req, resp);
    }

    @Override
    public void setThisAsActivePage(HttpServletRequest req)
    {
        req.setAttribute(Common.Enum.AD_PAGES.PAGE, Enum.AD_PAGES.ADMIN_MANAGE_STAFF);
    }

    @Override
    public void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        setThisAsActivePage(req);
        showNotification(req, "", NOTI_TYPE_INFO);
    }

    @Override
    public void showNotification(HttpServletRequest req, String message, String type)
    {
        req.setAttribute(NOTIFICATION_VALUE, message);
        req.setAttribute(NOTIFICATION_TYPE, type);
    }

    @Override
    public void setActivePanel(HttpServletRequest req, String panel)
    {
        req.setAttribute(ACTIVE_PANEL, panel);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        processRequest(req, resp);

        String from = req.getParameter(FORM_TYPE);

        switch (from)
        {
            case FORM_TYPE_ADD_STAFF:
                addStaff(req, resp);
        }

        renderPage(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        processRequest(req, resp);
        renderPage(req, resp);
    }

    private void addStaff(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        Validations vl = new Validations();
        boolean valid = true;

        if (req.getParameter("name").isEmpty())
        {
            valid = false;
            req.setAttribute("errorMessageName", "Name must be set!");
        }

        if (req.getParameter("tel").isEmpty())
        {
            valid = false;
            req.setAttribute("errorMessageTel", "Provide a valid telephone number!");
        }

        if ((req.getParameter("email").isEmpty()) && !(vl.validateEmailAddress(req.getParameter("email"))))
        {
            valid = false;
            req.setAttribute("errorMessageEmail", "Provide a valid email!");
        }

        if (req.getParameter("nic").isEmpty())
        {
            valid = false;
            req.setAttribute("errorMessageNic", "NIC must be set!");
        }

        if (req.getParameter("uname").isEmpty())
        {
            valid = false;
            req.setAttribute("errorMessageUname", "User name must be set!");
        }

        if (req.getParameter("pw").isEmpty())
        {
            valid = false;
            req.setAttribute("errorMessagePW", "Password must be set!");
        }

        if (req.getParameter("type").isEmpty())
        {
            valid = false;
            req.setAttribute("errorMessageType", "Type must be set!");
        }

        if (valid)
        {
            Staff stf = new Staff();
            Date DateAndTime = new Date();
            Database db = new Database();
            Password pw = new Password();

            try
            {
                stf.setName(req.getParameter("name"));
                stf.setTel(req.getParameter("tel"));
                stf.setEmail(req.getParameter("email"));
                stf.setNic(req.getParameter("nic"));
                stf.setUname(req.getParameter("uname"));
                stf.setPword(pw.hash(req.getParameter("pw").toCharArray()));
                stf.setType(req.getParameter("type"));
                stf.setDateAndTime(DateAndTime);

                db.saveStaff(stf);

                showNotification(req, stf.getName()+ " successfully added", NOTI_TYPE_SUCCESS);
            }
            catch (Exception e)
            {
                e.printStackTrace();
            }
        }
    }
}

















