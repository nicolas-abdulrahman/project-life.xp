@tool extends HBoxContainer

@export var first_color: Color = AppThemeData.blue:
	set(value):
		first_color = value
		update_colors()

@export var second_color: Color =AppThemeData.red:
	set(value):
		second_color = value
		update_colors()
@export var separator_color: Color =AppThemeData.white:
	set(value):
		separator_color = value
		update_colors()
@onready var first = $Label
@onready var second = $Label2
@onready var separator = $Label3
func _ready():
	update_colors()

func update_colors():
	if is_node_ready():
		first.add_theme_color_override("font_color", first_color)
		second.add_theme_color_override("font_color", second_color)
		separator.add_theme_color_override("font_color", separator_color)
