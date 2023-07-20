extends Control
signal start_game_pressed

@onready var start_game_button: Button = $%StartGameButton
@onready var options_menu: Control = $%OptionsMenu
@onready var content: Control = $%Content 


func _ready():
	start_game_button.grab_focus()
	if Global.has_pressed_support_button == false:
		get_node("Content/Label").set_text("Click support for 100 coins!")

func quit():
	get_tree().quit()
	
func open_options():
	options_menu.show()
	content.hide()
	options_menu.on_open()
	
func close_options():
	content.show();
	start_game_button.grab_focus()
	options_menu.hide()


func _on_start_game_button_pressed():
	emit_signal("start_game_pressed")


func _on_start_game_pressed():
	get_tree().change_scene_to_file(Global.main_path)



func _on_support_button_pressed():
	if Global.has_pressed_support_button == false:
		Global.add_coins(100)
		Global.has_pressed_support_button = true
		Global.save_data()
		get_node("Content/Label").set_text("후원 감사합니다")
	OS.shell_open("https://ggoljunsa.notion.site/51e8b4a54d044903b695adacbf9ea168?v=f8d9fa5319a2476b84f4fe9453ee958d")

