<%@ page import="Role.Customer" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="Core.SqlConnection" %>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
<head>
    <title>Update Profile</title>
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
    </script>
</head>
<body>
<div class="mainGrid">
    <%@include file="Templates/header.jsp" %>
    <div class="locationText">
        HOMEPAGE / UPDATE PROFILE
    </div>
<div class="Content">
    <%
        if (session.getAttribute("username") == null)
        {
            out.print("Error! Please login!");
        }
        else
        {
    %>
    <style>
        .form-wraper01{
            width: 50%;
            margin: auto;
        }
    </style>
    <div class="form-wraper01">
        <form action="/CustomerUpdating" method="POST">
            <%
                Customer cus = (Customer) session.getAttribute("customer");
            %>
            <input type="hidden" id="cusId" name="cusId" value="<%=cus.getId()%>"/>

            <div class="form-group">
                <label>Name :</label><label style="color: red;">${errorMessageName}</label>
                <input class="form-control" type="text" name="name" id="name" value="<%=cus.getName()%>"/>
            </div>
            <div class="form-group">
                <label>Address :</label><label style="color: red;">${errorMessageAdd}</label>
                <input class="form-control" type="text" name="address" id="address" value="<%=cus.getAddress()%>"/>
            </div>
            <div class="form-group">
                <label>Telephone :</label><label style="color: red;">${errorMessageTel}</label>
                <input class="form-control" type="text" name="tel" id="tel" value="<%=cus.getTel()%>"/>
            </div>
            <div class="form-group">
                <label>Email : </label><label style="color: red;">${errorMessageEmail}</label>
                <input class="form-control" type="text" name="email" id="email" value="<%=cus.getEmail()%>"/>
            </div>
            <div class="form-group">
                <label style="color: green;">${successful}</label>
            </div>
            <div class="form-group">
                <input type="submit" value="Update" class="btn btn-primary"/>
            </div>
        </form>

        <button class="btn btn-primary"><a href="updateCustomerPassword.jsp" style="color: black">Update Password</a></button><br/>
    </div>
    <%
        }
    %>
</div>
<%@include file="Templates/footer.jsp"%>
</div>
</body>
</html>
