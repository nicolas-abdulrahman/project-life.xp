extends PressButton


func button_press_action():
	var current_scene_root : Combat = get_tree().current_scene
	current_scene_root.Play.emit()
