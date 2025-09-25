extends Node2D

@export var enemy_controller : EnemyController
@export var animation_player : AnimationPlayer 
@export var walk_sprite : Sprite2D
@export var death_sprite : Sprite2D

var dead: bool = false

var hurt_timer = 0.0

func _ready():
	walk_sprite.visible = true
	death_sprite.visible = false

func _process(delta):
	if dead:
		return  # Don't play walk/idle if dead

	if enemy_controller.HP > 0:

		# Walk animation
		if abs(enemy_controller.velocity.x) > 0:
			animation_player.play("walk")
	
	if hurt_timer > 0:
		hurt_timer -= delta  # Decrease timer
		walk_sprite.modulate = Color(1, 0, 0)  # Change color to red
		if hurt_timer <= 0:  # When timer ends
			walk_sprite.modulate = Color(1, 1, 1)  # Reset color to normal (white)

# This method is called to start the hurt animation
func play_hurt_animation():
	hurt_timer = 0.3  # Set how long the "hurt" effect lasts

func die_animation():
	dead = true
	death_sprite.visible = true
	walk_sprite.visible = false
	enemy_controller.set_physics_process(false) # stop movement
	enemy_controller.set_collision_layer(0)     # disable collision
	enemy_controller.set_collision_mask(0)
	animation_player.play("death") # <-- make sure name matches AnimationPlayer

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "death":
		enemy_controller.queue_free()
