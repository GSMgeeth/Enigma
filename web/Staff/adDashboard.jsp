<%@ page import="Action.Staff.StaffWelcome" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="Core.SqlConnection" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.Array" %>
<%@ page import="java.util.Arrays" %><%--
  Created by IntelliJ IDEA.
  User: Geeth Sandaru
  Date: 5/7/2018
  Time: 20:11
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<%
    String root=request.getContextPath()+"/Staff/";
%>

<html>
<head>
    <title>Administration:Selena Gomez</title>
    <%@include file="Templates/commonImports.jsp" %>
    <script>
        $(document).ready(function () {
            <%
                Object o = request.getAttribute(StaffWelcome.NOTIFICATION_VALUE);
                String value = o == null ? "" : (String) o;
                if (!value.isEmpty()) {
            %>
            /*
             * Info
             * success
             * warning
             * error
             **/
            iziToast.<%=request.getAttribute(StaffWelcome.NOTIFICATION_TYPE).toString()%>({
                position: 'bottomRight', // center, bottomRight, bottomLeft, topRight, topLeft, topCenter, bottomCenter
                title: '<%=value%>',
                message: '',
                theme: 'dark', // dark, light
                color: '#1e293d',
                progressBarColor: '#ff6600',
                transitionIn: 'bounceInUp', //bounceInLeft, bounceInRight, bounceInUp, bounceInDown, fadeIn, fadeInDown, fadeInUp, fadeInLeft, fadeInRight or flipInX.
                transitionOut: 'fadeOutUp'// fadeOut, fadeOutUp, fadeOutDown, fadeOutLeft, fadeOutRight, flipOutX
            });
            <%
                }
            %>
        });
    </script>
</head>
<body>
<%
    if ((session.getAttribute("username") == null) || (session.getAttribute("nic") == null))
    {
        out.print("Error! Please login!");
    }
    else
    {
%>
<%@include file="Templates/header.jsp" %>
<%@include file="Templates/navigation.jsp" %>
<div class="content">
    <%--<form action="" method="post">--%>
        <%--<input type="hidden" name="requesting" value="monthlyProfitReport"/>--%>
        <%--<input type="submit" value="View Monthly Profit Report"/>--%>
    <%--</form>--%>
    <style>
        .order-chart {
            width: 70%;
            height: 700px;
            margin: auto;
            text-align: center;
        }
    </style>
    <div class="order-chart" style="">
        <h3 style="">Monthly Orders chart</h3>
        <canvas id="myChart"></canvas>
        <script>
            <%
            ArrayList<Integer> qty = new ArrayList<>();
            ArrayList<String> month = new ArrayList<>();

            try
            {
                ResultSet rs = SqlConnection.getData("SELECT COUNT(*) AS count, monthname(date) as month from invoice_copy ic INNER JOIN" +
                                                        " invoice i on ic.inv_id=i.inv_id GROUP by month(date)");

                while (rs.next())
                {
                    qty.add(rs.getInt("count"));
                    month.add(rs.getString("month"));
                }
            }
            catch (Exception e)
            {
                e.printStackTrace();
            }

            String monthList = "[";

            for (int i = 0; i < month.size(); i++)
            {
                if (i == (month.size() - 1))
                {
                    monthList += "'" + month.get(i) + "'";
                }
                else
                {
                    monthList += "'" + month.get(i) + "',";
                }
            }

            monthList += "]";
            %>
            var ctx = document.getElementById("myChart").getContext('2d');
            var data = <%=Arrays.deepToString(qty.toArray())%>;
            var labels = <%=monthList%>;
            var myChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: labels,
                    datasets: [{
                        label: '# of books sold',
                        data: data,
                        pointRadius: 2,
                        borderColor: [
                            'rgba(255,99,132,0.5)'
                        ],
                        borderWidth: 4
                    }
                    ]
                },
                options: {
                    scales: {
                        yAxes: [{
                            ticks: {
                                beginAtZero: false
                            }
                        }]
                    }
                }
            });
        </script>
    </div>
</div>
<%
    }
%>
</body>
</html>

