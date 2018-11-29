<%@page import="Common.Enum.AD_PAGES"%>
<%
    Object asObject = session.getAttribute("staff");
    if (asObject == null) {
        response.sendRedirect(AD_PAGES.ADMIN_LOGING.toString());
    }
%>

