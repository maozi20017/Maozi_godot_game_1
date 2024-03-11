extends VBoxContainer

@export var bus_name:String
var bus_id:int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bus_id=AudioServer.get_bus_index(bus_name)

func _on_hslider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bus_id,linear_to_db(value))
