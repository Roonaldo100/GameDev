extends Control
class_name HUD

@export var coin_amount_label : Label
@export var HP_amount_label : Label

func update_coin_label(number: int):
	coin_amount_label.text = "X"+str(number)
	
func update_hp_label(number: int):
	HP_amount_label.text = "HP: "+str(number)
	
