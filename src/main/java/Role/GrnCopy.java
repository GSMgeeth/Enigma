package Role;

public class GrnCopy
{
    private int grn_copy_id;
    private int grn_id;
    private int qty;
    private int to_add;

    private Book book;
    private Batch batch;

    public int getGrn_copy_id() {
        return grn_copy_id;
    }

    public void setGrn_copy_id(int grn_copy_id) {
        this.grn_copy_id = grn_copy_id;
    }

    public int getGrn_id() {
        return grn_id;
    }

    public void setGrn_id(int grn_id) {
        this.grn_id = grn_id;
    }

    public Book getBook()
    {
        return book;
    }

    public void setBook(Book book)
    {
        this.book = book;
    }

    public Batch getBatch() {
        return batch;
    }

    public void setBatch(Batch batch) {
        this.batch = batch;
    }

    public int getQty() {
        return qty;
    }

    public void setQty(int qty) {
        this.qty = qty;
    }

    public int getTo_add() {
        return to_add;
    }

    public void setTo_add(int to_add) {
        this.to_add = to_add;
    }
}
