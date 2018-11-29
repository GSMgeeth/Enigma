<%@page import="Core.SqlConnection"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="Role.Batch" %>
<%@ page import="Core.Database" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String by = request.getParameter("by");
    String value = request.getParameter("value");
    by=by==null?"":by;
    if (by.equalsIgnoreCase("Author")) {
        by = "author_name";
    } else if (by.equalsIgnoreCase("Book Name")) {
        by = "book_name";
    } else {
        by = "book_name";
    }

    String where = "";
    if (value != null) {
        where = "where " + by + " like '" + value + "%'";
    }
%>

<%
    try
    {
        ResultSet rs = SqlConnection.getData("SELECT * FROM book_rating " + where);
%>

<div class="pl">
    <%
            int i = 0;

            while (rs.next())
            {
                i++;

                Batch batch = Database.getFirstAvailableIsbnBatch(rs.getInt("book_id"));
    %>
    <div class="sp">
        <div class="pc">
            <div class="a">
                <div class="b"></div>
                <div class="b2"></div>
                <div class="c">
                    <div class="c1">
                        <div class="b-image">
                            <img src="bookImages/<%=rs.getString("book_name")%>.jpg" alt="book">
                        </div>
                    </div>
                    <div class="c2">
                        <div class="des">
                            <span><%=rs.getString("author_name")%></span><br>
                            <b><%=rs.getString("book_name")%></b><br>
                            <%
                                if ((rs.getString("description")).length() > 20)
                                {
                            %>
                            <%=rs.getString("description").substring(0,19)%>...
                            <%
                            }
                            else if ((rs.getString("description")).length() <= 20)
                            {
                            %>
                            <%=rs.getString("description")%>...
                            <%
                                }
                            %>
                        </div>
                        <div class="price">
                            <%=batch.getSelling_price()%>
                        </div>
                        <div class="cart-action" onclick="toCart(<%=rs.getInt("book_id")%>)">
                            0
                            <i class="fa fa-shopping-cart"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%
        if (i % 3 == 0)
        {
    %></div><div class="pl"><%
            }
        }
    }
    catch (Exception e)
    {
        e.printStackTrace();
    }
%>
</div>
