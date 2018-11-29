function showCustomers(path) {
    //get values from user
    var by = $("#lstSearchBy").val();
    var value = $("#txtSearch").val();
    //send values to getCustomers.jsp for getting data
    $.get(path + "Ajax/getCustomers.jsp",
        {
            by: by,
            value: value
        },
        function (data, status) {
            //set reserved data to table
            $("#search-table").html(data);
        });
}


