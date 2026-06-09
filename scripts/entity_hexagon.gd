@tool
class_name  PersonaContainer
extends Control


@export var flip : bool = false:
	set(value):
		flip= value
		_update_entity()
		queue_redraw()
@export var data: EntityData:
	set(value):
		data = value
		_update_entity()
		queue_redraw()
@export var outline_color: Color = Color.WHITE:
	set(value):
		outline_color= value
		queue_redraw()

@export var outline_size: float= 1:
	set(value):
		outline_size= value
		queue_redraw()

@export var hexagon_radius: float = 30.0:
	set(value):
		hexagon_radius = value
		_adjust_layout_size()
		update_minimum_size()
		queue_redraw()
		_update_entity()

@export var hexagon_color: Color = Color.BLACK:
	set(value):
		hexagon_color = value
		queue_redraw()

@export var sprite_offset_y: float = 20.0:
	set(value):
		sprite_offset_y = value
		_update_entity()

@onready var entity = $Entity
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
	_update_entity()
	queue_redraw()

func _on_resized() -> void:
	queue_redraw()
	_update_entity()

func _notification(what: int) -> void:
	if what == NOTIFICATION_CHILD_ORDER_CHANGED:
		_update_entity()

func _draw() -> void:
	var points := PackedVector2Array()
	var center := size / 2
	for i in range(6):
		var angle_rad := deg_to_rad(i * 60.0)
		var point := Vector2(
			center.x + hexagon_radius * cos(angle_rad),
			center.y + hexagon_radius * sin(angle_rad)
		)
		points.append(point)
	draw_polygon(points, PackedColorArray([hexagon_color]))
	draw_polyline(points + PackedVector2Array([points[0]]), outline_color, outline_size)

func _update_entity() -> void:
	if not is_inside_tree() or get_child_count()==0:
		return
	var entity: Entity = get_child(0)
	await get_tree().process_frame
	entity.set_data(data) 
	var center := size / 2
	entity.position.y =center.y -(entity.get_height()/2 ) 
	entity.position.x =  center.x
	
func get_entity()-> Entity:
	return $Entity
	
func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		# Check if it was the left mouse button and it was just pressed down
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var bus: EventBusClass = EventBus
			bus.entity_clicked.emit(entity)
			print("character click")
