class_name TimerLabel extends Label

signal Timer0
var value = 0
enum State{Pause, CountDown, CountUp}
var state = State.Pause


func display_time():
	var hours: int = int(value) / 3600
	var minutes: int = (int(value) % 3600) / 60
	var seconds: int = int(value) % 60
	
	# Formats to 2 digits each, separated by colons (e.g., "01:14:05")
	text = "%02d:%02d:%02d" % [hours, minutes, seconds]

func set_minutes(minutes: int):
	value = minutes * 60
	display_time()

func countdown():
	state= State.CountDown
func count_up():
	state = State.CountUp
	
func _process(delta: float) -> void:
	var multiplier = 1
	match state:
		State.Pause:
			return
		State.CountDown:
			multiplier =-1
	value +=  delta * multiplier
	display_time()
	if value <=0:
		value = 0
		state = State.Pause
		Timer0.emit()
