<%@page import="Core.SqlConnection"%>
<%@ page import="java.sql.ResultSet" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String by = request.getParameter("by");
    String value = request.getParameter("value");
    by=by==null?"":by;
    if (by.equalsIgnoreCase("Book ID")) {
        by = "book_id";
    } else if (by.equalsIgnoreCase("Book Name")) {
        by = "book_name";
    } else {
        by = "book_id";
    }

    String where = "";
    if (value != null) {
        where = "where " + by + " like '" + value + "%'";
    }
%>

<%
    try
    {
        ResultSet rs = SqlConnection.getData("SELECT * FROM book " + where);
%>

<table class="table table-striped ">
    <thead>
    <tr>
        <th>#</th>
        <th>ID</th>
        <th>NAME</th>
        <th>AUTHOR</th>
        <th>ACTION</th>
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

        <td><%=rs.getInt("book_id")%></td>
        <td><%=rs.getString("book_name")%></td>
        <td><%=rs.getString("author_name")%></td>
        <td>
            <button type="button" class="btn btn-default btn-sm" data-toggle="modal" onclick="showBookDetailsDialog('<%= request.getContextPath()+"/Staff/" %>','<%=rs.getInt("book_id")%>')"><i class="fa fa-tv"></i> <b>View More</b></button>
            <button type="button" class="btn btn-default btn-sm" data-toggle="modal" onclick="fillEditBookData('<%=rs.getInt("book_id")%>')"><i class="fa fa-pencil-alt"></i>  <b>Edit</b></button>
        </td>
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
