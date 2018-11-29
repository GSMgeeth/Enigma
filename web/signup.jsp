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
<div class="login_wraper">
    <div class="logo">
        <img src="Images/logo.png">
    </div>

    <form action="/CustomerAdding" method="POST">
        <div class="form-group">
            <label>Name :</label><label style="color: red;">${errorMessageName}</label>
            <input class="form-control" type="text" name="name" id="name"/>
        </div>
        <div class="form-group">
            <label>Address :</label><label style="color: red;">${errorMessageAdd}</label>
            <input class="form-control" type="text" name="address" id="address"/>
        </div>
        <div class="form-group">
            <label>Telephone :</label><label style="color: red;">${errorMessageTel}</label>
            <input class="form-control" type="text" name="tel" id="tel"/>
        </div>
        <div class="form-group">
            <label>Email : </label><label style="color: red;">${errorMessageEmail}</label>
            <input class="form-control" type="text" name="email" id="email"/>
        </div>
        <div class="form-group">
            <label>Username :</label><label style="color: red;">${errorMessageUname}</label>
            <input class="form-control" type="text" name="uname" id="uname"/>
        </div>
        <div class="form-group">
            <label>Password : </label><label style="color: red;">${errorMessagePw}</label>
            <input class="form-control" type="password" name="pw" id="pw"/>
        </div>
        <div class="form-group">
            <label style="color: green;">${successful}</label>
        </div>
        <div class="form-group">
            <input type="submit" value="Sign up" class="btn btn-primary"/>
        </div>
    </form>
</div>
</body>
</html>
















