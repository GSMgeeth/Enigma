package Action.Staff;

import Action.MultiTaskable;
import Common.Enum;
import Core.SqlConnection;
import net.sf.jasperreports.engine.*;

import javax.servlet.*;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;

public class AdminDashBoard extends HttpServlet implements MultiTaskable
{
    @Override
    public void renderPage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        if (AdminBookManagement.checkBookAvailability())
            showNotification(req, "There\\'re books that has only one copy left!", NOTI_TYPE_WORNING);

        req.getRequestDispatcher("/Staff/adDashboard.jsp").forward(req, resp);
    }

    @Override
    public void setThisAsActivePage(HttpServletRequest req) throws ServletException, IOException
    {
        req.setAttribute(Enum.AD_PAGES.PAGE, Enum.AD_PAGES.ADMIN_DASHBOARD.toString());
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
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        processRequest(req, resp);
        renderPage(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        processRequest(req, resp);

        String r = req.getParameter("requesting");

        switch (r)
        {
            case "monthlyProfitReport":
                getMonthlyProfitReport(req, resp);
                break;
        }
    }

    private void getMonthlyProfitReport(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        resp.sendRedirect("/Staff/Reports/monthlyProfitReport.jsp");
    }
}



























