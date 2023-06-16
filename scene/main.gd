extends Node2D

var ball_object = load("res://scene/ball.tscn")
var numbers = [0, 1, 2, 3]
@export var probabilities = [40, 30, 20, 10]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed:
		#print("마우스 위치: ", event.position)
		ball_generate(rand_generate(), event.position)

func ball_generate(num, pos):
	var instance = ball_object.instantiate()
	instance.ball_setsize(num)
	instance.position = pos
	add_child(instance)


#returns random 
func rand_generate():
	var random_number = randi()%100 # 0 to 99
	
	if random_number < probabilities[0]:
		return 0
	elif random_number < probabilities[1]+probabilities[0]:
		return 1
	elif random_number < probabilities[2]+probabilities[1]+probabilities[0]:
		return 2
	else:
		return 3

