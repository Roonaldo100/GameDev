extends AnimationPlayer

@export var player_controller : PlayerController
@export var animation_player : AnimationPlayer
@export var sprite : Sprite2D

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
