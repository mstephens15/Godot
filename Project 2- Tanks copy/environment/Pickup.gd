extends Area2D

enum Items {health, ammo}

var icon_textures = [preload("res://assets/items/wrench_white.png"),
						preload("res://assets/items/ammo_machinegun.png")]  # how to preload multiple pics; health = 0, ammo - 1

export (Items) var type = Items.health
export (Vector2) var amount = Vector2(10, 25)   # set vector between 10 and 25 for picking random integer

func _ready():
	$Icon.texture = icon_textures[type]   # we can choose which icon we want to display for the sprite, Icon

func _on_Pickup_body_entered(body):   # when tank passes over item...
	match type:
		Items.health:
			if body.has_method('heal'):
				body.heal(int(rand_range(amount.x, amount.y)))  # heal anywhere between 10 and 25
		Items.ammo:
			body.ammo += 12
	queue_free()    # delete the item from the map
