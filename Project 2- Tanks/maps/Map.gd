extends Node2D

func _ready():
	set_camera_limits()
	Input.set_custom_mouse_cursor(load("res://assets/UI/crossair_black.png"), 
			Input.CURSOR_ARROW, Vector2(16, 16))   # custom mouse cursor
	$Player.map = $Ground
	
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
	GLOBALS.restart()  # when player dies, reload game automatically
