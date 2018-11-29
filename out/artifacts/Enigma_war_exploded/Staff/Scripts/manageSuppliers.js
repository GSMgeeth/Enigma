function showSupplierDetailsDialog(path, bookid) {
    //ajax code load the model
    $.get(path + "ajx/getbookforviewmore.jsp",
        {
            id: bookid
        },
        function (data, status) {
            //set resaved data to table
            $("#book-view-more").html(data);
        });

    //show model
    $('#model-view-more').modal('show');

}

function updateSupplier() {
    id = $("#ed_id").val();
    var name = $("#ed_name").val();
    author = $("#ed-author").val();
    description = $("#ed-description").val();
    category = $("#ed-category").val();
    $.post("updatebook", {
            id: id,
            name: name,
            author: author,
            description: description,
            category: category,
            rtype: "rtypeupdate"

        },
        function (data, status) {
            $("#book-edit-form").html(data);
            showNotification($("#batchUpdateStatus").val());
            //hide model
            $("#model-edit-book").modal("hide");

        }
    );
}

function fillEditSupplierData(bookid) {
    //ajax code load the model
    $.post("updatebook",
        {
            id: bookid,
            rtype: "rtypefill"
        },
        function (data, status) {
            //set resaved data to table
            $("#book-edit-form").html(data);
        });
    //show model
    $('#model-edit-book').modal('show');
}

function showSupplierEditDialog(bookid) {
    //ajax code for the genarate edit dialog

    //show model
    $('#model-edit-book').modal('show');
}

function loadDataForEditSupplier(bookid) {
    //ajax code for load data
}

function showSuppliers(path) {
    //get values from user
    var by = $("#lstSearchBy").val();
    var value = $("#txtSearch").val();
    //send values to getSuppliers.jsp for geting data
    $.get(path + "Ajax/getSuppliers.jsp",
        {
            by: by,
            value: value
        },
        function (data, status) {
            //set resaved data to table
            $("#search-table").html(data);
        });
}


