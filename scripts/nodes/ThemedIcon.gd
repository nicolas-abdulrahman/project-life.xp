@tool
@icon("res://assets/svg/icons/skill.svg") # Point to your image file here
class_name ThemedIcon
extends TextureRect


@export var icon_size := AppThemeData.IconSize.SMALL:
	set(value):
		icon_size = value
		update_size()

func update_size() -> void:
	var val := AppThemeData.get_value(icon_size)
	var new_size := Vector2(val, val)
	size = new_size
	custom_minimum_size = new_size
func _ready() -> void:
	expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	
