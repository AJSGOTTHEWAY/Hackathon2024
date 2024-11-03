# Globals.gd
extends Node

# Define a global highlight material
var highlight_material = StandardMaterial3D.new()

func _init():
	# Set up the highlight material properties
	highlight_material.albedo_color = Color(1, 1, 0)  # Yellow color
	highlight_material.emission_enabled = true
	highlight_material.emission = Color(1, 1, 0)  # Yellow glow
	highlight_material.roughness = 0.5
	highlight_material.metallic = 0.0
	highlight_material.transparency = StandardMaterial3D.TRANSPARENCY_ALPHA
	highlight_material.alpha_scissor_threshold = 0.5
