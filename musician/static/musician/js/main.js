/**
 * Created by bruce on 24/01/17.
 */
function showEditInfo(elemToHidden, elemToShow) {
    document.getElementById(elemToHidden).style.display = "none";
    document.getElementById(elemToShow).style.display = "inherit";
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
        var friendForm = $(this);
        // Send the data using post
        var posting = $.post( friendForm.attr('action'), friendForm.serialize() );
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
