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