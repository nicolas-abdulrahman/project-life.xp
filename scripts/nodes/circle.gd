@icon("res://assets/svg/base/circle.svg")
@tool # This line lets you see the circle update directly inside the Godot editor!
class_name 	Circle
extends Control

@export var circle_color: Color = Color.WHITE:
	set(value):
		circle_color = value
		queue_redraw() # Tells Godot to update the shape when you change the color

func _draw() -> void:
	# Calculate the exact center point of the Control node
	var center = size / 2
	
	# Use the smallest side of the control node to calculate a perfect radius
	var radius = min(size.x, size.y) / 2
	
	# Draw it!
	draw_circle(center, radius, circle_color)

# This ensures the circle updates live if you resize the UI layout box in the editor
func _notification(what):
	if what == NOTIFICATION_RESIZED:
		queue_redraw()
