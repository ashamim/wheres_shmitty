var app = require('http').createServer()

app.listen(8900)

var io = require('socket.io')(app)

addHandlers = function() {
  io.sockets.on("connection", function(socket) {
    socket.emit("hello")
  })
}

addHandlers()
