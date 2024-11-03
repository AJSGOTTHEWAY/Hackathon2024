extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var meshInstance: MeshInstance3D = $Sketchfab_model/astronaut_fbx/Object_2/RootNode/Armature/Object_6/Skeleton3D/Object_9
@onready var material: StandardMaterial3D = meshInstance.mesh.surface_get_material(0)
@export var highlight_material: StandardMaterial3D
@onready var text: Sprite3D = $"../Sprite3D"
@onready var ui_layer: CanvasLayer = $"../UiLayer"

var part_count: int = 0  # Track the number of parts the player has found

# Different dialogue sequences based on part count
var dialogues = [
	[  # Initial dialogue
		"Oh, hello there, stranger! You look a bit... ruffled.",
		"Ah, I see. You're not from around here, are you? A duck, of all things, crash-landed on our planet!",
		"Your ship is in pieces, scattered across the landscape.",
		"If you want to get back home, you'll need to rebuild it piece by piece.",
		"I think I saw something shiny over that way. Could be one of your ship's parts.",
		"Good luck, little duck!"
	],
	[  # Dialogue after finding the first part
		"Ah, you found one of your ship's parts! Excellent work.",
		"But you'll need more if you want to get that thing flying again.",
		"I thought I saw another piece near the old ruins up the hill.",
		"Head that way, and be careful! The terrain gets a bit rough."
	],
	[  # Dialogue after finding the second part
		"You're back! I see you have another part in hand—fantastic!",
		"You're making progress, but there's still work to do.",
		"The last piece I saw was down by the river. Search along the banks to find it.",
		"Once you get that, you should have everything you need to rebuild your ship."
	],
	[  # Dialogue after finding the third (final) part
		"Well, would you look at that! You've found all the pieces of your ship!",
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
	connect("focused", Callable(self, "_on_interactable_focused"))
	connect("unfocused", Callable(self, "_on_interactable_unfocused"))
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
		ui_layer.start_dialogue(dialogues[part_count], "Cosmo")
	else:
		ui_layer.next_line()

# Function to be called when the player finds a part
func on_player_found_part() -> void:
	if part_count < dialogues.size() - 1:
		part_count += 1
