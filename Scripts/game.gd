extends Node2D

var player
var isPaused = false
var isInStatue = false
var isInStatue1 = false
var isInStatue2 = false
var isInStatue3 = false
var gate
var answer = "123"
var testAnswer = ""
var tutoOver =false

func _ready():
	player = get_node("Player")
	gate = get_node("Items/Gates/GateTuto")
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
	# Making the gate disapear in tuto


	if  Input.is_action_just_pressed("Activate") && isInStatue:
		for i in 20:
			gate.position.y = gate.position.y + 10
			await get_tree().create_timer(0.1).timeout
		
		$Player/Control.queue_free()
		$Items/Gates.remove_child(gate)

	if  Input.is_action_just_pressed("Activate") && isInStatue1:
		testAnswer = testAnswer + '1'
	
	if  Input.is_action_just_pressed("Activate") && isInStatue2:
		testAnswer = testAnswer + '2'

	if  Input.is_action_just_pressed("Activate") && isInStatue3:
		testAnswer = testAnswer + '3'
		
	if testAnswer.length() == 3:
		if testAnswer == answer:
			print("ca marche")
		else:
			print("nop")
			testAnswer=""
		pass
func back():
	get_tree().paused = false 
	isPaused = false

# Check statue

func _on_statue_tuto_body_entered(body):
	if body == $Player:
		isInStatue = true
		if tutoOver == false:
			$Player/Control/AnimationPlayer.active = true
			$Player/Control/AnimationPlayer.play("tipewritting")
			tutoOver = true


func _on_statue_tuto_body_exited(body):
	if body == $Player:
		isInStatue = false
		#$Player/Control/AnimationPlayer.active = false


#Statue n°1 
func _on_statue_1_body_entered(body):
	if body == $Player:
		isInStatue1 = true


func _on_statue_1_body_exited(body):
	if body == $Player:
		isInStatue1 = false
# Statue 2

func _on_statue_2_body_entered(body):
	if body == $Player:
		isInStatue2 = true

func _on_statue_2_body_exited(body):
	if body == $Player:
		isInStatue2 = false

#Statue 3

func _on_statue_3_body_entered(body):
	if body == $Player:
		isInStatue3 = true

func _on_statue_3_body_exited(body):
	if body == $Player:
		isInStatue3 = false
