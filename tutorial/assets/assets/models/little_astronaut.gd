extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var meshInstance: MeshInstance3D = $Sketchfab_model/astronaut_fbx/Object_2/RootNode/Armature/Object_6/Skeleton3D/Object_9
@onready var material: StandardMaterial3D = meshInstance.mesh.surface_get_material(0)
@export var highlight_material: StandardMaterial3D
@onready var ui_layer: CanvasLayer = $"../UiLayer"
@onready var text: Sprite3D = $astroLabel

#var part_count: int = 0  # Track the number of parts the player has found

# Different dialogue sequences based on part count
var dialogues = [
	[  # Initial dialogue before finding any parts
		"Oh, hello there, stranger! You look a bit... ruffled.",
		"Ah, I see. You're not from around here, are you? A duck, of all things, crash-landed on our planet!",
		"Your ship is in pieces, scattered across the landscape.",
		"If you want to get back home, you'll need to rebuild it piece by piece.",
		"I think I saw something shiny along the asteroids Southwest from here. Could be one of your ship's parts—a Radio, maybe.",
		"Once you've found it, come back and let me know. Good luck, little duck!"
	],
	[  # Dialogue after finding the first part (Radio)
		"Ah, you found the Radio! Excellent work—you're one step closer.",
		"But you'll need more if you want to get that thing flying again.",
		"I thought I saw another piece—a Fuel Can—near the end of the old maze up towards the East.",
		"Head that way, and watch out! The maze can be a bit tricky to navigate.",
		"Bring the Fuel Can back here once you’ve found it, and I’ll help you find the next part."
	],
	[  # Dialogue after finding the second part (Fuel Can)
		"You're back! I see you found the Fuel Can—fantastic!",
		"You're making real progress, but there’s still work to do.",
		"I think I have the last piece you need—a Toolbox—somewhere nearby.",
		"Take a look around here and see if you can find it!",
		"Once you’ve got the Toolbox, come back, and we’ll see if you have everything you need."
	],
	[  # Dialogue after finding the third (final) part (Toolbox)
		"Well, would you look at that! You’ve found the Toolbox—along with all the pieces of your ship!",
		"I knew you could do it, little duck. Now, all that's left is for you to put it back together.",
		"Best of luck on your journey back home. It was a pleasure meeting you!"
	]
]

func add_highlight() -> void:
	print("add_highlight called")  # Print to check if this function is called
	meshInstance.set_surface_override_material(0, material.duplicate())
	meshInstance.get_surface_override_material(0).next_pass = highlight_material
	
func remove_highlight() -> void:
	print("remove_highlight called")  # Print to check if this function is called
	meshInstance.set_surface_override_material(0, null)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Script is attached and _ready() is running")
	if animation_player.has_animation("Armature|Armature_001Action"):
		animation_player.play("Armature|Armature_001Action")

func _process(delta: float) -> void:
	pass

func _on_interactable_focused(interactor: Interactor) -> void:
	print("Focused on interactable object")
	add_highlight()
	text.visible = true

func _on_interactable_unfocused(interactor: Interactor) -> void:
	print("Unfocused from interactable object")
	remove_highlight()
	text.visible = false

func _on_interactable_interacted(interactor: Interactor) -> void:
	print("Interacted by Player")
	if !ui_layer.talking:
		# Start the dialogue based on the current part count
		ui_layer.start_dialogue(dialogues[ui_layer.partCount], "Cosmo")
	else:
		ui_layer.next_line()

## Function to be called when the player finds a part
#func on_player_found_part() -> void:
	#if part_count < dialogues.size() - 1:
		#part_count += 1
