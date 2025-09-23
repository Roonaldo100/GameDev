extends Node2D

@export var enemy_controller : EnemyController
@export var animation_player : AnimationPlayer 
@export var sprite : Sprite2D

func _process(delta):
	if enemy_controller.direction == 1:
		sprite.flip_h = false
	elif enemy_controller.direction == -1:
		sprite.flip_h = true
		
	if abs(enemy_controller.velocity.x) > 0:
		animation_player.play("walk")
