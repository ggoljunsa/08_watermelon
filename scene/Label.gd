extends Label

@onready var animation_player = $AnimationPlayer


func _ready():
	Global.connect("score_changed", _on_score_changed)

func _on_score_changed(new_score):
	text = "Score: " + str(new_score)
	animation_player.play("ScorePop")

