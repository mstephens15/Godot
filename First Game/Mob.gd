extends RigidBody2D

export (int) var MIN_SPEED = 150     # we dont want them to be going at the same pace
export (int) var MAX_SPEED = 250

func _ready():
	var mob_types = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]
	
func _on_VisibilityNotifier2D_screen_exited():     # if it goes off screen...
	queue_free()       # deletes mob 
