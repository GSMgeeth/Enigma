package Common;

import Role.*;

public interface ObjFactory
{
    Book getBook(int book_id) throws Exception;

    Book getBook() throws Exception;

    Customer getCustomer(String uname) throws Exception;

    Customer getCustomer() throws Exception;

    Staff getStaff(int stf_id) throws Exception;

    Staff getStaff() throws Exception;

    Supplier getSupplier(int sup_id) throws Exception;

    Supplier getSupplier() throws Exception;
}
