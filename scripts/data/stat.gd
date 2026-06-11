class_name Stat extends Resource

@export var icon :Texture2D
@export var color= Color.WHITE
@export var flip = false

func get_xp_to_next_level(current_level: int):
	# Level 1  -> 100 XP
	# Level 5  -> 136 XP   (Very easy)
	# Level 10 -> 225 XP   (Still gentle)
	# Level 20 -> 625 XP   (Very achievable!)
	# Level 30 -> 1,600 XP  (Ramping up...)
	# Level 50 -> 6,400 XP  (The wall hits!)
	return int(100.0 * pow(1 + (current_level - 1) / 4.0, 2))
