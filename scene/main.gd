extends Node2D

var ball_object = load("res://scene/ball.tscn")
var numbers = [0, 1, 2, 3]
@export var probabilities = [45, 30, 20, 5]
var instance
var throw_speed = Vector2(0, 100)
var ball_generate_flag = true

# Called when the node enters the scene tree for the first time.
func _ready():
	ball_generate(rand_generate(), $UI/Spot.position)
	var togglemenu_node = get_node("UI/PauseMenu/ToggleMenu")
	#print("togglemenu_node", togglemenu_node)
	togglemenu_node.connect("skin_changed", change_skin)

func change_skin():
	print("main_change_skin")
	$object.change_child_skin()

# Called every frame. 'delta' is the elapsed time since the previous frame.


func _process(_delta):
	pass
	"""
	if ball_generate_flag:
		var pos = Vector2($UI/Spot.position)
		ball_generate(rand_generate(), pos)
		ball_generate_flag = false
		await get_tree().create_timer(3).timeout
		ball_generate_flag = true
	"""





var input_flag = true
func _unhandled_input(event):
	if input_flag:
		if event is InputEventMouseButton and event.pressed:
			#print(event.position)
			input_flag = false
			#print("마우스 위치: ", event.position)
			var pos = Vector2(event.position.x, $UI/Spot.position.y+100)
			move_ball(pos)
			


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
	return int(num/10)*10
