@icon("res://assets/svg/base/panel.svg")
@tool
class_name PanelColor extends PanelContainer

@export var color: Color = Color("034953"):
	set(value):
		color = value
		if is_inside_tree(): update()

@export var child_color: Color = Color("c9f8ff"): 
	set(value): 
		child_color = value 
		if is_inside_tree(): update()

@export var child_outline: Color = Color("000000"):
	set(value):
		child_outline = value
		if is_inside_tree(): update()

func _ready() -> void:
	update()


func update() -> void:
	# Ensure the node is inside the tree before updating visuals
	if not is_inside_tree(): 
		return
		
	self_modulate = color
	
	# Check if there is actually a child node to modify
	if get_child_count() > 0:
		var child = get_child(0)
		
		if child is Label:
			# Labels use theme overrides for font colors
			child.add_theme_color_override("font_color", child_color)
			child.add_theme_color_override("font_shadow_color", child_outline)
		elif child is ThemedIcon:
			child.stroke_color = child_color
			child.fill_color = child_outline
		else:
			
			# Standard fallback for textures or buttons
			child.modulate = child_color
