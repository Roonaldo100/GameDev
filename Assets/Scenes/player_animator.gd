extends AnimationPlayer

@export var player_controller : PlayerController
@export var animation_player : AnimationPlayer
@export var sprite : Sprite2D

var hurt_timer = 0.0  # Timer to track how long the sprite should be hurt

var sword_animation_playing = false

func _process(delta):
	# No more manual flip needed!

	# Sword attack priority
	if player_controller.sword_attacking:
		if not sword_animation_playing:
			animation_player.play("sword")
			sword_animation_playing = true
		return

	sword_animation_playing = false

	# Walk / Idle
	if abs(player_controller.velocity.x) > 0:
		if animation_player.current_animation != "walk":
			animation_player.play("walk")
	else:
		if animation_player.current_animation != "idle":
			animation_player.play("idle")
	
	# Hurt effect handling: countdown the hurt_timer and reset sprite's color
	if hurt_timer > 0:
		hurt_timer -= delta  # Decrease timer
		sprite.modulate = Color(1, 0, 0)  # Change color to red
		if hurt_timer <= 0:  # When timer ends
			sprite.modulate = Color(1, 1, 1)  # Reset color to normal (white)

# This method is called to start the hurt animation
func play_hurt_animation():
	hurt_timer = 0.3  # Set how long the "hurt" effect lasts
