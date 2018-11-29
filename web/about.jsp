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
<div class="mainGrid">
    <%@include file="Templates/header.jsp" %>
    <div class="locationText">
        HOMEPAGE / ABOUT
    </div>
<div class="Content">
    <div class="wrapper row2" style="margin-left: 70px;">
        <div id="container" class="clear">
            <div id="about-us" class="clear">
                <section id="about-intro" class="one_third first">
                    <h2>Enigma Director</h2>
                    <div class="panorama"><img class="imgholder" src="Images/290x170.png" alt=""></div>
                    <p>&quot;Harvey Dent / Company Director&quot;</p>
                    <blockquote>
                        <p><span>&ldquo;</span>Enigma has offered a new style of selling books and has given the opportunity of reading books inside the store
                            for students and donate syllabus related books to high schools. We will keep doing these charities and encouraging students to read more.<span>&ldquo;</span></p>
                    </blockquote>
                <section id="skillset" class="one_third">
                    <h2>Enigma BookStore</h2>
                    <p> Enigma Bookshop is a division of the EduWest group of Companies in the United States. The bookshop first
                        commenced business over 65 years ago in the rural township of geneva, Alabama. In 1973, it moved to a busier location and found
                        its permanent home in New York. Within just a short period of time Enigma Bookshop expanded operations and activities in a
                        network of Branches Country wide to better serve its customers. Today we are comprised of more than 14
                        branches including bookstores in some of the major cities in US such as Brooklyn, Queens, Los Angels and Manhattan.
                    </p>
                </section>
                </section>
            </div>
        </div>
    </div>
</div>
<%@include file="Templates/footer.jsp"%>
</div>
</body>
</html>
