@tool class_name UserProfileNode extends Screen

@export var data : UserData
@onready var user_profile:  = %UserProfile
@onready var stats_container = %StatsContainer
func _ready() -> void:
	if data:
		if data.user_stats.size() == 0:
			data.initialize_new_profile()
		print("just work")
		%UserProfile.initialize(data) 
		%StatsContainer.initalize(data)
