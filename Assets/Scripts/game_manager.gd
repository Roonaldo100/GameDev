extends Node

var starting_area = 1
var current_area = 1
var area_path = "res://Assets/Scenes/Areas/"
var area_container : Node2D
var player: PlayerController

func _ready():
	#Allow global access of base of gameplay for persistence
	area_container = get_tree().get_first_node_in_group("area_container")
	player = get_tree().get_first_node_in_group("player")
	load_area(starting_area)

func next_area():
	current_area += 1
	load_area(current_area)
	

	
	
	
func load_area(area_number : int):
	var full_path = area_path + "area_" + str(area_number) + ".tscn"
	#get_tree().change_scene_to_file(full_path) #tempory solution before refactoring to allow player change between scenes
	var scene = load(full_path) as PackedScene
	if !scene:
		return
	#Remove the previous scene
	for child in area_container.get_children():
		child.queue_free() #not instance, happenes at end of physics frame
		await child.tree_exited #Prevents code execution until above completes
	#Setting up the new scene (after load)
	var instance = scene.instantiate()
	area_container.add_child(instance)
	#Allows for player to not be manually put into each scene
	var player_start_pos = get_tree().get_first_node_in_group("player_start_position") as Node2D
	player.teleport_to_location(player_start_pos.position)
		
	
	
