extends Node2D

@export var enemy_controller : EnemyController
@export var animation_player : AnimationPlayer 
@export var walk_sprite : Sprite2D
@export var death_sprite : Sprite2D

var dead: bool = false

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
