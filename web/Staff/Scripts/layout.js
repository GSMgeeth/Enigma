$(document).ready(function () {
    setInterval(function () {
        var d = new Date();
        var year = d.getFullYear();
        var month = d.getMonth();
        var day = d.getDate();
        var h = d.getHours();
        var m = d.getMinutes();
        var s = d.getSeconds();
        if (s < 10) {
            s = "0" + s;
        }
        if (m < 10) {
            m = "0" + m;
        }
        var time = "<b>Date</b> " + year + "/" + month + "/" + day + " <b>Time</b> " + h + ":" + m + ":" + s;
        document.getElementById("time-and-date").innerHTML = time;
    }, 1000);

});

function showNotification(message){
    iziToast.success({

        position: 'bottomRight', // center, bottomRight, bottomLeft, topRight, topLeft, topCenter, bottomCenter
        title:message,
        message: '',
        theme: 'dark', // dark, light
        color: '#1e293d',
        progressBarColor: '#ff6600',
        transitionIn: 'bounceInUp', //bounceInLeft, bounceInRight, bounceInUp, bounceInDown, fadeIn, fadeInDown, fadeInUp, fadeInLeft, fadeInRight or flipInX.
        transitionOut: 'fadeOutUp'// fadeOut, fadeOutUp, fadeOutDown, fadeOutLeft, fadeOutRight, flipOutX

    });
}

