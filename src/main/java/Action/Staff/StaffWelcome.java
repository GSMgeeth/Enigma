package Action.Staff;

import Action.MultiTaskable;
import Common.Enum;
import Common.ObjFactory;
import Common.Password;
import Common.StaffFactory;
import Core.SqlConnection;
import Role.Staff;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.ResultSet;

public class StaffWelcome extends HttpServlet implements MultiTaskable
{
    @Override
    public void renderPage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        //req.getRequestDispatcher("/Staff/adDashboard.jsp").forward(req, resp);
        resp.sendRedirect("/AdminDashBoard");
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
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        processRequest(req, resp);

        if ((req.getParameter("from") != null) && (req.getParameter("from").equals("logout")))
        {
            logout(req);
            resp.sendRedirect("/index.jsp");
        }
        else
        {
            boolean valid = login(req);

            if ((valid) && (req.getParameter("from") != null))
                req.getRequestDispatcher(req.getParameter("from")).forward(req, resp);
            else if (valid)
                renderPage(req, resp);
            else
                req.getRequestDispatcher("/Staff/staffLogin.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        processRequest(req, resp);

        if ((req.getParameter("from") != null) && (req.getParameter("from").equals("logout")))
        {
            logout(req);
            resp.sendRedirect("/index.jsp");
        }
        else if (req.getSession().getAttribute("nic") != null)
            renderPage(req, resp);
        else
            req.getRequestDispatcher("/Staff/staffLogin.jsp").forward(req, resp);
    }

    private boolean login(HttpServletRequest req) throws ServletException, IOException
    {
        ObjFactory factory = new StaffFactory();
        Staff stf = null;

        try
        {
            stf = factory.getStaff();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

        if (staffLogin(req.getParameter("uname"), req.getParameter("pw"), stf))
        {
            req.setAttribute("username", stf.getName());

            HttpSession session = req.getSession();

            session.setAttribute("username", stf.getUname());
            session.setAttribute("stfId", stf.getId());
            session.setAttribute("name", stf.getName());
            session.setAttribute("nic", stf.getNic());
            session.setAttribute("staff", stf);

            return true;
        }
        else
        {
            req.setAttribute("errorMessage", "Invalid login and password");

            return false;
        }
    }

    private boolean staffLogin(String uname, String pword, Staff stf)
    {
        boolean valid = false;
        Password pw = new Password();

        try
        {
            ResultSet rs = SqlConnection.getData("SELECT * FROM staff WHERE uname='" + uname + "'");

            if (rs.next() && rs.getBoolean("status"))
            {
                if (pw.authenticate(pword.toCharArray(), rs.getString("pw")))
                {
                    valid = true;
                    stf.setUname(uname);

                    ResultSet rsStf = SqlConnection.getData("SELECT * FROM staff WHERE uname='" + uname + "'");

                    if (rsStf.next())
                    {
                        stf.setId(rsStf.getInt("stf_id"));
                        stf.setName(rsStf.getString("name"));
                        stf.setTel(rsStf.getString("tel"));
                        stf.setEmail(rsStf.getString("email"));
                        stf.setNic(rsStf.getString("nic"));
                        stf.setType(rsStf.getString("type"));
                    }
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

    private void logout(HttpServletRequest req) throws ServletException, IOException
    {
        HttpSession session = req.getSession();
        session.invalidate();
    }
}
