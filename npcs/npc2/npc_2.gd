extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var dialogue: DialogueResource
func _ready() -> void:
	Global.connect("start_talking",start_talking)
	Global.connect("stop_talking",stop_talking)

func talk():
	DialogueManager.show_dialogue_balloon(dialogue)

func start_talking():
	animated_sprite_2d.play("Walk")
	
func stop_talking():
	animated_sprite_2d.play("Idle")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		talk()
