extends RigidBody2D

var ball_collision
var ball_texture
var ball_Area


var ball_level = 0 
@export var ball_size = [20,25, 30, 38, 45,50, 55, 60]
@export var collision_radius = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	ball_collision = get_node("$CollisionShape2D")
	#print($CollisionShape2D.shape.get_radius())
	ball_texture = $TextureRect
	ball_Area = get_node("Area2D/CollisionShape2D")
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_area_entered(area):
	if area.get_parent() is RigidBody2D:
		var other_ball = area.get_parent()
		if other_ball.ball_level == ball_level:
			print("merge")
			merge_ball(other_ball)

func merge_ball(other_ball):
	other_ball.set_physics_process(false)
	other_ball.position = position  # Immediately move the other ball to this ball's position
	other_ball.queue_free()
	ball_setsize(ball_level + 1)  # Increase the level and update the size



func ball_setsize(num: int):
	ball_level = num
	print(ball_size[num])
	ball_collision = get_node("CollisionShape2D")
	ball_collision.shape = CircleShape2D.new()
	ball_collision.shape.set_radius(float(ball_size[num]))
	
	ball_Area = get_node("Area2D/CollisionShape2D")
	ball_Area.shape = CircleShape2D.new()
	ball_Area.shape.set_radius(float(ball_size[num]+collision_radius))
	
