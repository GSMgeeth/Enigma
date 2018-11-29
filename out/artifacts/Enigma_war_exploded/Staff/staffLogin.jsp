<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String root = request.getContextPath() + "/Staff/";
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Enigma Admin:login</title>
    <%@include file="Templates/commonImports.jsp" %>

    <script>
        $.fn.extend({
            animateCss: function (animationName, callback) {
                var animationEnd = (function (el) {
                    var animations = {
                        animation: 'animationend',
                        OAnimation: 'oAnimationEnd',
                        MozAnimation: 'mozAnimationEnd',
                        WebkitAnimation: 'webkitAnimationEnd',
                    };

                    for (var t in animations) {
                        if (el.style[t] !== undefined) {
                            return animations[t];
                        }
                    }
                })(document.createElement('div'));

                this.addClass('animated ' + animationName).one(animationEnd, function () {
                    $(this).removeClass('animated ' + animationName);

                    if (typeof callback === 'function')
                        callback();
                });

                return this;
            }
        });

        function animateHeader(){
            $('#header').removeClass("h");
            $('#header').addClass("s");
            $('#header').animateCss("animated bounceInDown");
        }

        function show(){
            $('#header').removeClass("h");
            $('#header').addClass("s");
        }

    </script>
    <%
        String msg = "";

        if (request.getAttribute("errorMessage") != null)
            msg = request.getAttribute("errorMessage").toString();

        if (!msg.isEmpty())
        {
    %>
            <script>
                $(document).ready(function () {
                    /*
                     bounce flash pulse rubberBand
                     shake headShake swing	tada
                     wobble	jello
                     */
                    show();
                    $('#panel').animateCss('animated jello',function (){

                    });
                });
            </script>
        <%
            }
            else
            {
        %>
            <script>
                $(document).ready(function () {
                    /*
                     bounce flash pulse rubberBand
                     shake headShake swing	tada
                     wobble	jello
                     */

                    $('#panel').animateCss('animated flipInX',function(){
                        animateHeader();
                    });
                });
            </script>
        <%
            }
        %>
    <style>
        .s{
            opacity: 1;
        }

        .h{
            opacity: 0;
        }
        body{
            margin: 0px;
            background-color:  #052531;
            font-weight: bold;
        }

        .myheader{
            width: 35%;
            padding: 5px;
            padding-top: 60px;
            text-align: center;
            font-size: 20px;
            background-color: white;
            margin-left: auto;
            margin-right: auto;
            box-shadow: 0px 0px 20px 5px black;
            border-bottom:  solid 2px #ff6600;
            height: 100px;
            margin-top: -50px;
        }
        .mypanel{
            background-color: white;
            width: 35%;
            border-radius:0px;
            margin-left: auto;
            margin-right: auto;
            margin-top: 5%;
            padding: 30px;
            box-shadow: 0px 0px 20px 5px black;
            border-top: solid 2px #ff6600;
            border-bottom:  solid 2px #ff6600;
        }
        img{
            margin-bottom:  20px;
            width: 100%;
            height: 100%;
        }

        .logo{
            text-align: center;
            margin-bottom: 20px;
            border-bottom: solid 1px #e2e2e2;
        }
    </style>
</head>
<body>
<div id="header" class="myheader h">
    Admin Portal
</div>
<div id="panel" class="panel mypanel">
    <div class="logo">
        <img src="<%=root%>Images/logo.png">
    </div>


    <%
        if (request.getAttribute("from") == null)
        {
    %>
            <form action="/StaffWelcome" method="POST">
                <div class="form-group">
                    <label>Username :</label>
                    <input class="form-control" type="text" name="uname"/>
                </div>
                <div class="form-group">
                    <label>Password :</label>
                    <input class="form-control"  type="password" name="pw"/>
                </div>
                <div class="form-group">
                    <p style="color: red;font-size: 12px;">${errorMessage}</p>
                </div>
                <div class="form-group" style="text-align: right; border-bottom: solid 1px #e2e2e2; padding-bottom: 30px; margin-bottom: 30px;">
                    <input class="btn btn-default" type="reset" value="Reset"/>
                    <input class="btn btn-primary" type="submit" value="Login"/>
                </div>
            </form>
    <%
        }
        else
        {
    %>
            <form action="/StaffWelcome" method="POST">
                <div class="form-group">
                    <label>Username :</label>
                    <input class="form-control" type="text" name="uname"/>
                </div>
                <div class="form-group">
                    <label>Password :</label>
                    <input class="form-control"  type="password" name="pw"/>
                </div>
                <div class="form-group">
                    <p style="color: red;font-size: 12px;">${errorMessage}</p>
                </div>
                <div class="form-group" style="text-align: right; border-bottom: solid 1px #e2e2e2; padding-bottom: 30px; margin-bottom: 30px;">
                    <input class="btn btn-default" type="reset" value="Reset"/>
                    <input class="btn btn-primary" type="submit" value="Login"/>
                </div>
                <input type="hidden" name="from" value="${from}"/>
            </form>
    <%
        }
    %>

</div>
</body>
</html>

