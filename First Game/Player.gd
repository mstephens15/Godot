extends Area2D

signal hit

export (int) var SPEED     # integer speed can be changed now in the main screen
var velocity = Vector2()   # takes care of players movement
var screensize             # so we know size of screen when player goes off of it

func _ready():             # code that runs when first starting
	#hide()                 # player invisible until game starts
	screensize = get_viewport_rect().size   # gets size of screen

func _process(delta):      # runs every frame
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		$AnimatedSprite.play()
		velocity = velocity.normalized() * SPEED   # normalize resets length to one; because diagonal would get -2 or 2
		$Trail.emitting = true
	else:
		$AnimatedSprite.stop()
		$Trail.emitting = false
		
	position += velocity * delta
	position.x = clamp(position.x, 0, screensize.x)  # doesnt let you go off screen
	position.y = clamp(position.y, 0, screensize.y)  # doesnt let you go off screen
	 
	if velocity.x != 0:
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.flip_v = velocity.y > 0

# quits game if you hit escape
func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			get_tree().quit()

func _on_Player_body_entered(body):      # i created this signal in the "node" tab
	hide()
	emit_signal("hit")
	call_deferred("set_monitoring", false)    # so you dont get double hit, and so it doesnt get hit when hidden
	
func start(pos):        # tells the player where to start
	position = pos
	show()
	monitoring = true
