class_name StatData extends Resource

@export var name = ""
@export var level = 1
@export var xp = 0
var xp_history = [0,0,0,0,0,0,0]

func _init(n, l, xp) -> void:
	name = n
	level = l
	xp = xp
