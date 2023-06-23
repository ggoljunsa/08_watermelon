extends Button

func _ready():
	connect("pressed", _on_PauseButton_pressed)

func _on_PauseButton_pressed():
	if get_tree().paused == false:
		get_tree().paused = true
		%pause_popup.show()
	print("paused pressed")
