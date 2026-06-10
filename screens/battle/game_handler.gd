extends Node2D

enum State{Pause, Playing}
var state = State.Pause
@onready var entities= $entities
@onready var map = $Map
@onready var timer:TimerLabel = %TimerLabel
@onready var container =%InventoryContainer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame

	var current_scene_root : Combat = get_tree().current_scene
	current_scene_root.Play.connect(_on_start)

func _on_start():
	if timer.value == 0:
		timer.count_up()
	else:
		timer.countdown()
	
	state = State.Playing
	container.visible = false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if state == State.Pause:
		return
	var bus : EventBusClass = EventBus
	bus.animate.emit("Walk")
	entities.position.x +=delta* 20
	
