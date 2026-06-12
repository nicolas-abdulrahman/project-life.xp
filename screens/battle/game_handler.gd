class_name GameHandler extends Node2D


var pause = true
@onready var entities= $entities
@onready var map = $Map
@onready var timer:TimerLabel = %TimerLabel
@onready var container =%InventoryContainer
@onready var enemy_data = preload("res://entities/enemies/golem/golem.tres")
@onready var entity_packed = preload("res://scripts/entity.tscn")



func _ready() -> void:
	await get_tree().process_frame
	var current_scene_root : Combat = get_tree().current_scene
	current_scene_root.Play.connect(_on_start)
	current_scene_root.Pause.connect(_on_pause)
	var entity:Entity = entity_packed.instantiate()
	entities.add_child(entity)
	entity.set_data(enemy_data)
	map.add_entity(Vector2(5,0), entity)
	entity.add_child(entities)





func _on_start():
	container.visible = false
	entities.handle_turn()
	pause = false
func _on_pause():
	pause = true

func highlight_attack_area(hexes: Array[Vector2]):
	for hex in hexes:
		$Map/Attack.set_cell(hex)



	
