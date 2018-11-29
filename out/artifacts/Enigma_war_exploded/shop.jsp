<%@ page import="java.sql.ResultSet" %>
<%@ page import="Core.SqlConnection" %>
<%@ page import="Core.Database" %>
<%@ page import="Role.Batch" %>
<!DOCTYPE html>
<!DOCTYPE html>
<%
    String root = request.getContextPath() + "/";
%>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
<head>
    <title>Enigma Shop</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="Scripts/jquery.js" type="text/javascript"></script>
    <script src="Scripts/manageBooks.js" type="text/javascript"></script>
    <script src="Scripts/bootstrap.js" type="text/javascript"></script>
    <link href="Styles/bootstrap.css" rel="stylesheet" type="text/css"/>
    <link href="Styles/fontawesome-all.css" rel="stylesheet" type="text/css"/>
    <link href="Styles/layout.css" rel="stylesheet" type="text/css"/>
    <link href="Styles/animate.css" rel="stylesheet" type="text/css"/>
    <link href="Styles/shop.css" rel="stylesheet" type="text/css"/>
    <link href="Styles/Controlers.css" rel="stylesheet" type="text/css"/>
    <script>
        $(document).ready(function () {
            $("#menu-listiner").mouseenter(function () {
                $(".navi-manu").removeClass("animated bounceOutRight");
                $(".navi-manu").addClass("animated bounceInLeft");
            });
            $(".navi-manu").mouseleave(function () {
                $(".navi-manu").removeClass("animated bounceInLeft");
                $(".navi-manu").addClass("animated bounceOutRight");
            });
            $(".k").mouseenter(function () {
                $(".navi-manu").removeClass("animated bounceInLeft");
                $(".navi-manu").addClass("animated bounceOutRight");
            });
        });
    </script>
    <script type="text/javascript">
        function toCart(book_id)
        {
            document.getElementById('bookId').value = book_id;
            document.forms[0].submit();
        }
    </script>
</head>
<body>
<div class="mainGrid">
    <%@include file="Templates/header.jsp"%>
    <div class="locationText">
        HOMEPAGE / SHOP
    </div>
    <div class="Content">
        <div class="c-wraper">
            <div class="categories">
                <div>Product Categories</div>
                <ul>
                    <%
                        try
                        {
                            ResultSet rs = SqlConnection.getData("SELECT * FROM category");

                            while (rs.next())
                            {
                    %>
                    <li><a href="javascript:showBooksByCat('<%=root%>', '<%=rs.getString("cat_name")%>')"><i class="fa fa-arrow-right"></i><%=rs.getString("cat_name")%></a></li>
                    <%
                            }
                        }
                        catch (Exception e)
                        {
                            e.printStackTrace();
                        }
                    %>
                </ul>
            </div>
            <div class="product-wraper">
                <div class="shorter">
                    search by: <select id="lstSearchBy">
                    <option>Author</option>
                    <option selected="selected">Book Name</option>
                </select>
                    Search: <input type="text" onkeyup="showBooks('<%=root%>')" placeholder="Search text" id="txtSearch">
                    <button type="submit" onclick="showBooks('<%=root%>')" >Search</button>
                </div>

                <div class="product-list" id="search-table">
                    <div class="pl">
                        <%
                            try
                            {
                                ResultSet rs = SqlConnection.getData("select * from book_rating");

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
                                                <%
                                                    ResultSet rsCount = SqlConnection.getData("SELECT COUNT(*) as count FROM shopping_cart where cus_id=" +
                                                            session.getAttribute("cusId") + " and book_id=" + rs.getString("book_id"));

                                                    if (rsCount.next())
                                                    {
                                                %>
                                                <%=rsCount.getInt("count")%>
                                                <%
                                                    }
                                                %>
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
                </div>
                <div class="product-navi">
                    <ul class="pagination">
                        <li class="disabled"><a href="#">&laquo;</a></li>
                        <li class="active"><a href="#">1</a></li>
                        <li><a href="#">2</a></li>
                        <li><a href="#">3</a></li>
                        <li><a href="#">4</a></li>
                        <li><a href="#">5</a></li>
                        <li><a href="#">&raquo;</a></li>
                    </ul>
                </div>
                <form action="/ShoppingCartAdding" method="post">
                    <input type="hidden" name="bookId" id="bookId"/>
                </form>
            </div>
        </div>
    </div>
    <%@include file="Templates/footer.jsp"%>
</div>
</body>
</html>
