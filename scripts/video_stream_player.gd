@tool 
extends VideoStreamPlayer

func _ready():
	if Engine.is_editor_hint():
		autoplay = true
		play()
