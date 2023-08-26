extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
#	Utility.saveGame()
	Utility.loadGame()




func _on_quit_pressed():
	get_tree().quit()


func _on_play_pressed():
	get_tree().change_scene_to_file("res://world.tscn")
