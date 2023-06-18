extends Node

var image_location = []
# Called when the node enters the scene tree for the first time.
func _ready():
	var dir = DirAccess.open("res://res/lastorigin")
	
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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
