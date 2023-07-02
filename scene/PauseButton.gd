extends Button

func _ready():
	connect("pressed", _on_PauseButton_pressed)

func _on_PauseButton_pressed():
	%PauseMenu.open_pause_menu()
	#print("paused pressed")
