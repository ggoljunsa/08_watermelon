extends ItemList

# Load your image

func _ready():
	set_auto_height(true)
	print(get_viewport().get_visible_rect().size)
	var screen_size = Vector2i(get_viewport().get_visible_rect().size.x/5,
	get_viewport().get_visible_rect().size.x/5)
	set_fixed_icon_size(screen_size)
