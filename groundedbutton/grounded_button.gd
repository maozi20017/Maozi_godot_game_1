extends Area2D

var pressed: bool=false
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _on_body_entered(body: Node) -> void:
	print(body)
	if body.is_in_group("Player"):
		animated_sprite_2d.animation="pressed"
		pressed=true


func _on_body_exited(body: Node) -> void:
	if body.is_in_group("Player"):
		animated_sprite_2d.animation="default"
		pressed=false
