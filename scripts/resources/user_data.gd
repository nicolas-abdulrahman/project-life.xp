class_name UserData extends Resource



@export var user_stats: Array[StatData] = []
@export var user_name = "Nicolas"
@export var user_level = 1
@export var profile_xp = 0
@export var picture: Texture2D = load("res://assets/sprites/lifexp.png")
@export var inventory = Inventory.new()

func initialize_new_profile():
	if user_stats.size()==0:
		for stat in STATS.get_data():
			user_stats.append(StatData.new(stat.resource_name, 1 ,0))
