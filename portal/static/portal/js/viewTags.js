$(document).ready(cercaTag());

function cercaTag (){
    //$("#posts_container").on('change', function() {
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
                        //tfinale += "<a href='/portal/tag/" +p[0]+"/'>" +p[0]+ "</a>";
                    } else
                        tfinale += parole[i];

                    if (i != parole.length - 1)
                        tfinale += " ";

                }
                label[j].innerHTML = tfinale;
            } else
                label[j].innerHTML = href;
        }
    //});
};