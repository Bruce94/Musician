/**
 * Created by bruce on 24/01/17.
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
    $(".message_form").submit(function(event) {
        // Stop form from submitting normally
        event.preventDefault();
        var messageForm = $(this);
        // Send the data using post
        var posting = $.post( messageForm.attr('action'), messageForm.serialize() );
        // if success:
        posting.done(function(data) {
            location.reload();
        });
        // if failure:
        posting.fail(function(data) {
            // 4xx or 5xx response, alert user about failure
        });
    });

});
