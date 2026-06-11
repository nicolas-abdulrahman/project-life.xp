@tool
class_name Price
extends Control

enum CurrencyType{Crystals, Chips }
@export var type: CurrencyType = CurrencyType.Crystals:
	set(v):
		type = v
		_update()

@export var price: int = 20:
	set(v):
		price = v
		if is_node_ready():
			$HBoxContainer/Label2.text = str(price)


@export var icon_modulate: Color = Color.WHITE:
	set(v):
		icon_modulate = v
		if is_node_ready():
			$HBoxContainer/IconControl/ThemedIcon.modulate = icon_modulate

@export var icon_size: Vector2 = Vector2(25, 25):
	set(v):
		icon_size = v
		if is_node_ready():
			$HBoxContainer/IconControl.custom_minimum_size = icon_size
			var icon_node = $HBoxContainer/IconControl/ThemedIcon
			icon_node.custom_minimum_size = icon_size
			icon_node.size = icon_size
			icon_node.pivot_offset = icon_size / 2
			icon_node.position = Vector2.ZERO

func update(v: int) -> void:
	price = v

func _update():
	if type== CurrencyType.Crystals:
		$HBoxContainer/IconControl/ThemedIcon.texture = preload("res://assets/svg/icons/gemstone-mineral-svgrepo-com.svg")
		$HBoxContainer/IconControl/ThemedIcon.rotation = deg_to_rad(30)
	else:
		$HBoxContainer/IconControl/ThemedIcon.texture = preload("res://assets/svg/icons/chip-svgrepo-com.svg")
		$HBoxContainer/IconControl/ThemedIcon.rotation = 0
func _ready() -> void:
	# Trigger setters to apply initial values
	self.price = price
	self.type = type

	self.icon_modulate = icon_modulate
	self.icon_size = icon_size
