extends Area2D
class_name AreaExit

var is_open = false

func _ready():
	pass

func open():
	is_open = true

func close():
	is_open = false

func _on_body_entered(body: Node2D) -> void:
	if body is PlayerController and is_open:
		GameManager.next_area()
