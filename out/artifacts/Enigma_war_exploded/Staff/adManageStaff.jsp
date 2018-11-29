<%@page import="Common.Enum.AD_PAGES"%>
<%@ page import="Action.Staff.AdminStaffManagement" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<%
    String root = request.getContextPath() + "/Staff/";
%>

<html>
<head>
    <title>Administration:Selena Gomez</title>
    <%@include file="Templates/commonImports.jsp"%>

    <script src="<%=root%>Scripts/manageStaff.js" type="text/javascript"></script>
    <script>
        $(document).ready(function(){
            showStaff('<%=root%>');

        });
    </script>
</head>
<body>
<%
    if ((session.getAttribute("username") == null) || (session.getAttribute("nic") == null)
            || ((Staff)session.getAttribute("staff")).getType().equals("supervisor") || ((Staff)session.getAttribute("staff")).getType().equals("accountant"))
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
        <li class="active"><a data-toggle="tab" href="#search_books">SEARCH STAFF</a></li>
        <li class=""><a data-toggle="tab" href="#addnew_book">ADD STAFF</a></li>
    </ul>
    <div class="tab-content">
        <!-- ##### ADD NEW STAFF ##############################################3-->
        <div id="addnew_book" class="addnewform tab-pane fade in
                     "><!-- is active panel must be active -->
            <form  method="POST" action="<%=request.getContextPath() + AD_PAGES.ADMIN_MANAGE_STAFF.toString()%>" >
                <input type="hidden" name="<%=AdminStaffManagement.FORM_TYPE%>" value="<%=AdminStaffManagement.FORM_TYPE_ADD_STAFF%>"/>

                <div class="form-group">
                    <label class="control-label">Name :</label><label class=" control-label ferror-message">${errorMessageName}</label>
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
                    <label class="control-label">NIC :</label><label class=" control-label ferror-message">${errorMessageNic}</label>
                    <input  type="text" class="form-control" name="nic">
                </div>
                <div class="form-group">
                    <label class="control-label">USERNAME :</label><label class=" control-label ferror-message">${errorMessageUname}</label>
                    <input  type="text" class="form-control" name="uname">
                </div>
                <div class="form-group">
                    <label class="control-label">PASSWORD :</label><label class=" control-label ferror-message">${errorMessagePW}</label>
                    <input  type="password" class="form-control" name="pw">
                </div>
                <div class="search-fieldlebel">
                    <label>TYPE</label><label class=" control-label ferror-message">${errorMessageType}</label>
                </div>
                <select  class="form-control"  name="type" id="type">
                    <option value="admin">Admin</option>
                    <option value="accountant">Accountant</option>
                    <option value="hr">HR</option>
                    <option value="supervisor">Supervisor</option>
                </select> <br/>

                <button type="reset" onmouseup="showNotification('form reseted')" class="btn btn-default">Reset</button>
                <button type="submit" class="btn btn-primary">Save</button>
            </form>
        </div>
        <!-- ##### SEARCH STAFF ##############################################3-->
        <div id="search_books" class="tab-pane fade in active">
            <div class="book-search-panel">
                <div class="search-fieldlebel">
                    <label>Search</label>
                </div>
                <div class="search-field">
                    <input id="txtSearch" onkeyup="showStaff('<%=root%>')" class="form-control" type="text" name="search_text">
                </div>
                <div class="search-bylebel">
                    <label>By</label>
                </div>
                <div class="search-by" style="   width: 40%;">
                    <select  class="form-control"  id="lstSearchBy">
                        <option selected="selected">Name</option>
                        <option>NIC</option>
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


