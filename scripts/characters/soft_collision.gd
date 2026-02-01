extends Area2D
class_name SoftCollision

@export var push_strength := 50.0

func get_push_vector() -> Vector2:
	var push := Vector2.ZERO

	for area in get_overlapping_areas():
		var other = area.owner
		if other == owner || other is not Character:
			continue

		if (owner is Character):
			var dir = owner.global_position - other.global_position
			if dir.length() > 0:
				push += dir.normalized()

	return push.normalized() * push_strength
