extends Node
class_name ConditionalEvent

export var value: bool = true;

# warning-ignore:unused_signal
signal yes;
# warning-ignore:unused_signal
signal no;

func emit() -> void:
	emit_signal("yes" if value else "no");
