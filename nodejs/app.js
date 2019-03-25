var io = require('socket.io').listen(8008);
var querystring = require('querystring');
var http = require('http');

io.sockets.on('connection', function (socket) {
    console.log('Connesso')
    socket.on('message sent', function (data) {
        console.log(data);
        io.sockets.emit('message arrived', data);
        /*
        var elems_url = data.split("/");
        for(var i = 0; i < elems_url.length; i++){
            if(!isNaN(elems_url[i]) && elems_url[i]!=''){
                console.log(elems_url[i]);
                io.sockets.emit('message arrived', elems_url[i]);
            }
        }
        */
    });
    socket.on('message not seen', function (data) {
        io.sockets.emit('message notification', data);
    });
});