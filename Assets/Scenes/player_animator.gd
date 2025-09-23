extends AnimationPlayer

@export var player_controller : PlayerController
@export var animation_player : AnimationPlayer
@export var sprite : Sprite2D

var sword_animation_playing = false  # tracks if sword animation is currently active

func _process(delta):
	# Flip sprite based on facing
	sprite.flip_h = player_controller.facing == -1

	# Sword attack has priority
	if player_controller.sword_attacking:
		if not sword_animation_playing:
			animation_player.play("sword")
			sword_animation_playing = true
		return  # skip walk/idle while sword is active

	# Sword attack finished: reset flag
	sword_animation_playing = false

	# Walk / Idle
	if abs(player_controller.velocity.x) > 0:
		if animation_player.current_animation != "walk":
			animation_player.play("walk")
	else:
		if animation_player.current_animation != "idle":
			animation_player.play("idle")
