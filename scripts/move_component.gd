@icon("res://assets/svg/icons/stats/Agility.svg")
class_name MoveComponent extends Node2D


@onready var entity: Entity = get_parent()

func get_move_hexes()->Vector2i:
	return Vector2(1,0) *  -1 * (2 * int(entity.flipped) - 1)
	
func move(target, time):
	print("moving moving, ",get_move_hexes()," to target!", target)
	entity.animation.play("Walk")
	var tween = create_tween()
	tween.tween_property(get_parent(), "position", target, time)
