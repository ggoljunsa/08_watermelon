extends Node2D

var ball_object = load("res://scene/ball.tscn")
var numbers = [0, 1, 2, 3]
@export var probabilities = [45, 30, 20, 5]
var instance
var throw_speed = Vector2(0, 100)
var ball_generate_flag = true

# Called when the node enters the scene tree for the first time.
func _ready():
	original_position = $UI/Spot.position
	ball_generate(rand_generate(), $UI/Spot.position)
	var togglemenu_node = get_node("UI/PauseMenu/ToggleMenu")
	#print("togglemenu_node", togglemenu_node)
	togglemenu_node.connect("skin_changed", change_skin)

func change_skin():
	print("main_change_skin")
	$object.change_child_skin()

# Called every frame. 'delta' is the elapsed time since the previous frame.

#Queue 선언
var merge_queue : Array = []
#신호를 받는 메소드
func add_to_merge_queue(ball):
	#중복 방지를 위한 검사
	if ball not in merge_queue:
		merge_queue.append(ball)

# 매 프레임마다 합칠 공이 있는지 확인
func _process(_delta):
	handle_merge()

# 합치기 로직
func handle_merge():
	if merge_queue.size() < 2:
		return
	var ball_to_merge = merge_queue[0]
	var other_ball = merge_queue[1]
	#ball_to_merge will be queue_freed, so the position will be lower(bigger) than other_ball
	if ball_to_merge.position.y < other_ball.position.y:
		ball_to_merge = merge_queue[1]
		other_ball = merge_queue[0]
	ball_to_merge.merge_ball(other_ball)
	other_ball.get_node("Merge").play()
	merge_queue = []

	# 여기서 합치기 로직을 실행. ball.gd의 merge_ball 함수 등을 호출하면 됨
	# 예: ball_to_merge.merge_ball(other_ball)


var is_dragged = false
var original_position = Vector2.ZERO
var threshold = 50.0  # Change this based on your requirements
var input_flag = true
var drag_start_position = Vector2.ZERO  # Store the position where the drag started

func _input(event):
	if input_flag:
		if event is InputEventScreenTouch:
			if event.is_pressed():
				# The user touched the object, start dragging
				is_dragged = true
				drag_start_position = event.position
				instance.set_sleeping(true)  # Temporarily freeze physics
			elif not event.is_pressed():
				
				# The user released the touch, stop dragging
				is_dragged = false
				if instance.position.distance_to(original_position) < threshold:
					# The object is near the original position, move it back
					instance.position = original_position
					#sleeping = true  # Keep physics frozen
				else:
					#sleeping = false  # Let physics apply
					print("release")
					instance.set_physics_process(true)
					instance.freeze = false
					instance.get_node("Area2D").monitoring = true
					instance.set_process_input(false)
					emit_signal("detect_ball")
					input_flag = false

		elif event is InputEventScreenDrag and is_dragged:
			# Move the object with the drag
			var new_position = instance.position + event.relative
			var drag_start_position = event.position  # Store the position where the drag started
			var screen_rect = get_viewport_rect()
			
			# Clamp the position to stay within the screen
			new_position.x = clamp(new_position.x, 0, screen_rect.size.x)
			new_position.y = clamp(new_position.y, 0, original_position.y+50)
			
			instance.position = new_position


signal detect_ball
func move_ball(pos):
	#move the ball into certain position with tween
	var tween = instance.create_tween()
	tween.tween_property(instance, "position", pos, 0.1)
	await get_tree().create_timer(0.1).timeout
	#set gravity of the ball.
	instance.freeze = false
	instance.get_node("Area2D").monitoring = true
	#set the speed (
	#instance.set_linear_velocity(throw_speed)
	#await get_tree().create_timer(3).timeout
	emit_signal("detect_ball")

func ball_generate(num, pos):
	instance = ball_object.instantiate()
	instance.ball_setsize(num)
	instance.freeze = true
	instance.get_node("Area2D").monitoring = false
	instance.position = pos
	$object.add_child(instance)


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

#play sound
signal merge_sound
func play_sound():
	$AudioStreamPlayer.play(0.0)
	print('play')


func _on_object_balls_stabled():
	#after the ball is stabled, we must check it's gameover or not
	$GameOverArea2D.checkGameover()
	ball_generate(rand_generate(), $UI/Spot.position)
	input_flag = true

signal update_score
func _on_update_score():
	$UI/Score.text =  str(Global.score)


#game over function
func _on_game_over_area_2d_gameover():
	Global.update_high_score(Global.score)
	var coin_to_add = cal_coin_socre(Global.score)
	Global.add_coins(coin_to_add)
	$UI/GameoverMenu.show()
	$UI/GameoverMenu.set_result_screen()
	get_tree().paused = true
	


func _on_pause_menu_back_to_main_pressed():
	get_tree().change_scene_to_file("res://addons/EasyMenus/Scenes/main_menu.tscn")


func _on_gameover_menu_back_to_main_pressed():
	get_tree().change_scene_to_file("res://addons/EasyMenus/Scenes/main_menu.tscn")

func cal_coin_socre(num):
	return int(num/10)
