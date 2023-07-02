extends Area2D

signal gameover

var body_in_area = null
@onready var timer = $Timer

var wait_flag = 0
func _ready():
	connect("body_entered" ,_on_body_entered)
	connect("body_exited", _on_body_exited)
	timer.connect("timeout",_on_timer_timeout)

func _on_body_entered(body):
	body_in_area = body
	wait_flag +=1
	timer.start(5.0)  # Adjust this value to the number of seconds you want

func _on_body_exited(body):
	#if body == body_in_area:
	#	body_in_area = null
	#	timer.stop()
	#change to if least one object is remained
	wait_flag -=1
	if wait_flag <=1:
		timer.stop()

func _on_timer_timeout():
	if body_in_area:
		print('game over!')
		emit_signal("gameover")

