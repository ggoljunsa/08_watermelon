extends RigidBody2D

var ball_collision
var ball_texture
var ball_Area
var ball_level = 0 
var bojungchi = 300
@export var ball_size = [0.08*bojungchi,0.102*bojungchi, 0.155*bojungchi, 0.209*bojungchi, 0.25*bojungchi,0.3*bojungchi, 0.418*bojungchi, 0.45*bojungchi, 0.5*bojungchi, 0.55*bojungchi, 0.6*405, 0.7*bojungchi]
@export var collision_radius = 1


var is_dragged = false
var original_position = Vector2.ZERO
var threshold = 50.0  # Change this based on your requirements



#signal for scoring system
signal score_update

# Called when the node enters the scene tree for the first time.
func _ready():
	original_position = position
	print(original_position)
	#set angular damp
	set_angular_damp_mode(1)
	set_angular_damp(20)
	ball_collision = get_node("CollisionShape2D")
	#print($CollisionShape2D.shape.get_radius())
	ball_texture = $TextureRect
	ball_Area = get_node("Area2D/CollisionShape2D")

"""
func _input(event):
	if event is InputEventScreenTouch:
		if position.distance_to(event.position) < threshold and event.is_pressed():
			# The user touched the object, start dragging
			is_dragged = true
			sleeping = true  # Temporarily freeze physics
		elif not event.is_pressed():
			
			# The user released the touch, stop dragging
			is_dragged = false
			if position.distance_to(original_position) < threshold:
				# The object is near the original position, move it back
				position = original_position
				#sleeping = true  # Keep physics frozen
			else:
				#sleeping = false  # Let physics apply
				print("release")
				set_physics_process(true)
				freeze = false
				get_node("Area2D").monitoring = true
				set_process_input(false)
				get_parent()._on_main_detect_ball()

				

	if event is InputEventScreenDrag and is_dragged:
		# Move the object with the drag
		var new_position = position + event.relative
		var screen_rect = get_viewport_rect()
		
		# Clamp the position to stay within the screen
		new_position.x = clamp(new_position.x, 0, screen_rect.size.x)
		new_position.y = clamp(new_position.y, 0, original_position.y+50)
		
		position = new_position

"""




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pass



func _on_area_2d_area_entered(area):
	if area.get_parent() is RigidBody2D:
		var other_ball = area.get_parent() 
		if other_ball != null:
			#other ball will be the slow one, which gets bigger
			if other_ball.ball_level == ball_level:
				if speed(linear_velocity) > speed(other_ball.linear_velocity):
					$Merge.play()
					await get_tree().create_timer(0.05).timeout
					#set_physics_process(false)
					merge_ball(other_ball)
					#
					#set_physics_process(true)
					
				else:
					#print('hello')
					$Merge.play()
					await get_tree().create_timer(0.05).timeout
					#await get_tree().create_timer(0.1).timeout
		else:
			print("error: other ball null error")

func speed(linear_velocity):
	return sqrt(linear_velocity.x*linear_velocity.x + linear_velocity.y*linear_velocity.y)

func merge_ball(other_ball):
	if other_ball != null:
		Global.increment_score(ball_level+1)
		set_physics_process(false)
		position = other_ball.position   # Immediately move the other ball to this ball's position
		other_ball.get_node("AnimationPlayer").play("anim_small")
		other_ball.ball_setsize(ball_level + 1)  # Increase the level and update the size
		other_ball.get_node("AnimationPlayer").play("anim_big")
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
	change_texture()

	
	#set physics, gravity, mass elements
	set_mass(ball_size[num]*10)
	print(get_mass(), ": ball mass")
	set_physics_process(true)

func change_texture():
	#set the texture properities
	$TextureRect.size = Vector2(ball_size[ball_level]*2, ball_size[ball_level]*2)
	$TextureRect.position = Vector2(-ball_size[ball_level], -ball_size[ball_level])
	$TextureRect.set_anchors_preset(Control.PRESET_CENTER,true)
	if Global.image_var[Global.skin_num][ball_level] != null:
		$TextureRect.set_texture(Global.image_var[Global.skin_num][ball_level])
	
