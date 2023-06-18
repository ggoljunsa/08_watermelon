extends RigidBody2D

var ball_collision
var ball_texture
var ball_Area


var ball_level = 0 
@export var ball_size = [20,25, 30, 38, 45,50, 55, 60, 65, 70, 75, 80]
@export var collision_radius = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	ball_collision = get_node("CollisionShape2D")
	#print($CollisionShape2D.shape.get_radius())
	ball_texture = $TextureRect
	ball_Area = get_node("Area2D/CollisionShape2D")
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(linear_velocity)
	pass


func _on_area_2d_area_entered(area):
	if area.get_parent() is RigidBody2D:
		var other_ball = area.get_parent() #other ball will be the slow one, which gets bigger
		if other_ball.ball_level == ball_level:
			if speed(linear_velocity) < speed(other_ball.linear_velocity):
				set_physics_process(false)
				merge_ball(other_ball)
				await get_tree().create_timer(0.1).timeout
				set_physics_process(true)

func speed(linear_velocity):
	return sqrt(linear_velocity.x*linear_velocity.x + linear_velocity.y*linear_velocity.y)

func merge_ball(other_ball):
	set_physics_process(false)
	position = other_ball.position   # Immediately move the other ball to this ball's position
	other_ball.ball_setsize(ball_level + 1)  # Increase the level and update the size
	queue_free()





func ball_setsize(num: int):
	#print(num, 'setsize')
	set_physics_process(false)
	ball_level = num
	ball_collision = get_node("CollisionShape2D")

	var new_shape = CircleShape2D.new()
	new_shape.set_radius(float(ball_size[num]))
	ball_collision.call_deferred("set", "shape", new_shape)
	
	ball_Area = get_node("Area2D/CollisionShape2D")
	
	var new_area_shape = CircleShape2D.new()
	new_area_shape.set_radius(float(ball_size[num] + collision_radius))
	ball_Area.call_deferred("set", "shape", new_area_shape)

	set_physics_process(true)

	
