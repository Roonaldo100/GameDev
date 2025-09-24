extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body is PlayerController:
		GameManager.HP -= 1
		print("PLayer hit")
