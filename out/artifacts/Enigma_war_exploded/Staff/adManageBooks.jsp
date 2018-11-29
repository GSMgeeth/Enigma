<%@page import="Action.Staff.AdminBookManagement"%>
<%@page import="Common.Enum.AD_PAGES"%>
<%@ page import="Core.SqlConnection" %>
<%@ page import="java.sql.ResultSet" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<%
    //EVERY JSP PAGE MUST HAVE THIS SCRIPT
    Object o3 = request.getAttribute(AD_PAGES.PAGE);
    if (o3 == null) {
        response.sendRedirect(AD_PAGES.ADMIN_MANAGE_BOOK.toString());
    }
    //END:EVERY JSP PAGE MUST HAVE THIS SCRIPT
    String root = request.getContextPath() + "/Staff/";
%>
<html>
<head>
    <title>Administration:Selena Gomez</title>
    <%@include file="Templates/commonImports.jsp" %>
    <script src="<%=root%>Scripts/manageBooks.js" type="text/javascript"></script>
    <link href="<%=root%>Styles/manageBooks.css" rel="stylesheet" type="text/css"/>
    <script>
        $(document).ready(function () {
            showBooks('<%=root%>');
            showCategories('<%=root%>');
            hadleImageUploadforNew();
            hadleImageUploadforUpdate();
            <%
                Object o = request.getAttribute(AdminBookManagement.NOTIFICATION_VALUE);
                String value = o == null ? "" : (String) o;
                if (!value.isEmpty()) {
            %>
            /*
             * Info
             * success
             * warning
             * error
             **/
            iziToast.<%=request.getAttribute(AdminBookManagement.NOTIFICATION_TYPE).toString()%>({
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
    if ((session.getAttribute("username") == null) || (session.getAttribute("nic") == null)
            || ((Staff)session.getAttribute("staff")).getType().equals("hr") || ((Staff)session.getAttribute("staff")).getType().equals("accountant"))
    {
        out.print("Error! Please login!");
    }
    else
    {
%>
<!-- ##### Header ##############################################3-->
<%@include file="Templates/header.jsp" %>
<!-- ##### NAVIGATION ##############################################3-->
<%@include file="Templates/navigation.jsp" %>

<%
    Object o2 = request.getAttribute(AdminBookManagement.ACTIVE_PANEL);
    String active_panel;
    if (o2 == null) {
        active_panel = AdminBookManagement.PNL_SEARCH_BOOKS;
    } else {
        active_panel = o2.toString();
    }
%>
<div class="content">
    <ul class="nav nav-tabs mynavi">
        <li class="<%=(active_panel.equals(AdminBookManagement.PNL_SEARCH_BOOKS)) ? "active" : ""%>"><a data-toggle="tab" href="#search_books">SEARCH BOOKS</a></li>
        <li class="<%=(active_panel.equals(AdminBookManagement.PNL_ADD_NEW_BOOK)) ? "active" : ""%>"><a data-toggle="tab" href="#addnew_book">ADD BOOK</a></li>
        <li class="<%=(active_panel.equals(AdminBookManagement.PNL_VIEW_CATEGORIES)) ? "active" : ""%>"><a data-toggle="tab" href="#search_categories">VIEW CATEGORIES</a></li>
        <li class="<%=(active_panel.equals(AdminBookManagement.PNL_ADD_NEW_CATEGORY)) ? "active" : ""%>"><a data-toggle="tab" href="#addnew_category">ADD CATEGORY</a></li>
        <li class="<%=(active_panel.equals(AdminBookManagement.PNL_VIEW_BATCHES)) ? "active" : ""%>"><a data-toggle="tab" href="#search_batches">VIEW BATCHES</a></li>
        <li class="<%=(active_panel.equals(AdminBookManagement.PNL_ADD_NEW_BATCH)) ? "active" : ""%>"><a data-toggle="tab" href="#addnew_batch">ADD BATCH</a></li>
        <li class="<%=(active_panel.equals(AdminBookManagement.PNL_ISBN_ADDING)) ? "active" : ""%>"><a data-toggle="tab" href="#isbnAding">ADD ISBNs</a></li>
    </ul>
    <div class="tab-content">
        <!-- ##### ADD NEW BOOK ##############################################3-->
        <div id="addnew_book" class="addnewform tab-pane fade in
                     <%=(active_panel.equals(AdminBookManagement.PNL_ADD_NEW_BOOK)) ? "active" : ""%>
                     ">
            <form  method="POST" action="<%=request.getContextPath() + AD_PAGES.ADMIN_MANAGE_BOOK.toString()%>" enctype="multipart/form-data" >
                <input type="hidden" name="<%=AdminBookManagement.FORM_TYPE%>" value="<%=AdminBookManagement.FORM_TYPE_ADD_BOOK%>"/>

                <div class="form-group">
                    <label class="control-label">Name:</label><label class=" control-label ferror-message">${error_book_name}</label>
                    <input  type="text" class="form-control" name="BookName">
                </div>
                <div class="form-group">
                    <label class="control-label">Category:</label><label class="control-label ferror-message">${error_book_c}</label>
                    <select  required="" autocomplete=""  class="form-control chosen-select" name="category">
                        <%
                            try
                            {
                                ResultSet rs = SqlConnection.getData("SELECT cat_name FROM category");

                                while (rs.next())
                                {
                        %>
                        <option value='<%=rs.getString("cat_name")%>'><%=rs.getString("cat_name")%></option>
                        <%
                                }
                            }
                            catch (Exception e)
                            {
                                e.printStackTrace();
                            }
                        %>
                    </select>
                </div>

                <div class="form-group">
                    <label>Author:</label><label class="ferror-message">${error_book_author}</label>
                    <input required="" type="text" class="form-control" name="AuthorName">
                </div>
                <div class="form-group">
                    <label>Description:</label>
                    <textarea name="Description" class="form-control"></textarea>
                </div>
                <div class="form-group">
                    <label>Image</label>
                    <input id="imgload" required="" type="file" class="form-control" name="aFile">
                </div>
                <div class="form-group">
                    <img id="imgshow" width="145" height="209" src="Staff/Images/book-1.jpg" alt="book Image">
                </div>
                <button type="reset" onmouseup="showNotification('form reseted')" class="btn btn-default">Reset</button>
                <button type="submit" class="btn btn-primary">Save</button>

            </form>
        </div>
        <!-- ##### SEARCH BOOK ##############################################3-->
        <div id="search_books" class="tab-pane fade in
                     <%=(active_panel.equals(AdminBookManagement.PNL_SEARCH_BOOKS)) ? "active" : ""%>
                     ">
            <div class="book-search-panel">
                <div class="search-fieldlebel">
                    <label>Search</label>
                </div>
                <div class="search-field">
                    <input id="txtSearch" onkeyup="showBooks('<%=root%>')" class="form-control" type="text" name="search_text">
                </div>
                <div class="search-bylebel">
                    <label>By</label>
                </div>
                <div class="search-by">
                    <select  class="form-control"  id="lstSearchBy">
                        <option>Book ID</option>
                        <option selected="selected">Book Name</option>
                    </select>
                </div>
            </div>
            <div class="book-table" id="search-table">
                <table class="table table-striped ">

                </table>
            </div>
            <!-- ##### VIEW BOOK DETAILS ##############################################3-->
            <!-- Modal -->
            <div id="model-view-more" class="modal fade" role="dialog">
                <div class="modal-dialog">

                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title"><i class="fa fa-tv"></i> Book Details</h4>
                        </div>
                        <div id="book-view-more" class="modal-body view-body">
                            <!--Ajax load-->
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        </div>
                    </div>

                </div>
            </div>
            <!-- ##### UPDATE BOOK ##############################################3-->
            <!-- Modal -->
            <div id="model-edit-book" class="modal fade " role="dialog">
                <div class="modal-dialog" style="width:80%;">
                    <!-- Modal content-->

                    <div class="modal-content ">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title"><i class="fa fa-pencil-alt"></i> Update Book</h4>
                        </div>
                        <div id="book-edit-form">
                            <!-- Ajax load -->
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" onclick="showNotification('Canceled:Update book')" data-dismiss="modal"><i class="fa fa-arrow-circle-down"></i> Cancel</button>
                            <button type="button" class="btn btn-default" onclick="updateBook()"><i class="fa fa-upload"></i> Update</button>
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <!-- ##### SEARCH CATEGORIES ##############################################3-->
        <div id="search_categories" class="tab-pane fade in
                     <%=(active_panel.equals(AdminBookManagement.PNL_VIEW_CATEGORIES)) ? "active" : ""%>
                     ">
            <div class="book-search-panel">
                <div class="search-fieldlebel">
                    <label>Search</label>
                </div>
                <div class="search-field">
                    <input id="txtCategorySearch" onkeyup="showCategories('<%=root%>')" class="form-control" type="text" name="search_text">
                </div>
                <div class="search-bylebel">
                    <label>By</label>
                </div>
                <div class="search-by">
                    <select  class="form-control"  id="lstCategorySearchBy">
                        <option>ID</option>
                        <option selected="selected">Name</option>
                    </select>
                </div>
            </div>
            <div class="book-table" id="category-search-table">
                <table class="table table-striped ">

                </table>
            </div>

        </div>
        <!-- ##### ADD NEW CATEGORIES ##############################################3-->
        <div id="addnew_category" class="addnewform tab-pane fade in
                     <%=(active_panel.equals(AdminBookManagement.PNL_ADD_NEW_CATEGORY)) ? "active" : ""%>
                     ">
            <form method="POST" action="<%=request.getContextPath() + AD_PAGES.ADMIN_MANAGE_BOOK.toString()%>" enctype="multipart/form-data" >
                <input type="text" name="<%=AdminBookManagement.FORM_TYPE%>" value="<%=AdminBookManagement.FORM_TYPE_ADD_CATEGORY%>" hidden="">
                <div class="form-group">
                    <label>Name:</label><label class="ferror-message"></label>
                    <input required="" type="text" class="form-control" name="catName">
                </div>

                <button type="submit" class="btn btn-primary">Save</button>

            </form>
        </div>
        <!-- ##### SEARCH BATCHES ##############################################3-->
        <div id="search_batches" class="tab-pane fade in
                     <%=(active_panel.equals(AdminBookManagement.PNL_VIEW_BATCHES)) ? "active" : ""%>
                     ">
            <div class="book-search-panel">
                <div class="search-fieldlebel">
                    <label>Search</label>
                </div>
                <div class="search-field">
                    <input id="txtBatch"  onkeyup="showBatches('<%=root%>')" class="form-control" type="text" name="search_text">
                </div>
                <div class="search-bylebel">
                    <label>By</label>
                </div>
                <div class="search-by">
                    <select name="by" class="form-control"  id="lstSearchBatchBy">
                        <option selected="selected">Buying Price</option>
                        <option>Selling Price</option>
                    </select>
                </div>
            </div>
            <div id="allbatches" class="book-table">

            </div>
        </div>
        <!-- ##### ADD NEW BATCH ##############################################3-->
        <div id="addnew_batch" class="addnewform tab-pane fade in
                     <%=(active_panel.equals(AdminBookManagement.PNL_ADD_NEW_BATCH)) ? "active" : ""%>
                     ">
            <form method="POST" action="<%=request.getContextPath() + AD_PAGES.ADMIN_MANAGE_BOOK.toString()%>" enctype="multipart/form-data" >
                <input type="text" name="<%=AdminBookManagement.FORM_TYPE%>" value="<%= AdminBookManagement.FORM_TYPE_ADD_BATCH %>" hidden="">
                <div class="form-group">
                    <label>Buying Price:</label><label class="ferror-message">${errorbprice}</label>
                    <input required="" type="text" class="form-control" name="buying_price">
                </div>
                <div class="form-group">
                    <label>Selling Price:</label><label class="ferror-message">${errorsprice}</label>
                    <input required="" type="text" class="form-control" name="selling_price">
                </div>
                <button type="submit" class="btn btn-primary">Save</button>
            </form>
        </div>
        <!-- ##### ISBN ADING ##############################################3-->
        <div id="isbnAding" class="addnewform tab-pane fade in
                     <%=(active_panel.equals(AdminBookManagement.PNL_ISBN_ADDING)) ? "active" : ""%>
                     ">

            <form action="<%= AD_PAGES.ADMIN_MANAGE_BOOK%>" method="POST">
                <input type="text" name="<%=AdminBookManagement.FORM_TYPE%>" value="<%=AdminBookManagement.FORM_TYPE_ADD_ISBN%>" hidden="">

                <input type="hidden" id="bookId" name="bookId"/>
                <input type="hidden" id="grnId" name="grnId"/>
                <input type="hidden" id="grnCopyId" name="grnCopyId"/>
                <input type="hidden" id="toAdd" name="toAdd"/>

                <div class="form-group">
                    <label>Book name : </label><label class="ferror-message">${errorMessageBkName}</label>
                    <input class="form-control" type="text" disabled="disabled" name="bookName" id="bookName"/>

                </div>
                <div class="form-group">
                    <label> ISBN: </label><label class="ferror-message">${errorMessageIsbn}</label>
                    <input class="form-control" type="<text" name="isbn" id="isbn"/>

                </div>
                <div class="form-group">
                    <input class="btn btn-default" type="submit" value="Add"/>
                </div>


            </form>
            <div class="book-table">
                <table class="table table-striped table-hover" id="grnCopyTable">
                    <tr>
                        <th>Grn Copy ID</th>
                        <th>Grn ID</th>
                        <th>Book ID</th>
                        <th>Batch ID</th>
                        <th>Book Name</th>
                        <th>Quantity</th>
                        <th>To add</th>
                    </tr>
                    <%
                        try
                        {
                            ResultSet rs = SqlConnection.getData("SELECT * FROM grn_copy WHERE to_add!=0");

                            while (rs.next())
                            {
                    %>
                    <tr style="cursor: pointer;">
                        <%
                            out.print("<td>" + rs.getInt("grn_copy_id") + "</td>");
                            out.print("<td>" + rs.getInt("grn_id") + "</td>");
                            out.print("<td>" + rs.getInt("book_id") + "</td>");
                            out.print("<td>" + rs.getInt("batch_id") + "</td>");

                            ResultSet rsName = SqlConnection.getData("SELECT book_name FROM book WHERE book_id=" + rs.getInt("book_id"));

                            if (rsName.next()) {
                                out.print("<td>" + rsName.getString("book_name") + "</td>");
                            }

                            out.print("<td>" + rs.getInt("qty") + "</td>");
                            out.print("<td>" + rs.getInt("to_add") + "</td>");
                        %>
                    </tr>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    %>
                </table>
            </div>
            <script>

                var table = document.getElementById("grnCopyTable");

                for (var i = 1; i < table.rows.length; i++)
                {
                    table.rows[i].onclick = function ()
                    {
                        document.getElementById("grnCopyId").value = this.cells[0].innerHTML;
                        document.getElementById("grnId").value = this.cells[1].innerHTML;
                        document.getElementById("bookId").value = this.cells[2].innerHTML;
                        document.getElementById("bookName").value = this.cells[4].innerHTML;
                        document.getElementById("toAdd").value = this.cells[6].innerHTML;
                    };
                }

            </script>
        </div>
    </div>
</div>
<%
    }
%>
</body>
</html>

