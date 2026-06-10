@tool
@icon("res://assets/svg/icons/skill.svg")
class_name ThemedIcon
extends TextureRect

# Path to the base SVG file
@export_file("*.svg") var svg_path: String = "res://assets/svg/icons/skill.svg":
	set(value):
		svg_path = value
		update_svg()

@export var icon_size := AppThemeData.IconSize.SMALL:
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
		
	# 1. Read the raw SVG text file
	var file = FileAccess.open(svg_path, FileAccess.READ)
	var svg_text = file.get_as_text()
	file.close()
	
	# Convert Godot colors to Hex strings that SVG understands
	var fill_hex = "#" + fill_color.to_html(false)
	var stroke_hex = "#" + stroke_color.to_html(false)
	
	# 2. Inject your properties into the root elements using regex or simple replacement
	# Note: For this basic replacement to work perfectly, your base SVG file should 
	# have placeholder tags or clean styling inside the code (e.g., fill="currentColor")
	
	# Simple replacement example (assuming your SVG text contains these properties)
	svg_text = svg_text.replace('fill="currentColor"', 'fill="' + fill_hex + '"')
	svg_text = svg_text.replace('stroke="currentColor"', 'stroke="' + stroke_hex + '"')
	
	# 3. Convert the modified string back into an Image/Texture
	var img = Image.new()
	var err = img.load_svg_from_string(svg_text, Engine.get_write_movie_path() == "" and 1.0 or 1.0)
	
	if err == OK:
		# Resize the rendered vector image to match your theme bounds
		var target_scale = AppThemeData.get_value(icon_size)
		img.resize(target_scale, target_scale, Image.INTERPOLATE_LANCZOS)
		
		# Apply it to the TextureRect
		texture = ImageTexture.create_from_image(img)
