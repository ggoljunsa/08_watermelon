extends Label

func _ready():
	Global.connect("score_changed", _on_score_changed)

func _on_score_changed(new_score):
	text = "Score: " + str(new_score)
