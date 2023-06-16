extends Node2D

var ball_object = load("res://scene/ball.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed:
		#print("마우스 위치: ", event.position)
		var instance = ball_object.instantiate()
		instance.position = event.position
		add_child(instance)
