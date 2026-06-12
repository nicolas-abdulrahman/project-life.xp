class_name  HealthComponent extends Node2D


@onready var entity: Entity = $".."
var health 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	health = entity.data.max_health
	
func take_damage(attack: AttackComponent)-> bool:
	print("ouch, ", attack.damage)
	health -= attack.damage
	var dead = false
	if health <= 0:
		dead = true
		on_death()
	return dead 

func on_death():
	entity.queue_free()
