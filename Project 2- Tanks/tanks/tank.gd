# our generic tank script, used as a baseline for player and enemy tanks
extends KinematicBody2D

signal health_changed
signal dead             # when tank dies

export (PackedScene) var Bullet
export (int) var speed             # how fast bullet moves
export (float) var rotation_speed  # how fast tank rotates
export (float) var gun_cooldown
export (int) var health

var velocity = Vector2()
var can_shoot = true
var alive = true

func _ready():
	$GunTimer.wait_time = gun_cooldown
	
func control(delta):    # called every frame, let you input keyboard controls 
	pass
	
func _physics_process(delta):
	if not alive:
		return
	control(delta)
	move_and_slide(velocity)

# quit if hitting escape
func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			get_tree().quit()
