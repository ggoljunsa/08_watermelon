extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Black_in")
	await get_tree().create_timer(3).timeout
	$AnimationPlayer.play("Black_out")
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://addons/EasyMenus/Scenes/main_menu.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _input(event):
		if event is InputEventKey or event is InputEventMouseButton:
			if event.is_pressed():
				get_tree().change_scene_to_file("res://addons/EasyMenus/Scenes/main_menu.tscn")
