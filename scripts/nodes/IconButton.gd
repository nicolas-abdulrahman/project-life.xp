@tool
@icon("res://assets/svg/icons/skill.svg") # Point to your image file here
class_name IconButton
extends Button


@export var target_scene := preload("res://screens/quests/quest_screen.tscn"):
	set(value):
		target_scene = value
@export var icon_size := AppThemeData.IconSize.BIG:
	set(value):
		icon_size = value
		update_size()

func update_size() -> void:
	var val := AppThemeData.get_value(icon_size)
	var new_size := Vector2(val, val)
	size = new_size
	custom_minimum_size = new_size


func _on_button_pressed() -> void:
	var handler = ScreenHandler as ScreenHandlerNode
	if not handler:
		return
	handler.transition_to(target_scene)
	

func _ready() -> void:
	update_size()
	expand_icon = true
	pressed.connect(_on_button_pressed)
