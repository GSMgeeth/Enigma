package Action.Staff;

import Action.MultiTaskable;
import Common.Enum;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "AdminCustomerManagement")
public class AdminCustomerManagement extends HttpServlet implements MultiTaskable
{
    @Override
    public void renderPage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        req.getRequestDispatcher("/Staff/adManageCustomers.jsp").forward(req, resp);
    }

    @Override
    public void setThisAsActivePage(HttpServletRequest req) throws ServletException, IOException
    {
        req.setAttribute(Enum.AD_PAGES.PAGE, Enum.AD_PAGES.ADMIN_MANAGE_CUSTOMER.toString());
    }

    @Override
    public void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        setThisAsActivePage(req);
        showNotification(req, "", NOTI_TYPE_INFO);
    }

    @Override
    public void showNotification(HttpServletRequest req, String message, String type) throws ServletException, IOException
    {
        req.setAttribute(NOTIFICATION_VALUE, message);
        req.setAttribute(NOTIFICATION_TYPE, type);
    }

    @Override
    public void setActivePanel(HttpServletRequest req, String panel) throws ServletException, IOException
    {
        req.setAttribute(ACTIVE_PANEL, panel);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        processRequest(req, resp);
        renderPage(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        processRequest(req, resp);
        renderPage(req, resp);
    }
}
