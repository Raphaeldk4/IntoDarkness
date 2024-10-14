extends Control

@onready var inputButtonScene = preload ("res://scenes/input_button.tscn")
@onready var actionList = $PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/actionList

var isRemapping = false
var actionToRemap = null
var remappingButton = null

var inputActions = {
	"Left": "Move Left",
	"Right": "Move Right",
	"Activate": "Interact",
	"Lighter": "Use Lighter"
}

func _ready():
	_createActionList()
	
func _createActionList():
	InputMap.load_from_project_settings()
	for item in actionList.get_children():
		item.queue_free()
		
	for action in inputActions:
		var button = inputButtonScene.instantiate()
		var actionLabel = button.find_child("labelAction")
		var inputLabel = button.find_child("labelInput")
		
		actionLabel.text = inputActions[action]
		
		var events = InputMap.action_get_events(action)
		if events.size() > 0:
			inputLabel.text = events[0].as_text().trim_suffix(" (Physical)")
		else:
			inputLabel.text = ""
		
		actionList.add_child(button)
		button.pressed.connect(_onInputButtonPressed.bind(button, action))

func _onInputButtonPressed(button, action):
	if !isRemapping: 
		isRemapping = true
		actionToRemap = action
		remappingButton = button
		button.find_child("labelInput").text = "press key to bind..."

func _input(event):
	if isRemapping:
		if (event is InputEventKey || (event is InputEventMouseButton && event.pressed)):
			if event is InputEventMouseButton  && event.double_click:
				event.double_click == false
			
			InputMap.action_erase_events(actionToRemap)
			InputMap.action_add_event(actionToRemap, event)
			_updateActionList(remappingButton, event)
		
			isRemapping = false
			actionToRemap = null
			remappingButton = null
			
			accept_event()
			
func _updateActionList(button, event):
	button.find_child("labelInput").text = event.as_text().trim_suffix(" (Physical)")



func _on_reset_button_pressed():
	_createActionList()
