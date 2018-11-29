<%@page import="Core.SqlConnection"%>
<%@ page import="java.sql.ResultSet" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String id = request.getParameter("id");
    if (id == null || id.isEmpty()) {
%>

<div class="alert alert-warning">Book id is needed..!</div>

<%
} else {
%>

<%
    try
    {
        ResultSet rs = SqlConnection.getData("SELECT * from book as a inner join category as b on a.cat_id=b.cat_id where book_id='" + id + "'");
%>

<div class="model-image-c">
    <img src="<%= request.getContextPath()+"/Staff/" %>Images/book-1.jpg" alt="book">
</div>
<div class="model-book-details">
    <%
        int i = 0;
        while (rs.next())
        {
            i++;
    %>
    <table>
        <tbody>
        <tr>
            <td><label>ID</label></td>
            <td><label>:</label></td>
            <td><label><%=rs.getInt("book_id")%></label></td>
        </tr>
        <tr>
            <td><label>Name</label></td>
            <td><label>:</label></td>
            <td><label><%=rs.getString("book_name")%></label></td>
        </tr>
        <tr>
            <td><label>Author</label></td>
            <td><label>:</label></td>
            <td><label><%=rs.getString("author_name")%></label></td>
        </tr>
        <tr>
            <td><label>description</label></td>
            <td><label>:</label></td>
            <td><label><%=rs.getString("description")%></label></td>
        </tr>
        <tr>
            <td><label>Category</label></td>
            <td><label>:</label></td>
            <td><label><%=rs.getString("cat_name")%></label></td>
        </tr>

        </tbody>
    </table>
    <%
        }

        if (i == 0)
        {

    %>
    <div class="alert alert-warning">there is no book available for id <%=id%></div>
    <%
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    %>

</div>
<%
    }
%>