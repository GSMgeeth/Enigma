<%@page import="Core.SqlConnection"%>
<%@ page import="java.sql.ResultSet" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String by = request.getParameter("by");
    String value = request.getParameter("value");
    by=by==null?"":by;
    if (by.equalsIgnoreCase("Name(Company)")) {
        by = "company";
    } else if (by.equalsIgnoreCase("Agent")) {
        by = "agent_name";
    } else {
        by = "company";
    }

    String where = "";
    if (value != null) {
        where = "where " + by + " like '" + value + "%'";
    }
%>

<%
    try
    {
        ResultSet rs = SqlConnection.getData("SELECT * FROM supplier " + where);
%>

<table class="table table-striped ">
    <thead>
    <tr>
        <th>#</th>
        <th>NAME/COMPANY</th>
        <th>AGENT</th>
        <th>ADDRESS</th>
        <th>TELL</th>
        <th>EMAIL</th>
        <th>REG DATE</th>
        <th>STATUS</th>
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

            <td><%=rs.getString("company")%></td>
            <td><%=rs.getString("agent_name")%></td>
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
