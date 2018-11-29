<%@page import="Common.Enum.AD_PAGES"%>
<%@ page import="Action.Staff.AdminCustomerManagement" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<%
    String root=request.getContextPath()+"/Staff/";
%>

<html>
<head>
    <title>Administration:Selena Gomez</title>
    <%@include file="Templates/commonImports.jsp" %>

    <script src="<%=root%>Scripts/manageCustomers.js" type="text/javascript"></script>
    <script>
        $(document).ready(function(){
            showCustomers('<%=root%>');
        });
    </script>
</head>
<body>
<%
    if ((session.getAttribute("username") == null) || (session.getAttribute("nic") == null)
            || ((Staff)session.getAttribute("staff")).getType().equals("hr") || ((Staff)session.getAttribute("staff")).getType().equals("accountant")
            || ((Staff)session.getAttribute("staff")).getType().equals("supervisor"))
    {
        out.print("Error! Please login!");
    }
    else
    {
%>
<%@include file="Templates/header.jsp" %>
<%@include file="Templates/navigation.jsp" %>
<div class="content">
    <ul class="nav nav-tabs mynavi">
        <li class="active"><a data-toggle="tab" href="#search_books">SEARCH CUSTOMERS</a></li>
    </ul>
    <div class="tab-content">
        <!-- ##### SEARCH CUSTOMERS ##############################################3-->
        <div id="search_books" class="tab-pane fade in active">
            <div class="book-search-panel">
                <div class="search-fieldlebel">
                    <label>Search</label>
                </div>
                <div class="search-field">
                    <input id="txtSearch" onkeyup="showCustomers('<%=root%>')" class="form-control" type="text" name="search_text">
                </div>
                <div class="search-bylebel">
                    <label>By</label>
                </div>
                <div class="search-by" style="   width: 40%;">
                    <select  class="form-control"  id="lstSearchBy">
                        <option selected="selected">Name</option>
                        <option>Address</option>
                    </select>
                </div>
            </div>
            <div class="book-table" id="search-table" style="width: 90%;">
                <table class="table table-striped ">

                </table>
            </div>
        </div>
    </div>
</div>
<%
    }
%>
</body>
</html>

