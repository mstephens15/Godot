extends Label

#func _process(delta):
#	text = String(GLOBALS.score)
var enemies
var enemyCounter

# get number of enemies in 'enemytank' group
# make it a string because the text property of label only takes strings
func _ready():
	enemies = get_tree().get_nodes_in_group("enemytank")
	enemyCounter = enemies.size()
	text = str(enemyCounter)
	print(text)
