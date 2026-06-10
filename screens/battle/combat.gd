class_name Combat extends Screen


signal Play
signal Pause
@onready var combat_ui  = %InventoryContainer
@onready var scroll_container : ScrollContainer =$PanelContainer/ScrollContainer 
@onready var map: Map =%Map 

func _ready() -> void:
	update_layout()
	map.click_outside.connect(_on_click_out)
	map.click.connect(_on_click_map)

func _on_click_out():
	combat_ui.visible = false
	update_layout()

func _on_click_map():
	combat_ui.visible = true
	update_layout()

func update_layout():
	if combat_ui.visible:
		# Wait for layout to update then scroll to bottom
		await get_tree().process_frame
		scroll_container.scroll_vertical = scroll_container.get_v_scroll_bar().max_value
	else:
		scroll_container.scroll_vertical = 0
