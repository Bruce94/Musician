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
            url: $(this).attr('action'),
            type: 'POST',
            data: {message: $('#chat-msg').val()},
            success: function (data) {
                var url = $("#message_form").attr('action');
                url_elem = url.split("/");
                var mess = [];
                mess.push('' + data.usr_id + '');
                for (var i = 0; i < url_elem.length; i++) {
                    if (!isNaN(url_elem[i]) && url_elem[i] != '') {
                        mess.push(url_elem[i]);
                    }
                }
                mess.push($('#chat-msg').val());
                mess.push(data.sender);
                mess.push(data.icon);
                $('#chat-msg').val('');
                var chatlist = document.getElementById('messages_container');
                chatlist.scrollTop = chatlist.scrollHeight;
                socket.emit('message sent', mess);
            }
        });
    });

    $("#post_form").submit(function (event) {
        // Stop form from submitting normally
        event.preventDefault();
        var formData = new FormData();
        formData.append('message', $('#newpost').val());
        formData.append('image', $('#real_file')[0].files[0]);
        $.ajax({
            url: $(this).attr('action'),
            type: 'POST',
            data: formData,
            processData: false,  // tell jQuery not to process the data
            contentType: false,  // tell jQuery not to set contentType
            success: function (data) {
                var url = $("#post_form").attr('action');
                url_elem = url.split("/");
                console.log(url);
                var mess = [];
                mess.push('' + data.usr_id + '');
                for (var i = 0; i < url_elem.length; i++) {
                    mess.push(url_elem[i]);
                }
                $('#newpost').val('');
                document.getElementById('image_selected').style.display = "none";
                $('#share').attr('disabled', 'disabled');
                socket.emit('post sent', mess);
            }
        });
    });

    $(document).ready(function () {
        $('#send').attr('disabled', 'disabled');
        $('#chat-msg').keyup(function () {
            if ($(this).val() != '') {
                $('#send').removeAttr('disabled');
            } else {
                $('#send').attr('disabled', 'disabled');
            }
        });

        cercaTag();
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

function cercaTag (){
        var label = document.getElementsByClassName("enteredText");

        for (var j = 0; j < label.length; j++) {
            var href = label[j].innerHTML;

            var tfinale = "";

            if (href.match(/#[a-z,A-Z]+/)) {
                var parole = href.split(/[\s,]+/);
                for (var i = 0; i < parole.length; i++) {
                    if (parole[i].startsWith("#") && parole[i].match(/^(?!(#.*#))/)) {
                        var p = parole[i].match(/#.+$/);
                        parole[i] = parole[i].slice(1, parole[i].length);
                        tfinale += "<a href='/portal/tag/" + parole[i] + "/'>#" + parole[i] + "</a>";
                    } else
                        tfinale += parole[i];

                    if (i != parole.length - 1)
                        tfinale += " ";

                }
                label[j].innerHTML = tfinale;
            } else
                label[j].innerHTML = href;
        }
}

function refPosts(usr_id){

    var token = $('#token').attr('value');
    $.ajax({
        type: "GET",
        url: "/portal/new_post/get/",
        async: true,
        cache: false,
        timeout: 50000,
        dataType: 'json',
        success: function (data) {

            var elem = $.parseJSON(data);
            var home_posts = elem.home_posts;
            var dati = "";

            dati += `<div class="row">
                <div class="col-sm-12">
                    <div class="well text-left col-sm-12">
                        <div class="col-sm-12">
                            <div class="col-sm-2">
                                 <img src=" ${home_posts.user_image_url}"
                                     class="img-circle align-right" height="60" width="60" alt="Musician_image">
                            </div><div class="col-sm-9">
                                <a href="/musician/${home_posts.user_post_id}"
                                   style="font-size: 20px;">${home_posts.user_firstname} ${home_posts.user_lastname}</a>
                                <p style="font-size: 13px;">${home_posts.pub_date}</p>
                            </div>`;
            if (home_posts.user_post_id == usr_id){

                dati += `<div class="col-sm-1">

                                <form action="/portal/" method="post" id="message_form" autocomplete="off">
                                  ${token} 
                                        <button type="button" class="btn btn-default dropdown-toggle"
                                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            <span class="glyphicon glyphicon-chevron-down"></span>
                                        </button>
                                        <ul class="dropdown-menu">
                                            <li>
                                                <input type="submit" class="list-options" name="del_${home_posts.post_id}"
                                                       value="Delete Post">
                                            </li>
                                        </ul>
                                </form>
                         </div>`;
                }

                dati += `</div>
                         <div class="col-sm-12 text-left">
                            <p class="enteredText" style="font-size: 25px;">${home_posts.text}</p>`;
                if (home_posts.img_url){
                    dati += `<img src="${home_posts.img_url}" class="img-thumbnail" id="image_selected" >`;
                }
                dati +=`</div>
                        <div class="col-sm-12 text-left" style="margin-bottom: 20px;">
                            <i id="polliceSu${home_posts.post_id}" class="fa fa-thumbs-o-up" style="font-size:28px;color:gray" onclick="likedPost(${home_posts.user_post_id}, ${usr_id}, ${home_posts.post_id}, 1);" title="Like"></i>
                            <span id="nlikes${home_posts.post_id}" class="badge" data-toggle="modal" >${home_posts.post_n_like}</span>
                            <i id="polliceGiu${home_posts.post_id}" class="fa fa-thumbs-o-down" style="font-size:28px;color:gray" onclick="likedPost(${home_posts.user_post_id}, ${usr_id}, ${home_posts.post_id}, 2);" title="Dislike"></i>
                            <span id="ndislikes${home_posts.post_id}" class="badge" data-toggle="modal" >${home_posts.post_n_dislike}</span>`;

                dati += `<button type="button" class="btn btn-default btn-sm"
                                    onclick="showCommentArea('comment_div_${home_posts.post_id}')">
                                <span class="glyphicon glyphicon-comment" ></span> Comment
                            </button>
                        </div>
                        <div class="panel-footer col-sm-12 text-left" hidden="true" id="comment_div_${home_posts.post_id}">
                            <div class="col-sm-12" style="margin-bottom: 20px">
                        </div>
                            <form form action="/portal/" method="post" class="message_form" autocomplete="off">
                                  ${token} 
                                <div class="col-sm-1">
                                     <img src="${home_posts.request_user_img_url}"
                                         class="img-circle align-right" height="35" width="35" alt="Musician_image">
                                </div>
                                <div class="col-sm-11">
                                     <input type="text" class="form-control"  name="comment_${home_posts.post_id}">
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>`;

            dati += document.getElementById("posts_container").innerHTML;
            document.getElementById("posts_container").innerHTML = dati;
            var postlist = document.getElementById('posts_container');
            postlist.scrollTop = postlist.scrollHeight;
            scrolling = false;
            cercaTag();
        },
        //complete: function(data){cercaTag()},
        error: function (XMLHttpRequest, textStatus, errorThrown) {
        },
    });
}

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
}

var scrolling = false;

function refNewMessages(){
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
}

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
}

function checkNotif(){ // checkVoteNotif
    $.ajax({
        type: "GET",
        url: "/musician/messages/get_num_notif/", //get_num_votes/",
        async: true,
        cache: false,
        timeout: 50000,
        dataType: 'json',
        success: function (data) {
            var elem = $.parseJSON(data);
            var n_notifiche = parseInt(elem.n_comm) + parseInt(elem.n_votes);
            if (n_notifiche > 0)
                document.getElementById("countNotifications").innerHTML = n_notifiche;

        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
        },

    });
}

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
}

function send_friendship_request(data){
    socket.emit('friendship request', data);
}

function spawnNotification(body,icon,title) {
    Notification.requestPermission().then(function(result) {
        if (result === 'denied') {
            console.log('Permission wasn\'t granted. Allow a retry.');
            return;
        }
        if (result === 'default') {
            console.log('The permission request was dismissed.');
            return;
        }
    });
    var options = {
      body: body,
      icon: icon
    }
    var n = new Notification(title,options);
    n.image;
}

function likedPost(user_post_id, user_id, post_id, vote){
    $.ajax({
        type: "GET",
        url: "/portal/like/"+vote+"/"+post_id+"/get/",
        async: true,
        cache: false,
        timeout: 50000,
        dataType: 'json',
        success: function (data) {
            var elem = $.parseJSON(data);
            var actual_vote = elem.actual_vote;

            if(actual_vote == 1){
                document.getElementById("polliceSu".concat(post_id)).style.color="blue";
                document.getElementById("polliceGiu".concat(post_id)).style.color="gray";
            }
            if(actual_vote == 2) {
                document.getElementById("polliceSu".concat(post_id)).style.color = "gray";
                document.getElementById("polliceGiu".concat(post_id)).style.color = "red";
            }
            if(actual_vote == 0) {
                document.getElementById("polliceSu".concat(post_id)).style.color = "gray";
                document.getElementById("polliceGiu".concat(post_id)).style.color = "gray";
            }

            document.getElementById("nlikes".concat(post_id)).textContent = elem.nlike;
            document.getElementById("ndislikes".concat(post_id)).textContent = elem.ndislike;

            var mess = [];
            mess.push('' + user_post_id + '');
            socket.emit("new general notification",mess);
            },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
        },
    });
}