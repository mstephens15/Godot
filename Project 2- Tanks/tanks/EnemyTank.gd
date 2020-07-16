extends "res://tanks/Tank.gd"

onready var parent = get_parent()

export (float) var turret_speed
export (int) var detect_radius

var target = null

func _ready():
	$DetectRadius/CollisionShape2D.shape.radius = detect_radius

func control(delta):
	if parent is PathFollow2D:
		parent.set_offset(parent.get_offset() + speed * delta)
		position = Vector2()       # will always keep enemy tank on path; had an issue bc enemy and us both kinematic so it would get stuck; this is relative to parent position
	else:
		#other movement
		pass

# linear_interpolate transforms one value to another at constant speed, aka turret_speed * delta
# basically, it is rotating from the current_dir to the target_dir at that current speed
func _process(delta):
	if target:
		var target_dir = (target.global_position - global_position).normalized()   # where the target (player) is in the world
		var current_dir = Vector2(1, 0).rotated($Turret.global_rotation)           # how the enemy tank is currently rotated
		$Turret.global_rotation = current_dir.linear_interpolate(target_dir, turret_speed*delta).angle()

func _on_DetectRadius_body_entered(body):
	target = body

func _on_DetectRadius_body_exited(body):
	if body == target:
		target = null       # drop target if target leaves area
