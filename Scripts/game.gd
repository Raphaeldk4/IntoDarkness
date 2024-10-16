extends Node2D
#region Déclaration variables
var player
var isPaused = false
var isInStatue = false
var isInStatue1 = false
var isInStatue2 = false
var isInStatue3 = false
var isInEndLevel = false
var gate
var answer = "123"
var testAnswer
var tutoStart =false
var tutoOver =false
var enigma =false
var successEnigma = false
var isInLevelEndBegin = false
var checkDone= false


#endregion
func _ready():
	player = get_node("Player")
	gate = get_node("Items/Gates/GateTuto")
	$settings.get_node("back").pressed.connect(back)
	testAnswer = ""
	$Player/GameMusic.play()
	

func _process(_delta):
	
	#restart si tombe dans un trou
	if player.position.y > 500:
		get_tree().reload_current_scene()

	#Menu pause
	if Input.is_action_just_pressed("ui_cancel"): 
		if isPaused == false:
			get_tree().paused = true 
			$settings.visible = true
			isPaused = true
		else:
			get_tree().paused = false 
			$settings.visible = false
			$settings.get_node("inputSettingsCanvas").visible = false
			$settings.get_node("sound2").visible = false
			isPaused = false


	# Making the gate disapear in tuto

	if  Input.is_action_just_pressed("Activate") && isInStatue && !tutoOver :
		$Items/statue/statueTuto/Lever.play()
		$Items/Gates/GateTuto/digging.play()
		for i in 20:
			gate.position.y = gate.position.y + 10
			await get_tree().create_timer(0.1).timeout
		$Player/Control.queue_free()
		$Items/Gates/GateTuto.visible =false
		$Items/Gates/GateTuto/CollisionShape2D.queue_free()
		tutoStart = false
		tutoOver = true

	# Checks pour la réponse a  l'énigme
	
	if  Input.is_action_just_pressed("Activate") && isInStatue1:
		$Items/statue/statue1/Lever.play()
		testAnswer = testAnswer + "1"

	if  Input.is_action_just_pressed("Activate") && isInStatue2:
		$Items/statue/statue2/Lever.play()
		testAnswer = testAnswer + "2"

	if  Input.is_action_just_pressed("Activate") && isInStatue3:
		$Items/statue/statue3/Lever.play()
		testAnswer = testAnswer + "3"

	if Input.is_action_just_pressed("Activate") && enigma && successEnigma == false:
		var heart = preload("res://Sound/effects/Beating heart.wav")
		if testAnswer.length() == 0:
			$Items/statue/statue1/heart.play()
			$Items/statue/statue2/heart.stop()
			$Items/statue/statue3/heart.stop()
		if testAnswer.length() == 1:
			$Items/statue/statue1/heart.stop()
			$Items/statue/statue2/heart.play()
		if testAnswer.length() == 2:
			$Items/statue/statue2/heart.stop()
			$Items/statue/statue3/heart.play()
		if testAnswer.length() == 3:
			$Items/statue/statue3/heart.stop()
			
	# Test pour la réponse

	if testAnswer.length() == 3:
		if testAnswer == answer:
			successEnigma = true
			$Items/endOfLevel/Doorway.visible= true
		else:
			$Player/error.play()
			testAnswer=""
			$Items/statue/statue1/heart.play()

	if testAnswer.length() > 3:
		testAnswer=""
		
	if  testAnswer.length() == 0 && isInEndLevel:
		$Items/statue/statue1/heart.play()
		enigma =true


func back():
	get_tree().paused = false 
	isPaused = false

func _on_gate_body_entered(body):
	if body == $Player:
		$Player.noLeft = true

func _on_gate_body_exited(body):
	if body == $Player:
		$Player.noLeft = false


func _on_gate_tuto_body_entered(body):
	if body == $Player:
		$Player.noRight = true



func _on_gate_tuto_body_exited(body):
	if body == $Player:
		$Player.noRight = false
#region Collision checks

# Check statue
func _on_statue_tuto_body_entered(body):
	if body == $Player:
		isInStatue = true
		if tutoStart == false && !tutoOver:
			$Player/Control/AnimationPlayer.active = true
			$Player/Control/AnimationPlayer.play("tipewritting")
			tutoStart = true

func _on_statue_tuto_body_exited(body):
	if body == $Player:
		isInStatue = false

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

#Début fin de niveau
func _on_end_of_level_body_entered(body):
	if body == $Player:
		print("kjvljv")
		isInEndLevel = true
		if isInEndLevel:
			$"Player/Enigma label/AnimationPlayer".active = true
			$"Player/Enigma label/AnimationPlayer".play("enigmaend")
			await get_tree().create_timer(10).timeout
			$"Player/Enigma label".visible = false
			isInLevelEndBegin = false

func _on_end_of_level_body_exited(body):
	if body == $Player:
		isInEndLevel = false

func _on_doorway_body_entered(body):
	if body == $Player && successEnigma:
		$Player/succes.play()

#endregion

