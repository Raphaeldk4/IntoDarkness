extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("Lighter"):
		$Player/PointLight2D.scale.x = $Player/PointLight2D.scale.x+0.5
		$Player/PointLight2D.scale.y = $Player/PointLight2D.scale.y+0.5
	if Input.is_action_just_released("Lighter"):
		$Player/PointLight2D.scale.x = $Player/PointLight2D.scale.x-0.5
		$Player/PointLight2D.scale.y = $Player/PointLight2D.scale.y-0.5

