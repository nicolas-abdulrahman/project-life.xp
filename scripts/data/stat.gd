class_name Stat extends Resource

var name :String= "Vitality"
var level : int= 1
func _init(p_name: String = "New Hero", p_level: int = 1) -> void:
	name = p_name
	level = p_level
