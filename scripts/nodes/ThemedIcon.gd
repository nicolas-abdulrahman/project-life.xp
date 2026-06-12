@tool
@icon("res://assets/svg/icons/skill.svg")
class_name ThemedIcon
extends TextureRect

# Path to the base SVG file
@export_file("*.svg") var svg_path: String = "res://assets/svg/icons/skill.svg":
	set(value):
		svg_path = value
		update_svg()

@export var icon_size: AppThemeData.IconSize= AppThemeData.IconSize.SMALL:
	set(value):
		icon_size = value
		update_size()

@export var fill_color: Color = Color.WHITE:
	set(value):
		fill_color = value
		update_svg()

@export var stroke_color: Color = Color.BLACK:
	set(value):
		stroke_color = value
		update_svg()

@export var stroke_width: float = 2.0:
	set(value):
		stroke_width = value
		update_svg()

func _ready() -> void:
	stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	update_size()
	update_svg()

func update_size() -> void:
	var val := AppThemeData.get_value(icon_size)
	var new_size := Vector2(val, val)
	custom_minimum_size = new_size
	size = new_size

func update_svg() -> void:
	if not FileAccess.file_exists(svg_path):
		return
	
	var svg_text = FileAccess.get_file_as_string(svg_path)
	
	# Convert colors to hex
	var fill_hex = "#" + fill_color.to_html(false)
	var stroke_hex = "#" + stroke_color.to_html(false)
	
	# Replace ANY hex color (simplistic but effective)
	var fill_regex = RegEx.new()
	fill_regex.compile('fill="#[0-9A-Fa-f]{6}"')
	svg_text = fill_regex.sub(svg_text, 'fill="' + fill_hex + '"', true)
	
	var stroke_regex = RegEx.new()
	stroke_regex.compile('stroke="#[0-9A-Fa-f]{6}"')
	svg_text = stroke_regex.sub(svg_text, 'stroke="' + stroke_hex + '"', true)
	
	# Load as texture (Godot 4.3+)
	var dpi_texture = DPITexture.create_from_string(svg_text)
	if dpi_texture:
		texture = dpi_texture
