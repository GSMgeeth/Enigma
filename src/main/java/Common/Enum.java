package Common;

public class Enum
{
    public enum AD_PAGES
    {
        ADMIN_DASHBOARD("/StaffWelcome"),
        ADMIN_LOGING("/StaffWelcome"),
        ADMIN_LOGOUT("/StaffWelcome"),
        ADMIN_MANAGE_BOOK("/AdminBookManagement"),
        ADMIN_MANAGE_CUSTOMER("/AdminCustomerManagement"),
        ADMIN_MANAGE_STAFF("/AdminStaffManagement"),
        ADMIN_MANAGE_SUPPLIER("/AdminSupplierManagement"),
        ADMIN_MANAGE_TRANSACTION("/AdminTransactionManagement"),
        ADMIN_EDIT_MY_PROFILE("admineditprofile"),
        ADMIN_MESSAGE("adminmassages"),
        ADMIN_MY_PROFILE("adminmyprofile"),
        ADMIN_NOTIFICATION("adminnotifications"),;

        private final String value_as_string;
        public static final String PAGE = "page";


        AD_PAGES(String value_string)
        {
            this.value_as_string = value_string;
        }

        @Override
        public String toString()
        {
            return value_as_string;
        }
    }

    public enum STAFF_TYPE
    {
        ADMIN("admin"),HR("hr"),ACCOUNTANT("accountant"),SUPERVISOR("supervisor");

        private final String valueAsString;

        STAFF_TYPE(String s) {
            valueAsString = s;
        }

        @Override
        public String toString() {
            return valueAsString;
        }
    }
}












