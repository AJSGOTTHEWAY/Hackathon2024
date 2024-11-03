extends Node3D
@onready var meshInstance1: MeshInstance3D = $"Sketchfab_Scene/Sketchfab_model/root/GLTF_SceneRootNode/node-0_0/Object_4"
@onready var meshInstance2: MeshInstance3D = $"Sketchfab_Scene/Sketchfab_model/root/GLTF_SceneRootNode/node-0_0/Object_5"
@onready var meshInstance3: MeshInstance3D = $"Sketchfab_Scene/Sketchfab_model/root/GLTF_SceneRootNode/node-0_0/Object_6"
@onready var meshInstance4: MeshInstance3D = $"Sketchfab_Scene/Sketchfab_model/root/GLTF_SceneRootNode/node-0_0/Object_7"
@onready var meshInstance5: MeshInstance3D = $"Sketchfab_Scene/Sketchfab_model/root/GLTF_SceneRootNode/node-0_0/Object_8"
@onready var material1: StandardMaterial3D = meshInstance1.mesh.surface_get_material(0)
@onready var material2: StandardMaterial3D = meshInstance2.mesh.surface_get_material(0)
@onready var material3: StandardMaterial3D = meshInstance3.mesh.surface_get_material(0)
@onready var material4: StandardMaterial3D = meshInstance4.mesh.surface_get_material(0)
@onready var material5: StandardMaterial3D = meshInstance5.mesh.surface_get_material(0)

@export var highlight_material: StandardMaterial3D
@onready var text: Sprite3D = $"Hover Label"
@onready var rocket: Node3D = $"."
@onready var ui_layer: CanvasLayer = $"../UiLayer"
@onready var collision_shape_3d: CollisionShape3D = $StaticBody3D/CollisionShape3D
@onready var interaction_shape_3d: CollisionShape3D = $"../fuelcan/Interactable/CollisionShape3D"



func add_highlight() -> void:
	print("add_highlight called")  # Print to check if this function is called
	meshInstance1.set_surface_override_material(0, material1.duplicate())
	meshInstance1.get_surface_override_material(0).next_pass = highlight_material
	meshInstance2.set_surface_override_material(0, material2.duplicate())
	meshInstance2.get_surface_override_material(0).next_pass = highlight_material
	meshInstance3.set_surface_override_material(0, material3.duplicate())
	meshInstance3.get_surface_override_material(0).next_pass = highlight_material
	meshInstance4.set_surface_override_material(0, material4.duplicate())
	meshInstance4.get_surface_override_material(0).next_pass = highlight_material
	meshInstance5.set_surface_override_material(0, material5.duplicate())
	meshInstance5.get_surface_override_material(0).next_pass = highlight_material
	
func remove_highlight() -> void:
	print("remove_highlight called")  # Print to check if this function is called
	meshInstance1.set_surface_override_material(0, null)
	meshInstance2.set_surface_override_material(0, null)
	meshInstance3.set_surface_override_material(0, null)
	meshInstance4.set_surface_override_material(0, null)
	meshInstance5.set_surface_override_material(0, null)


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
	if !ui_layer.talking and ui_layer.partCount != 3:
		# Start the dialogue based on the current part count
		ui_layer.start_dialogue(["My ship's all busted, maybe I can find some help somewhere..."], "You")
	elif !ui_layer.talking and ui_layer.partCount == 3:
		ui_layer.finished()
	else:
		ui_layer.next_line()
	
