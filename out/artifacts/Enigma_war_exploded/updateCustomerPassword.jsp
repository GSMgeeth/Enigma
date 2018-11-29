<%@ page import="Role.Customer" %><%--
  Created by IntelliJ IDEA.
  User: Geeth Sandaru
  Date: 4/26/2018
  Time: 22:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Update Customer Password</title>
    <link href="Styles/bootstrap.css" rel="stylesheet" type="text/css"/>
    <style>
        body{
            background-color: #333;
        }

        .login_wraper{
            width: 500px;
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
    if ((session.getAttribute("username") == null) && (session.getAttribute("rescue") == null))
    {
        out.print("Error! Please login!");
    }
    else if (session.getAttribute("rescue") == "rescued")
    {
%>
<div class="login_wraper">
    <div class="logo">
        <img src="Images/logo.png">
    </div>

    <form  action="/CustomerPasswordUpdating" method="POST">
        <input type="hidden" name="from" value="rescue"/>
        <div class="form-group">
            <label>New Password : </label>
            <input class="form-control" type="password" name="pword" id="pword"/>
        </div>
        <div class="form-group">
            <label style="color: green;font-weight: bold;">${successful}</label>
        </div>
        <div class="form-group" style="text-align: right; border-bottom: solid 1px #e2e2e2; padding-bottom: 30px; margin-bottom: 30px;">
            <input class="btn btn-default" type="reset" value="Reset"/>
            <input class="btn btn-primary" type="submit" value="Update Password"/>
        </div>
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

    <form  action="/CustomerPasswordUpdating" method="POST">
        <div class="form-group">
            <label>Current Password :</label><label style="color: red;font-weight: bold;">${errorMessagePW}</label>
            <input class="form-control" type="text" name="oldPword"/>
        </div>
        <div class="form-group">
            <label>New Password : </label>
            <input class="form-control" type="password" name="newPword"/>
        </div>
        <div class="form-group" style="text-align: right; border-bottom: solid 1px #e2e2e2; padding-bottom: 30px; margin-bottom: 30px;">
            <input class="btn btn-default" type="reset" value="Reset"/>
            <input class="btn btn-primary" type="submit" value="Update Password"/>
        </div>
        <input type="hidden" name="from" value="update"/>
    </form>
</div>
<%
    }
%>
</body>
</html>
