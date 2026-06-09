class_name Combat extends Screen



@onready  var combat_ui : CombatUI = $PanelContainer/VBoxContainer/Container
@onready var map: Map = $PanelContainer/VBoxContainer/SubViewportContainer/SubViewport/Map
func _ready() -> void:
	update()
	map.click_outside.connect(_on_click_out)
	map.click.connect(_on_click_map)

func _on_click_out():
	combat_ui.visible = false
	update()
func _on_click_map():
	combat_ui.visible = true
	update()

func update():
	pass
	#map.position.y= get_viewport_rect().size.y - combat_ui.get_height()  -  map.HEIGHT * map.tile_set.tile_size.y
	
