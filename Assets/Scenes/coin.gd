extends Area2D
@export var animator: AnimationPlayer

func _process(delta):
	animator.play("spinning")


func _on_body_entered(body: Node2D) -> void:
	GameManager.add_coin()
	queue_free()
	
