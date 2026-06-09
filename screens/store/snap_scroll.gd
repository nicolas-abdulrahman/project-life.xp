class_name  SnapScroll extends ScrollContainer

# Signal fired when a new page locks in, perfect for running your "other stuff"
signal page_changed(page_index: int)

@export var snap_speed: float = 10.0

var current_page: int = 0
var total_pages: int = 2
var page_width: float = 0.0
var is_swiping: bool = false
var target_scroll_x: float = 0.0

@onready var h_scroll_bar = get_h_scroll_bar()

func _ready() -> void:
	# Wait a frame for the UI container layout to fully compute sizes
	await get_tree().process_frame
	
	# Assumes the first child is your HBoxContainer
	var container = get_child(0)
	if container and container.get_child_count() > 0:
		total_pages = container.get_child_count()
		# Calculate width of a single page/panel
		page_width =500 
	
	# Connect to input signals to know when the user lets go
	gui_input.connect(_on_gui_input)

func _process(delta: float) -> void:
	# Smoothly glide the scrollbar to the target page position if the user isn't actively dragging
	if not is_swiping and scroll_horizontal != target_scroll_x:
		scroll_horizontal = lerp(scroll_horizontal, int(target_scroll_x), snap_speed * delta)

func _on_gui_input(event: InputEvent) -> void:

	if event is InputEventMouseButton:
		if event.pressed:
			print("Is swipping")
			is_swiping = true
			#_on_release_action()

func _on_release_action():
	print("Released via mouse or finger!")
	is_swiping = false
	calculate_snap_target()
func calculate_snap_target() -> void:
	if page_width == 0: return
	
	# Find out exactly where the scroll bar currently sits
	var current_scroll = scroll_horizontal
	
	# Determine the closest page alignment index
	var estimated_page = current_scroll / page_width
	var base_page = floor(estimated_page)
	var remainder = estimated_page - base_page
	
	# 50% Threshold Check: If scrolled more than halfway past the current page, go to the next one
	var new_page = base_page
	if remainder >= 0.5:
		new_page = base_page + 1
	
	# Clamp the page index to stay within valid boundaries
	new_page = clamp(new_page, 0, total_pages - 1)
	
	# Calculate the exact pixel coordinate for that page destination
	target_scroll_x = new_page * page_width
	
	# If the page actually changed, trigger your side effects!
	if new_page != current_page:
		current_page = new_page
		page_changed.emit(current_page)
		_do_other_stuff(current_page)

# Put your side effects right here!
func _do_other_stuff(page_index: int) -> void:
	print("Snapped to page: ", page_index)
	# Examples:
	# 1. Update page indicator dots UI
	# 2. Play a page-flip sound effect
	# 3. Trigger asset background loading for subsequent panels
