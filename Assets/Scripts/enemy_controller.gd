extends CharacterBody2D
class_name EnemyController

@export var speed: float = 1.0
@export var edge_ray: RayCast2D
@export var wall_ray: RayCast2D
@export var direction: int = 1  # 1 = right, -1 = left
@export var pivot_point: Node2D 
@export var animator: Node2D  

var speed_multiplier: float = 30.0
var HP: int = 20
var edge_cooldown: float = 0.0  # Prevent rapid direction switching

func _physics_process(delta: float) -> void:
	if HP > 0:
		check_for_turn(delta)

		# Apply gravity
		if not is_on_floor():
			velocity.y += get_gravity().y * delta 

		# Movement
		velocity.x = direction * speed * speed_multiplier
		pivot_point.scale.x = direction
		move_and_slide()

	check_death()

func check_for_turn(delta: float) -> void:
	if edge_cooldown > 0.0:
		edge_cooldown -= delta
		return

	# Edge ray: always in front of feet
	edge_ray.position.x = 10.0   # distance ahead of pivot center
	edge_ray.target_position = Vector2(0, 10.0)  # pointing down

	# Wall ray: always pointing forward
	wall_ray.position.x = 10.0   # in front of enemy
	wall_ray.target_position = Vector2(10.0, 0.0) # points right in local space

	# Flip pivot handles visual facing, rays automatically flip with pivot
	if is_on_floor() and not edge_ray.is_colliding():
		direction *= -1
		edge_cooldown = 0.2
	if wall_ray.is_colliding():
		direction *= -1
		edge_cooldown = 0.2




func take_damage(damage_amount: int) -> void:
	HP -= damage_amount

func check_death() -> void:
	if HP <= 0:
		animator.die_animation()
		# queue_free will now happen after the animation finishes
