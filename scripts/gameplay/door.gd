extends CollisionObject2D
class_name Door

export var enabled: bool = true;
export var interaction_enabled: bool = true;

export var locked: bool = false;

export var linked_door_path: NodePath = "";
export var doors_to_change: Dictionary;

export var open_prompt: String = "DOOR_OPEN_PROMPT";
export var locked_prompt: String = "DOOR_LOCKED_PROMPT";
export var item_prompt: String = "DOOR_ITEM_KEY_PROMPT";
export var has_item_prompt: String = "DOOR_HAS_ITEM_KEY_PROMPT";
export var needed_item: String = "";

export var open_sound: AudioStream;
export var locked_sound: AudioStream;
export var lock_sound: AudioStream;
export var unlock_sound: AudioStream;

signal opened;
signal passed;
signal locked;
signal unlocked;
signal tried;

var sound_player: AudioStreamPlayer;
var linked_door: Door;
onready var tp_position: Node2D = $TpPosition;

func _ready():
	reset_linked_door();
	
	if not has_node("SoundPlayer"):
		sound_player = AudioStreamPlayer.new();
		add_child(sound_player);
		sound_player.name = "SoundPlayer";
	else: sound_player = get_node("SoundPlayer");


func can_interact(_interacted: Node2D) -> bool:
	return enabled and interaction_enabled;
	
func get_prompt(interacted: Node2D) -> String:
	if not enabled or not interaction_enabled: return "";
	
	var plr = interacted as Player;
	if not plr: return "";
	
	var item_final_prompt: String = has_item_prompt if plr.contains_inventory(needed_item) else item_prompt;
	var locked_final_prompt: String = item_final_prompt if needed_item != "" else locked_prompt;
	var actual_prompt = open_prompt if not locked else locked_final_prompt;
	return actual_prompt;
	
func show_spacebar(interacted: Node2D) -> bool:
	if not enabled or not interaction_enabled: return false;
	
	var plr = interacted as Player;
	if not plr: return false;
	
	if locked:
		return needed_item != "" and plr.contains_inventory(needed_item);
	else: return true;

	
func interact(interacted: Node2D) -> void:
	if not enabled or not interaction_enabled: return;
	
	var plr = interacted as Player;
	if not plr: return;
	
	if locked:
		if needed_item != "" and plr.contains_inventory(needed_item): unlock();
		else:
			emit_signal("tried");
			sound_player.stream = locked_sound;
			sound_player.play();
	else:
		open(interacted);
	
func open(interacted: Node2D):
	if not enabled or not linked_door: return;
	
	var plr = interacted as Player;
	if not plr: return;
	
	emit_signal("opened");
	linked_door.teleport(plr);
	sound_player.stream = open_sound;
	sound_player.play();

	
func lock(item: String = ""):
	if not enabled: return;
	
	if locked: return;
	
	needed_item = item;
	locked = true;
	emit_signal("locked");
	sound_player.stream = lock_sound;
	sound_player.play();

func unlock():
	if not enabled: return;
	
	if not locked: return;
	
	needed_item = "";
	locked = false;
	emit_signal("unlocked");
	sound_player.stream = unlock_sound;
	sound_player.play();

func teleport(node: Node2D):
	GlobalFade.start_fade();
	node.global_position = tp_position.global_position;
	emit_signal("passed");

func change_linked_door(id) -> void:
	var path: NodePath = doors_to_change[id] as NodePath;
	if not path: return;
	
	if not has_node(path): 
		print(self.name + ": door " + path + " does not exist");
		return;
	
	var new_door: Door = get_node(path) as Door;
	if not new_door: 
		print(self.name + ": door " + path + " does not exist");
		return;
	
	linked_door = new_door;
	
func reset_linked_door() -> void:
	if not has_node(linked_door_path) or not get_node(linked_door_path) as Door:
		linked_door = null;
		print(self.name + ": door " + linked_door_path + " does not exist");
	else:
		linked_door = get_node(linked_door_path) as Door;
	
	
