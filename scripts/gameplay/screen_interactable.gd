extends CollisionObject2D
class_name ScreenInteractable

export var enabled: bool = true;
export var screen_scene: PackedScene;
export var prompt: String = "SCREEN_INTERACTABLE_PROMPT";

var screen: ShowableScreen;

signal showed;
signal solved;
signal unsolved;
signal hidden;

signal user_event_1;
signal user_event_2;
signal user_event_3;

func _ready() -> void:
	if not screen_scene: return;
	screen = screen_scene.instance() as ShowableScreen;	
	if not screen: return;
	
# warning-ignore:return_value_discarded
	screen.connect("showed", self, "_showed");
# warning-ignore:return_value_discarded
	screen.connect("hidden", self, "_hidden");
# warning-ignore:return_value_discarded
	screen.connect("solved", self, "_solved");
# warning-ignore:return_value_discarded
	screen.connect("unsolved", self, "_unsolved");
# warning-ignore:return_value_discarded
	screen.connect("user_event_1", self, "_user_event_1");
# warning-ignore:return_value_discarded
	screen.connect("user_event_2", self, "_user_event_2");
# warning-ignore:return_value_discarded
	screen.connect("user_event_3", self, "_user_event_3");

func can_interact(interacted: Node2D) -> bool:
	if not enabled: return false;
	
	var plr: Player = interacted as Player;
	return plr != null;

func get_prompt(interacted: Node2D) -> String:
	if not enabled: return "";
	
	var plr: Player = interacted as Player;
	return prompt if plr else "";
	
func show_spacebar(interacted: Node2D) -> bool:
	return can_interact(interacted);
	
func interact(interacted: Node2D) -> void:
	if not enabled: return;
	
	var plr: Player = interacted as Player;
	if not plr: return;
	
	plr.show_screen(screen);


func _showed():
	emit_signal("showed");
	
func _hidden():
	emit_signal("hidden");
	
func _solved():
	emit_signal("solved");
	
func _unsolved():
	emit_signal("unsolved");
	
func _user_event_1():
	emit_signal("user_event_1");
	
func _user_event_2():
	emit_signal("user_event_2");
	
func _user_event_3():
	emit_signal("user_event_3");

func call_user_event_1() -> void:
	if not enabled or not screen: return;
	
	screen.call_user_event_1();
	
func call_user_event_2() -> void:
	if not enabled or not screen: return;
	
	screen.call_user_event_2();
	
func call_user_event_3() -> void:
	if not enabled or not screen: return;
	
	screen.call_user_event_3();
