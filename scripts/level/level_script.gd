extends Node
class_name LevelScript


func go_to_level(level_name: String):
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/levels/" + level_name + ".tscn");

func quit():
	get_tree().quit();
