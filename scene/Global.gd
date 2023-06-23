extends Node
var image_location = []
var image_var = []
signal score_changed(new_score)
var score : int = 0:
	get:
		return score
	set(val):
		print("score_set")
		score = val
		emit_signal("score_changed", score)


func _init():
	score = 0

func increment_score(value):
	score += value

func reset_score():
	score = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	var dir = DirAccess.open("user://res/lastorigin")
	
	if dir:  # If the directory exists
		dir.list_dir_begin()
		var file_name = dir.get_next()
		
		while file_name != "":
			if dir.current_is_dir():
				# Skip directories
				file_name = dir.get_next()
				continue
			
			# Only consider .png files
			if file_name.get_extension().to_lower() == "png":
				image_location.append("res://res/lastorigin/" + file_name)
			file_name = dir.get_next()

	else:
		print("An error occurred when trying to access the path.")
	
	print(image_location)
	for path in image_location:
		image_var.append(load(path))
	print(image_var)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


