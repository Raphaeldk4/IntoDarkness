extends Node2D

var started = false
var isEnglish = true
var game = preload("res://scenes/game.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	#connect main menu buttons
	$HUD/mainMenuHud.get_node("start").pressed.connect(startGame)
	$HUD/mainMenuHud.get_node("settings").pressed.connect(openSettings)
	$HUD/mainMenuHud.get_node("exit").pressed.connect(exitGame)
	$HUD/mainMenuHud.get_node("language").pressed.connect(changeLanguage)
	
	#settings back 
	$HUD/settings.get_node("back").pressed.connect(back)

	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	return

#main menu buttons
func startGame(): 
	started = true
	get_tree().change_scene_to_file("res://scenes/game.tscn")
	
func openSettings():
	$HUD/mainMenuHud.visible = false
	$HUD/settings.visible = true

func exitGame(): 
	get_tree().quit()


func changeLanguage(): 
	if isEnglish == true:
		TranslationServer.set_locale("fr")
		isEnglish = false
	else: 
		TranslationServer.set_locale("en")
		isEnglish = true


func back():
	$HUD/mainMenuHud.visible = true
