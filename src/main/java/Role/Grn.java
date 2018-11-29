package Role;

import java.util.Date;

public class Grn
{
    private int grn_id;
    private int sup_id;
    private String veh_no;
    private double discount;
    private Date DateAndTime;
    private int stf_id;

    public int getGrn_id() {
        return grn_id;
    }

    public void setGrn_id(int grn_id) {
        this.grn_id = grn_id;
    }

    public int getSup_id() {
        return sup_id;
    }

    public void setSup_id(int sup_id) {
        this.sup_id = sup_id;
    }

    public String getVeh_no() {
        return veh_no;
    }

    public void setVeh_no(String veh_no) {
        this.veh_no = veh_no;
    }

    public double getDiscount() {
        return discount;
    }

    public void setDiscount(double discount) {
        this.discount = discount;
    }

    public Date getDateAndTime() {
        return DateAndTime;
    }

    public void setDateAndTime(Date dateAndTime) {
        DateAndTime = dateAndTime;
    }

    public int getStf_id() {
        return stf_id;
    }

    public void setStf_id(int stf_id) {
        this.stf_id = stf_id;
    }
}
