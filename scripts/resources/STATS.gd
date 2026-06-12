class_name STATS extends Resource



static func stats() -> Array[String]:
	return ["Vitality", "Agility", "Focus", "Intellect", "Spirit", "Charisma"]
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
	var i = 0
	for stat in stats():
		if stat== name:
			return get_data().get(i)
		i+=1
	return null
