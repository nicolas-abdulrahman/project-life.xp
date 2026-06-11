class_name STATS extends Resource


# Called when the node enters the scene tree for the first time.

static func get_data() -> Array[Stat]:
	const dir ="res://scripts/resources/stats/" 
	return [
		preload(dir + "Vitality.tres"),
		preload(dir + "Agility.tres"),
		preload(dir + "Focus.tres"),
		preload(dir + "Intellect.tres"),
		preload(dir + "Spirit.tres"),
		preload(dir + "Charisma.tres")
	]
static func get_resource(name) -> Stat:
	for stat in get_data():
		if name == stat.resource_name:
			return stat
	push_error("no stat with the name, " + name)
	return
