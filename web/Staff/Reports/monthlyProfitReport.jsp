<%@ page import="java.io.InputStream" %>
<%@ page import="Core.SqlConnection" %>
<%@ page import="net.sf.jasperreports.engine.*" %>
<%@ page contentType="application/pdf" %>
<%--
  Created by IntelliJ IDEA.
  User: Geeth Sandaru
  Date: 5/19/2018
  Time: 13:45
  To change this template use File | Settings | File Templates.
--%>

<%
    String root=request.getContextPath()+"/";
%>

<html>
<head>
    <title>MonthlyProfitReport</title>
</head>
<body>
    <%
        try
        {
            InputStream input = getClass().getResourceAsStream("/Reports/MonthlyProfitReport.jrxml");
            JasperReport jasperReport = JasperCompileManager.compileReport(input);

            JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, null, SqlConnection.getConnection());
            JasperExportManager.exportReportToPdfStream(jasperPrint, response.getOutputStream());
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    %>
</body>
</html>
