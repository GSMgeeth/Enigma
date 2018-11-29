function showBooks(path) {
    //get values from user
    var by = $("#lstSearchBy").val();
    var value = $("#txtSearch").val();
    //send values to getBook.js for getting data
    $.get(path + "Ajax/getBooks.jsp",
        {
            by: by,
            value: value
        },
        function (data, status) {
            //set reserved data to table
            $("#search-table").html(data);
        });
}

function showBooksByCat(path, cat) {
    //get values from user
    //send values to getBooksByCategory.jsp to get data
    $.get(path + "Ajax/getBooksByCategory.jsp",
        {
            cat: cat
        },
        function (data, status) {
            //set reserved data to table
            $("#search-table").html(data);
        });
}
