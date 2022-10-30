extends AnimationTree
class_name PlayerAnimations

onready var parent_plr: Player = get_parent() as Player;


var velocity: Vector2;
var wish_dir: Vector2;


func _physics_process(_delta) -> void:
	wish_dir = parent_plr.wish_dir;
	velocity = parent_plr.velocity;
	
	if wish_dir.length() > 0.0 and velocity.length() > 0.0:
		get("parameters/playback").travel("walk");
		set("parameters/idle/blend_position", wish_dir.normalized());
		set("parameters/walk/blend_position", wish_dir.normalized());
	else:
		get("parameters/playback").travel("idle");
