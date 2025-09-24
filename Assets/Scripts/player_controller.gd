extends CharacterBody2D
class_name PlayerController

@export var speed = 10
@export var jump_power = 10
@export var sword : RayCast2D
@export var pivot_point : Node2D   # reference to the PivotPoint

var speed_multiplier = 30
var jump_multiplier = -30
var direction = 1
var facing = 1

# Sword vars
var sword_attacking = false
var sword_attack_timer : float = 0.0
var sword_attack_time : float = 0.5
var sword_hit_registered = false
var sword_damage = 10

func _input(event):
	if event.is_action_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_power * jump_multiplier

	if event.is_action_pressed("move_down"):
		set_collision_mask_value(3, false)
	else:
		set_collision_mask_value(3, true)

	if event.is_action_pressed("sword") and not sword_attacking:
		sword_attacking = true
		sword_attack_timer = sword_attack_time
		sword_hit_registered = false

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta 

	# Movement
	direction = Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		facing = direction
		velocity.x = direction * speed * speed_multiplier
	else:
		velocity.x = move_toward(velocity.x, 0, speed * speed_multiplier)

	# Flip whole pivot instead of sprite + sword separately
	pivot_point.scale.x = facing  

	# Sword attack
	if sword_attacking:
		if sword.is_colliding() and not sword_hit_registered:
			var hit = sword.get_collider()
			if hit and hit.is_in_group("enemy"):
				print("Enemy hit!")
				sword_hit_registered = true
				hit.take_damage(sword_damage)

		sword_attack_timer -= delta
		if sword_attack_timer <= 0.0:
			sword_attacking = false
			sword_hit_registered = false

	move_and_slide()

func teleport_to_location(new_location):
	position = new_location
