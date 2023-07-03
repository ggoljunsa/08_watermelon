extends Control
signal start_game_pressed

@onready var start_game_button: Button = $%StartGameButton
@onready var options_menu: Control = $%OptionsMenu
@onready var content: Control = $%Content 


func _ready():
	start_game_button.grab_focus()

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
	OS.shell_open("https://ggoljunsa.notion.site/51e8b4a54d044903b695adacbf9ea168?v=f8d9fa5319a2476b84f4fe9453ee958d")

