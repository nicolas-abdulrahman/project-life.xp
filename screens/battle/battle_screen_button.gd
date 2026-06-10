extends  PressButton

func button_press_action():
	var screen_handler : ScreenHandlerNode = ScreenHandler
	screen_handler.transition_to(load("res://screens/battle/combat.tscn"))
	print("hello")
