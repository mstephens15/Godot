extends Area2D

export (int) var speed
export (int) var damage
export (float) var lifetime
export (float) var steer_force = 0

var velocity = Vector2()
var acceleration = Vector2()
var target = null

func start(_position, _direction, _target=null):
	position = _position
	rotation = _direction.angle()
	velocity = _direction * speed    # travel in right direction and right speed
	target = _target
	$Timer.wait_time = lifetime
	$Timer.start()                   # makes the bullet despawn
	
func explode():
	velocity = Vector2()   # make the bullet stop moving
	$Sprite.hide()         # now hide the bullet
	$Explosion.show()      # now show the explosion start
	$Explosion.play('smoke')  # now play the explosion animation
	
func seek():
	var desired = (target.position - position).normalized() * speed
	var steer = (desired - velocity).normalized() * steer_force
	return steer

func _process(delta):
	if target:
		acceleration += seek()
		velocity += acceleration * delta
		velocity = velocity.clamped(speed)  # clamp makes it so there is a max speed
		rotation = velocity.angle()         # rotated to go the direction of the velocity
	position += velocity * delta
	
func _on_Bullet_body_entered(body):
	explode()
	if body.has_method('take_damage'):
		body.take_damage(damage)

func _on_Timer_timeout():
	explode()


func _on_Explosion_animation_finished():    # when bullet animation is finished...
	queue_free()
