extends AudioStreamPlayer

var tween;

func play_music(name: String, volume: float = 0.0, fade_in: float = 0.0, 
	fade_from: float = -80.0):
	stream = load("res://sounds/" + name);
	play();
	if fade_in != 0.0:
		volume_db = fade_from;
		if tween:
			tween.stop();
		tween = create_tween();
		tween.tween_property(self, "volume_db", volume, fade_in);
	else:
		volume_db = volume;

func stop_music(fade_out: float = 0.0):
	if fade_out != 0.0:
		if tween:
			tween.stop();
		tween = create_tween();
		tween.tween_property(self, "volume_db", 0.0, fade_out);
		tween.connect("finished", self, "stop", [], CONNECT_ONESHOT);
	else:
		stop();
