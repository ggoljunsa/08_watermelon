extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_pause_popup_close_pressed():
	%pause_popup.hide()
	get_tree().paused = false
