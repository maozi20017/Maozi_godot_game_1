extends Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
const button_color: Color = Color.BLUE
var button_area: bool=false
func _process(_delta: float) -> void:
	Buttons.checkButtonInput(button_area,animated_sprite_2d, button_color)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		button_area=true

func _on_body_exited(body: Node) -> void:
	if body.is_in_group("Player"):
		button_area=false
