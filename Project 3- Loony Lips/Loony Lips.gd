extends Control

var player_words = []

# an array of dictionaries (each dictionary is a different story)
#var template = [
#		{"prompts" : ["a name", "a noun", "adjective"],
#		"story" : "Twas the night before christmas, and %s watched %s. 'This is the %s', he said."
#		},
#		{
#		"prompts" : ["a location", "a food", "a person you know"],
#		"story" : "Back in %s, your boy ate himself up some %s and almost killed %s in the process"	
#		},
#		{
#		"prompts" : ["a person", "an animal", "a pokemon", "an avatar"],
#		"story" : "WOAH! When %s was eating some potatoes, I saw a %s fight a %s, then realized I was dreaming with %s."
#		}
#		]

var current_story = {}
onready var PlayerText = $VBoxContainer/HBoxContainer/PlayerText
onready var DisplayText = $VBoxContainer/DisplayText

func _ready():
	set_current_story()
	DisplayText.text = "Welcome to my dope word mad lips game! "   # Short intro
	check_player_words_length()
	PlayerText.grab_focus()    # becomes the thing that is selected when starting to play
	
	
func set_current_story():
	randomize()  # like rolling dice, can repeat because its completely random every time
	var stories = $StoryBook.get_child_count()
	var selected_story = randi() % stories    # picks random number between 0 and however many children StoryBook has
	current_story.prompts = $StoryBook.get_child(selected_story).prompts
	current_story.story = $StoryBook.get_child(selected_story).story
	

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
	return player_words.size() == current_story.prompts.size()
	
func check_player_words_length():  # if the lengths are the same, display all the text by running tell_story
	if is_story_done():
		end_game()
	else:
		prompt_player()

func tell_story():   # display all the inputted text
	DisplayText.text = current_story.story % player_words
	
func prompt_player():  # asks the person questions until lengths match
	DisplayText.text += "May I have " + current_story.prompts[player_words.size()] + " please?"

func end_game():   # once the story is written, make it so you cant input anything anymore
	PlayerText.queue_free()
	$VBoxContainer/HBoxContainer/Label.text = "Again?"
	tell_story()
