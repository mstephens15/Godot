extends Node2D

var lives = 3
var coins = 0
var target_number_of_coins = 10    # if you get 10 coins, you get a new life

func _ready():
	add_to_group("Gamestate")
	update_GUI()                # right when game loads, update GUI

func hurt():
	lives -= 1
	$Player.hurt()
	update_GUI()       # every time bunny hits something bad, play sound and reduce by one life
	if lives < 0:
		end_game()

func update_GUI():    
	get_tree().call_group("GUI", "update_GUI", lives, coins)   # we are updating the amount of lives left, starting with var lives = 5

func coin_up():
	coins += 1
	update_GUI()
	
	#whats leftover from coins - target number of coins; every time you hit a multiple of target_coins (10, 20, 30), this statement is now true
	var multiple_of_coins = (coins % target_number_of_coins) == 0  
	if multiple_of_coins:
		life_up()
		
func life_up():
	lives += 1
	update_GUI()

func end_game():
	get_tree().change_scene("res://Levels/GameOver.tscn")
