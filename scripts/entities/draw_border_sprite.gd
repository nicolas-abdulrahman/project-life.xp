@tool extends Sprite2D

func _draw() -> void:
	# Cria o retângulo baseado no tamanho atual (size) do seu Control
	# No _draw, o início é sempre Vector2.ZERO (coordenada local)

	var full_texture_size: Vector2 = texture.get_size()
	
	# 2. Divide the width by columns (hframes) and height by rows (vframes)
	var frame_width: float = full_texture_size.x  / hframes
	var frame_height: float = full_texture_size.y / vframes
	
	var size1 =  Vector2(frame_width, frame_height)
	
	var rect: Rect2 = Rect2(-size1/2, size1 )
	
	# Cores de debug (Verde brilhante para a borda, verde transparente para o fundo)
	var border_color: Color = Color.GREEN
	var fill_color: Color = Color(0, 1, 0, 0.15) # 15% de opacidade
	
	# 1. Pinta o fundo da área de clique para ficar bem visível
	draw_rect(rect, fill_color, true)
	
	# 2. Desenha a borda da caixa (filled = false, espessura = 2.0 pixels)
	draw_rect(rect, border_color, false, 2.0)
