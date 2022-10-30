extends Node
class_name MusicPlayer


func play_music(name: String, volume: float = 0.0, fade_in: float = 0.0, 
	fade_from: float = -80.0):
	GlobalMusicPlayer.play_music(name, volume, fade_in, fade_from);

func stop_music(fade_out: float = 0.0):
	GlobalMusicPlayer.stop_music(fade_out);
