extends Area2D

signal gameover

var body_in_area = []


var wait_flag = 0
func _ready():
	connect("body_entered" ,_on_body_entered)
	connect("body_exited", _on_body_exited)
	

func _process(delta):
	pass
	
func checkGameover():
	if body_in_area.size() >0 :
		print('game over!')
		emit_signal("gameover")

func _on_body_entered(body):
	body_in_area.append(body)
	
func _on_body_exited(body):
	body_in_area.erase(body)
	#if body == body_in_area:
	#	body_in_area = null
	#	timer.stop()
	#change to if least one object is remained
	wait_flag -=1
	


