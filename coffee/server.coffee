app = require('express')()
server = require('http').createServer app
io = require('socket.io').listen server
exec = require('child_process').exec;

server.listen 8083

app.get '/', (req, res)->
	res.sendfile __dirname + '/html/index.html'

io.sockets.on 'connection', (socket)->

	x = 0
	y = 0

	child = exec 'xdotool getmouselocation', (error, stdout, stderr)->
		console.log stdout

	socket.on 'movemouse', (direction)->
		if direction is "up" then x = x - 5
		if direction is "down" then x = x + 5
		if direction is "left" then y = y - 5
		if direction is "right" then y = y + 5

		exec "xdotool mousemove #{x} #{y}", (e, so, se)->
			console.log e, so, se