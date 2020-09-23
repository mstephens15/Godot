extends CanvasLayer

func _ready():
	pass
#	$Control/TextureRect/HBoxContainer/LifeCount.text = "3" ; it would have to be a string

func update_GUI(lives_left, coins):
	$Control/TextureRect/HBoxContainer/LifeCount.text = str(lives_left)
	$Control/TextureRect/HBoxContainer/CoinCount.text = str(coins)
