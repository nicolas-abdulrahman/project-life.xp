class_name Character extends Control



var is_dragging: bool = false
var drag_offset: Vector2 = Vector2.ZERO

func _gui_input(event: InputEvent) -> void:
	print("clicked on character")
	# Check if the left mouse button is pressed down
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			is_dragging = true
			# Calculate the offset so the node doesn't 'snap' its top-left corner to the mouse
			drag_offset = get_global_mouse_position() - global_position
		else:
			is_dragging = false

	# If the mouse moves while dragging, update the position
	if event is InputEventMouseMotion and is_dragging:
		global_position = get_global_mouse_position() - drag_offset
