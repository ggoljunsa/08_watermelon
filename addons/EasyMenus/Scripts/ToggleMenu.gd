extends Control

# Declare your button and checkbox here
var checkBoxes = []
var lockButton = null
var isLocked = true
var lockPrice = 10 # Here we set a certain amount to unlock the button.


# Called when the node enters the scene tree for the first time.
func _ready():
	# Assign your button and checkbox here
	for i in range(9):
		var checkbox = CheckBox.new() # create new checkbox
		checkbox.connect("toggled", _on_checkbox_toggled, i) # connect its "toggled" signal to a function
		add_child(checkbox) # add the checkbox as child
		checkBoxes.append(checkbox) # add to the list of checkboxes

func _on_checkbox_toggled(i):
	print('checked', i)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
