extends Node
class_name AudioSettings

signal ready_sounds(volume);
signal ready_music(volume);


func _ready():
	var volume_snd: float = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Sound"));
	var volume_mus: float = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"));
	
	emit_signal("ready_sounds", volume_snd);
	emit_signal("ready_music", volume_mus);

func set_sound(value: float):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound"), value);
	
func set_music(value: float):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value);
