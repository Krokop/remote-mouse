jQuery(document).ready ->

	snake = [{'x':1, 'y':1}, {'x':2, 'y':1}, {'x':3, 'y':1}, {'x':4, 'y':1}, {'x':5, 'y':1}]
	lenght = 5
	canvas = $(".canvas")[0]
	ctx = canvas.getContext("2d")
	w = $(".canvas").width()
	h = $(".canvas").height()
	w_s = 5
	ctx.fillStyle = "white"
	ctx.fillRect(0, 0, w, h)
	ctx.strokeStyle = "black"
	ctx.strokeRect(0, 0, w, h)
	ctx.rect(snake[0]['x']*w_s, snake[0]['y']*w_s, w_s, w_s)

	create_snake = () ->
		for i in [lenght-1..0]
			ctx.fillStyle = "blue"
			ctx.rect(snake[i]['x']*w_s, snake[i]['y']*w_s, w_s, w_s)
			ctx.strokeStyle = "black"


	o = create_snake()


