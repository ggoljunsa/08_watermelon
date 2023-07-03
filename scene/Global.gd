extends Node
@export_dir var image_location: String = "res://res/lastorigin"
var img_location = ["res://res/lastorigin",
					"res://res/physicalGame",
					"res://res/elven",
					"res://res/manmae"
					]
var image_var = []
@export var main_path: String = "res://scene/main.tscn"
signal score_changed(new_score)
var score : int = 0:
	get:
		return score
	set(val):
		print("score_set")
		score = val
		emit_signal("score_changed", score)

var highscore = 0
var skin_num = 0

func _init():
	score = 0

func increment_score(value):
	score += value

func reset_score():
	score = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for location in img_location:
		image_var.append(load_imports_at(location, "png"))
	# test:
	print(image_var)


func load_imports_at(path: String, filter: String = "") -> Array:
	if not DirAccess.dir_exists_absolute(path):
		push_error("Invalid path '%s'" % path)
		return Array()
		
	if not path.ends_with("/"):
		path += "/"
		
	if filter != "" and not filter.begins_with("."):
		filter = "." + filter
		
	var loaded_files: Array = Array()
	for filename in DirAccess.get_files_at(path):
		for suffix in [".import", ".remap"]:
			if not filename.ends_with(filter + suffix):
				continue
			var full_path: String = path + filename.trim_suffix(suffix)
			var file: Resource = load(full_path)
			if file == null:
				push_error("Error while loading file '%s'" % full_path)
				continue
			loaded_files.append(file)
		
	return loaded_files

func set_skin(num):
	skin_num = num
	print(skin_num)
