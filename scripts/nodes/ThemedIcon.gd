@tool
@icon("res://assets/svg/icons/skill.svg") # Point to your image file here
class_name ThemedIcon
extends TextureRect

enum IconSize {
	SMALL,
	NORMAL,
	BIG
}

static func get_value(size: IconSize) -> int:
	match size:
		IconSize.SMALL: return 18
		IconSize.NORMAL: return 25
		IconSize.BIG: return 30
	return 25
@export var icon_size: IconSize = IconSize.SMALL:
	set(value):
		icon_size = value
		update_size()

func update_size() -> void:
	var val = get_value(icon_size)
	var new_size = Vector2(val, val)
	size = new_size
	custom_minimum_size = new_size
func _ready() -> void:
	expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	
