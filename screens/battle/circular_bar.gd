@tool
extends Control

@onready var clock = %TimerLabel
@export var radius: float = 120.0:
	set(v):
		radius = v
		custom_minimum_size = Vector2(radius * 2 + 60, radius * 2 + 60)
		queue_redraw()
@export var padding =2
@export var bar_thickness: float = 20.0
@export var tick_count: int = 60
@export var tick_length: float = 15.0
@export var handle_size: Vector2 = Vector2(10, 40)
@export var value: float = 0.0: # Normalized 0.0 to 1.0
	set(v):
		value = clamp(v, 0.0, 1.0)
		queue_redraw()
		
@onready var timer_label = %TimerLabel
@onready var element = $".."
var is_dragging: bool = false

var total = 0
func _ready() -> void:
	radius = element.size.x /2 +tick_length + padding
	custom_minimum_size = Vector2(radius * 2 + 60, radius * 2 + 60)
	mouse_filter = MouseFilter.MOUSE_FILTER_PASS

func _draw() -> void:
	var center = size / 2.0
	
	# Draw the background track
	draw_arc(center, radius, 0, TAU, 100, Color(1, 1, 1, 0.1), bar_thickness, true)
	
	# Draw ticks (vertical lines around the circle)
	for i in range(tick_count):
		var angle = (float(i) / tick_count) * TAU - (TAU / 4)
		var dir = Vector2.from_angle(angle)
		
		# Make them "vertical" by drawing them with a constant X-offset or just radial?
		# The user said "vertical lines", let's try to make them look like a stylized cage
		var start = center + dir * (radius - tick_length / 2.0)
		var end = center + dir * (radius + tick_length / 2.0)
		
		var tick_color = Color(1, 1, 1, 0.3)
		if float(i) / tick_count <= value:
			tick_color = Color(0.2, 0.8, 1.0, 0.8) # Cyan-ish
		
		draw_line(start, end, tick_color, 3.0, true)
	
	# Draw the handle (the draggable bar)
	var handle_angle = value * TAU - PI/2.0
	var handle_dir = Vector2.from_angle(handle_angle)
	var handle_pos = center + handle_dir * radius
	
	# The handle is a larger "vertical" bar
	draw_set_transform(handle_pos, handle_angle + PI/2.0, Vector2.ONE)
	# Glow effect for handle
	draw_rect(Rect2(-handle_size / 2.0 - Vector2(2, 2), handle_size + Vector2(4, 4)), Color(1, 0.4, 0, 0.3))
	draw_rect(Rect2(-handle_size / 2.0, handle_size), Color.ORANGE)
	draw_set_transform(Vector2.ZERO, 0, Vector2.ONE)

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				if _is_pos_near_handle(event.position):
					is_dragging = true
					get_viewport().set_input_as_handled()
			else:
				if is_dragging:
					is_dragging = false
					get_viewport().set_input_as_handled()
	
	if event is InputEventMouseMotion and is_dragging:
		_update_value_from_pos(event.position)
		get_viewport().set_input_as_handled()

func _is_pos_near_handle(pos: Vector2) -> bool:
	var center = size / 2.0
	var handle_angle = value * TAU - PI/2.0
	var handle_dir = Vector2.from_angle(handle_angle)
	var handle_pos = center + handle_dir * radius
	return pos.distance_to(handle_pos) < 30.0 # Threshold for easier clicking

func _update_value_from_pos(pos: Vector2) -> void:
	var center = size / 2.0
	var diff = pos - center
	var angle = diff.angle() + PI/2.0 # Adjust so 0 is at top
	if angle < 0:
		angle += TAU
	
	
	var new_value = angle / TAU
	if value > 0.8 and new_value < 0.2:
		print("Full circle completed clockwise!")
		total +=1
	elif value < 0.2 and new_value > 0.8:
		if total ==0:
			return
		print("Full circle completed counter-clockwise!")
		total -=1
		if total<0:
			total =0
	value = new_value
	var minutes = int(value * 60)
	minutes += total *60
	clock.set_minutes(minutes)
	
	

func is_near_clock(value: float, threshold: float, tolerance: float) -> bool:
	var distance = abs(value - threshold)

	# If the distance is huge (like 59), it means we are measuring the long way 
	# around the circle. This flips it to measure across the 12 o'clock gap.
	if distance > 30: 
		distance = 60 - distance
		
	return distance <= tolerance
