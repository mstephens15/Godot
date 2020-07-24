extends Area2D

export (int) var speed
export (int) var damage
export (float) var lifetime

var velocity = Vector2()

func start(_position, _direction):
	position = _position
	rotation = _direction.angle()
	$Timer.wait_time = lifetime
	$Timer.start()                   # makes the bullet despawn
	velocity = _direction * speed    # travel in right direction and right speed
	
func explode():
	velocity = Vector2()   # make the bullet stop moving
	$Sprite.hide()         # now hide the bullet
	$Explosion.show()      # now show the explosion start
	$Explosion.play('smoke')  # now play the explosion animation
	
	
func _process(delta):
	position += velocity * delta
	
func _on_Bullet_body_entered(body):
	explode()
	if body.has_method('take_damage'):
		body.take_damage(damage)

func _on_Timer_timeout():
	explode()


func _on_Explosion_animation_finished():    # when bullet animation is finished...
	queue_free()
