var io = require('socket.io').listen(8008);
var querystring = require('querystring');
var http = require('http');

io.sockets.on('connection', function (socket) {
    console.log('Connesso');
    socket.on('message sent', function (data) {
        console.log(data);
        io.sockets.emit('message arrived', data);
    });
    socket.on('message not seen', function (data) {
        io.sockets.emit('message notification', data);
    });
    socket.on('friendship request', function (data) {
        console.log('friendship request ['+data+']');
        io.sockets.emit('friendship notification', data);
    })
});