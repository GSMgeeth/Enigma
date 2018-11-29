<%@page import="Core.SqlConnection"%>
<%@ page import="java.sql.ResultSet" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String by = request.getParameter("by");
    String value = request.getParameter("value");
    by = by == null ? "" : by;

    if (by.equalsIgnoreCase("ID")) {
        by = "cat_id";
    } else if (by.equalsIgnoreCase("Name")) {
        by = "cat_name";
    } else {
        by = "cat_id";
    }

    String where = "";

    if (value != null) {
        where = "where " + by + " like '" + value + "%'";
    }
%>

<%
    try
    {
        ResultSet rs = SqlConnection.getData("SELECT * FROM category " + where);
%>

<table class="table table-striped ">
    <thead>
    <tr>
        <th>#</th>
        <th>ID</th>
        <th>NAME</th>
    </tr>
    </thead>
    <tbody>
    <%
        int i=0;
        while (rs.next())
        {
    %>
    <tr>
        <td><%=++i%></td>
        <td><%=rs.getInt("cat_id")%></td>
        <td><%=rs.getString("cat_name")%></td>
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
