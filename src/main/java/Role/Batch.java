package Role;

public class Batch
{
    private int batch_id;
    private float buying_price;
    private float selling_price;
    private int stf_id;

    public void setBatch_id(int batch_id)
    {
        this.batch_id = batch_id;
    }

    public int getBatch_id()
    {
        return batch_id;
    }

    public void setBuying_price(float buying_price)
    {
        this.buying_price = buying_price;
    }

    public float getBuying_price()
    {
        return buying_price;
    }

    public void setSelling_price(float selling_price)
    {
        this.selling_price = selling_price;
    }

    public float getSelling_price()
    {
        return selling_price;
    }

    public void setStf_id(int stf_id)
    {
        this.stf_id = stf_id;
    }

    public int getStf_id()
    {
        return stf_id;
    }
}
