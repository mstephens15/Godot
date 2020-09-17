extends Control

var player_words = []
var prompts = ["a name", "a noun", "adjective"]
var story = "Twas the night before christmas, and %s watched %s. 'This is the %s', he said."

onready var PlayerText = $VBoxContainer/HBoxContainer/PlayerText
onready var DisplayText = $VBoxContainer/DisplayText

func _ready():
	DisplayText.text = "Welcome to my dope word mad lips game!"   # Short intro
	check_player_words_length()
	PlayerText.grab_focus()    # becomes the thing that is selected when starting to play

func _on_PlayerText_text_entered(new_text):   # new_text is whatever the person entered
	add_to_player_words()
	
func _on_TextureButton_pressed():  # when button is pressed
	if is_story_done():
		get_tree().reload_current_scene()
	else:
		add_to_player_words()

func add_to_player_words():
	player_words.append(PlayerText.text)   # add what player typed into new array
	DisplayText.text = ""                    # clears the intro after first input
	PlayerText.clear()                     # delete inputted word so u can input another now
	check_player_words_length()            # quick if the lengths are now the same
	
func is_story_done():     # check if length of questions is same as answers
	return player_words.size() == prompts.size()
	
func check_player_words_length():  # if the lengths are the same, display all the text by running tell_story
	if is_story_done():
		end_game()
	else:
		prompt_player()

func tell_story():   # display all the inputted text
	DisplayText.text = story % player_words
	
func prompt_player():  # asks the person questions until lengths match
	DisplayText.text += "Can I have " + prompts[player_words.size()] + " please?"

func end_game():   # once the story is written, make it so you cant input anything anymore
	PlayerText.queue_free()
	$VBoxContainer/HBoxContainer/Label.text = "Again?"
	tell_story()
