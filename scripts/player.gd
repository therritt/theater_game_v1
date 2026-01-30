class_name Player extends CharacterBody2D

enum Direction { DOWN, UP, LEFT, RIGHT }

@export var speed := 100

var curr_dir: Direction = Direction.DOWN

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: StateMachine = $StateMachine

func _ready() -> void:
	anim.animation_finished.connect(_on_animation_finished)

func _on_animation_finished() -> void:
	state_machine.on_animation_finished(anim.animation)

func update_direction(v: Vector2) -> void:
	if abs(v.x) > abs(v.y):
		curr_dir = Direction.RIGHT if v.x > 0 else Direction.LEFT
	else:
		curr_dir = Direction.DOWN if v.y > 0 else Direction.UP

func get_movement_input() -> Vector2:
	return Input.get_vector("left", "right", "up", "down")

func is_moving() -> bool:
	return get_movement_input() != Vector2.ZERO

func play_anim(type: String, directionalName: bool = true) -> void:
	var dir_name := "front"

	match curr_dir:
		Direction.UP:
			dir_name = "back"
		Direction.LEFT, Direction.RIGHT:
			dir_name = "side"

	anim.flip_h = curr_dir == Direction.LEFT

	var anim_name := type
	if (directionalName):
		anim_name = dir_name + "_" + type

	if anim.animation != anim_name:
		anim.play(anim_name)
