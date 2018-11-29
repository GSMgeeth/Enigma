<%@page import="Core.SqlConnection"%>
<%@ page import="java.sql.ResultSet" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String by = request.getParameter("by");
    String value = request.getParameter("value");
    by=by==null?"":by;
    if (by.equalsIgnoreCase("Name")) {
        by = "name";
    } else if (by.equalsIgnoreCase("address")) {
        by = "address";
    } else {
        by = "name";
    }

    String where = "";
    if (value != null) {
        where = "where " + by + " like '" + value + "%'";
    }
%>

<%
    try
    {
        ResultSet rs = SqlConnection.getData("SELECT * FROM customer " + where);
%>

<table class="table table-striped ">
    <thead>
    <tr>
        <th>#</th>
        <th>NAME</th>
        <th>ADDRESS</th>
        <th>TEL</th>
        <th>EMAIL</th>
        <th>REG DATE</th>
        <th>STATUS</th>
    </tr>
    </thead>
    <tbody>
    <%
        while (rs.next())
        {
    %>
    <tr>
        <td><%=rs.getInt("cus_id")%></td>
        <td><%=rs.getString("name")%></td>
        <td><%=rs.getString("address")%></td>
        <td><%=rs.getString("tel")%></td>
        <td><%=rs.getString("email")%></td>
        <td><%=rs.getString("reg_date")%></td>
        <td><%=rs.getString("status")%></td>
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
