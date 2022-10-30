extends Node
class_name Chapter



# warning-ignore:unused_signal
signal chapter_1;
# warning-ignore:unused_signal
signal chapter_2;
# warning-ignore:unused_signal
signal chapter_3;
# warning-ignore:unused_signal
signal chapter_4;

func _ready():
	var current_chapter = clamp(GameState.chapter, 0, 4);
	emit_signal("chapter_" + str(current_chapter));

func next():
	GameState.next_chapter();

func set_chapter(value: int):
	GameState.set_chapter(value);
