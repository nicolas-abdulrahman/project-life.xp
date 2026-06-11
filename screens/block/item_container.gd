extends VBoxContainer

@export var data: Item
@onready var item_name = $Label
@onready var effect = $Label2
@onready var item : Key= $PanelContainer/VBoxContainer/MarginContainer/SubViewportContainer/SubViewport/Key
@onready var price: Price = $PanelContainer/VBoxContainer/Price
func _ready() -> void:
	if data:
		$PanelContainer/VBoxContainer/Price
		item_name.text = data.name
		effect.text = data.effect
		await get_tree().process_frame
		item.set_data(data)
		price.update(data.price)
