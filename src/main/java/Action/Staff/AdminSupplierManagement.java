package Action.Staff;

import Action.MultiTaskable;
import Common.Enum;
import Common.ObjFactory;
import Common.SupplierFactory;
import Common.Validations;
import Core.Database;
import Role.Staff;
import Role.Supplier;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;

public class AdminSupplierManagement extends HttpServlet implements MultiTaskable
{
    public static final String FORM_TYPE_ADD_SUPPLIER = "ft01";

    @Override
    public void renderPage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        req.getRequestDispatcher("/Staff/adManageSuppliers.jsp").forward(req, resp);
    }

    @Override
    public void setThisAsActivePage(HttpServletRequest req)
    {
        req.setAttribute(Enum.AD_PAGES.PAGE, Enum.AD_PAGES.ADMIN_MANAGE_SUPPLIER);
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
            case FORM_TYPE_ADD_SUPPLIER:
                addSupplier(req, resp);
        }

        renderPage(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        processRequest(req, resp);

        if (req.getSession().getAttribute("nic") != null)
            renderPage(req, resp);
        else
            req.getRequestDispatcher("/Staff/staffLogin.jsp").forward(req, resp);
    }

    private void addSupplier(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        Validations vl = new Validations();
        boolean valid = true;

        if (req.getParameter("name").isEmpty())
        {
            valid = false;
            req.setAttribute("errorMessageName", "Company must be set!");
        }

        if (req.getParameter("address").isEmpty())
        {
            valid = false;
            req.setAttribute("errorMessageAdd", "Address must be set!");
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

        if (req.getParameter("agent").isEmpty())
        {
            valid = false;
            req.setAttribute("errorMessageAgent", "Agent must be set!");
        }

        if (valid)
        {
            try
            {
                ObjFactory factory = new SupplierFactory();
                Supplier sup = factory.getSupplier();
                Date DateAndTime = new Date();
                Database db = new Database();
                HttpSession session = req.getSession();

                sup.setName(req.getParameter("name"));
                sup.setAddress(req.getParameter("address"));
                sup.setTel(req.getParameter("tel"));
                sup.setEmail(req.getParameter("email"));
                sup.setAgentName(req.getParameter("agent"));
                sup.setDateAndTime(DateAndTime);
                sup.setStaff((Staff)session.getAttribute("staff"));

                db.saveSupplier(sup);

                req.setAttribute("successful","Supplier successfully added");
            }
            catch (Exception e)
            {
                e.printStackTrace();
            }
        }
    }
}















