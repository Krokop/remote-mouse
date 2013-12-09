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

pix = 20
x=0
y=0

dir  = 'no'

io.sockets.on 'connection', (socket)->
	socket.on 'i_server', (e) ->
		back = socket.id
#		exec 'xdotool getmouselocation', (error, stdout, stderr)->
#			x = parseInt(stdout.split(' ')[0].slice(2, stdout.length))
#			y = parseInt(stdout.split(' ')[1].slice(2, stdout.length))
#			console.log x,y
		socket.emit 'stay_server'

	socket.on 'i_client', (e) ->
		socket.emit 'stay_client'

	d = "sto"
	socket.on 'move_mouse', (direction)->
		if direction is d
			dir = direction
		else
			move_mouse(direction)
			d = direction


	socket.on 'stop_mouse', (direction) ->
		dir = direction

	socket.on 'click_mouse', ()->
		exec 'xdotool mousedown 1'
		exec 'xdotool mouseup 1'

	socket.on "scroll", (areas) ->
		console.log 'scroll down'
		if areas is "down" then exec "xdotool key 116"
		if areas is "up" then exec "xdotool key 111"
		if areas is "left" then exec "xdotool key 113"
		if areas is "right" then exec "xdotool key 114"

	move_mouse = (dir)->
		console.log "move mouse #{dir}"
		if dir is "stop" or dir is "no"
			return 0
		if dir is "top" and x-pix>0 then x = x-pix
		if dir is "left" and y-pix>0 then y = y-pix
		if dir is "right" then y = y+pix
		if dir is "down" then x = x+pix
		exec "xdotool mousemove #{y} #{x}"

#	setInterval ->
#		move_mouse(dir)
#	,300
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