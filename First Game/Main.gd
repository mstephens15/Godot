extends Node

export (PackedScene) var Mob
var score 

func _ready():
	randomize()      # random mob spawns every time
	
func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.show_message("Ready??")
	$HUD.update_score(score)

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()     # stops generating mobs
	$HUD.game_over()

func _on_StartTimer_timeout():
	$ScoreTimer.start()
	$MobTimer.start()

func _on_ScoreTimer_timeout():  # every time a second goes by, you get a point
	score += 1
	$HUD.update_score(score)

func _on_MobTimer_timeout():
	$MobPath/MobSpawnLocation.set_offset(randi())  # choose random location on Path2D
	var mob = Mob.instance()                       # Create a Mob instance and add it to the scene
	add_child(mob)     # wont be executed until it becomes part of tree
	var direction = $MobPath/MobSpawnLocation.rotation + PI/2
	mob.position = $MobPath/MobSpawnLocation.position
	direction += rand_range(-PI/4, PI/4)   # 45 degrees
	mob.rotation = direction
	mob.set_linear_velocity(Vector2(rand_range(mob.MIN_SPEED, mob.MAX_SPEED), 0).rotated(direction))    # property of RigidBody2D
