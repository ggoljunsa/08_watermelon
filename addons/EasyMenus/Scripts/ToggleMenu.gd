extends Control

# Declare your button and checkbox here
@onready var radio_buttons = $VBoxContainer/ItemList
@export var checkBox_text : Array = Array()
var lockButton = null
var isLocked = true
var lockPrice = 10 # Here we set a certain amount to unlock the button.
signal skin_changed
var skin_label

# Called when the node enters the scene tree for the first time.
func _ready():
	load_data()
	# Global.coins = 200
	skin_label = %GatchaLabel
	skin_label.text = "Press Gacha to unlock the skin"
	update_coin_text()

func update_coin_text():
	$VBoxContainer/Coins.text = "Coins: " + str(Global.coins)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_item_list_item_clicked(index, at_position, mouse_button_index):
	#it gives signal also when the button is disabled
	Global.set_skin(index)
	emit_signal("skin_changed")
	#print("item clicked", index, at_position, mouse_button_index)
	pass # Replace with function body.


func _on_item_list_item_selected(index):
	#print("item selected", index)
	pass # Replace with function body.


func _on_item_list_item_activated(index):
	#enter or double click
	#print("item activated", index)
	pass # Replace with function body.


signal close
func go_back():
	emit_signal("close")

# Randomly selects an index of a locked skin
func _get_random_locked_skin_index():
	var locked_skin_indices = []
	for i in range(radio_buttons.get_item_count()):
		if radio_buttons.is_item_disabled(i):
			locked_skin_indices.append(i)
	if locked_skin_indices.size() == 0:
		return -1
	return locked_skin_indices[randi() % locked_skin_indices.size()]


func _on_gacha_button_pressed():
	if Global.coins >= lockPrice:
		var skin_index = _get_random_locked_skin_index()
		if skin_index != -1:
			radio_buttons.set_item_disabled(skin_index, false)
			Global.coins -= lockPrice
			skin_label.text = "You've unlocked " + radio_buttons.get_item_text(skin_index) + "!"
			save_data()
		else:
			skin_label.text = "All skins have been unlocked."
	else:
		skin_label.text = "You don't have enough coins to unlock a skin."

#function to save things
func save_data():
	var save_file = ConfigFile.new()
	save_file.set_value("game_data", "coins", Global.coins)
	
	var unlocked_skins = []
	for i in range(radio_buttons.get_item_count()):
		if not radio_buttons.is_item_disabled(i):
			unlocked_skins.append(radio_buttons.get_item_text(i))
	save_file.set_value("game_data", "unlocked_skins", unlocked_skins)
	save_file.save("user://savegame.save")

# Function to load coins and unlocked skins from a file
func load_data():
	var save_file = ConfigFile.new()
	if save_file.load("user://savegame.save") == OK:
		Global.coins = save_file.get_value("game_data", "coins", 0)
		
		var unlocked_skins = save_file.get_value("game_data", "unlocked_skins", [])
		for i in range(radio_buttons.get_item_count()):
			var skin_name = radio_buttons.get_item_text(i)
			if skin_name in unlocked_skins:
				radio_buttons.set_item_disabled(i, false)
			else:
				radio_buttons.set_item_disabled(i, true)
	else:
		print("No save file found, starting with 0 coins and no unlocked skins.")
