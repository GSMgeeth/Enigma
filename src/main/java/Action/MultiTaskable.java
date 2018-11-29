package Action;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public interface MultiTaskable
{
    public static final String NOTIFICATION_VALUE = "notifi";
    public static final String NOTIFICATION_TYPE = "notitype";


    public static final String NOTI_TYPE_WORNING = "warning";
    public static final String NOTI_TYPE_INFO = "info";
    public static final String NOTI_TYPE_SUCCESS = "success";
    public static final String NOTI_TYPE_ERROR = "error";

    public static final String ACTIVE_PANEL = "activep";

    public static final String FORM_TYPE = "ftype";

    void renderPage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException;
    void setThisAsActivePage(HttpServletRequest req) throws ServletException, IOException;
    void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException;
    void showNotification(HttpServletRequest req, String message, String type) throws ServletException, IOException;
    void setActivePanel(HttpServletRequest req, String panel) throws ServletException, IOException;
}
