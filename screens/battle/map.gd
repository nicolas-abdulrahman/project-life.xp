class_name Map extends TileMapLayer

var placed_tiles: Array[Vector2i] = []
@onready var placement: TileMapLayer = $Placement

func _ready() -> void:
	var bus :EventBusClass = EventBus
	bus.entity_clicked.connect(_on_character_clicked)
	bus.entity_released.connect(_on_entity_release)
	
func _on_entity_release(entity:Entity):
	clear_highlights()
func _on_character_clicked(entity: Entity):
	highlight_placeable_tiles()
func highlight_placeable_tiles() -> void:
	for tile in get_used_cells():
		placement.set_cell(tile, 1, Vector2i(0, 0))

# Dica extra: Uma função útil para limpar os destaques anteriores antes de desenhar novos
func clear_highlights() -> void:
	placement.clear()
	
