<%@page import="java.sql.ResultSet"%>
<%@page import="Core.SqlConnection"%>

<script>
    $(document).ready(function () {
        hadleImageUploadforUpdate();
    });
</script>

<!-- need attribute id and message to load this page -->
<%
    Object o = request.getAttribute("id");

    if (o != null)
    {
%>
<%
    try
    {
        ResultSet rs = SqlConnection.getData("SELECT * FROM book WHERE book_id=" + request.getAttribute("id"));

        while (rs.next())
        {
%>
<div class="modal-body update-model-body">
    <div class="update-form-part-1">
        <div>
            <input id="imgload2" required="" onchange="hadleImageUploadforUpdate();" type="file" name="bookImage"  hidden="hidden" style="display: none;">
            <img id="imgshow2" src="bookImages/<%=rs.getString("book_name")%>.jpg" width="150" height="200" alt="book image"><br>
            <button onclick="$('#imgload2').click();" class="btn btn-primary">Open an Image</button>
        </div>
    </div>
    <div class="update-form-part-2">
        <div class="form-group">
            <label  class="control-label">Name:</label><label class=" control-label ferror-message">${e_name}</label>
            <input id="ed_id"  type="text" class="form-control" name="id" hidden="" value="<%=rs.getInt("book_id")%>" style="display: none">
            <input id="ed_name" type="text" class="form-control" name="name" value="<%=rs.getString("book_name")%>">
        </div>
        <div class="form-group">
            <label class="control-label">Category:</label><label class="control-label ferror-message">${e_category}</label>
            <select id="ed-category"  required="" autocomplete=""  class="form-control chosen-select" name="category">
                <%
                    ResultSet rsCat = SqlConnection.getData("SELECT * FROM category;");

                    while(rsCat.next())
                    {
                %>
                <option value="<%=rsCat.getString("cat_name")%>" <%if(rsCat.getInt("cat_id") == rs.getInt("cat_id")){%>selected="selected"<%}%>><%=rsCat.getString("cat_name")%></option>
                <%
                    }
                %>
            </select>
        </div>
        <div class="form-group">
            <label>Author:</label><label class="ferror-message">${e_author}</label>
            <input id="ed-author" required="" type="text" class="form-control" name="author" value="<%=rs.getString("author_name")%>">
        </div>
        <div class="form-group">
            <label>Description:</label>
            <textarea id="ed-description" name="description" class="form-control"><%=rs.getString("description")%></textarea>
        </div>
    </div>
</div>

<%
    if ((request.getAttribute("message") != null) &&(!request.getAttribute("message").toString().isEmpty()))
    {
%>
        <input style="display: none" id="batchUpdateStatus" value="${message}">
<%
    }
%>
<%
        }
    }
    catch (Exception e)
    {
        e.printStackTrace();
    }
%>
<%
}
else
{
%>
something went wrong in your request
<%
    }
%>





