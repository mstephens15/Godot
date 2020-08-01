extends Node

# this script was put in Project -> Project Settings -> Autoload
# because of that, every scene will now automatically load this 

var slow_terrain = [0, 10, 20, 30, 7, 8, 17, 18]
var current_level = 0    # what level we are on in the game
var levels = ["res://ui/TitleScreen.tscn", "res://maps/Map01.tscn"]

func restart():
	current_level = 0
	get_tree().change_scene(levels[current_level])
	
func next_level():
	current_level += 1
	if current_level < levels.size():
		get_tree().change_scene(levels[current_level])
	else:
		restart()
