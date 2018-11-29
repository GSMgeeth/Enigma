<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
<head>
    <title>Home</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="Scripts/jquery.js" type="text/javascript"></script>
    <script src="Scripts/bootstrap.js" type="text/javascript"></script>
    <link href="Styles/bootstrap.css" rel="stylesheet" type="text/css"/>
    <link href="Styles/fontawesome-all.css" rel="stylesheet" type="text/css"/>
    <link href="Styles/layout.css" rel="stylesheet" type="text/css"/>
    <link href="Styles/animate.css" rel="stylesheet" type="text/css"/>
    <link href="Styles/home.css" rel="stylesheet" type="text/css"/>
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
<div class="mainGrid">
    <%@include file="Templates/header.jsp"%>
    <div class="locationText">
        HOMEPAGE / Home
    </div>
    <div class="Content">
        <div class="home-about">
            <div class="h-c">
                <h5>OUR BOOK SHOP SERVICE</h5>
                <h2>Bookselling is the commercial Trading of books</h2>
                <p>
                    Scholars and students spent many hours in these
                    bookshop schools reading, examining, and studying
                    available books . or purchasing favourite selections
                    for their private libraries.
                </p>

            </div>
            <div class="h-c">
                <div class="sc">
                    <h3><i class="fa fa-trophy"></i> Popular Books </h3>
                    <p>Enigma offers a large number of so popular
                        books for fair prices and with Discounts.
                        We calculate ratings of books with a
                        special algorithm.</p>

                </div>
                <div class="sc">
                    <h3><i class="fa fa-pencil-alt"></i> Best Authors</h3>
                    <p>We choose only the best authors who has
                        written very exciting books and has a
                        good welcome from the reading society. Many
                        awarded authors are in our collections.<p>
                </div>
            </div>
            <div class="h-c">
                <div class="sc">
                    <h3><i class="fa fa-book"></i> Amazing Book Quality</h3>
                    <p>Our books are with very strong and beautiful
                        pages and covers. Most of them are laminated.
                        So the books are secure from water and dust.<p>

                </div>
                <div class="sc">
                    <h3><i class="fa fa-shipping-fast"></i> Fast Shipping</h3>
                    <p>We make every effort to send you your books fast
                        and safe as possible. New delivery methods are
                        on the way. We are to use drones for in-city
                        deliveries.<p>
                </div>
            </div>
        </div>

        <div class="Author-History">
            <div class="a-c ac1">
                <img class="a-image" src="Images/author-1-280x390.jpg" alt="">
            </div>
            <div class="a-c">
                <h2> Author <span>History</span> of Inovation</h2>
                <h3><span>July James</span> <i>Author</i></h3>
                <p>
                    July James was born in 1960 in Virginia,
                    where he currently resides. He received a
                    Bachelor of Arts degree in political
                    science from Virginia Commonwealth
                    University and a law degree from the
                    University of Virginia. He practiced
                    law for nine years in Washington,
                    D.C., as both a trial and corporate
                    attorney. July James works have appeared
                    in nume
                </p>
            </div>
            <div class="a-c"></div>
        </div>
    </div>
    <%@include file="Templates/footer.jsp"%>
</div>
</body>
</html>
