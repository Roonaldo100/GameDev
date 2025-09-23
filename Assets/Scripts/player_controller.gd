extends CharacterBody2D
class_name PlayerController

@export var speed = 10 #export variables allow for editing in inspector
@export var jump_power = 10
@export var sword : RayCast2D

var speed_multiplier = 30
var jump_multiplier = -30
var direction = 1 #Direction allows for 0, while facing does not
var facing = 1  # 1 = right, -1 = left
var sword_attacking = false
var sword_attack_timer : float = 0.0
var sword_attack_time : float = 0.2

func _input(event):
	# Handle jump
	if event.is_action_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_power * jump_multiplier
	
	# One-way platforms
	if event.is_action_pressed("move_down"):
		set_collision_mask_value(3, false)
	else:
		set_collision_mask_value(3, true)

	# Sword attack
	if event.is_action_pressed("sword"):
		sword_attacking = true
		sword_attack_timer = sword_attack_time

func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta 

	# Sword attack handling
	if sword_attacking:
		if sword.is_colliding():
			var hit = sword.get_collider()
			if hit and hit.is_in_group("enemy"):
				print("Enemy hit!")
				sword_attacking = false
		sword_attack_timer -= delta
		if sword_attack_timer <= 0.0:
			sword_attacking = false

	# Movement input
	direction = Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		facing = direction  # update facing only when moving
		velocity.x = direction * speed * speed_multiplier
	else:
		velocity.x = move_toward(velocity.x, 0, speed * speed_multiplier)

	# Sword always in front of player facing
	sword.target_position = Vector2(20 * facing, 0)

	move_and_slide()
	
func teleport_to_location(new_location):
	position = new_location
