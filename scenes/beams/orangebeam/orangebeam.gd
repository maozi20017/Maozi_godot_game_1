extends Area2D
@onready var orange_beam: Area2D = $"."

func _ready() -> void:
	Global.connect("toggle_orange_beam",toggle_beam)

# 當有物體進入節點時執行
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.start()

func toggle_beam():
	orange_beam.visible=not visible
	orange_beam.monitoring=not monitoring
