<%@page import="Core.SqlConnection"%>
<%@ page import="java.sql.ResultSet" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String by = request.getParameter("by");
    String value = request.getParameter("value");
    by = by == null ? "" : by;

    if (by.equalsIgnoreCase("Buying Price")) {
        by = "buying_price";
    } else if (by.equalsIgnoreCase("Selling Price")) {
        by = "selling_price";
    } else {
        by = "buying_price";
    }

    String where = "";

    if (value != null) {
        where = "where " + by + " like '" + value + "%'";
    }
%>

<%
    try
    {
        ResultSet rs = SqlConnection.getData("SELECT * FROM batch " + where);
%>

<table class="table table-striped ">
    <thead>
    <tr>
        <th>#</th>
        <th>BUYING PRICE</th>
        <th>SELLING PRICE</th>
    </tr>
    </thead>
    <tbody>
    <%
        int i = 0;
        while (rs.next())
        {
    %>
        <tr>
            <td><%=++i%></td>
            <td><%=rs.getFloat("buying_price")%></td>
            <td><%=rs.getFloat("selling_price")%></td>
        </tr>
    <%
        }
    }
    catch (Exception e)
    {
        e.printStackTrace();
    }
    %>
    </tbody>
</table>
