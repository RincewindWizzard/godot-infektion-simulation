extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	var carrier_count = get_node("HBoxContainer/level_container/level").carrier_count
	var spinner :SpinBox = get_node("HBoxContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/carrier_count")
	spinner.value = carrier_count


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
