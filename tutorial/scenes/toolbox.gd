extends Node3D

@onready var meshInstance: MeshInstance3D = $"toolbodskethc/Sketchfab_model/0f8865732f954a6a88bd0e528192cd45_fbx/RootNode/Box002/Box002_Material #32_0"
@onready var material: StandardMaterial3D = meshInstance.mesh.surface_get_material(0)
@export var highlight_material: StandardMaterial3D
@onready var text: Sprite3D = $"../Sprite3D"

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
	print("got toolbox")
