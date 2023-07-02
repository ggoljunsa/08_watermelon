extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_result_screen():
	$Content/HighScore.text =  "Hightscore: "+ str(Global.highscore)
	$Content/Score.text = "Score: " + str(Global.score)


func _on_retry_game_button_pressed():
	pass # Replace with function body.


func _on_options_button_pressed():
	pass # Replace with function body.


func _on_quit_button_pressed():
	
	pass # Replace with function body.


func _on_back_to_menu_button_pressed():
	get_tree().change_scene_to_file("res://addons/EasyMenus/Scenes/main_menu.tscn")
	pass # Replace with function body.
