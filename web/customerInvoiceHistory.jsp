<%@ page import="java.sql.ResultSet" %>
<%@ page import="Core.SqlConnection" %>

<!DOCTYPE html>

<html>
<head>
    <title>Customer History</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="Scripts/jquery.js" type="text/javascript"></script>
    <script src="Scripts/bootstrap.js" type="text/javascript"></script>
    <link href="Styles/bootstrap.css" rel="stylesheet" type="text/css"/>
    <link href="Styles/fontawesome-all.css" rel="stylesheet" type="text/css"/>
    <link href="Styles/layout.css" rel="stylesheet" type="text/css"/>
    <link href="Styles/animate.css" rel="stylesheet" type="text/css"/>
    <link href="Styles/cart.css" rel="stylesheet" type="text/css"/>
    <style>
        .history-table {
            height: 400px;
            overflow-y: scroll;
        }
        thead div {
            position: absolute;
        }
    </style>
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
</head>
<body>
<%
    if (session.getAttribute("username") == null)
    {
        out.print("Error! Please login!");
    }
    else
    {
%>
<div class="mainGrid">
    <%@include file="Templates/header.jsp" %>
    <div class="locationText">
        HOMEPAGE / HISTORY
    </div>
<div class="Content">
    <div class="cart-products">
        <div class="history-table">
            <form>
                <table id="cart" class="table table-striped table-hover ">
                    <thead>
                    <tr>
                        <th>Book Name</th>
                        <th>ISBN</th>
                        <th>Price</th>
                        <th>date</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        try
                        {
                            int cus_id = Integer.parseInt(session.getAttribute("cusId").toString());

                            ResultSet rs = SqlConnection.getData("select i.date, c.ISBN, b.book_name, t.selling_price from invoice i " +
                                    "inner join invoice_copy c on i.inv_id=c.inv_id " +
                                    "inner join book_copy bc on c.ISBN=bc.ISBN inner join book b on bc.book_id=b.book_id " +
                                    "inner join grn_copy g on bc.grn_id=g.grn_id and bc.book_id=g.book_id " +
                                    "inner join batch t on g.batch_id=t.batch_id where i.cus_id=" + cus_id + " order by i.date desc");

                            if (!rs.first())
                            {
                                out.print("<h3>Nothing in the History!</h3>");
                            }
                            else
                            {
                                rs.previous();

                                while (rs.next())
                                {
                    %>
                    <tr>
                        <%
                            out.print("<td>" + rs.getString("book_name") + "</td>");
                            out.print("<td>" + rs.getString("ISBN") + "</td>");
                            out.print("<td>" + rs.getString("selling_price") + "</td>");
                            out.print("<td>" + rs.getString("date") + "</td>");
                        %>
                    </tr>
                    <%
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
                </div>
            </form>
        </div>
    </div>

</div>
<%@include file="Templates/footer.jsp"%>
<%
    }
%>
</div>
</body>
</html>
