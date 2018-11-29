package Action.Staff;

import Action.MultiTaskable;
import Common.BookFactory;
import Common.Enum;
import Common.ObjFactory;
import Core.Database;
import Core.SqlConnection;
import Role.*;

import javax.naming.spi.ObjectFactory;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;

public class AdminTransactionManagement extends HttpServlet implements MultiTaskable
{
    public static final String FORM_TYPE_ADD_ORDER = "ft05";
    public static final String FORM_TYPE_ADD_GRN = "ft06";

    public static final String PNL_ORDER_ADDING = "pnl07";
    public static final String PNL_GRN_ADDING = "pnl08";

    @Override
    public void renderPage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        req.getRequestDispatcher("/Staff/adManageTransaction.jsp").forward(req, resp);
    }

    @Override
    public void setThisAsActivePage(HttpServletRequest req)
    {
        req.setAttribute(Enum.AD_PAGES.PAGE, Enum.AD_PAGES.ADMIN_MANAGE_TRANSACTION.toString());
    }

    @Override
    public void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        setActivePanel(req, PNL_ORDER_ADDING);
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

        if (from != null)
        {
            switch (from)
            {
                case FORM_TYPE_ADD_GRN:
                    addGrn(req, resp);
                    break;
                case FORM_TYPE_ADD_ORDER:
                    addOrder(req, resp);
                    break;
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
        renderPage(req, resp);
    }

    private void addGrn(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        try
        {
            Database db = new Database();
            HttpSession session = req.getSession();
            Grn grn = new Grn();
            Date dateAndTime = new Date();
            GrnCopy grnCopy = new GrnCopy();

            String supp = req.getParameter("supp");
            String veh_no = req.getParameter("veh");
            Double discount = Double.parseDouble(req.getParameter("discount"));
            int stf_id = Integer.parseInt(session.getAttribute("stfId").toString());

            grn.setDiscount(discount);
            grn.setVeh_no(veh_no);
            grn.setStf_id(stf_id);
            grn.setDateAndTime(dateAndTime);

            ResultSet rsSupp = SqlConnection.getData("SELECT sup_id FROM supplier WHERE company='" + supp + "'");

            if (rsSupp.next())
            {
                grn.setSup_id(rsSupp.getInt("sup_id"));
            }

            String date = new SimpleDateFormat("yyyy/MM/dd").format(dateAndTime);
            String time = new SimpleDateFormat("hh:mm:ss").format(dateAndTime);

            db.saveGrn(grn);

            ResultSet rs = SqlConnection.getData("SELECT grn_id FROM grn WHERE stf_id=" + stf_id + " AND date='" + date + "' AND time='" + time + "'");

            if (rs.next())
            {
                grnCopy.setGrn_id(rs.getInt("grn_id"));
            }

            ArrayList bookNameList = new ArrayList();
            ArrayList batchList = new ArrayList<>();
            ArrayList qtyList = new ArrayList();

            String bkName = req.getParameter("bkName");
            String batch = req.getParameter("bkBatch");
            String qty = req.getParameter("bkQty");

            while(true)
            {
                bookNameList.add(bkName.substring(0, bkName.indexOf(',')));
                batchList.add(batch.substring(0, batch.indexOf(',')));
                qtyList.add(qty.substring(0, qty.indexOf(',')));

                if (bkName.indexOf(',') != (bkName.length() - 1))
                {
                    bkName = bkName.substring((bkName.indexOf(',') + 1), bkName.length());
                    batch = batch.substring(batch.indexOf(',') + 1, batch.length());
                    qty = qty.substring(qty.indexOf(',') + 1, qty.length());
                }
                else
                    break;
            }

            Iterator itrBkName = bookNameList.iterator();
            Iterator itrBatch = batchList.iterator();
            Iterator itrQty = qtyList.iterator();

            ObjFactory factory = new BookFactory();
            Book book = factory.getBook();
            Batch b = new Batch();

            while (itrBkName.hasNext() && itrBatch.hasNext() && itrQty.hasNext())
            {
                bkName = itrBkName.next().toString();
                int bkQty = Integer.parseInt(itrQty.next().toString());
                batch = itrBatch.next().toString();
                float bkBatch[] = {Float.parseFloat(batch.substring(0, batch.indexOf('-'))),
                        Float.parseFloat(batch.substring(batch.indexOf('-') + 1, batch.length()))};

                ResultSet rsBkName = SqlConnection.getData("SELECT book_id FROM book WHERE book_name='" + bkName + "'");
                ResultSet rsBatch = SqlConnection.getData("SELECT batch_id FROM batch WHERE buying_price=" + bkBatch[0] + " AND selling_price=" + bkBatch[1]);

                int bkId, batchId;

                if (rsBkName.next() && rsBatch.next())
                {
                    bkId = rsBkName.getInt("book_id");
                    batchId = rsBatch.getInt("batch_id");

                    b.setBatch_id(batchId);
                    b.setBuying_price(bkBatch[0]);
                    b.setSelling_price(bkBatch[1]);

                    book.setBookId(bkId);

                    grnCopy.setBatch(b);
                    grnCopy.setBook(book);
                }

                grnCopy.setQty(bkQty);
                grnCopy.setTo_add(bkQty);

                db.saveGrnCopy(grnCopy);
            }

            req.setAttribute("successful","successfully added!");
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }

    private void addOrder(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        String isbn = req.getParameter("isbn");

        try
        {
            Database db = new Database();
            BookCopy bookCopy = new BookCopy();
            InvoiceCopy invCopy = new InvoiceCopy();

            bookCopy.setISBN(isbn);
            invCopy.setISBN(bookCopy);
            invCopy.setStatus(true);

            db.updateInvoiceCopy(invCopy);

            showNotification(req, req.getParameter("isbn") + " status successfully changed!", NOTI_TYPE_SUCCESS);
            setActivePanel(req, PNL_ORDER_ADDING);
        }
        catch (Exception e)
        {
            showNotification(req, "Something went wrong!", NOTI_TYPE_ERROR);
            setActivePanel(req, PNL_ORDER_ADDING);

            e.printStackTrace();
        }
    }
}


















