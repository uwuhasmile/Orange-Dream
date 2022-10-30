extends Node2D
class_name Teleport

export var node_to_tp_path: NodePath = ""

var node_to_tp;

func _ready():
	if has_node(node_to_tp_path):
		node_to_tp = get_node(node_to_tp_path);
	
func teleport():
	if not node_to_tp: return;
	
	node_to_tp.global_position = global_position;
