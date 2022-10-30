extends Node
class_name Note

export var texts: Array = [ "Text 1", "Text 2" ];

var current_id: int = -1;

signal started;
signal ended;
signal changed(text);


func start() -> void:
	if texts.size() <= 0: end();
	
	current_id = 0;
	emit_signal("started");
	emit_signal("changed", tr(texts[current_id]));
	
func end() -> void:
	current_id = -1;
	emit_signal("changed", "");
	emit_signal("ended");
	
func next() -> void:
	if current_id <= -1: return;
	if texts.size() <= 0 or current_id >= texts.size() - 1: 
		end();
		return;
	
	current_id += 1;
	emit_signal("changed", tr(texts[current_id]));
	
