extends CharacterBody2D
var isPaused = false

const SPEED = 400.0
const JUMP_VELOCITY = -800.0

var jump = false
var noLeft = false
var noRight = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * 1.5  * delta
		
	if Input.is_action_just_released("ui_accept"):
		$AnimatedSprite2D.play("jump")
		$jump.play()
		

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("Left", "Right")
	
	if direction:
		velocity.x = direction * SPEED
		
		if is_on_floor():
			$AnimatedSprite2D.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
		if is_on_floor():
			$AnimatedSprite2D.play("idle")
		$AnimatedSprite2D.flip_h = false

	
	if direction >= 0:
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.flip_h = true
		
	if noLeft == true:
		if velocity.x < 0:
			velocity.x = 0

	if noRight == true:
		if velocity.x > 0:
			velocity.x = 0
	move_and_slide()




