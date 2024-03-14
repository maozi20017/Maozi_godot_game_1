extends Area2D
@onready var blue_beam: Area2D = $"."

func _ready() -> void:
	Global.connect("toggle_blue_beam",toggle_beam)

# 當有物體進入節點時執行
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.spawn()

func toggle_beam():
	blue_beam.visible=not visible
	blue_beam.monitoring=not monitoring
