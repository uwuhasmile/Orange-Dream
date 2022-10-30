extends Node
class_name Code

var enabled: bool = true;
export var code: String = "BCAD";

var current_code: String = "";

signal activated;
signal failed;

func set_current_code(value: String):
	if current_code == code: return;
	
	if value.length() == code.length():
		if value == code:
			current_code = value;
			emit_signal("activated");
		else:
			current_code = "";
			emit_signal("failed");
	else:
		current_code = value;
		
	print(self.name + ": current code is " + current_code);
		
func add(value: String):
	set_current_code(current_code + value);

func reset():
	current_code = "";
