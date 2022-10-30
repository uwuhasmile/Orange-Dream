extends Node
class_name InputAction

export var enabled: bool = true;
export var needed_action: String = "ui_accept";

var pressed: bool = false;

signal just_pressed;
signal pressed;
signal just_released;
signal released;
	

func _input(event):
	if not enabled: return;
	
	if event.is_action_pressed(needed_action):
		if not pressed:
			pressed = true;
			emit_signal("just_pressed");
		emit_signal("pressed");
	elif event.is_action_released(needed_action):
		if pressed:
			pressed = false;
			emit_signal("just_released");
		emit_signal("released");
			
