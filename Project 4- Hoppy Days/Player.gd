extends KinematicBody2D

var motion = Vector2(0,0)

const GRAVITY = 250
const SPEED = 1500
const UP = Vector2(0,-1)   # fixing gravity multiplying itself
const JUMP_SPEED = 4500
const WORLD_LIMIT = 4000
const BOOST_MULTIPLIER = 1.5

signal animate

func _physics_process(delta):
	apply_gravity()
	jump()
	move()
	animate()
	move_and_slide(motion, UP)   #gravity in action only when falling; doesnt build up when not falling
	
func apply_gravity():   # only apply gravity when in the air
	if position.y > WORLD_LIMIT:
		get_tree().call_group("Gamestate", "end_game")
	if is_on_floor() and motion.y > 0:    
		motion.y = 0
	elif is_on_ceiling():
		motion.y = 1      # use 1 because you want the bunny to be just slightly off the ceiling, so itll fall instead of hover
	else:
		motion.y += GRAVITY
		
func jump():
	if Input.is_action_pressed("jump") and is_on_floor():
		motion.y -= JUMP_SPEED
		$JumpSFX.play()

func move():
	if Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		motion.x = -SPEED
	elif Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		motion.x = SPEED
	else:                  # to make it stop if no buttons are pressing
		motion.x = 0
	
func animate():
	emit_signal("animate", motion)   
	
func hurt():
	position.y -= 1                         # used to bypass gravity
	yield(get_tree(), "idle_frame")         # dont do anything until i tell you otherwise   
	motion.y = -JUMP_SPEED
	$PainSFX.stream = load("res://Hoppy_Days_Assets/SFX/pain.ogg")
	$PainSFX.play()

func boost():
	position.y -= 1                         # used to bypass gravity
	yield(get_tree(), "idle_frame")         # dont do anything until i tell you otherwise
	motion.y = -1                           # make it so you cant do that huge jump
	motion.y -= JUMP_SPEED * BOOST_MULTIPLIER
