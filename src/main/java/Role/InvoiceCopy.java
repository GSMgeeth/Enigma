package Role;

public class InvoiceCopy
{
    private int inv_id;
    private boolean status;

    private BookCopy isbn;

    public int getInv_id() {
        return inv_id;
    }

    public void setInv_id(int inv_id) {
        this.inv_id = inv_id;
    }

    public BookCopy getISBN()
    {
        return isbn;
    }

    public void setISBN(BookCopy isbn)
    {
        this.isbn = isbn;
    }

    public boolean getStatus()
    {
        return status;
    }

    public void setStatus(boolean status)
    {
        this.status = status;
    }
}
