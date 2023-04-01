extends RigidBody2D

@export var radius : int = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	set_radius(radius)

	
func set_radius(new_radius):
	radius = new_radius
	var collision_shape : CollisionShape2D = get_node("collision_shape")
	var circle : CircleShape2D = collision_shape.shape
	circle.radius = radius
	
	get_node("canvas").size = Vector2(radius * 2, radius * 2)
	# var material = self.material as ShaderMaterial
	# material.set_shader_parameter("radius", radius)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
