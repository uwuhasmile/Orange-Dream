extends CollisionObject2D
class_name Bed

export var enabled: bool = true;
export var level: String = "test_level";
export var prompt: String = "BED_TEST_LEVEL_PROMPT";
export var transition_sound: AudioStream;

signal lied;

func can_interact(_interacted: Node2D) -> bool:
	return enabled;
	
func get_prompt(interacted: Node2D) -> String:
	if not enabled: return "";
	
	var plr = interacted as Player;
	if not plr: return "";
	
	return prompt;
	
func show_spacebar(interacted: Node2D) -> bool:
	if not enabled: return false;
	
	var plr = interacted as Player;
	if not plr: return false;
	
	return true;

	
func interact(interacted: Node2D) -> void:
	if not enabled: return;
	
	var plr = interacted as Player;
	if not plr: return;
	
	plr.input_enabled = false;
	emit_signal("lied");
	GlobalFade.start_fade(Color(0.0, 0.0, 0.0, 0.0), Color(1.0, 1.0, 1.0, 1.0));
	GlobalStreamPlayer.stream = transition_sound;
	GlobalStreamPlayer.play();
	var _i = GlobalFade.connect("fade_over", get_tree(), "change_scene", 
		[ "res://scenes/levels/" + level + ".tscn" ], CONNECT_ONESHOT);
	_i = GlobalFade.connect("fade_over", GlobalFade, "start_fade", 
		[ Color(1.0, 1.0, 1.0, 1.0), Color(0.0, 0.0, 0.0, 0.0) ], CONNECT_ONESHOT);
