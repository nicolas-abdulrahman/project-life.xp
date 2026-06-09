extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _pressed():
	var handler :ScreenHandlerNode = ScreenHandler
	handler.transition_to(load("res://screens/quests/quest_screen.tscn"))
