<%@page import="Common.Enum.AD_PAGES"%>
<%@ page import="Role.Staff" %>

<%
    String p = request.getAttribute(AD_PAGES.PAGE).toString();
    String type = ((Staff)session.getAttribute("staff")).getType();
%>

<div class="main-menu">
    <ul>
        <%
            switch (type)
            {
                case "admin":
        %>
        <li class="<%=((p.equals(AD_PAGES.ADMIN_DASHBOARD.toString())) ? "manu-active" : "")%>"><a href="<%=request.getContextPath() + AD_PAGES.ADMIN_DASHBOARD.toString()%>"><i class="fas fa-home"></i>Dashboard</a></li>
        <li class="<%=((p.equals(AD_PAGES.ADMIN_MANAGE_BOOK.toString())) ? "manu-active" : "")%>"><a href="<%=request.getContextPath() + AD_PAGES.ADMIN_MANAGE_BOOK.toString()%>"><i class="fas fa-book"></i>Manage Books</a></li>
        <li class="<%=((p.equals(AD_PAGES.ADMIN_MANAGE_STAFF.toString())) ? "manu-active" : "")%>"><a href="<%=request.getContextPath() + AD_PAGES.ADMIN_MANAGE_STAFF.toString()%>"><i class="fas fa-user"></i> Manage Staff</a></li>
        <li class="<%=((p.equals(AD_PAGES.ADMIN_MANAGE_CUSTOMER.toString())) ? "manu-active" : "")%>"><a href="<%=request.getContextPath() + AD_PAGES.ADMIN_MANAGE_CUSTOMER.toString()%>"><i class="fas fa-cart-arrow-down"></i> Manage Customers</a></li>
        <li class="<%=((p.equals(AD_PAGES.ADMIN_MANAGE_SUPPLIER.toString())) ? "manu-active" : "")%>"><a href="<%=request.getContextPath() + AD_PAGES.ADMIN_MANAGE_SUPPLIER.toString()%>"><i class="fas fa-cart-plus"></i> Manage Suppliers</a></li>
        <li class="<%=((p.equals(AD_PAGES.ADMIN_MANAGE_TRANSACTION.toString())) ? "manu-active" : "")%>"><a href="<%=request.getContextPath() + AD_PAGES.ADMIN_MANAGE_TRANSACTION.toString()%>"><i class="fas fa-paper-plane"></i> Manage Transactions</a></li>
        <li class="<%=((p.equals(AD_PAGES.ADMIN_NOTIFICATION.toString())) ? "manu-active" : "")%>"><a href="<%=request.getContextPath() + AD_PAGES.ADMIN_NOTIFICATION.toString()%>"><i class="fas fa-clock"></i> Notifications</a></li>
        <li class="<%=((p.equals(AD_PAGES.ADMIN_MESSAGE.toString())) ? "manu-active" : "")%>"><a href="<%=request.getContextPath() + AD_PAGES.ADMIN_MESSAGE.toString()%>"><i class="fas fa-envelope"></i>Messages</a></li>
        <%
                break;
                case "supervisor":
        %>
        <li class="<%=((p.equals(AD_PAGES.ADMIN_DASHBOARD.toString())) ? "manu-active" : "")%>"><a href="<%=request.getContextPath() + AD_PAGES.ADMIN_DASHBOARD.toString()%>"><i class="fas fa-home"></i>Dashboard</a></li>
        <li class="<%=((p.equals(AD_PAGES.ADMIN_MANAGE_BOOK.toString())) ? "manu-active" : "")%>"><a href="<%=request.getContextPath() + AD_PAGES.ADMIN_MANAGE_BOOK.toString()%>"><i class="fas fa-book"></i>Manage Books</a></li>
        <li class="<%=((p.equals(AD_PAGES.ADMIN_MANAGE_SUPPLIER.toString())) ? "manu-active" : "")%>"><a href="<%=request.getContextPath() + AD_PAGES.ADMIN_MANAGE_SUPPLIER.toString()%>"><i class="fas fa-cart-plus"></i> Manage Suppliers</a></li>
        <li class="<%=((p.equals(AD_PAGES.ADMIN_MANAGE_TRANSACTION.toString())) ? "manu-active" : "")%>"><a href="<%=request.getContextPath() + AD_PAGES.ADMIN_MANAGE_TRANSACTION.toString()%>"><i class="fas fa-paper-plane"></i> Manage Transactions</a></li>
        <li class="<%=((p.equals(AD_PAGES.ADMIN_NOTIFICATION.toString())) ? "manu-active" : "")%>"><a href="<%=request.getContextPath() + AD_PAGES.ADMIN_NOTIFICATION.toString()%>"><i class="fas fa-clock"></i> Notifications</a></li>
        <li class="<%=((p.equals(AD_PAGES.ADMIN_MESSAGE.toString())) ? "manu-active" : "")%>"><a href="<%=request.getContextPath() + AD_PAGES.ADMIN_MESSAGE.toString()%>"><i class="fas fa-envelope"></i>Messages</a></li>
        <%
                break;
                case "accountant":
        %>
        <li class="<%=((p.equals(AD_PAGES.ADMIN_DASHBOARD.toString())) ? "manu-active" : "")%>"><a href="<%=request.getContextPath() + AD_PAGES.ADMIN_DASHBOARD.toString()%>"><i class="fas fa-home"></i>Dashboard</a></li>
        <li class="<%=((p.equals(AD_PAGES.ADMIN_MANAGE_TRANSACTION.toString())) ? "manu-active" : "")%>"><a href="<%=request.getContextPath() + AD_PAGES.ADMIN_MANAGE_TRANSACTION.toString()%>"><i class="fas fa-paper-plane"></i> Manage Transactions</a></li>
        <li class="<%=((p.equals(AD_PAGES.ADMIN_NOTIFICATION.toString())) ? "manu-active" : "")%>"><a href="<%=request.getContextPath() + AD_PAGES.ADMIN_NOTIFICATION.toString()%>"><i class="fas fa-clock"></i> Notifications</a></li>
        <li class="<%=((p.equals(AD_PAGES.ADMIN_MESSAGE.toString())) ? "manu-active" : "")%>"><a href="<%=request.getContextPath() + AD_PAGES.ADMIN_MESSAGE.toString()%>"><i class="fas fa-envelope"></i>Messages</a></li>
        <%
                break;
                case "hr":
        %>
        <li class="<%=((p.equals(AD_PAGES.ADMIN_DASHBOARD.toString())) ? "manu-active" : "")%>"><a href="<%=request.getContextPath() + AD_PAGES.ADMIN_DASHBOARD.toString()%>"><i class="fas fa-home"></i>Dashboard</a></li>
        <li class="<%=((p.equals(AD_PAGES.ADMIN_MANAGE_STAFF.toString())) ? "manu-active" : "")%>"><a href="<%=request.getContextPath() + AD_PAGES.ADMIN_MANAGE_STAFF.toString()%>"><i class="fas fa-user"></i> Manage Staff</a></li>
        <li class="<%=((p.equals(AD_PAGES.ADMIN_NOTIFICATION.toString())) ? "manu-active" : "")%>"><a href="<%=request.getContextPath() + AD_PAGES.ADMIN_NOTIFICATION.toString()%>"><i class="fas fa-clock"></i> Notifications</a></li>
        <li class="<%=((p.equals(AD_PAGES.ADMIN_MESSAGE.toString())) ? "manu-active" : "")%>"><a href="<%=request.getContextPath() + AD_PAGES.ADMIN_MESSAGE.toString()%>"><i class="fas fa-envelope"></i>Messages</a></li>
        <%
                break;
            }
        %>
    </ul>
</div>


