package Role;

public class Book
{
    private int bookId;
    private String bookName;
    private String authorName;
    private String des;
    private String img;
    private int rating;

    private Category cat;

    public int getBookId()
    {
        return bookId;
    }

    public void setBookId(int bookId)
    {
        this.bookId = bookId;
    }

    public void setBookName(String bookName)
    {
        this.bookName = bookName;
    }

    public String getBookName()
    {
        return bookName;
    }

    public void setAuthorName(String authorName)
    {
        this.authorName = authorName;
    }

    public String getAuthorName()
    {
        return authorName;
    }

    public void setDes(String des)
    {
        this.des = des;
    }

    public String getDes()
    {
        return des;
    }

    public void setCat(Category cat)
    {
        this.cat = cat;
    }

    public Category getCat()
    {
        return cat;
    }

    public void setImg(String img)
    {
        this.img = img;
    }

    public String getImg()
    {
        return img;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }
}
