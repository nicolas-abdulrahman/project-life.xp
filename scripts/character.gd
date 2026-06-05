@tool class_name Character extends Control



var is_dragging: bool = false
var drag_offset: Vector2 = Vector2.ZERO

func _ready() -> void:
	await get_parent().ready
	var sprite: Sprite2D = $"../Sprite2D"
	set_anchors_preset(Control.PRESET_TOP_LEFT)
	size = sprite.get_rect().size
	position = sprite.position + ( -sprite.get_rect().size / 2)


func _gui_input(event: InputEvent) -> void:
	print("character clicked")
	var entity = $".."
	var bus : EventBusClass = EventBus
	# Check if the left mouse button is pressed down
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			bus.entity_clicked.emit($"..")
			is_dragging = true
			# Calculate the offset so the node doesn't 'snap' its top-left corner to the mouse
			drag_offset = get_global_mouse_position() - global_position
		else:
			bus.entity_released.emit($"..")
			is_dragging = false

	# If the mouse moves while dragging, update the position
	if event is InputEventMouseMotion and is_dragging:
		entity.global_position = get_global_mouse_position() - drag_offset
func _draw() -> void:
	# Cria o retângulo baseado no tamanho atual (size) do seu Control
	# No _draw, o início é sempre Vector2.ZERO (coordenada local)
	var rect: Rect2 = Rect2(Vector2.ZERO, size)
	
	# Cores de debug (Verde brilhante para a borda, verde transparente para o fundo)
	var border_color: Color = Color.GREEN
	var fill_color: Color = Color(0, 1, 0, 0.15) # 15% de opacidade
	
	# 1. Pinta o fundo da área de clique para ficar bem visível
	draw_rect(rect, fill_color, true)
	
	# 2. Desenha a borda da caixa (filled = false, espessura = 2.0 pixels)
	draw_rect(rect, border_color, false, 2.0)
