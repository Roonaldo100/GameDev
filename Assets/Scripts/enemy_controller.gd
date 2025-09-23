extends CharacterBody2D
class_name EnemyController

@export var speed: float = 1.0
@export var edge_ray: RayCast2D
@export var wall_ray: RayCast2D
@export var direction: int = 1  # 1 = right, -1 = left

var speed_multiplier: float = 30.0

var edge_cooldown: float = 0.0  # Prevent rapid direction switching

func _physics_process(delta: float) -> void:
	check_for_turn(delta)

	# Apply gravity
	if not is_on_floor():
		velocity.y += get_gravity().y * delta 
	
	# Set horizontal movement
	velocity.x = direction * speed * speed_multiplier

	# Apply movement
	move_and_slide()

func check_for_turn(delta: float) -> void:
	if edge_cooldown > 0.0:
		edge_cooldown -= delta
		return

	# Reposition the RayCast2D node itself to be in front of the enemy
	var offset_x = 10.0 * direction
	edge_ray.position.x = offset_x
	edge_ray.target_position = Vector2(0, 20.0)  # x postition, y position
	wall_ray.target_position = Vector2(10.0 * direction, 0.0)

	if is_on_floor() and not edge_ray.is_colliding():
		direction *= -1
		edge_cooldown = 0.2
	if wall_ray.is_colliding():
		direction *= -1
		edge_cooldown = 0.2  # debounce
		
