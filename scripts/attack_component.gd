extends Node2D
@onready var entity: Entity = $".."


func get_attack_hexes(map: Map):
	return Vector2(1,0)
	

func attack():
	entity.animation.play("Attack")
	
