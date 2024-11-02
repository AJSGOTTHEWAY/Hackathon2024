extends Node3D
@onready var background_viewport: SubViewport = $base/background_viewport_container/background_viewport
@onready var foreground_viewport: SubViewport = $base/foreground_viewport_container/foreground_viewport
@onready var background: Camera3D = $base/background_viewport_container/background_viewport/background
@onready var foreground: Camera3D = $base/foreground_viewport_container/foreground_viewport/foreground


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resize();
	


func resize():
	background_viewport.size = DisplayServer.window_get_size()
	foreground_viewport.size = DisplayServer.window_get_size()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	background.global_transform = GameManager.player.camera_point.global_transform
	foreground.global_transform = GameManager.player.camera_point.global_transform
