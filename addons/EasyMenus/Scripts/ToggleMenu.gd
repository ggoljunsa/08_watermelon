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
	# Assign your button and checkbox here
	for button in radio_buttons:
		#print(button.get_index())
		button.text = checkBox_text[button.get_index()]
		#button.connect("toggled", _on_button_toggled, button.get_index())
	"""
	for i in range(9):
		var checkbox = CheckBox.new() # create new checkbox
		if checkBox_text[i] != null:
			checkbox.text = checkBox_text[i]
		checkbox.connect("toggled", _on_checkbox_toggled, i) # connect its "toggled" signal to a function
		$Content.add_child(checkbox) # add the checkbox as child
		checkBoxes.append(checkbox) # add to the list of checkboxes
"""

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_check_box_toggled(button_pressed, extra_arg_0):
	if button_pressed:
		emit_signal("skin_changed")
		Global.set_skin(extra_arg_0)
		for other_button in radio_buttons:
			if other_button != radio_buttons[extra_arg_0]:
				other_button.set_pressed(false)



func _on_check_box_pressed(extra_arg_0):
	emit_signal("skin_changed")
	Global.set_skin(extra_arg_0)
	for other_button in radio_buttons:
		if other_button != radio_buttons[extra_arg_0]:
			other_button.set_pressed(false)
		else:
			other_button.set_pressed(true)
