extends Node2D

@onready var map : TileMapLayer = $".."
class Cords:
	var map_position : Vector2
	var node : Node
	func _init(p,n):
		map_position = p
		node = n
		
var character_pos = [Cords.new(Vector2.ZERO,preload("res://screens/store_screen/persona_container.tscn").instantiate() )]

func _ready() -> void:
	update()
func update():
	for node_pos in character_pos:
		node_pos.node.position = map.to_local(node_pos.map_position)
