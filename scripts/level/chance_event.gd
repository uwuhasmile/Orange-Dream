extends Node
class_name ChanceEvent

export var chance: int = 25;

signal called;

func emit():
	var random = RandomNumberGenerator.new();
	random.randomize();
	var num: int = random.randi_range(1, 100) as int;
	if num <= chance:
		emit_signal("called");
		
	print(self.name + ": chance is " + str(chance) + ", value is " + str(num));
