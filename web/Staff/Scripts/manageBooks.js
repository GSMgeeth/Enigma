function showBookDetailsDialog(path, bookid) {
    //ajax code load the model
    $.get(path + "Ajax/getbookforviewmore.jsp",
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

function updateBook() {
    id = $("#ed_id").val();
    var name = $("#ed_name").val();
    author = $("#ed-author").val();
    description = $("#ed-description").val();
    category = $("#ed-category").val();
    var bookImage=$("#imgload2").val();
    $.post("/BookUpdating", {
            id: id,
            name: name,
            author: author,
            description: description,
            category: category,
            rtype: "rtypeupdate",
            bookImage:bookImage
        },
        function (data, status) {
            $("#book-edit-form").html(data);
            showNotification($("#batchUpdateStatus").val());
            //hide model
            $("#model-edit-book").modal("hide");
        }
    );
}

function fillEditBookData(bookid) {
    //ajax code load the model
    $.post("/BookUpdating",
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

function showBookEditDialog(bookid) {
    //ajax code for the genarate edit dialog

    //show model
    $('#model-edit-book').modal('show');
}

function loadDataForEditBook(bookid) {
    //ajax code for load data
}

function showBooks(path) {
    //get values from user
    var by = $("#lstSearchBy").val();
    var value = $("#txtSearch").val();
    //send values to getbook.js for geting data
    $.get(path + "Ajax/getbooks.jsp",
        {
            by: by,
            value: value
        },
        function (data, status) {
            //set resaved data to table
            $("#search-table").html(data);
        });
}

function showBatches(path){
    //get values from user
    var by = $("#lstSearchBatchBy").val();
    var value = $("#txtBatch").val();
    //send values to getbook.js for getting data
    $.get(path + "Ajax/getBatches.jsp",
        {
            by: by,
            value: value
        },
        function (data, status) {
            //set resaved data to table
            $("#allbatches").html(data);
        });
}

function showCategories(path) {
    //get values from user
    var by = $("#lstCategorySearchBy").val();
    var value = $("#txtCategorySearch").val();
    //send values to getbook.js for getting data
    $.get(path + "Ajax/getCategories.jsp",
        {
            by: by,
            value: value
        },
        function (data, status) {
            //set resaved data to table
            $("#category-search-table").html(data);
        });


}

function hadleImageUploadforNew() {
    $("#imgload").change(function () {
        if (this.files && this.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                $('#imgshow').attr('src', e.target.result);
            }
            reader.readAsDataURL(this.files[0]);
        }
    });
}


function hadleImageUploadforUpdate() {
    $("#imgload2").change(function () {
        if (this.files && this.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                $('#imgshow2').attr('src', e.target.result);
            }
            reader.readAsDataURL(this.files[0]);
        }
    });
}