@tool
extends CanvasItem
@export var radius: float = 50.0:
	set(value):
		radius= value
		queue_redraw() 

@export var fill: Color = Color.BLACK:
	set(value):
		fill= value
		queue_redraw()

@export var outline_color: Color = Color.WHITE:
	set(value):
		outline_color= value
		queue_redraw()

@export var outline_size: float= 1:
	set(value):
		outline_size= value
		queue_redraw()

func _ready() -> void:
	queue_redraw()

func _draw() -> void:
	var points = PackedVector2Array()
	var center = Vector2.ZERO 
	
	for i in range(6):
		var angle_rad = deg_to_rad(i * 60.0)
		var point = Vector2(
			center.x + radius* cos(angle_rad),
			center.y + radius* sin(angle_rad)
		)
		points.append(point)
	
	draw_polygon(points, PackedColorArray([fill]))
	
	draw_polyline(points + PackedVector2Array([points[0]]), outline_color, outline_size)
