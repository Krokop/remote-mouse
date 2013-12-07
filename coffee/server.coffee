app = require('express')()
express = require('express')
server = require('http').createServer app
io = require('socket.io').listen server
exec = require('child_process').exec;

server.listen 8083
app.use('/script', express.static(__dirname + '/'))
app.use('/style', express.static(__dirname + '/scss'))

app.get '/', (req, res)->
	res.sendfile __dirname + '/html/index.html'

x=0
y=0

io.sockets.on 'connection', (socket)->
	x=0
	y=0
	socket.on 'i_server', (e) ->
		back = socket.id
		socket.emit 'stay_server'

	socket.on 'i_client', (e) ->
		socket.emit 'stay_client'

	socket.on 'move_mouse', (direction)->
		dir = direction
		console.log dir, x, y
		if dir is "top" and x is not 0 then x = x-20
		if dir is "left" and y is not 0 then y = y-20
		if dir is "right" then y = y+20
		if dir is "down" then x = x+20
		exec "xdotool mousemove #{y} #{x}", (error, stdout, stderr)->
			console.log stdout

#
#	exec 'xdotool getmouselocation', (error, stdout, stderr)->
#		x = parseInt(stdout.split(' ')[0].slice(2, stdout.length))
#		y = parseInt(stdout.split(' ')[1].slice(2, stdout.length))
#		console.log x, y
#
#
#	socket.on 'movemouse', (new_direction)->
#		direction = new_direction
#		console.log new_direction
#		if direction is "up" then x = x - 20
#		if direction is "down" then x = x + 20
#		if direction is "left" then y = y - 20
#		if direction is "right" then y = y + 20
#		exec "xdotool mousemove #{y} #{x}", (error, stdout, stderr)->
#			console.log stdout


#x = 0
#y = 0
#
#direction = "no"
#setInterval ->
#        console.log 'direction', direction
#        if direction is "null" then return no
#        if direction is "up" then x = x - 1
#        if direction is "down" then x = x + 1
#        if direction is "left" then y = y - 1
#        if direction is "right" then y = y + 1
#        if direction is not "null" then exec "xdotool mousemove #{y} #{x}", (error, stdout, stderr)->
#                console.log stdout
#
#        , 1500
#
#io.sockets.on 'connection', (socket)->
#
#        child = exec 'xdotool getmouselocation', (error, stdout, stderr)->
#                console.log stdout
#
#
#
#        socket.on 'movemouse', (new_direction)->
#                direction = new_direction
#                console.log 'new direction'