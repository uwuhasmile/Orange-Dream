extends Node
class_name Fade


func start_fade(from: Color = Color.black, 
	to: Color = Color(0.0, 0.0, 0.0, 0.0), time: float = 2.0) -> void:
	GlobalFade.start_fade(from, to, time);
