extends Control

signal get_skin
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_getskin_pressed():
	emit_signal("get_skin")
	hide()
	pass # Replace with function body.


func _on_button_back_pressed():
	hide()
