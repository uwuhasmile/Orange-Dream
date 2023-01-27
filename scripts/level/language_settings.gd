extends Node
class_name LanguageSettings

signal ready_language(lang_id);

var languages: Array = [
	"en",
	"uk",
];

func _ready() -> void:
	emit_signal("ready_language", languages.find(TranslationServer.get_locale().substr(0, 2)));


func change_language(value: int) -> void:
	TranslationServer.set_locale(languages[value]);
