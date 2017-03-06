/**
 * Created by bruce on 24/01/17.
 */
function showEditInfo(elemToHidden, elemToShow) {
    document.getElementById(elemToHidden).style.display = "none";
    document.getElementById(elemToShow).style.display = "inherit";
}

var stile = "top=10, left=10, width=250, height=200, status=no, menubar=no, toolbar=no scrollbars=no";

function Popup(apri)
{
  window.open(apri, "", stile);
}

jQuery(function ($) {
    $('.datepick').each(function() {
        $(this).datepicker({dateFormat: 'yy-mm-dd'}).datepicker("option", {
				changeMonth: true,
				changeYear: true
        });
    });

});

$(function() {
    $("#message_form").submit(function(event) {
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
