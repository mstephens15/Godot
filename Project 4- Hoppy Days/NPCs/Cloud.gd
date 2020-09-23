extends Node2D

var timeout

func _process(delta):
	if $Sprite/RayCast2D.is_colliding():
		fire()
		
func fire():   # we need to add a the lightning scene as a child when player collides
	# have to use load() because it is a resource, not a string           
	if not timeout:
		$Sprite/RayCast2D.add_child(load("res://NPCs/Lightning.tscn").instance())
		$Sprite/Timer.start()
		timeout = true

func _on_Timer_timeout():
	timeout = false
