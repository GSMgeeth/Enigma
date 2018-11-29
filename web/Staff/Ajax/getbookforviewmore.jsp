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
        ResultSet rs = SqlConnection.getData("SELECT * from book a inner join category b on a.cat_id=b.cat_id where book_id='" + id + "'");
%>

<div class="model-image-c">
    <%
        int i = 0;
        if (rs.first())
        {
            i++;

            if ((rs.getString("img") == null) || ((rs.getString("img").isEmpty())))
            {
    %>
    <img src="<%= request.getContextPath()+"/Staff/" %>Images/book-1.jpg" alt="book">
    <%
            }
            else
            {
    %>
    <img src="bookImages/<%=rs.getString("book_name")%>.jpg" alt="book" width="150" height="200" >
    <%
            }
    %>
</div>
<div class="model-book-details">
    <table class="table table-striped ">
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