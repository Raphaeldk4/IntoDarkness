extends CanvasLayer
var started = get_node

# Called when the node enters the scene tree for the first time.
func _ready():
	#connect settings menu buttons
	$".".get_node("sound").pressed.connect(openSound)
	$".".get_node("back").pressed.connect(back)
	$".".get_node("buttons").pressed.connect(buttons)
	
	#connect sound settings 
	$sound2.get_node("back").pressed.connect(backSound)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
#settings menu buttons
func back():
		$".".visible = false
	
func openSound():
	$".".visible = false
	$sound2.visible = true

func backSound():
	$".".visible = true
	$sound2.visible = false

func buttons():
	$".".visible =false
	$inputSettingsCanvas.visible = true
