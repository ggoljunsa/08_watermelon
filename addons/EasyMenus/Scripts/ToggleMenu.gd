extends Control

# Declare your button and checkbox here
@onready var radio_buttons = $Content2.get_children()
@export var checkBox_text : Array = Array()
var lockButton = null
var isLocked = true
var lockPrice = 10 # Here we set a certain amount to unlock the button.
signal skin_changed

# Called when the node enters the scene tree for the first time.
func _ready():
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


func _on_gacha_button_pressed():
	#first check if it's enough coin left
	#if coin is left enough, you can unlock random skin left
	#use label to show whick skin you unlocked
	#if coin is not enough, you can't unlock the skin, set text can't get skin
	
	pass # Replace with function body.
