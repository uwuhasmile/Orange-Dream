extends Control
class_name ShowableScreen

var showed: bool = false;

var fade_tween;
onready var fade_rect: ColorRect = $FadeRect;

signal showed;
signal showed_final;
signal started_hide;
signal solved;
signal unsolved;
signal hidden;

signal user_event_1;
signal user_event_2;
signal user_event_3;

func show_screen() -> void:
	if showed: return;
	
	showed = true;
	fade_tween = create_tween();
	fade_rect.modulate = Color.white;
	fade_tween.tween_property(fade_rect, "modulate", Color(1.0, 1.0, 1.0, 0.0), 1.0);
	fade_tween.connect("finished", self, "_ended_showing", [], CONNECT_ONESHOT);
	emit_signal("showed");
	
func hide_screen():
	if not showed: return;
	
	showed = false;
	fade_tween = create_tween();
	fade_rect.modulate = Color(1.0, 1.0, 1.0, 0.0);
	fade_tween.tween_property(fade_rect, "modulate", Color(1.0, 1.0, 1.0, 1.0), 1.0);
	fade_tween.connect("finished", self, "_ended_hiding", [], CONNECT_ONESHOT);
	emit_signal("started_hide");
	
func _ended_showing():
	emit_signal("showed_final");
	
func _ended_hiding():
	emit_signal("hidden");
	
func solve():
	emit_signal("solved");
	
func unsolve():
	emit_signal("unsolved");

func call_user_event_1():
	emit_signal("user_event_1");
	
func call_user_event_2():
	emit_signal("user_event_2");
	
func call_user_event_3():
	emit_signal("user_event_3");
