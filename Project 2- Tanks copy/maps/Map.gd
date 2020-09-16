extends Node2D

var noded = -1
var enemies
var enemyCounter

func _ready():
	set_camera_limits()
	Input.set_custom_mouse_cursor(load("res://assets/UI/crossair_black.png"), 
			Input.CURSOR_ARROW, Vector2(16, 16))   # custom mouse cursor
	$Player.map = $Ground
#	for node in get_children():
#		noded += 1
#		print(noded)
#		print(get_child(noded))
#	print($Paths/Path2D/PathFollow2D/EnemyTank.get_groups())     # what group is this node in
#	print($Player.is_in_group("enemytank"))   # checking if what node i select is in the group i pass
#	print(get_tree().get_nodes_in_group("enemytank"))
	
func set_camera_limits():
	var map_limits = $Ground.get_used_rect() # for example, gets that the map is 10 tiles wide
	var map_cellsize = $Ground.cell_size     # gets that each tile is 128 pixels
	$Player/Camera2D.limit_left = map_limits.position.x * map_cellsize.x
	$Player/Camera2D.limit_right = map_limits.end.x * map_cellsize.x
	$Player/Camera2D.limit_top = map_limits.position.y * map_cellsize.y
	$Player/Camera2D.limit_bottom = map_limits.end.y * map_cellsize.y

# receives the 'shoot' signal form tank.gd
# have to go to Player, and connect 'shoot' signal to this
func _on_Tank_shoot(bullet, _position, _direction, _target=null):
	var b = bullet.instance() 
	add_child(b)
	b.start(_position, _direction, _target)

func _on_Player_dead():
	GLOBALS.next_level()
	#GLOBALS.restart()  # when player dies, reload game automatically

