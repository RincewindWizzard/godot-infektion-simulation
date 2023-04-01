extends Node2D

@export var carrier_count : int = 1
@export var carrier_scene: PackedScene
@export var initial_velocity : float = 500
@onready var level_bounds : CollisionPolygon2D = get_node("level_bounds/CollisionPolygon2D")
@onready var rng = RandomNumberGenerator.new()
const border_margin = 100
var carriers = []



# Called when the node enters the scene tree for the first time.
func _ready():
	change_carrier_count(carrier_count)
		
		
func change_carrier_count(count):
	var spawn_area : Rect2 = get_rect()
	print(spawn_area)
	if len(carriers) < count:
		while len(carriers) < count:
			var carrier = carrier_scene.instantiate()
			carrier.set_position(random_position())
			carrier.linear_velocity = Vector2(initial_velocity, 0).rotated(rng.randf_range(0, 2 * PI))
			self.add_child(carrier)
			carriers.append(carrier)
	else:
		while count < len(carriers):
			var del_carrier = carriers[0]
			self.remove_child(del_carrier)
			carriers.remove_at(0)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func get_rect() -> Rect2:
	var polygon : PackedVector2Array = level_bounds.get_polygon()
	var width = 0
	var height = 0

	for vec in polygon:
		width = max(width, vec.x)
		height = max(height, vec.y)
	
	return Rect2(0, 0, width, height)

func on_level_container_resized(width, height):

	var new_rect = PackedVector2Array()
	new_rect.append(Vector2(0, 0))
	new_rect.append(Vector2(width, 0))
	new_rect.append(Vector2(width, height))
	new_rect.append(Vector2(0, height))
	
	level_bounds.set_polygon(new_rect)
	
	var carrier_count = len(carriers)
	for carrier in carriers:
		if is_out_of_bounds(carrier.get_position()):
			carrier.set_position(random_position())

	print("on_level_container_resized" + str(get_rect()))

func is_out_of_bounds(pos):
	var bounds = get_rect()
	
	return (
		pos.x < border_margin 
		or pos.x > bounds.end.x - border_margin
		or pos.y < border_margin 
		or pos.y > bounds.end.y - border_margin
	)
	
func random_position() -> Vector2:
	var spawn_area = get_rect()
	return Vector2(
		rng.randf_range(spawn_area.position.x + border_margin, spawn_area.end.x - border_margin),
		rng.randf_range(spawn_area.position.y + border_margin, spawn_area.end.y - border_margin)
	)

func _on_carrier_count_value_changed(value):
	change_carrier_count(value)


func _on_restart_button_pressed():
	var count = len(carriers)
	change_carrier_count(0)
	change_carrier_count(count)
