extends Camera2D

export var speed:float = 600
var inputVector = Vector2()

func _input(event):
	inputVector = Vector2()
	if Input.is_action_pressed("left"):
		inputVector.x -= 1
	if Input.is_action_pressed("right"):
		inputVector.x += 1
	if Input.is_action_pressed("up"):
		inputVector.y -= 1
	if Input.is_action_pressed("down"):
		inputVector.y += 1
		
	inputVector = inputVector.normalized()
	
func _process(delta):
	global_position += inputVector * speed * delta
