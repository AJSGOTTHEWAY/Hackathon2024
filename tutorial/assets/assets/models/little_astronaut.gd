extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var meshInstance: MeshInstance3D = $Sketchfab_model/astronaut_fbx/Object_2/RootNode/Armature/Object_6/Skeleton3D/Object_9
@onready var material: StandardMaterial3D = meshInstance.mesh.surface_get_material(0)
@export var highlight_material: StandardMaterial3D

func add_highlight() -> void:
	print("add_highlight called")  # Print to check if this function is called
	#var highlight_material = StandardMaterial3D.new()
	#highlight_material.albedo_color = Color(1, 1, 0)  # Yellow color for visibility
	#highlight_material.emission_enabled = true
	#highlight_material.emission = Color(1, 1, 0)  # Set glow color to yellow
	#highlight_material.emission_energy = 2.0  # Increase energy for brightness
	meshInstance.set_surface_override_material(0, material.duplicate())
	meshInstance.get_surface_override_material(0).next_pass = highlight_material
	#meshInstance.set_surface_override_material(0, highlight_material)

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
	print("Focused on interaasctable object")  # Print to check if focusing triggers
	add_highlight()

func _on_interactable_unfocused(interactor: Interactor) -> void:
	print("Unfocused from interactable object")  # Print to check if unfocusing triggers
	remove_highlight()
