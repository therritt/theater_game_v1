extends CharacterBody2D
class_name Character

enum Direction { DOWN, UP, LEFT, RIGHT }

@export var speed := 100
var curr_dir: Direction = Direction.DOWN

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: StateMachine = $StateMachine

func update_direction(v: Vector2) -> void:
	if abs(v.x) > abs(v.y):
		curr_dir = Direction.RIGHT if v.x > 0 else Direction.LEFT
	else:
		curr_dir = Direction.DOWN if v.y > 0 else Direction.UP

func play_anim(type: String, is_directional: bool = true, is_strict_dir: bool = true) -> void:
	var dir_name := "front"

	match curr_dir:
		Direction.UP:
			dir_name = "back"
		Direction.LEFT:
			dir_name = "left" if is_strict_dir else "side"
		Direction.RIGHT:
			dir_name = "right" if is_strict_dir else "side"

	if (not is_strict_dir):
		anim.flip_h = curr_dir == Direction.LEFT

	var anim_name := type
	if (is_directional):
		anim_name = dir_name + "_" + type

	if anim.animation != anim_name:
		anim.play(anim_name)
