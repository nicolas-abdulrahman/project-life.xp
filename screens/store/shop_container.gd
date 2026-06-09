@tool class_name ShopContainer extends PanelContainer


@onready var container = $VBoxContainer/MarginContainer/HBoxContainer2
@onready var label = $VBoxContainer/MarginContainer2/Label
@export var entities: Array[EntityData]
var accent = false
@export var text = "Personfffa":
	set(value):
		text = value
		update()
	
func update():
	if not is_inside_tree() or get_child_count()==0:
		return
	label.text = text
var entity_container = preload("res://screens/store/entity_shop_container.tscn")
func _ready():
	for entity: EntityData in entities:
		var entity_c: EntityContainer = entity_container.instantiate()
		entity_c.data = entity

		container.add_child(entity_c)
		entity_c.data = entity
		
