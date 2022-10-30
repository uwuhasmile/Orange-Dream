extends Control
class_name HUD

onready var interaction_label: Label = $InteractionLabel;
onready var spacebar_image: TextureRect = $Spacebar;

func update_interaction_prompt(prompt: String) -> void:
	if prompt == "":
		interaction_label.text = "";
		interaction_label.visible = false;
		return;
		
	interaction_label.visible = true;
	interaction_label.text = prompt;

func update_spacebar(spacebar: bool) -> void:
	spacebar_image.visible = spacebar;
