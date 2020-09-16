extends Node

# this script was put in Project -> Project Settings -> Autoload
# because of that, every scene will now automatically load this 

var score = 0

var slow_terrain = [0, 10, 20, 30, 7, 8, 17, 18]
var current_level = 0    # what level we are on in the game
var levels = ["res://ui/TitleScreen.tscn", "res://maps/Map01.tscn","res://maps/Map02.tscn","res://ui/DeathScene.tscn"]

func restart():
	current_level = 0
	get_tree().change_scene(levels[current_level])
	
func next_level():
	current_level += 1
	if current_level < levels.size():
		get_tree().change_scene(levels[current_level])
	else:
		restart()

# quit if hitting escape
func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			get_tree().quit()
