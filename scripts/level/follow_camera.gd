extends Camera2D
class_name FollowCamera

export var node_to_follow_path: NodePath = "";

var node_to_follow: Node2D;

func _ready():
	if has_node(node_to_follow_path):
		node_to_follow = get_node(node_to_follow_path) as Node2D;

func _physics_process(_delta):
	if current and node_to_follow:
		global_transform = node_to_follow.global_transform;

