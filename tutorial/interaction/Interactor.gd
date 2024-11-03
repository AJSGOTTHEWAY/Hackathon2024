extends Area3D

class_name Interactor
const speech = [ " Press [E] TO INTERACT "]
var controller: Node3D

func interact(interactable: Interactable) -> void:
	if is_instance_valid(interactable):
		interactable.interacted.emit(self)
		

func focus(interactable: Interactable) -> void:
	if is_instance_valid(interactable):
		print("Focusing on:", interactable)  # Debug print
		
		interactable.emit_signal("focused", self)

func unfocus(interactable: Interactable) -> void:
	if is_instance_valid(interactable):
		print("Unfocusing from:", interactable)  # Debug print
		interactable.emit_signal("unfocused", self)

#Returns the closest overlapping Interactable or null if there isn't one.
func get_closest_interactable() -> Interactable:
	var list: Array[Area3D] = get_overlapping_areas()
	var distance: float
	var closest_distance: float = INF
	var closest: Interactable = null

	for interactable in list:
		distance = interactable.global_position.distance_to(global_position)

		# Sets the first interactable in the list as closest
		if distance < closest_distance:
			closest = interactable as Interactable
			closest_distance = distance

	return closest
