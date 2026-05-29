@tool
extends Control

@export var outline_color: Color = Color.WHITE:
	set(value):
		outline_color= value
		queue_redraw()

@export var outline_size: float= 1:
	set(value):
		outline_size= value
		queue_redraw()

@export var hexagon_radius: float = 50.0:
	set(value):
		hexagon_radius = value
		_adjust_layout_size()
		update_minimum_size()
		queue_redraw()
		_update_sprite()

@export var hexagon_color: Color = Color.ORANGE_RED:
	set(value):
		hexagon_color = value
		queue_redraw()

@export var sprite_offset_y: float = 0.0:
	set(value):
		sprite_offset_y = value
		_update_sprite()

func _get_minimum_size() -> Vector2:
	var width = hexagon_radius * 2.0
	var height = hexagon_radius * sqrt(3.0)
	return Vector2(width, height)



func _adjust_layout_size() -> void:
	size = _get_minimum_size()

func _ready() -> void:
	item_rect_changed.connect(_on_resized)
	_adjust_layout_size()
	update_minimum_size()
	queue_redraw()
	_update_sprite()

func _on_resized() -> void:
	queue_redraw()
	_update_sprite()

func _notification(what: int) -> void:
	if what == NOTIFICATION_CHILD_ORDER_CHANGED:
		_update_sprite()

func _draw() -> void:
	var points = PackedVector2Array()
	var center = size / 2
	for i in range(6):
		var angle_rad = deg_to_rad(i * 60.0)
		var point = Vector2(
			center.x + hexagon_radius * cos(angle_rad),
			center.y + hexagon_radius * sin(angle_rad)
		)
		points.append(point)
	draw_polygon(points, PackedColorArray([hexagon_color]))
	draw_polyline(points + PackedVector2Array([points[0]]), outline_color, outline_size)

func _update_sprite() -> void:
	if get_child_count() == 0:
		return
	var sprite = get_child(0)
	if not sprite is Sprite2D:
		return
	
	# Keep the sprite exactly at the center of the control box plus your offset
	sprite.position = (size / 2) + Vector2(0, sprite_offset_y)
	
	# Force the sprite scale back to its original size (1, 1)
	#sprite.scale = Vector2.ONE
