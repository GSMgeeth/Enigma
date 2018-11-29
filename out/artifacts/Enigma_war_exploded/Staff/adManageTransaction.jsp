<%@ page import="Action.Staff.AdminTransactionManagement" %>
<%@ page import="Core.SqlConnection" %>
<%@ page import="java.sql.ResultSet" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<%
    String root=request.getContextPath()+"/Staff/";
%>

<html>
<head>
    <title>Administration:Selena Gomez</title>
    <%@include file="Templates/commonImports.jsp" %>
    <script src="<%=root%>Scripts/manageBooks.js" type="text/javascript"></script>
    <link href="<%=root%>Styles/manageBooks.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript">
        function addGrnRow()
        {
            var bookName = document.getElementById("bookName").value;
            var batch = document.getElementById("batch").value;
            var qty = document.getElementById("qty").value;

            if (!isNaN(qty))
            {
                qty = parseInt(qty);
            }
            else
            {
                alert("Quantity must be a number!");
                return 1;
            }

            var table = document.getElementById("grnTable");
            var newRow = table.insertRow();

            var cell1 = newRow.insertCell(0);
            var cell2 = newRow.insertCell(1);
            var cell3 = newRow.insertCell(2);
            var cell4 = newRow.insertCell(3);

            cell1.innerHTML = bookName;
            cell2.innerHTML = batch;
            cell3.innerHTML = qty;
            cell4.innerHTML = qty * parseFloat(batch.substring(0, batch.indexOf("-")));

            var tmpBkName = document.getElementById("bkName").value;
            document.getElementById("bkName").value = bookName + "," + tmpBkName;

            var tmpBatch = document.getElementById("bkBatch").value;
            document.getElementById("bkBatch").value = batch + "," + tmpBatch;

            var tmpQty = document.getElementById("bkQty").value;
            document.getElementById("bkQty").value = qty + "," + tmpQty;

            var sum = 0.0;

            for (var i = 1; i < table.rows.length; i++)
            {
                sum = sum + parseFloat(table.rows[i].cells[3].innerHTML);
            }

            var dis = document.getElementById("discount").value;

            if (!isNaN(dis))
            {
                dis = parseFloat(dis);
            }
            else
            {
                alert("Discount must be a number!");
                return 1;
            }

            document.getElementById("netPayment").innerText = sum;
            document.getElementById("grossPayment").innerText = sum - (sum * dis) / 100;
        }
    </script>
    <script>
        $(document).ready(function () {
            <%
                Object o = request.getAttribute(AdminTransactionManagement.NOTIFICATION_VALUE);
                String value = o == null ? "" : (String) o;
                if (!value.isEmpty()) {
            %>
            /*
             * Info
             * success
             * warning
             * error
             **/
            iziToast.<%=request.getAttribute(AdminTransactionManagement.NOTIFICATION_TYPE).toString()%>({
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
            || ((Staff)session.getAttribute("staff")).getType().equals("hr"))
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
    Object o2 = request.getAttribute(AdminTransactionManagement.ACTIVE_PANEL);
    String active_panel;
    if (o2 == null) {
        active_panel = AdminTransactionManagement.PNL_ORDER_ADDING;
    } else {
        active_panel = o2.toString();
    }
%>
<div class="content">
    <ul class="nav nav-tabs mynavi">
        <li class="<%=(active_panel.equals(AdminTransactionManagement.PNL_ORDER_ADDING)) ? "active" : ""%>"><a data-toggle="tab" href="#isbnAding">Orders</a></li>
        <li class="<%=(active_panel.equals(AdminTransactionManagement.PNL_GRN_ADDING)) ? "active" : ""%>"><a data-toggle="tab" href="#grnAdding">GRNs</a></li>
    </ul>
    <div class="tab-content">
        <!-- ##### ORDERS ##############################################3-->
        <div id="isbnAding" class="addnewform tab-pane fade in
                     <%=(active_panel.equals(AdminTransactionManagement.PNL_ORDER_ADDING)) ? "active" : ""%>
                     ">
            <form action="<%= AD_PAGES.ADMIN_MANAGE_TRANSACTION%>" method="POST">
                <input type="text" name="<%=AdminTransactionManagement.FORM_TYPE%>" value="<%=AdminTransactionManagement.FORM_TYPE_ADD_ORDER%>" hidden="">

                <input type="hidden" id="isbn" name="isbn"/>
                <input type="hidden" id="inv_id" name="inv_id"/>

                <div class="form-group">
                    <label>ISBN : </label><label class="ferror-message"></label>
                    <input class="form-control" type="text" disabled="disabled" name="isbn" id="bookIsbn"/>
                </div>

                <div class="form-group">
                    <input class="btn btn-default" type="submit" value="Packed"/>
                </div>
            </form>

            <div class="book-table">
                <table class="table table-striped table-hover" id="OrderTable">
                    <tr>
                        <th>Inv_ID</th>
                        <th>Cus_Name</th>
                        <th>Address</th>
                        <th>Date</th>
                        <th>ISBN</th>
                    </tr>
                    <%
                        try
                        {
                            ResultSet rs = SqlConnection.getData("SELECT * FROM orders;");

                            while (rs.next())
                            {
                    %>
                    <tr style="cursor: pointer;">
                        <%
                            out.print("<td>" + rs.getInt("inv_id") + "</td>");
                            out.print("<td>" + rs.getString("name") + "</td>");
                            out.print("<td>" + rs.getString("address") + "</td>");
                            out.print("<td>" + rs.getString("date") + "</td>");
                            out.print("<td>" + rs.getString("ISBN") + "</td>");
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
                var table = document.getElementById("OrderTable");

                for (var i = 1; i < table.rows.length; i++)
                {
                    table.rows[i].onclick = function ()
                    {
                        document.getElementById("inv_id").value = this.cells[0].innerHTML;
                        document.getElementById("isbn").value = this.cells[4].innerHTML;
                        document.getElementById("bookIsbn").value = this.cells[4].innerHTML;
                    };
                }
            </script>
        </div>

        <!-- ##### GRN ##############################################3-->
        <div id="grnAdding" class="addnewform tab-pane fade in
                     <%=(active_panel.equals(AdminTransactionManagement.PNL_GRN_ADDING)) ? "active" : ""%> ">

            <div class="search-fieldlebel">
                <label>Name</label>
            </div>
            <select  class="form-control"  name="bookName" id="bookName">
                <%
                    try
                    {
                        ResultSet rs = SqlConnection.getData("SELECT book_name FROM book");

                        while (rs.next())
                        {
                %>
                <option value="<%=rs.getString("book_name")%>"><%=rs.getString("book_name")%></option>
                <%
                        }
                    }
                    catch (Exception e)
                    {
                        e.printStackTrace();
                    }
                %>
            </select>

            <div class="search-fieldlebel">
                <label>Batch</label>
            </div>
            <select  class="form-control"  name="batch" id="batch">
            <%
                try
                {
                    ResultSet rs = SqlConnection.getData("SELECT * FROM batch");

                    while (rs.next())
                    {
            %>
            <option value='<%= "" + rs.getFloat("buying_price") + "-" + rs.getFloat("selling_price")%>'><%= "" + rs.getFloat("buying_price") + "-" + rs.getFloat("selling_price")%></option>
            <%
                    }
                }
                catch (Exception e)
                {
                    e.printStackTrace();
                }
            %>
            </select>

            <div class="form-group">
                <label class="control-label">Quantity :</label>
                <input  type="text" class="form-control" name="qty" id="qty">
            </div>

            <div class="form-group">
                <button class="btn btn-default" type="button" onclick="addGrnRow();">Add to Cart</button>
            </div>

            <div class="book-table">
                <table class="table table-striped table-hover" id="grnTable">
                    <tr>
                        <th>Name</th>
                        <th>Batch ID</th>
                        <th>Quantity</th>
                        <th>Total</th>
                    </tr>
                </table>
            </div>

            <form action="<%= AD_PAGES.ADMIN_MANAGE_TRANSACTION%>" method="POST">

                <div class="form-group">
                    <label class="control-label">Net Payment :</label>
                    <label id="netPayment"></label>
                </div>

                <div class="form-group">
                    <label class="control-label">Discount :</label>
                    <input  type="text" class="form-control" name="discount" id="discount">
                </div>

                <div class="form-group">
                    <label class="control-label">Gross Payment :</label>
                    <label id="grossPayment"></label>
                </div>

                <div class="search-fieldlebel">
                    <label>Supplier</label>
                </div>
                <select  class="form-control"  name="supp" id="supp">
                    <%
                        try
                        {
                            ResultSet rs = SqlConnection.getData("SELECT company FROM supplier");

                            while (rs.next())
                            {
                    %>
                    <option value="<%=rs.getString("company")%>"><%=rs.getString("company")%></option>
                    <%
                            }
                        }
                        catch (Exception e)
                        {
                            e.printStackTrace();
                        }
                    %>
                </select>

                <div class="form-group">
                    <label class="control-label">Vehicle No :</label>
                    <input  type="text" class="form-control" name="veh" id="veh">
                </div>

                <p style="color: red;">${errorMessage}</p>

                <p style="color: green;">${successful}</p> <br/>

                <input type="text" name="<%=AdminTransactionManagement.FORM_TYPE%>" value="<%=AdminTransactionManagement.FORM_TYPE_ADD_GRN%>" hidden="">

                <div class="form-group">
                    <input class="btn btn-default" type="submit" value="Add GRN"/>
                </div>

                <input type="hidden" name="bkName" id="bkName">
                <input type="hidden" name="bkBatch" id="bkBatch">
                <input type="hidden" name="bkQty" id="bkQty">
            </form>
        </div>
    </div>
</div>
<%
    }
%>
</body>
</html>

