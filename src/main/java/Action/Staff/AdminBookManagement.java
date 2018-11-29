package Action.Staff;

import Action.MultiTaskable;
import Action.Staff.Ajax.AdminBookManagement_BookUpdating;
import Common.BookFactory;
import Common.Enum;
import Common.ObjFactory;
import Core.Database;
import Core.SqlConnection;
import Role.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.ResultSet;

@WebServlet(name = "AdminBookManagement")
@MultipartConfig
public class AdminBookManagement extends HttpServlet implements MultiTaskable
{
    public static final String FORM_TYPE_ADD_CATEGORY = "ft01";
    public static final String FORM_TYPE_ADD_BOOK = "ft02";
    public static final String FORM_TYPE_UPDATE_BOOKS = "ft03";
    public static final String FORM_TYPE_ADD_BATCH = "ft04";
    public static final String FORM_TYPE_ADD_ISBN = "ft05";

    public static final String PNL_SEARCH_BOOKS = "pnl01";
    public static final String PNL_ADD_NEW_BOOK = "pnl02";
    public static final String PNL_VIEW_CATEGORIES = "pnl03";
    public static final String PNL_ADD_NEW_CATEGORY = "pnl04";
    public static final String PNL_VIEW_BATCHES = "pnl05";
    public static final String PNL_ADD_NEW_BATCH = "pnl06";
    public static final String PNL_ISBN_ADDING = "pnl07";

    @Override
    public void renderPage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        req.getRequestDispatcher("/Staff/adManageBooks.jsp").forward(req, resp);
    }

    @Override
    public void setThisAsActivePage(HttpServletRequest req) throws ServletException, IOException
    {
        req.setAttribute(Enum.AD_PAGES.PAGE, Enum.AD_PAGES.ADMIN_MANAGE_BOOK.toString());
    }

    @Override
    public void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        setActivePanel(req, PNL_SEARCH_BOOKS);
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

        String from = req.getParameter(FORM_TYPE);

        if (from != null)
        {
            switch (from)
            {
                case FORM_TYPE_ADD_BATCH:
                    addBatch(req, resp);
                    break;
                case FORM_TYPE_ADD_CATEGORY:
                    addCategory(req, resp);
                    break;
                case FORM_TYPE_ADD_BOOK:
                    addBook(req);
                    break;
                case FORM_TYPE_ADD_ISBN:
                    addISBN(req, resp);
            }
        } else
        {
            showNotification(req, "Something went wrong!", NOTI_TYPE_ERROR);
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

    private void addBatch(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        boolean valid = true;

        if (req.getParameter("buying_price").isEmpty())
        {
            valid = false;
            req.setAttribute("errorbprice", "Buying price must be set!");
        }

        if (req.getParameter("selling_price").isEmpty())
        {
            valid = false;
            req.setAttribute("errorsprice", "Selling price must be set!");
        }

        if (valid)
        {
            try
            {
                Database db = new Database();
                Batch batch = new Batch();
                HttpSession session = req.getSession();

                batch.setBuying_price(Float.parseFloat(req.getParameter("buying_price")));
                batch.setSelling_price(Float.parseFloat(req.getParameter("selling_price")));
                batch.setStf_id(Integer.parseInt(session.getAttribute("stfId").toString()));

                db.saveBatch(batch);

                showNotification(req, "Batch successfully added!", NOTI_TYPE_SUCCESS);
                setActivePanel(req, PNL_VIEW_BATCHES);
            } catch (NumberFormatException nfe)
            {
                req.setAttribute("errorbprice", "Buying price must be a floating point number!");
                req.setAttribute("errorsprice", "Selling price must be a floating point number!");
                setActivePanel(req, PNL_ADD_NEW_BATCH);
            } catch (Exception e)
            {
                showNotification(req, "Something went wrong!", NOTI_TYPE_ERROR);
                setActivePanel(req, PNL_ADD_NEW_BATCH);
            }
        }
    }

    private void addCategory(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        if (!req.getParameter("catName").isEmpty())
        {
            try
            {
                Database db = new Database();
                Category cat = new Category();

                ResultSet rs = SqlConnection.getData("SELECT cat_id FROM category WHERE cat_name='" + req.getParameter("catName") + "'");

                if (rs.first())
                {
                    showNotification(req, "category is already there!", NOTI_TYPE_WORNING);
                    setActivePanel(req, PNL_ADD_NEW_CATEGORY);
                } else
                {
                    cat.setCatName(req.getParameter("catName"));

                    db.saveCategory(cat);

                    showNotification(req, req.getParameter("catName") + " successfully added!", NOTI_TYPE_SUCCESS);
                    setActivePanel(req, PNL_VIEW_CATEGORIES);
                }
            } catch (Exception e)
            {
                showNotification(req, "Something went wrong!", NOTI_TYPE_ERROR);
                setActivePanel(req, PNL_ADD_NEW_CATEGORY);
            }
        } else
        {
            showNotification(req, "category must be set!", NOTI_TYPE_ERROR);
            setActivePanel(req, PNL_ADD_NEW_CATEGORY);
        }
    }

    private void addBook(HttpServletRequest req) throws ServletException, IOException
    {
        boolean valid = true;

        if (req.getParameter("BookName").isEmpty())
        {
            valid = false;
            req.setAttribute("error_book_name", "Book name must be set!");
        }

        if (req.getParameter("AuthorName").isEmpty())
        {
            valid = false;
            req.setAttribute("error_book_author", "Author name must be set!");
        }

        if (req.getParameter("category").isEmpty())
        {
            valid = false;
            req.setAttribute("error_book_c", "category must be set!");
        }

        if (valid)
        {
            try
            {
                Database db = new Database();
                ObjFactory factory = new BookFactory();
                Book bk = factory.getBook();
                Category cat;

                bk.setBookName(req.getParameter("BookName"));
                bk.setAuthorName(req.getParameter("AuthorName"));
                bk.setDes(req.getParameter("Description"));

                ResultSet rs = SqlConnection.getData("SELECT cat_id FROM category WHERE cat_name='" + req.getParameter("category") + "'");

                if (rs.next())
                {
                    cat = ((BookFactory) factory).getCategory(rs.getInt("cat_id"));

                    bk.setCat(cat);

                    Part fp = req.getPart("aFile");
                    AdminBookManagement_BookUpdating.imageSaver(req, fp);

                    bk.setImg(req.getServletContext().getRealPath("bookImages") + "\\" + req.getParameter("BookName") + ".jpg");

                    db.saveBook(bk);

                    showNotification(req, req.getParameter("BookName") + " successfully added!", NOTI_TYPE_SUCCESS);
                } else
                {
                    req.setAttribute("error_book_c", "Category doesn't exist!");
                }
            } catch (Exception e)
            {
                e.printStackTrace();
            }
        }
    }

    private void addISBN(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        if (!req.getParameter("isbn").isEmpty())
        {
            try
            {
                Database db = new Database();
                BookCopy bkCopy = new BookCopy();
                GrnCopy grnCopy = new GrnCopy();

                int grnCopyId = Integer.parseInt(req.getParameter("grnCopyId"));
                int toAdd = Integer.parseInt(req.getParameter("toAdd")) - 1;

                bkCopy.setBookId(Integer.parseInt(req.getParameter("bookId")));
                bkCopy.setGrnId(Integer.parseInt(req.getParameter("grnId")));
                bkCopy.setISBN(req.getParameter("isbn"));

                db.saveBookCopy(bkCopy);

                grnCopy.setTo_add(toAdd);
                grnCopy.setGrn_copy_id(grnCopyId);

                db.updateGrnCopy(grnCopy);

                showNotification(req, req.getParameter("isbn") + " successfully added!", NOTI_TYPE_SUCCESS);
                setActivePanel(req, PNL_ISBN_ADDING);
            }
            catch (Exception e)
            {
                showNotification(req, "Something went wrong!", NOTI_TYPE_ERROR);
                setActivePanel(req, PNL_ISBN_ADDING);
            }
        } else
        {
            req.setAttribute("errorMessageIsbn", " ISBN must be set!");
            setActivePanel(req, PNL_ISBN_ADDING);
        }
    }

    static boolean checkBookAvailability() throws ServletException, IOException
    {
        boolean available = true;
        int i = 0;

        try
        {
            ResultSet rs = SqlConnection.getData("SELECT b.book_name AS book_name FROM book b INNER JOIN book_count c ON b.book_id=c.book_id WHERE c.count=1;");

            while (rs.next())
            {
                i++;
            }

            if (i > 0)
                available = false;
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

        return !available;
    }
}
























