extends CSGSphere3D


@export var speed:float = 5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotate_y(speed * delta)
