extends Node2D

var taken = false

func _ready():
	$AnimatedSprite.play()

func _on_Area2D_body_entered(body):
	if not taken:
		taken = true
		$AnimationPlayer.play("die")
		$AudioStreamPlayer.play()
		get_tree().call_group("Gamestate", "coin_up")

func die():       # get rid of the coin when you pass through it
	queue_free()
