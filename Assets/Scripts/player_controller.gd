extends CharacterBody2D
class_name PlayerController

@export var speed = 10 #export variables allow for editting of values in inspector
@export var jump_power = 10
@export var hurt_player : AudioStreamPlayer
#@export var camera = Camera2D

var speed_multiplier = 30
var jump_multiplier = -30
var direction = 10



#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0

func _input(event):
		# Handle jump.
	if event.is_action_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_power * jump_multiplier #handle jumping
	#if event.is_action_pressed("move_down"):
		#set_collision_mask_value(10, false)
	#else:
		#set_collision_mask_value(10, true) #allows player to move down throughh 1 way platforms by disabling physics on these
	#

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta 



	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * speed * speed_multiplier
	else:
		velocity.x = move_toward(velocity.x, 0, speed * speed_multiplier)

	move_and_slide()
	
func teleport_to_location(new_location):
	#camera.smoothing.enabled = false
	position = new_location
	#await get_tree().physics_frame
	#camera.smoothing.enabled = true
