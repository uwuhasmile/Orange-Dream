extends Node
class_name EventSequence


export var enabled: bool = true;
export var current_value: int = 0;

signal event_0;
signal event_1;
signal event_2;
signal event_3;
signal event_4;
signal event_5;
signal event_6;
signal event_7;

func _ready():
	set_current_value(current_value);

func set_current_value(value: int) -> void:
	if value < 0:
		current_value = 7;
	elif value > 7:
		current_value = 0;
	else: current_value = value;

func emit(value: int):
	if value == 0:
		emit_signal("event_0");
	elif value == 1:
		emit_signal("event_1");
	elif value == 2:
		emit_signal("event_2");
	elif value == 3:
		emit_signal("event_3");
	elif value == 4:
		emit_signal("event_4");
	elif value == 5:
		emit_signal("event_5");
	elif value == 6:
		emit_signal("event_6");
	elif value == 7:
		emit_signal("event_7");
	else:
		print(self.name + ": invalid event.");

func next():
	set_current_value(current_value + 1);
	emit(current_value);
	
func previous():
	set_current_value(current_value - 1);
	emit(current_value);
