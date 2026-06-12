@icon("res://assets/svg/swords.svg")
class_name AttackComponent extends Node2D
@onready var entity: Entity = $".."
var damage = 1

func get_attack_hexes(map: Map):
	return Vector2(1,0) *  -1 * (2 * int(entity.flipped) - 1)
	

func attack(health: HealthComponent)-> bool:
	if not health:
		return false
	print("Im attacking, ",entity.data.character_name)
	entity.animation.play("Attack")
	var dead = health.take_damage(self)
	return dead
	
