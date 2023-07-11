extends Node
@export_dir var image_location: String = "res://res/lastorigin"
var img_location = ["res://res/lastorigin",
					"res://res/physicalGame",
					"res://res/manmae",
					"res://res/elven"
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

var skin_num = 0

var high_score_file = ConfigFile.new()
var high_score_path = "user://high_score.cfg"
var high_score = 0


func _init():
	score = 0

func increment_score(value):
	score += value

func reset_score():
	score = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_high_score()
	#load_coins()
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

func load_high_score():
	var error = high_score_file.load(high_score_path)
	
	if error == OK:  # If the file has been found and loaded successfully
		high_score = high_score_file.get_value("score", "high_score", 0)  # default value is 0
	else:
		print("No high score file found, setting default high score to 0.")

func save_high_score(new_score):
	high_score = new_score
	high_score_file.set_value("score", "high_score", new_score)
	high_score_file.save(high_score_path)

func update_high_score(new_score):
	if new_score > high_score:
		save_high_score(new_score)

var coins = 0

# This function adds a specific amount of coins to the player's total
func add_coins(amount):
	coins += amount

# This function is called when the player wants to buy something
func spend_coins(amount):
	if coins >= amount:
		coins -= amount
		return true
	else:
		print("Not enough coins")
		return false
"""
# Function to save coins to a file
func save_coins():
	var save_file = ConfigFile.new()
	save_file.set_value("coin_data", "coins", coins)
	save_file.save("user://savegame.save")

# Function to load coins from a file
func load_coins():
	var save_file = ConfigFile.new()
	if save_file.load("user://savegame.save") == OK:
		coins = save_file.get_value("coin_data", "coins", 0)
	else:
		print("No save file found, starting with 0 coins")
"""

		
