# our generic tank script, used as a baseline for player and enemy tanks
extends KinematicBody2D

signal shoot   # gets connected to the map scene, NOT PlayerTank due to various bugs (if player dies, bullet goes away)
signal health_changed
signal dead             # when tank dies

export (PackedScene) var Bullet    # can accept a scene; for example, go to player scene, and drag PlayerBullet into this
export (int) var max_speed             # how fast bullet moves
export (float) var rotation_speed  # how fast tank rotates
export (float) var gun_cooldown
export (int) var max_health

export (int) var gun_shots = 1     # number of bullets per shot; default is 1
export (float, 0, 1.5) var gun_spread = 0.2   # contrain from (0,1.5); default is 0.2
var velocity = Vector2()
var can_shoot = true
var alive = true
var health

func _ready():
	health = max_health
	emit_signal("health_changed", health * 100/max_health)  # displayed as %
	$GunTimer.wait_time = gun_cooldown
	
func control(delta):    # called every frame, let you input keyboard controls 
	pass

func take_damage(amount):
	health -= amount
	emit_signal("health_changed", health * 100/max_health)  # displayed as %)
	if health <= 0:
		explode()
		
func heal(amount):
	health += amount
	health = clamp(health, 0, max_health)
	emit_signal("health_changed", health * 100/max_health)

func shoot(num, spread, target=null):
	if can_shoot:    # shoot bullet, and then...
		can_shoot = false   # start timer for cooldown
		$GunTimer.start()
		var dir = Vector2(1, 0).rotated($Turret.global_rotation)
		if num > 1:      # if number of shots is more than one
			for i in range(num):    # for every shot...
				var a = -spread + i * (2*spread) / (num-1)  # get angle 
				emit_signal('shoot', Bullet, $Turret/Muzzle.global_position, dir.rotated(a), target) # rotate by that direction
		else:
			emit_signal('shoot', Bullet, $Turret/Muzzle.global_position, dir, target) # passing the signal 'shoot' to the Map scene
		$AnimationPlayer.play('muzzle_flash')

func _physics_process(delta):
	if not alive:
		return
	control(delta)
	move_and_slide(velocity)

func explode():
	$CollisionShape2D.set_deferred('disabled', true)
	alive = false    # stops physics_process, so it wont move anymore
	$Turret.hide()
	$Body.hide()
	$Explosion.show()
	$Explosion.play()
	emit_signal('dead')

# quit if hitting escape
func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			get_tree().quit()

func _on_GunTimer_timeout():
	can_shoot = true


func _on_Explosion_animation_finished():
	queue_free()   # once the animation of the explosion finishes, then destroy tank
