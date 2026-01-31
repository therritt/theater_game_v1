extends Character
class_name Player

@onready var mask_stack: MaskStack = $MaskStack

func _ready() -> void:
	anim.animation_finished.connect(_on_animation_finished)

func _on_animation_finished() -> void:
	state_machine.on_animation_finished(anim.animation)

func add_mask(mask: Mask):
	mask_stack.add_mask(mask)

func get_movement_input() -> Vector2:
	return Input.get_vector("left", "right", "up", "down")

func is_moving() -> bool:
	return get_movement_input() != Vector2.ZERO
