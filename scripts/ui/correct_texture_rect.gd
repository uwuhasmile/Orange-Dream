tool
extends TextureRect
class_name CorrectTextureRect

export var textures: Array;
export var needed_index: int = 3;

export var current_index: int = 0 setget set_current_index;

signal activated;
signal deactivated;

var original_index: int;

func _ready():
	original_index = current_index;

func set_current_index(value: int):
	var max_num: int = textures.size() - 1;
	var previous_index: int = current_index;
	
	if value > max_num:
		value = 0;
	elif value < 0:
		value = textures.size() - 1;
		
	if value == previous_index: return;
	
	current_index = value;
	
	if not Engine.is_editor_hint():
		if previous_index != needed_index and current_index == needed_index:
			emit_signal("activated");
		elif previous_index == needed_index and current_index != needed_index:
			emit_signal("deactivated");
		
	var tex: Texture = textures[current_index] as Texture;
	if not tex: return;
	
	texture = tex;

func next():
	if Engine.is_editor_hint(): return;
	
	set_current_index(current_index + 1);
	
func previous():
	if Engine.is_editor_hint(): return;
	
	set_current_index(current_index - 1);

func reset():
	set_current_index(original_index);
