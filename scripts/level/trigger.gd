extends Area2D
class_name Trigger

signal trigger_entered;
signal trigger_exited;

func _ready():
# warning-ignore:return_value_discarded
	connect("body_entered", self, "_body_entered");
# warning-ignore:return_value_discarded
	connect("body_exited", self, "_body_exited");

func _body_entered(_body: Node):
	emit_signal("trigger_entered");
	
func _body_exited(_body: Node):
	emit_signal("trigger_exited");
