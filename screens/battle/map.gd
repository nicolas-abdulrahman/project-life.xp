class_name Map extends TileMapLayer

signal click
signal click_outside
var placed_tiles: Array[Vector2i] = []
var highlting = false 
var HEIGHT = 1

var selected_tile: Vector2i = Vector2i(-1,-1)
@onready var placement: TileMapLayer = $Placement
@onready var entities = $"../entities"
func _ready() -> void:
	var bus :EventBusClass = EventBus
	bus.entity_released.connect(_on_entity_release)
	for i in range(10):
		for j in  range(HEIGHT):
			var cell = 1 if i<3 else 2
			set_cell(Vector2(i,j), 1, Vector2i(0,0), cell )
	bus.entity_released.connect(_on_entity_release)
	bus.entity_clicked.connect(_on_entity_click)

	
func _on_entity_click(entity: Entity):
	if selected_tile == Vector2i(-1,-1):
		return
	entity.reparent(entities)
	entity.animation.play("Idle")
	entity.position = map_to_local(selected_tile)
	var height = tile_set.tile_size.y /4
	entity.position.y -=height
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var global_mouse_pos = get_global_mouse_position()
		var tile_pos: Vector2i = local_to_map(to_local(global_mouse_pos))
		var tile = get_cell_atlas_coords(tile_pos)
		if tile!= Vector2i(-1,-1):
			click.emit()
			clear_highlights()
			print("Clicked Tile Map Position: ", tile_pos)
			selected_tile = tile_pos
			placement.set_cell(tile_pos, 1, Vector2i(0,0))
			highlting = true
		else:
			selected_tile =  Vector2i(-1,-1)
			clear_highlights()
			click_outside.emit()
	
func _on_entity_release(entity:Entity):
	selected_tile = Vector2(-1,-1)
	clear_highlights()

func highlight_placeable_tiles() -> void:
	for tile in get_used_cells():
		placement.set_cell(tile, 1, Vector2i(0, 0))

# Dica extra: Uma função útil para limpar os destaques anteriores antes de desenhar novos
func clear_highlights() -> void:
	placement.clear()
