extends Node

var chapter: int = 1;

func _ready():
	set_chapter(ProjectSettings.get_setting("global/default_chapter") as int);

func next_chapter():
	set_chapter(chapter + 1);

func set_chapter(value: int):
	chapter = clamp(value, 0, 4) as int;
