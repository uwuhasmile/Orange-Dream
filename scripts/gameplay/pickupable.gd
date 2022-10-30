extends CollisionObject2D
class_name Pickupable

export var enabled: bool = true;

export var item_id: String = "key";
export var prompt: String = "ITEM_KEY_PROMPT";
export var has_item_prompt: String = "ITEM_HAS_KEY_PROMPT";

export var pickup_sound: AudioStream;

signal picked_up;

func can_interact(interacted: Node2D) -> bool:
	var plr: Player = interacted as Player;
	if not plr: return false;
	
	return enabled and not plr.contains_inventory(item_id);
	
func get_prompt(interacted: Node2D) -> String:
	var plr: Player = interacted as Player;
	if not plr: return "";
	
	var actual_prompt: String = prompt if not plr.contains_inventory(item_id) else has_item_prompt;
	return actual_prompt if enabled else "";
	
func show_spacebar(interacted: Node2D) -> bool:
	if not enabled: return false;
	
	var plr: Player = interacted as Player;
	if not plr: return false;
	
	return not plr.contains_inventory(item_id);
	
func interact(interacted: Node2D) -> void:
	if not enabled: return;
	
	var plr: Player = interacted as Player;
	if not plr: return;
	
	if plr.add_item_to_inventory(item_id):
		enabled = false;
		plr.play_item_sound(pickup_sound);
		emit_signal("picked_up");
		queue_free();
