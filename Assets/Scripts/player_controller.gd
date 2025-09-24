extends CharacterBody2D
class_name PlayerController

@export var speed = 10
@export var jump_power = 10
@export var sword : RayCast2D

var speed_multiplier = 30
var jump_multiplier = -30
var direction = 1 #can be 0, unlike facing
var facing = 1
#Sword vars
var sword_attacking = false #Set to true on attack press
var sword_attack_timer : float = 0.0 #timer for sword collision active
var sword_attack_time : float = 0.5 #Max time sword collision is active
var sword_hit_registered = false
var sword_damage = 10

func _input(event):
	if event.is_action_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_power * jump_multiplier

	if event.is_action_pressed("move_down"):
		set_collision_mask_value(3, false)
	else:
		set_collision_mask_value(3, true)

	if event.is_action_pressed("sword") and not sword_attacking: #prevent call to if already attacking
		sword_attacking = true
		sword_attack_timer = sword_attack_time
		sword_hit_registered = false  # reset hit flag for new swing

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

	# Sword always in front of player
	sword.target_position = Vector2(20 * facing, 0)

	# Sword attack
	if sword_attacking:
		if sword.is_colliding() and not sword_hit_registered:
			var hit = sword.get_collider()
			if hit and hit.is_in_group("enemy"):
				print("Enemy hit!")
				sword_hit_registered = true  # only hit once this swing
				hit.take_damage(sword_damage)

		sword_attack_timer -= delta
		if sword_attack_timer <= 0.0:
			sword_attacking = false
			sword_hit_registered = false  # reset for next swing

	move_and_slide()

func teleport_to_location(new_location):
	position = new_location
