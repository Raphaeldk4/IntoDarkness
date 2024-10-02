extends Node2D

var started = false

# Called when the node enters the scene tree for the first time.
func _ready():
	#connect main menu buttons
	$HUD/mainMenuHud.get_node("start").pressed.connect(startGame)
	$HUD/mainMenuHud.get_node("settings").pressed.connect(openSettings)
	$HUD/mainMenuHud.get_node("exit").pressed.connect(exitGame)
	
	#connect settings menu buttons
	$HUD/settings.get_node("sound").pressed.connect(openSound)
	$HUD/settings.get_node("back").pressed.connect(back)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	return

#main menu buttons
func startGame(): 
	started = true
	
func openSettings():
	$HUD/mainMenuHud.visible = false
	$HUD/settings.visible = true

func exitGame(): 
	get_tree().quit()

#settings menu buttons
func back():
	if started == false: 
		$HUD/mainMenuHud.visible = true
		$HUD/settings.visible = false
	
func openSound():
	$HUD/settings.visible = false
	$HUD/sound.visible = true
