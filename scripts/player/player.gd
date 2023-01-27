extends KinematicBody2D
class_name Player


export var input_enabled: bool = true;
export var movement_enabled: bool = true;
export var sprint_enabled: bool = true;
export var can_attack: bool = true;
export var can_interact: bool = true;

export var item_inventory: Array;

export var walk_speed: float = 300.0;
export var run_speed: float = 300.0;
export var acceleration: float = 9.0;

export var interaction_distance: float = 60.0;

var sprinting: bool = false;

var wish_dir: Vector2 = Vector2.ZERO;
var velocity: Vector2 = Vector2.ZERO;

var interacting_item: CollisionObject2D;
var current_screen: ShowableScreen;

onready var interaction_raycast = $InteractionRayCast;
onready var hud: HUD = get_node("%HUD");
onready var item_sounds: AudioStreamPlayer = $ItemSounds;

func _draw():
	if OS.is_debug_build():
		var int_color: Color = Color.green if interacting_item and interacting_item.can_interact(self) else Color.red;
		if can_interact: draw_line(Vector2(0, 0), interaction_raycast.cast_to, int_color, 2, false);

func _process(_delta):
	update();
	
	process_input();
	process_hud();

func _physics_process(delta) -> void:
	if movement_enabled: process_movement(delta);
	else: velocity = Vector2.ZERO;
	if input_enabled:
		if can_interact: process_interaction();
	
func process_movement(delta: float):
	if input_enabled and movement_enabled: 
		wish_dir = Input.get_vector("move_left", "move_right", 
			"move_up", "move_down").normalized();
	else:
		wish_dir = Vector2.ZERO;
	sprinting = sprint_enabled and Input.is_action_pressed("sprint");
	
	var needed_speed = walk_speed if not sprinting else run_speed;
	var desired_velocity: Vector2 = wish_dir * needed_speed;
	
	velocity = velocity.linear_interpolate(desired_velocity, acceleration * delta);
	velocity = move_and_slide(velocity);

func process_interaction() -> void:
	if wish_dir.length() > 0: interaction_raycast.cast_to = wish_dir * interaction_distance;
	if not interaction_raycast.is_colliding():
		interacting_item = null;
		return;
	var casted_item = interaction_raycast.get_collider();
	if not (casted_item.has_method("can_interact") and casted_item.has_method("interact") 
		and casted_item.has_method("get_prompt") and casted_item.has_method("show_spacebar")): return;
	interacting_item = casted_item;

func process_input() -> void:
	if input_enabled:
		if Input.is_action_just_pressed("interact") and interacting_item:
			if can_interact and interacting_item.can_interact(self): interacting_item.interact(self);

func process_hud():
	if input_enabled and can_interact and interacting_item:
		hud.update_interaction_prompt(interacting_item.get_prompt(self));
		hud.update_spacebar(interacting_item.show_spacebar(self));
	else:
		hud.update_interaction_prompt("");
		hud.update_spacebar(false);

func contains_inventory(item: String) -> bool:
	return item_inventory.has(item);

func add_item_to_inventory(item: String) -> bool:
	if item_inventory.has(item): return false;
	item_inventory.append(item);
	return true;
	
func remove_item_from_inventory(item: String) -> void:
	if not item_inventory.has(item): return;
	item_inventory.remove(item_inventory.find(item));
	
func play_item_sound(stream: AudioStream):
	item_sounds.stream = stream;
	item_sounds.play();
	
func show_screen(screen: ShowableScreen) -> void:
	if not screen: return;
	
	current_screen = screen;
	$HUDLayer.add_child(current_screen);
# warning-ignore:return_value_discarded
	current_screen.connect("hidden", self, "hide_screen", [], CONNECT_ONESHOT);
	current_screen.show_screen();
	input_enabled = false;
	
func hide_screen() -> void:
	if not current_screen: return;
	
	$HUDLayer.remove_child(current_screen);
	current_screen = null;
	input_enabled = true;


func free():
	pass # Replace with function body.
