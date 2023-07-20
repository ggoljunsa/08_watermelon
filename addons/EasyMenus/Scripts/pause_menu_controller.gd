extends Control
signal resume
signal back_to_main_pressed

@onready var content : VBoxContainer = $%Content
@onready var options_menu : Control = $%OptionsMenu
@onready var resume_game_button: Button = $%ResumeGameButton
#for my custom options
@onready var toggle_menu : Control = $%ToggleMenu

func open_pause_menu():
	#Stops game and shows pause menu
	get_tree().paused = true
	show()
	resume_game_button.grab_focus()
	
func close_pause_menu():
	get_tree().paused = false
	hide()
	emit_signal("resume")

func _on_resume_game_button_pressed():
	close_pause_menu()


func _on_options_button_pressed():
	content.hide()
	options_menu.show()
	options_menu.on_open()


func _on_options_menu_close():
	options_menu.hide()
	content.show()
	resume_game_button.grab_focus()

func _on_quit_button_pressed():
	Global.save_data()
	get_tree().quit()


func _on_back_to_menu_button_pressed():
	close_pause_menu()
	emit_signal("back_to_main_pressed")

func _input(event):
	if (event.is_action_pressed("ui_cancel") or event.is_action_pressed("pause")) and visible and !options_menu.visible:
		accept_event()
		close_pause_menu()



func _on_toggle_button_pressed():
	content.hide()
	toggle_menu.show()
	toggle_menu.load_things()
	#toggle_menu.on_open()


func _on_toggle_menu_close():
	toggle_menu.hide()
	content.show()
	toggle_menu.grab_focus()


func _on_reset_button_pressed():
	print('reset')
	Global.reset_data()
