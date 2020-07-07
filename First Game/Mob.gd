extends RigidBody2D

export (int) var MIN_SPEED      # we dont want them to be going at the same pace
export (int) var MAX_SPEED

var mob_types = ['fly', 'swim', 'walk']

func _ready():
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]
	


func _on_VisibilityNotifier2D_screen_exited():     # if it goes off screen...
	queue_free()       # deletes mob 
