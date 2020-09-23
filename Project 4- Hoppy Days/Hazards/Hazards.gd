extends Area2D

func _on_SpikeTop_body_entered(body):
	if body.has_method("hurt"):  # dont really need this, but its a good bug check
		get_tree().call_group("Gamestate", "hurt") # every hazard now broadcasts on channel Gamestate
