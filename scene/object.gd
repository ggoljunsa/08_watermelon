extends Control
#안에 있는 ball object가 정지해 있는지, 체크하기. 
signal balls_stabled
# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
var children

func _process(delta):
	children = get_children()
	#print(children)
	if check_if_stopped(children):
		print('stop')
		emit_signal("balls_stabled")
		set_process(false)

func check_if_stopped(children):
	
	for child in children:
		if speed(child.linear_velocity) > 5 or child.position.y < 300:
			#print(child.linear_velocity)
			return false
	return true


func speed(linear_velocity):
	return sqrt(linear_velocity.x*linear_velocity.x + linear_velocity.y*linear_velocity.y)

func _on_main_detect_ball():
	await get_tree().create_timer(1).timeout 
	set_process(true)
	#print('sex')
	pass # Replace with function body.
