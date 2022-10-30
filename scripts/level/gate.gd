extends Node
class_name Gate

export var needed_num: int = 3;

var current_num: int = 0 setget set_num;

signal opened;
signal closed;

func set_num(value: int):
	var prev_num = current_num;
	var num: int = clamp(value, 0, needed_num) as int;
	if num == prev_num: return;
	
	current_num = num;
	if prev_num < needed_num and current_num >= needed_num:
		emit_signal("opened");
	elif prev_num >= needed_num and current_num < needed_num:
		emit_signal("closed");
		
	print(self.name + ": current number is set to " + str(current_num));

func add():
	set_num(current_num + 1);
	
func subtract():
	set_num(current_num - 1);

func reset():
	set_num(0);
