/**
 * Created by bruce on 23/03/19.
 */
function showEditInfo(elemToHidden, elemToShow) {
    document.getElementById(elemToHidden).style.display = "none";
    document.getElementById(elemToShow).style.display = "inherit";
}

function showCommentArea(elemToShow){
    if(document.getElementById(elemToShow).style.display == "inherit"){
        document.getElementById(elemToShow).style.display = "none"
    }
    else{
        document.getElementById(elemToShow).style.display = "inherit";
    }
}

jQuery(function ($) {
    $('.datepick').each(function() {
        $(this).datepicker({dateFormat: 'yy-mm-dd'}).datepicker("option", {
            changeMonth: true,
            changeYear: true,
            yearRange: '1950:'+(new Date).getFullYear()
        });
    });

});



$(function() {
    $("#message_form").submit(function(event) {
        // Stop form from submitting normally
        event.preventDefault();

        $.ajax({
            url:$(this).attr('action'),
            type:'POST',
            data: {message: $('#chat-msg').val()},
            success: function (data) {
                var url = $("#message_form").attr('action');
                url_elem = url.split("/");
                var mess = [];
                mess.push(''+data.usr_id+'');
                for(var i = 0; i < url_elem.length; i++) {
                    if (!isNaN(url_elem[i]) && url_elem[i] != '') {
                        mess.push(url_elem[i]);
                    }
                }
                $('#chat-msg').val('');
                var chatlist = document.getElementById('messages_container');
                chatlist.scrollTop = chatlist.scrollHeight;
                socket.emit('message sent', mess);
            }
        });
    });

    $(document).ready(function() {
        $('#send').attr('disabled','disabled');
        $('#chat-msg').keyup(function() {
            if($(this).val() != '') {
                $('#send').removeAttr('disabled');
            }
            else {
                $('#send').attr('disabled','disabled');
            }
        });
    });

    // using jQuery
    function getCookie(name) {
        var cookieValue = null;
        if (document.cookie && document.cookie != '') {
            var cookies = document.cookie.split(';');
            for (var i = 0; i < cookies.length; i++) {
                var cookie = jQuery.trim(cookies[i]);
                // Does this cookie string begin with the name we want?
                if (cookie.substring(0, name.length + 1) == (name + '=')) {
                    cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                    break;
                }
            }
        }
        return cookieValue;
    }

    var csrftoken = getCookie('csrftoken');

    function csrfSafeMethod(method) {
        // these HTTP methods do not require CSRF protection
        return (/^(GET|HEAD|OPTIONS|TRACE)$/.test(method));
    }

    $.ajaxSetup({
        beforeSend: function(xhr, settings) {
            if (!csrfSafeMethod(settings.type) && !this.crossDomain) {
                xhr.setRequestHeader("X-CSRFToken", csrftoken);
            }
        }
    });


});


function refMessages(usr){
    //if (!scrolling) {
    $.ajax({
        type: "GET",
        url: "/musician/messages/"+usr+"/get/",
        async: true,
        cache: false,
        timeout: 50000,
        dataType: 'json',
        success: function (data) {

            var elem = $.parseJSON(data);
            var messages = elem.messages;
            var dati = "";
            for (i=0; i < messages.length; i++){
                if (messages[i].sender == usr){
                    dati += "<div class=\"recived_message\">";
                    dati += messages[i].text;
                    dati += "<p class=\"recived_message_data\">";
                    dati += messages[i].data_request;
                    dati += "</p>";
                    dati += "</div>";
                }
                else{
                    dati += "<div class=\"sent_message\">";
                    dati += messages[i].text;
                    dati += "<p class=\"sent_message_data\">";
                    dati += messages[i].data_request;
                    dati += "</p>";
                    dati += "</div>";
                }

            }
            document.getElementById("messages_container").innerHTML = dati;
            var chatlist = document.getElementById('messages_container');
            chatlist.scrollTop = chatlist.scrollHeight;
            scrolling = false;
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
        },
    });
    //}
    //scrolling = false;
};

var scrolling = false;

function refNewMessages(usr){
    $.ajax({
        type: "GET",
        url: "/musician/messages/get_newmsg/",
        async: true,
        cache: false,
        timeout: 50000,
        dataType: 'json',
        success: function (data) {
            var elem = $.parseJSON(data);
            var nm_users = elem.nm_users;
            if (nm_users.length > 0) {
                var dati = "<h4 class=\"title-users-message\">New Messages</h4>";
                for (i = 0; i < nm_users.length; i++) {
                    dati += "<a href=\"/musician/messages/" + nm_users[i].id + "\" class=\"list-group-item \">";
                    dati += "<img class=\"search-musician\" src=\"" + nm_users[i].img_url + "\" alt = \"" + nm_users[i].username + "\"/>";
                    dati += "<h3 class=\"list-group-item-heading\">" + nm_users[i].last_name + " " + nm_users[i].first_name + "</h3>";
                    dati += "<p  class=\"list-group-item-text\">Username: " + nm_users.username + "</p>";
                    dati += "</a>";
                }
                document.getElementById("new_user_messages").innerHTML = dati;
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
        },

    });
};

function checkMsgNotif(){
    $.ajax({
        type: "GET",
        url: "/musician/messages/get_num_new_msg/",
        async: true,
        cache: false,
        timeout: 50000,
        dataType: 'json',
        success: function (data) {
            var elem = $.parseJSON(data);
            var n_mes = elem.n_mes;
            if (n_mes> 0) {
                document.getElementById("num_msg").innerHTML = n_mes;
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
        },

    });
};

function checkFrienshipNotif(){
    $.ajax({
        type: "GET",
        url: "/musician/get_fs_request/",
        async: true,
        cache: false,
        timeout: 50000,
        dataType: 'json',
        success: function (data) {
            var elem = $.parseJSON(data);
            var n_fs = elem.n_fs;
            if (n_fs> 0) {
                document.getElementById("num_fs").innerHTML = n_fs;
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
        },

    });
};


function send_friendship_request(data){
    socket.emit('friendship request', data);
}