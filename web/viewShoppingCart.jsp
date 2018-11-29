<%@ page import="java.sql.ResultSet" %>
<%@ page import="Core.SqlConnection" %>
<%@ page import="Role.Batch" %>
<%@ page import="Core.Database" %>
<!DOCTYPE html>

<html>
<head>
    <title>Shopping Cart</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="Scripts/jquery.js" type="text/javascript"></script>
    <script src="Scripts/bootstrap.js" type="text/javascript"></script>
    <link href="Styles/bootstrap.css" rel="stylesheet" type="text/css"/>
    <link href="Styles/fontawesome-all.css" rel="stylesheet" type="text/css"/>
    <link href="Styles/layout.css" rel="stylesheet" type="text/css"/>
    <link href="Styles/animate.css" rel="stylesheet" type="text/css"/>
    <link href="Styles/cart.css" rel="stylesheet" type="text/css"/>
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

        function remove(book_id)
        {
            document.getElementById('bookId').value = book_id;
            document.forms[1].submit();
        }

        function totalCost()
        {
            var table = document.getElementById("cart");
            var sum = 0.0;

            for (var i = 1; i < table.rows.length; i++)
            {
                var p=$("#p"+(i - 1));
                var q=$("#qty"+(i - 1));
                q = parseInt(q.val());

                if (isNaN(q))
                    q = 0;

                sum = sum + parseFloat(p.text()) * q;
            }

            document.getElementById("totalPayment").innerText = sum;
        }
    </script>
</head>
<body>
<%
    if (session.getAttribute("username") == null)
    {
        out.print("Error! Please login!");
        request.setAttribute("from", "/viewShoppingCart.jsp");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
    else
    {
%>
<div class="mainGrid">
    <%@include file="Templates/header.jsp" %>
    <div class="locationText">
        HOMEPAGE / CART
    </div>
    <div class="Content">
        <div class="cart-products">
            <form action="/BookBuying" method="post">
                <table id="cart" class="table table-striped table-hover ">
                    <thead>
                    <tr>
                        <th>Book ID</th>
                        <th>Book Name</th>
                        <th>Author</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Remove</th>
                    </tr>
                    </thead>
                    <tbody>
                            <%
                            try
                            {
                                int cus_id = Integer.parseInt(session.getAttribute("cusId").toString());
                                ResultSet rs = SqlConnection.getData("select * from book b, shopping_cart s where s.book_id=b.book_id AND s.cus_id=" + cus_id);

                                if (!rs.first())
                                {
                                    out.print("<h3>Nothing in the Cart!</h3>");
                                }
                                else
                                {
                                    rs.previous();
                                    int i = 0;

                                    while (rs.next())
                                    {
                            %>
                    <tr>
                        <%
                            out.print("<td>" + rs.getInt("book_id") + "</td>");
                            out.print("<td>" + rs.getString("book_name") + "</td>");
                            out.print("<td>" + rs.getString("author_name") + "</td>");

                            Batch batch = Database.getFirstAvailableIsbnBatch(rs.getInt("book_id"));

                            if (batch != null)
                                out.print("<td id='p" + i + "'>" + batch.getSelling_price() + "</td>");

                            out.print("<td><input type='text' class='form-control' style='width: 70px;' id='qty" + i + "' onkeyup='totalCost()' name='qty" + i + "'/></td>");
                            out.print("<td><input type='button' class='btn btn-primary' onClick='remove(" + rs.getInt("book_id") + ")' value='Remove'/></td>");
                        %>
                    </tr>
                    <%
                                    i++;
                                }
                            }
                        }
                        catch (Exception e)
                        {
                            e.printStackTrace();
                        }
                    %>
                    </tbody>
                </table>
                <div class="ct-wraper">
                    <div class="empty">

                    </div>
                    <div class="total-cart">
                        <h3>Cart Total</h3>
                        <div class="list-group">
                            <div class="list-group-item litem">
                                <div><b>Total</b></div>
                                <div class="number-value" id="totalPayment">
                                </div>
                            </div>
                        </div>
                        <p style="color: green;">${successful}</p> <br/>
                        <p style="color: red;">${error}</p> <br/>
                        <input type="hidden" name="from" value="cart"/>
                        <input type="submit" class="btn btn-danger" value="Proceed to checkout"/>
                    </div>
                </div>
            </form>
            <form action="/ShoppingCartRemoving" method="post">
                <input type="hidden" name="bookId" id="bookId"/>
            </form>
        </div>

    </div>
<%@include file="Templates/footer.jsp"%>
</div>
<%
    }
%>
</body>
</html>
