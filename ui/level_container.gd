extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_resized():
	var level = get_node("level")
	var rect = self.get_rect()
	level.on_level_container_resized(rect.size.x, rect.size.y)
