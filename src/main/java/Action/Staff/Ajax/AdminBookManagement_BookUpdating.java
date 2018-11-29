package Action.Staff.Ajax;

import Common.BookFactory;
import Common.ObjFactory;
import Core.Database;
import Core.SqlConnection;
import Role.Book;
import Role.Category;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.ResultSet;
import java.util.Objects;

@WebServlet(name = "AdminBookManagement_BookUpdating")
public class AdminBookManagement_BookUpdating extends HttpServlet
{
    public static final String REQUEST_TYPE = "rtype";
    public static final String R_TYPE_FILL = "rtypefill";
    public static final String R_TYPE_UPDATE = "rtypeupdate";
    public static final String MESSAGE = "message";

    private void renderPage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        req.getRequestDispatcher("/Staff/Ajax/updateBook.jsp").forward(req, resp);
    }

    private void fillForm(HttpServletRequest request)
    {
        request.setAttribute("id", request.getParameter("id"));
        setMessage(request, "");
    }

    private void setMessage(HttpServletRequest request, String message)
    {
        request.setAttribute(MESSAGE, message);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        String type = req.getParameter(REQUEST_TYPE);

        if (null != type)
        {
            switch (type)
            {
                case R_TYPE_FILL:
                    fillForm(req);
                    break;
                case R_TYPE_UPDATE:
                    updateBook(req, resp);
            }
        }

        renderPage(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        resp.getWriter().println("this is outdated book servlet");
    }

    private void updateBook(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        boolean valid = true;
        req.setAttribute("id", req.getParameter("id"));

        if (req.getParameter("name").isEmpty())
        {
            valid = false;
            req.setAttribute("e_name", "Book name must be set!");
        }

        if (req.getParameter("author").isEmpty())
        {
            valid = false;
            req.setAttribute("e_author", "Author name must be set!");
        }

        if (req.getParameter("category").isEmpty())
        {
            valid = false;
            req.setAttribute("e_category", "category must be set!");
        }

        if (valid)
        {
            try
            {
                Database db = new Database();
                ObjFactory factory = new BookFactory();
                Book bk = factory.getBook();
                Category cat;

                bk.setBookId(Integer.parseInt(req.getParameter("id")));
                bk.setBookName(req.getParameter("name"));
                bk.setAuthorName(req.getParameter("author"));
                bk.setDes(req.getParameter("description"));

                ResultSet rs = SqlConnection.getData("SELECT cat_id FROM category WHERE cat_name='" + req.getParameter("category") + "'");

                if (rs.first())
                {
                    cat = ((BookFactory) factory).getCategory(rs.getInt("cat_id"));

                    bk.setCat(cat);
                }

                Part fp = req.getPart("bookImage");
                imageSaver(req, fp);

                bk.setImg(req.getServletContext().getRealPath("bookImages") + "\\" + req.getParameter("BookName") + ".jpg");

                bk.setRating(Objects.requireNonNull(factory.getBook(Integer.parseInt(req.getParameter("id")))).getRating());

                db.updateBook(bk);

                setMessage(req, req.getParameter("name") + " is updated!");
            }
            catch (Exception e)
            {
                e.printStackTrace();
            }
        }
    }

    public static void imageSaver(HttpServletRequest req, Part fp)
    {
        new Thread(() -> {
            try
            {
                InputStream in = fp.getInputStream();
                fp.getName();

                File imageFile = new File(req.getServletContext().getRealPath("bookImages") + "\\" + req.getParameter("BookName") + ".jpg");

                if (imageFile.exists())
                    imageFile.delete();

                FileOutputStream out = new FileOutputStream(imageFile);

                int read;
                final byte[] bytes = new byte[1024];

                while ((read = in.read(bytes)) != -1)
                {
                    out.write(bytes, 0, read);
                }

            }
            catch (Exception e)
            {
                e.printStackTrace();
            }

        }).start();
    }
}
















