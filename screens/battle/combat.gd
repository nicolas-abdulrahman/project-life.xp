class_name Combat extends Screen


signal Play
signal Pause
enum State{Pause, Playing}
var state = State.Pause
@onready var combat_ui  = %InventoryContainer
@onready var scroll_container : ScrollContainer =$PanelContainer/ScrollContainer 
@onready var map: Map =%Map 
@onready var timer: TimerLabel= %TimerLabel
@onready var game_handler: GameHandler = %GameHandler
func _ready() -> void:
	update_layout()
	map.click_outside.connect(_on_click_out)
	map.click.connect(_on_click_map)
	Play.connect(_on_play)
	Pause.connect(_on_pause)
func _on_play():
	if timer.value == 0:
		timer.count_up()
	else:
		timer.countdown()
	state= State.Playing

func _on_pause():
	state = state.Playing

func _on_click_out():
	combat_ui.visible = false
	update_layout()

func _on_click_map():
	combat_ui.visible = true
	update_layout()

func _physics_process(delta: float) -> void:
	if state == State.Playing:
		%InventoryContainer.visible= false
	#change this later!	
	
func update_layout():
	if combat_ui.visible and state== State.Pause:
		# Wait for layout to update then scroll to bottom
		await get_tree().process_frame
		scroll_container.scroll_vertical = scroll_container.get_v_scroll_bar().max_value
	else:
		scroll_container.scroll_vertical = 0
