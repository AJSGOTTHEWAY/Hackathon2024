extends CanvasLayer

@onready var dialogue_text: Label = $"UI/Panel/Dialogue Text"
@onready var name_label: Label = $"UI/Panel/Name Label"
@onready var panel: Panel = $"UI/Panel"
@onready var ui: Control = $UI
@onready var fuel_can: TextureRect = $"UI/Fuel Can"
@onready var radio: TextureRect = $UI/Radio
@onready var toolbox: TextureRect = $UI/Toolbox
@onready var finish: TextureRect = $UI/Finish

var talking: bool = false
var dialogue_lines: Array = []  # Array to store dialogue lines
var current_line: int = 0  # Track the current line index
var partCount = 0

func _ready() -> void:
	ui.visible = true  # Initially hide the dialogue box
	panel.visible = false
	partCount = 0
	

func finished() -> void:
	finish.visible = true

func gotFuel() -> void:
	fuel_can.visible = true
	partCount+=1

func gotTools() -> void:
	toolbox.visible = true
	partCount+=1

func gotRadio() -> void:
	radio.visible = true
	partCount+=1

# Function to start dialogue
func start_dialogue(lines: Array, speaker_name: String = "") -> void:
	dialogue_lines = lines.duplicate()
	current_line = 0
	panel.visible = true  # Show the dialogue box
	name_label.text = speaker_name  # Set the speaker's name if provided
	talking = true
	display_line()

# Function to display the current line
func display_line() -> void:
	if current_line < dialogue_lines.size():
		dialogue_text.text = dialogue_lines[current_line]
	else:
		end_dialogue()

# Function to go to the next line
func next_line() -> void:
	current_line += 1
	display_line()

# Function to end dialogue
func end_dialogue() -> void:
	panel.visible = false  # Hide the dialogue box
	talking = false
	dialogue_lines.clear()

# Function to handle input for advancing dialogue
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and panel.visible:
		next_line()
