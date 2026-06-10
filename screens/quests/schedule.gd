@tool
class_name Schedule extends PanelContainer
# Percentage constraints: 10%, 70%, 20%
const COL_RATIOS = [0.1, 0.5, 0.4]
const LINE_COLOR = Color(1, 1, 1, 0.4)
const LINE_WIDTH = 2.0
const padding = 3
var column_widths = [0.0, 0.0, 0.0]
var lines_overlay: Control

@onready var v_box = find_child("VBoxContainer", true, false)
@onready var header: HBoxContainer = %Header
func _ready():
	# Discovery/Setup overlay for lines to ensure they are ON TOP
	lines_overlay = get_node_or_null("LinesOverlay")
	if not lines_overlay:
		lines_overlay = Control.new()
		lines_overlay.name = "LinesOverlay"
		lines_overlay.mouse_filter = Control.MOUSE_FILTER_IGNORE
		lines_overlay.set_anchors_preset(Control.PRESET_FULL_RECT)
		add_child(lines_overlay)
	
	lines_overlay.draw.connect(_on_overlay_draw)
	
	resized.connect(_update_layout)
	
	# Initial layout
	await get_tree().process_frame
	_update_layout()

func _update_layout():
	if not is_inside_tree(): return
	
	# Base width from the panel size
	var base_width = size.x
	if base_width <= 0: base_width = 720.0
	
	# Calculate pixel widths
	for i in range(COL_RATIOS.size()):
		column_widths[i] = base_width * COL_RATIOS[i]
	
	# Apply to rows
	if v_box:
		for child in v_box.get_children():
			if child is HBoxContainer:
				_apply_to_row(child)
	
	if lines_overlay:
		lines_overlay.queue_redraw()

func _apply_to_row(container: HBoxContainer):
	container.add_theme_constant_override("separation", 0)
	container.alignment = BoxContainer.ALIGNMENT_CENTER
	
	var children = container.get_children()
	for i in range(min(children.size(), 3)):
		var child = children[i]
		child.custom_minimum_size.x = column_widths[i]
		child.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
		
		
		
		if child is Label:
			child.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		elif child is CheckBox:
			child.size_flags_horizontal = Control.SIZE_SHRINK_CENTER

func _on_overlay_draw():
	# Draw on the overlay node which is the last child (drawn last = on top)
	var height = size.y
	var current_x = 0.0
	
	for i in range(COL_RATIOS.size() - 1):
		current_x += column_widths[i]
		
		lines_overlay.draw_line(
			Vector2(current_x, header.size.y),
			Vector2(current_x, height),
			LINE_COLOR,
			LINE_WIDTH
		)
