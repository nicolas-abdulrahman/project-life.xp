@tool
@icon("res://assets/svg/icons/skill.svg") # Point to your image file here
class_name ThemedIcon
extends TextureRect

const ICON_SIZE: Vector2i = Vector2i(20, 20)

@export var icon_style: String = "IconDefault":
	set(value):
		icon_style = value
		theme_type_variation = value
		_update_icon_style()

func _ready() -> void:
	# 1. Fix Godot's stubborn image scaling rules
	expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	
	# 2. Lock the size to our universal constant!
	custom_minimum_size = ICON_SIZE
	size = ICON_SIZE
	
	# 3. Apply the semantic colors
	_update_icon_style()
	
	# Safely connect the theme change signal so it updates live
	if not theme_changed.is_connected(_update_icon_style):
		theme_changed.connect(_update_icon_style)

func _update_icon_style() -> void:
	if has_theme_color("modulate_color", icon_style):
		modulate = get_theme_color("modulate_color", icon_style)
