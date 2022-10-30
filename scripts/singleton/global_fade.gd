extends CanvasLayer

onready var fade_rect: ColorRect = $FadeRect;

var tween;

# warning-ignore:unused_signal
signal fade_over;

func start_fade(from: Color = Color.black, to: Color = Color(0.0, 0.0, 0.0, 0.0), 
	time: float = 2.0) -> void:
	if tween:
		tween.stop();
	tween = create_tween();
	fade_rect.color = from;
	tween.tween_property(fade_rect, "color", to, time);
	tween.connect("finished", self, "emit_signal", [ "fade_over" ]);

func get_current() -> Color:
	return fade_rect.color;
