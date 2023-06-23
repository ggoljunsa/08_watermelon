extends AudioStreamPlayer

var music = ["res://res/sound/ID15_snd_bubble.wav", "res://res/sound/ID15_snd_bubble.wav"]

# Called when the node enters the scene tree for the first time.
func _ready():
	self.set_volume_db(3.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func play_music(num):
	self.playing = true
	print("play")
	
