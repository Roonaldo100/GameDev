extends Node

var starting_area = 1
var current_area = 1
var area_path = "res://Assets/Scenes/Areas/"
var area_container : Node2D
#Player Vars
var player: PlayerController
var HP: int = 10
var keys: int = 0
var coins: int = 0
#Scene Vars
var keys_required: int = 1
var game_is_resetting: bool = false

func _ready():
	#Allow global access of base of gameplay for persistence
	area_container = get_tree().get_first_node_in_group("area_container")
	player = get_tree().get_first_node_in_group("player")
	load_area(starting_area)

func next_area():
	current_area += 1
	load_area(current_area)
	
func load_area(area_number : int):
	reset_keys()
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
	
func add_key():
	keys += 1
	if keys >= keys_required:
		var door = get_tree().get_first_node_in_group("area_exits") as AreaExit
		door.open()
	
func reset_keys():
	keys = 0
	
func add_coin():
	coins += 1
	print("player coins: " + str(coins))

func game_over():
	if game_is_resetting:
		return # prevents multiple triggers
	game_is_resetting = true
	HP = 3
	current_area = 1
	await load_area(current_area)
	game_is_resetting = false
	
