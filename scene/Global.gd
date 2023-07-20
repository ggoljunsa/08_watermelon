extends Node
@export_dir var image_location: String = "res://res/lastorigin"
var img_location
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

var save_file = ConfigFile.new()
var save_path = "user://save_data.cfg"
var high_score = 0

var skin_name = ["기본 라오 스킨 01",
				"피지컬게임 스킨",
				"만메 시아 스킨",
				"클루리스 엘븐콘 스킨",
				"만메 아카콘 스킨",
				"가다랭 스킨",
				"웨히히 스킨",
				"초티지 스킨",
				"에라라오 미호담당자 스킨",
				"Milky 스킨",
				"검정벽돌 뮤즈 스킨",
				"개발자 사팍콘 스킨",
				"개발자 이과콘 스킨",
				"검정벽돌 도트 스킨",
				"아몬두만 스킨"]
var skin_description = ["라스트오리진 캐릭터들이 있는 기본 스킨. 순서는 가슴 크기순입니다.",
				"게임에 나온 그림들을 직접 그려줬습니다. 순서는 가슴 크기순입니다.",
				"만메님의 허락을 받았습니다. 귀여운 시아와 게임을 즐길 수 있습니다.",
				"우유짤들이 덜 씹덕같아서 밖에서 게임하기에 딱입니다.",
				"만메님의 허락을 받았습니다. 아카콘에 있는 것을 넣었습니다. ",
				"에라라오에 이어서 두 번째 팬게임에 참가하였습니다.(반강제)",
				"허락을 받았습니다. 짤을 고르고 있어서 임시로 아카콘 브라우니를 넣었습니다... 빨리 넣겠습니다.",
				"허락을 받았습니다. 라할배들이 추억에 젖었으면 좋겠습니다. 움짤을 넣어서 움직일 수 있게 해보기 위해서 나엔 이미지밖에 안 나오는 반쪽짜리 스킨입니다.",
				"수상할 정도로 미호를 좋아하는 그림쟁이의 스킨입니다. 8개가 넘어가면 전신 일러가 나옵니다.",
				"전 Coffecat닉네임의 스킨입니다. 자료가 유실되어 아카콘을 넣어서 살짝 지글거립니다.",
				"개발자의 그림 스승님의 스킨입니다. 수상할 정도로 뮤즈를 좋아하는 것 같습니다.",
				"개발자가 발로 그린 사팍콘입니다. 스킨 개수를 채우고 싶어서 넣었습니다.",
				"개발자가 윾갤콘을 파쿠리한 이과콘입니다. 스킨 개수를 채우고 싶어서 넣었습니다.",
				"개발자의 그림 스승님의 도트 작업물입니다. 도트를 잘 찍습니다.",
				"아몬두만 님의 스킨입니다."]
var has_pressed_support_button = false

func _init():
	score = 0

func increment_score(value):
	score += value

func reset_score():
	score = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	img_location = get_directories_in_path("res://res/skin/")
	load_data()
	#load_coins()
	for location in img_location:
		image_var.append(load_imports_at(location, "png"))
	# test:
	print(img_location)

func get_directories_in_path(path: String, filter: String = "") -> Array:
	if not DirAccess.dir_exists_absolute(path):
		push_error("Invalid path '%s'" % path)
		return Array()
	var loaded_files: Array = Array()
	var dir_name = DirAccess.get_directories_at(path)
	for folder_name in dir_name:
		loaded_files.append(path + folder_name+ '/')
	return loaded_files
		


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
	if num < img_location.size():
		skin_num = num
	print(skin_num)

func load_high_score():
	var error = save_file.load(save_path)
	
	if error == OK:  # If the file has been found and loaded successfully
		high_score = save_file.get_value("game_data", "high_score", 0)  # default value is 0
	else:
		print("No high score file found, setting default high score to 0.")

func save_high_score(new_score):
	high_score = new_score
	save_file.set_value("game_data", "high_score", new_score)
	save_file.save(save_path)

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
# Function to save coins to a file
func save_coins():
	save_file.set_value("game_data", "coins", coins)
	save_file.save(save_path)

# Function to load coins from a file
func load_coins():
	var save_file = ConfigFile.new()
	if save_file.load(save_path) == OK:
		coins = save_file.get_value("game_data", "coins", 0)
	else:
		print("No save file found, starting with 0 coins")

func reset_data():
	save_file.set_value("game_data", "coins", 1000)
	coins = save_file.get_value("game_data", "coins", 0)
	#print("coins: ", coins)
	save_file.set_value("game_data", "high_score", 0)
	high_score = save_file.get_value("game_data", "high_score", 0)
	#print("highscore: ", high_score)
	save_file.set_value("game_data", "unlocked_skins", [])
	unlocked_skins = save_file.get_value("game_data", "unlocked_skins", [])
	#print("unlocked_skin: ", unlocked_skins)
	save_file.set_value("game_data", "supprotbutton", false)
	has_pressed_support_button = save_file.get_value("game_data", "supprotbutton", false)
	save_file.save(save_path)
	pass # Replace with function body.

#function to save things
var unlocked_skins = []
func save_data():
	save_coins()
	save_file.set_value("game_data", "cur_skin", skin_num)
	#ToggleMenu.get_unlocked_skins()
	save_file.set_value("game_data", "unlocked_skins", unlocked_skins)
	save_file.set_value("game_data", "supprotbutton", has_pressed_support_button)
	save_file.save(save_path)

# Function to load coins and unlocked skins from a file
func load_data():
	if save_file.load(save_path) == OK:
		load_coins()
		unlocked_skins = save_file.get_value("game_data", "unlocked_skins", [])
		skin_num = save_file.get_value("game_data", "cur_skin", 0)
		has_pressed_support_button = save_file.get_value("game_data", "supprotbutton", false)
		#ToggleMenu.set_unlocked_skins()
	else:
		print("No save file found, starting with 0 coins and no unlocked skins.")
