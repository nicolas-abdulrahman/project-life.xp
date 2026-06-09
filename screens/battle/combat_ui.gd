class_name CombatUI extends Container

func get_height():
	if visible:
		var container: Container = $Container
		return container.size.y
	return 0
