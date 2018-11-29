<%--
  Created by IntelliJ IDEA.
  User: Geeth Sandaru
  Date: 4/24/2018
  Time: 18:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Password Recovery</title>
    <link href="Styles/bootstrap.css" rel="stylesheet" type="text/css"/>
    <style>
        body{
            background-color: #052531;
        }

        .form-wraper{
            text-align: center;
            padding: 30px;
            background-color: white;
            margin-top: 15%;
            width: 100%;
            padding-left: 300px;
            padding-right: 300px;
            box-shadow: 0px 0px 20px 5px black;
        }

        p{
            background-color: white;
            padding: 10px;
            border: solid 2px #ff9933;
            width: 200px;
            margin-top: 70%;
            margin: auto;
            margin-top: 10px;
            margin-bottom: 10px;
            text-align: center;

        }
    </style>
</head>
<body>

<%
    if (request.getAttribute("status") == null)
    {
%>
<div class="form-wraper">
    <form action="/PasswordRecovery" method="post">
        <div class="form-group">
            <label><b>Email</b></label><label style="color: red;">${error}</label>
            <input class="form-control" type="email" name="email"/>
        </div>

        <div class="form-group" style="text-align: right;">
            <input class="btn btn-default" type="reset" value="Reset"/>
            <input class="btn btn-primary" type="submit" value="Send rescue email"/>
        </div>
        </form>
</div>
<%
}
else if (request.getAttribute("status") == "sent")
{
%>
<div class="form-wraper">
    <form action="/PasswordRecovery" method="post">
        <div class="form-group">
            <label><b>Code</b></label>
            <input class="form-control" type="text" name="recoveryCode"/>
        </div>

        <input  type="hidden" name="email" value=${mail}>

        <div class="form-group" style="text-align: right;">
            <input class="btn btn-default" type="reset" value="Reset"/>
            <input class="btn btn-primary" type="submit" value="change password"/>
        </div>
    </form>
</div>

<%
    if (request.getAttribute("error") != null)
    {
%>
        <p style="color: red;">${error}</p>
<%
    }

    if (request.getAttribute("successful") != null)
    {
%>
    <p style="color: green;">${successful}</p>
<%
    }
%>


<%
    }
%>
</body>
</html>
