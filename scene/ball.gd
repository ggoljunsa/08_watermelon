extends RigidBody2D

var ball_collision
var ball_texture
var ball_Area


var ball_level = 0 
@export var ball_size = [30, 200, 300]


# Called when the node enters the scene tree for the first time.
func _ready():
	ball_collision = $CollisionShape2D
	ball_texture = $TextureRect
	ball_Area = $Area2D/CollisionShape2D
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_area_entered(area):
	
	pass # Replace with function body.

func ball_setsize(num: int):
	ball_level = num
	ball_collision.shape = ball_size[num]
	ball_Area.shape = ball_size[num] + 30
	
