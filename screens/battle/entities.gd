extends Node2D

var turn_time =2
var elapsed = 0
var turn_cooldown_time = 0.5  # Slightly longer than movement
var cooldown= turn_cooldown_time 
var actions = []
@onready var game: GameHandler = $".."
@onready var map: Map = %Map
func _process(delta: float) -> void:
	if game.pause:
		return
	if cooldown < turn_cooldown_time:
		cooldown+=delta
		return
	elapsed +=delta
	if elapsed >= turn_time:
		elapsed =0
		handle_turn()
		cooldown = 0
	
func get_movement(pos, entity)-> Vector2i:
	print("moving..")
	var component: MoveComponent = entity.get_node("MoveComponent")
	if not component:
		return pos
	var direction = component.get_move_hexes()
	var new_pos = pos + direction
	return new_pos


func handle_turn():
	var new_map:Dictionary[Vector2i, Entity] = {}
	var movements = []
	for pos in map.entities_map.keys():
		var entity: Entity = map.entities_map[pos]
		var new_pos = get_movement(pos, entity) 
		var node = map.entities_map.get(new_pos)
		if node:
			if entity.is_enemy(node):
				if entity.attack_component:
					var dead = entity.attack_component.attack(node.health_component)
					if dead:
						continue
				new_map[pos] = entity
				continue
		if new_map.has(new_pos):
			entity.wait()
			new_map[pos] = entity
			continue
		new_map[new_pos] = entity
		if new_pos == pos:
			continue
		var local_pos = map.map_to_local(new_pos)
		entity.move_component.move(map.adjust_height(local_pos), turn_time)
			
	map.entities_map = new_map
