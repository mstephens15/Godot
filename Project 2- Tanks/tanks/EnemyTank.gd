extends "res://tanks/Tank.gd"

onready var parent = get_parent()

export (float) var turret_speed
export (int) var detect_radius

var target = null

# makes it so each enemy tank has their own size collision shape radius
func _ready():
	var circle = CircleShape2D.new()
	$DetectRadius/CollisionShape2D.shape = circle
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
# in current_dir, the 1 in Vector means it is pointing in the same direction
func _process(delta):
	if target:
		var target_dir = (target.global_position - global_position).normalized()   # where the target (player) is in the world
		var current_dir = Vector2(1, 0).rotated($Turret.global_rotation)           # how the enemy tank is currently rotated
		$Turret.global_rotation = current_dir.linear_interpolate(target_dir, turret_speed*delta).angle()
		if target_dir.dot(current_dir) > 0.9:
			shoot()

func _on_DetectRadius_body_entered(body):
	target = body

func _on_DetectRadius_body_exited(body):
	if body == target:
		target = null       # drop target if target leaves area
