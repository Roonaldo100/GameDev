extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body is PlayerController:
		GameManager.HP -= 1
		body.animator.play_hurt_animation()
		print("Payer hit. HP = " + str(GameManager.HP))
		if GameManager.HP < 1:
			GameManager.game_over()
