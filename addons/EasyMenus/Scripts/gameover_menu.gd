extends Control
signal resume
signal back_to_main_pressed
signal restart_game_pressed
@onready var content : VBoxContainer = $%Content
@onready var options_menu : Control = $%OptionsMenu
@onready var retry_game_button: Button = $%RetryGameButton
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_result_screen():
	$Content/HighScore.text =  "Hightscore: "+ str(Global.high_score)
	$Content/Score.text = "Score: " + str(Global.score)
	$Content/Coins.text = "Coins: " + str(Global.coins)

func _on_retry_game_button_pressed():
	close_gameover_menu()
	emit_signal("restart_game_pressed")
	pass # Replace with function body.


func _on_options_button_pressed():
	content.hide()
	options_menu.show()
	options_menu.on_open()


func _on_quit_button_pressed():
	Global.save_data()
	get_tree().quit()

func close_gameover_menu():
	get_tree().paused = false
	hide()
	emit_signal("resume")

func _on_back_to_menu_button_pressed():
	print("back_to_main")
	close_gameover_menu()
	emit_signal("back_to_main_pressed")
	pass # Replace with function body.


func _on_restart_game_pressed():
	Global.score = 0
	get_tree().change_scene_to_file(Global.main_path)


func _on_options_menu_close():
	options_menu.hide()
	content.show()
	retry_game_button.grab_focus()
