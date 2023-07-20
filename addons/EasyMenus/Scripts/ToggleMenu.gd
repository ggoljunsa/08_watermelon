extends Control

# Declare your button and checkbox here
@onready var radio_buttons =%ItemList
@export var checkBox_text : Array = Array()
var lockButton = null
var isLocked = true
var lockPrice = 100 # Here we set a certain amount to unlock the button.
signal skin_changed
var skin_label
var selectbox
# Called when the node enters the scene tree for the first time.
func _ready():
	get_unlocked_skins()
	skin_label = get_node("VBoxContainer2/GatchaLabel")
	selectbox = get_node("SelectBox")
	skin_label.set_text("Press Gacha to unlock the skin")
	# Global.coins = 200
	pass
func load_things():
	update_coin_text()
	for i in range(radio_buttons.get_item_count()):
		if not radio_buttons.is_item_disabled(i):
			radio_buttons.set_item_disabled(i, true)
	set_unlocked_skins()
	print(Global.unlocked_skins)

func get_unlocked_skins():
	var un_skins = []
	for i in range(radio_buttons.get_item_count()):
		if not radio_buttons.is_item_disabled(i):
			un_skins.append(Global.skin_name[i])
	Global.unlocked_skins = un_skins

func set_unlocked_skins():
	for i in range(radio_buttons.get_item_count()):
		var skin_name = Global.skin_name[i]
		if skin_name in Global.unlocked_skins:
			radio_buttons.set_item_disabled(i, false)
		else:
			radio_buttons.set_item_disabled(i, true)

func update_coin_text():
	%Coins.text = "Coins: " + str(Global.coins)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


var temp_skin_var = 0
func _on_item_list_item_clicked(index, at_position, mouse_button_index):
	#open selectbox
	#it gives signal also when the button is disabled
	if radio_buttons.is_item_disabled(index) == false:
		temp_skin_var = index
		selectbox.get_node("VBoxContainer/HBoxContainer/Button_getskin").set_disabled(false)
	else:
		selectbox.get_node("VBoxContainer/HBoxContainer/Button_getskin").set_disabled(true)
		pass
	selectbox.show()
	selectbox.get_node("VBoxContainer/Label").set_text(Global.skin_name[index])
	selectbox.get_node("VBoxContainer/Label2").set_text(Global.skin_description[index])
	

func _on_item_list_item_selected(index):
	#print("item selected", index)
	pass # Replace with function body.


func _on_item_list_item_activated(index):
	#enter or double click
	#print("item activated", index)
	pass # Replace with function body.


signal close
func go_back():
	get_unlocked_skins()
	Global.save_data()
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
			skin_label.text = "You've unlocked " + Global.skin_name[skin_index] + "!"
			get_unlocked_skins()
		else:
			skin_label.text = "All skins have been unlocked."
	else:
		skin_label.text = "You don't have enough coins to unlock a skin."
	load_things()


func _on_select_box_get_skin():
	Global.set_skin(temp_skin_var)
	emit_signal("skin_changed")
