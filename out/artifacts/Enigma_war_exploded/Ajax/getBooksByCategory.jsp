<%@page import="Core.SqlConnection"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="Role.Batch" %>
<%@ page import="Core.Database" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String cat = request.getParameter("cat");
    cat=cat==null?"":cat;
    int catId = 1;

    try
    {
        ResultSet rsCat = SqlConnection.getData("SELECT cat_id FROM category WHERE cat_name='" + cat + "'");

        while (rsCat.next())
        {
            catId = rsCat.getInt("cat_id");
        }
    }
    catch (Exception e)
    {
        e.printStackTrace();
    }
%>

<%
    try
    {
        ResultSet rs = SqlConnection.getData("SELECT * FROM book_rating WHERE cat_id=" + catId);
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
