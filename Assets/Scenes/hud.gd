extends Control
class_name HUD

@export var coin_amount_label : Label

func update_coin_label(number: int):
	coin_amount_label.text = "X"+str(number)
