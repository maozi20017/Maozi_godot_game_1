extends Area2D

func processButton(button: AnimatedSprite2D, color: Color) -> void:
	if button.animation == "default":
		button.animation = "pressed"
	else:
		button.animation = "default"
	if color==Color.ORANGE:
		Global.emit_signal("toggle_orange_beam")
	if color==Color.BLUE:
		Global.emit_signal("toggle_blue_beam")

func checkButtonInput(button_area:bool,button: AnimatedSprite2D, color: Color) -> void:
	if button_area and Input.is_action_just_pressed("use"):
		processButton(button, color)
