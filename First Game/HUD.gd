extends CanvasLayer

signal start_game     # start game when hitting the button

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()
	
func game_over():      # game over button appears for two seconds, then start button reappears
	show_message("Game Over")
	yield($MessageTimer, "timeout")  # stops execution of this func until this signal appears
	$StartButton.show()
	$MessageLabel.text = "Dodge the\nCreeps!"
	$MessageLabel.show()
	
func update_score(score):
	$ScoreLabel.text = str(score)

func _on_MessageTimer_timeout():
	$MessageLabel.hide()


func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")
