<%@page import="Action.Staff.AdminSupplierManagement"%>
<%@page import="Action.Staff.AdminBookManagement"%>
<%@page import="Common.Enum.AD_PAGES"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<%
    String root = request.getContextPath() + "/Staff/";
%>

<html>
<head>
    <title>Administration:Selena Gomez</title>
    <%@include file="Templates/commonImports.jsp"%>

    <script src="<%=root%>Scripts/manageSuppliers.js" type="text/javascript"></script>
    <script>
        $(document).ready(function(){
            showSuppliers('<%=root%>');

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
    <ul class="nav nav-tabs mynavi">
        <li class="active"><a data-toggle="tab" href="#search_books">SEARCH SUPPLIERS</a></li>
        <li class=""><a data-toggle="tab" href="#addnew_book">ADD SUPPLIER</a></li>
    </ul>
    <div class="tab-content">
        <!-- ##### ADD NEW SUPPLIER ##############################################3-->
        <div id="addnew_book" class="addnewform tab-pane fade in
                     "><!-- is active panel must be active -->
            <form  method="POST" action="<%=request.getContextPath() + AD_PAGES.ADMIN_MANAGE_SUPPLIER.toString()%>" >
                <input type="hidden" name="<%=AdminSupplierManagement.FORM_TYPE%>" value="<%=AdminSupplierManagement.FORM_TYPE_ADD_SUPPLIER%>"/>

                <div class="form-group">
                    <label class="control-label">Nama/Company :</label><label class=" control-label ferror-message">${errorMessageName}</label>
                    <input  type="text" class="form-control" name="name">
                </div>
                <div class="form-group">
                    <label class="control-label">Telephone :</label><label class=" control-label ferror-message">${errorMessageTel}</label>
                    <input  type="text" class="form-control" name="tel">
                </div>
                <div class="form-group">
                    <label class="control-label">Email :</label><label class=" control-label ferror-message">${errorMessageEmail}</label>
                    <input  type="text" class="form-control" name="email">
                </div>
                <div class="form-group">
                    <label class="control-label">Agent :</label><label class=" control-label ferror-message">${errorMessageAgent}</label>
                    <input  type="text" class="form-control" name="agent">
                </div>
                <div class="form-group">
                    <label class="control-label">Address :</label><label class=" control-label ferror-message">${errorMessageAdd}</label>
                    <textarea  type="text" class="form-control" name="address"></textarea>
                </div>
                <button type="reset" onmouseup="showNotification('form reseted')" class="btn btn-default">Reset</button>
                <button type="submit" class="btn btn-primary">Save</button>
            </form>
        </div>
        <!-- ##### SEARCH SUPPLIER ##############################################3-->
        <div id="search_books" class="tab-pane fade in active">
            <div class="book-search-panel">
                <div class="search-fieldlebel">
                    <label>Search</label>
                </div>
                <div class="search-field">
                    <input id="txtSearch" onkeyup="showSuppliers('<%=root%>')" class="form-control" type="text" name="search_text">
                </div>
                <div class="search-bylebel">
                    <label>By</label>
                </div>
                <div class="search-by" style="   width: 40%;">
                    <select  class="form-control"  id="lstSearchBy">
                        <option selected="selected">Name/Company</option>
                        <option>Agent</option>
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

