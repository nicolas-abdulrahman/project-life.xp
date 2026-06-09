class_name ScreenHandlerNode extends CanvasLayer

@onready var color_rect := $ColorRect
@onready var panel = $PanelContainer2
func _ready():
	await get_tree().process_frame
	
	# Grab the top parent node of the currently active scene
	var root_node = get_tree().current_scene
	
	if root_node:
		if root_node is Screen:
			panel.visible =  root_node.display_bottom_bar
	


func transition_to(target_scene_path: PackedScene, duration: float = 0.3) -> void:
	# 1. Block inputs so the user can't spam buttons during the transition
	color_rect.mouse_filter = Control.MOUSE_FILTER_STOP
	
	# 2. Fade to black
	var tween := create_tween()
	tween.tween_property(color_rect, "color:a", 1.0, duration)
	await tween.finished
	

	await get_tree().process_frame
	var tree := get_tree()
	var root := tree.root
	
	if tree.current_scene:
		tree.current_scene.queue_free()
	
	# 2. Attach your pre-existing instantiated node to the root viewport
	var new_scene := target_scene_path.instantiate()
	root.add_child(new_scene)
	tree.current_scene = new_scene
	await tree.process_frame
	
	# 4. Fade back out to reveal the new screen
	var tween_out := create_tween()
	tween_out.tween_property(color_rect, "color:a", 0.0, duration)
	await tween_out.finished
	
	# 5. Unblock inputs
	color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
