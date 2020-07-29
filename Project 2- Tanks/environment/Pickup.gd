extends Area2D

enum Items {health, ammo}

export (Items) var type = Items.health
export (Vector2) var amount = Vector2(10, 25)   # set vector between 10 and 25 for picking random integer

func _on_Pickup_body_entered(body):   # when tank passes over item...
	match type:
		Items.health:
			if body.has_method('heal'):
				body.heal(int(rand_range(amount.x, amount.y)))  # heal anywhere between 10 and 25
		Items.ammo:
			pass
	queue_free()    # delete the item from the map
