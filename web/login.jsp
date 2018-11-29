<%--
  Created by IntelliJ IDEA.
  User: Geeth Sandaru
  Date: 4/1/2018
  Time: 16:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="Styles/bootstrap.css" rel="stylesheet" type="text/css"/>
    <title>Login</title>
    <style>
        body{
            background-color: #333;
        }

        .login_wraper{
            width: 400px;
            margin: auto;
            margin-top: 100px;
            background-color: white;
            padding: 20px;
            border-radius: 0px 10px 0px 10px;
            box-shadow: 0px 0px 20px 5px black;
        }

        img{
            margin-bottom:  20px;
            width: 90%;
            height: 80%;
        }

        .logo{
            text-align: center;
            margin-bottom: 20px;
            border-bottom: solid 1px #e2e2e2;
            height: 100px;
        }
    </style>
</head>
<body>
<%
    if (request.getAttribute("from") == null)
    {
%>
<div class="login_wraper">
    <div class="logo">
        <img src="Images/logo.png">
    </div>

    <form action="/CustomerLogin" method="POST">
        <div class="form-group">
            <label>Username :</label>
            <input class="form-control" type="text" name="uname"/>
        </div>
        <div class="form-group">
            <label>Password :</label>
            <input class="form-control" type="password" name="pw"/>
        </div>
        <div class="form-group">
            <label style="color: red;font-weight: bold;">${errorMessage}</label>
        </div>
        <div class="form-group" style="text-align: right; border-bottom: solid 1px #e2e2e2; padding-bottom: 30px; margin-bottom: 30px;">
            <input class="btn btn-default" type="reset" value="Reset"/>
            <input class="btn btn-primary" type="submit" value="Login"/>
        </div>

        <div class="form-group"><a href="passwordRecovery.jsp">Forget Password?</a></div>
        <div class="form-group"><a href="signup.jsp">Not a member?</a></div>
    </form>
</div>
<%
    }
    else
    {
%>
<div class="login_wraper">
    <div class="logo">
        <img src="Images/logo.png">
    </div>

    <form action="/CustomerLogin" method="POST">
        <div class="form-group">
            <label>Username :</label>
            <input class="form-control" type="text" name="uname"/>
        </div>
        <div class="form-group">
            <label>Password :</label>
            <input class="form-control" type="password" name="pw"/>
        </div>
        <div class="form-group">
            <label style="color: red;font-weight: bold;">${errorMessage}</label>
        </div>
        <div class="form-group" style="text-align: right; border-bottom: solid 1px #e2e2e2; padding-bottom: 30px; margin-bottom: 30px;">
            <input class="btn btn-default" type="reset" value="Reset"/>
            <input class="btn btn-primary" type="submit" value="Login"/>
        </div>

        <input type="hidden" name="from" value="${from}"/>

        <div class="form-group"><a href="passwordRecovery.jsp">Forget Password?</a></div>
        <div class="form-group"><a href="signup.jsp">Not a member?</a></div>
    </form>
</div>
<%
    }
%>
</body>
</html>
















