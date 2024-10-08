extends Node2D

var isPaused = false
func _ready():
	$settings.get_node("back").pressed.connect(back)
	
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"): 
		if isPaused == false:
			get_tree().paused = true 
			$settings.visible = true
			isPaused = true
		else:
			get_tree().paused = false 
			$settings.visible = false
			isPaused = false
			

func back():
	get_tree().paused = false 
	isPaused = false
