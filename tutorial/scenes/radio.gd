extends Node3D

@onready var meshInstance: MeshInstance3D = $"hand raido/hand radio"
@onready var material: StandardMaterial3D = meshInstance.mesh.surface_get_material(0)
@export var highlight_material: StandardMaterial3D
@onready var text: Sprite3D = $"Hover Label"
@onready var ui_layer: CanvasLayer = $"../UiLayer"
@onready var collision_shape_3d: CollisionShape3D = $StaticBody3D/CollisionShape3D
@onready var radio: Node3D = $"."
@onready var interaction_shape_3d: CollisionShape3D = $"../radio/Interactable/CollisionShape3D"


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
	print("got radio")
	ui_layer.gotRadio()
	radio.visible = false
	collision_shape_3d.disabled = true
	interaction_shape_3d.disabled = true
