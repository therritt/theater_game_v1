extends CharacterBody2D
class_name Character

enum Direction { DOWN, UP, LEFT, RIGHT }

signal died(character: Character)

@export var max_hp := 1
@export var speed := 100
@export var invincibility_time := 0.5
@export var knockback_str := 200

var invincible := false
var curr_hp: int
var is_dead := false
var curr_dir: Direction = Direction.DOWN

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: StateMachine = $StateMachine
@onready var soft_collision: SoftCollision = $SoftCollision

func _ready() -> void:
	curr_hp = max_hp
	anim.animation_finished.connect(_on_animation_finished)

func _on_animation_finished() -> void:
	state_machine.on_animation_finished(anim.animation)

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

func take_damage(damage: int, knockback: float, source_pos: Vector2):
	if invincible:
		return

	print("max_hp: ", max_hp)
	print("curr_hp: ", curr_hp)
	print("damage: ", damage)

	invincible = true
	curr_hp -= damage
	
	_on_damage_taken()
	apply_knockback(source_pos, knockback)
	play_hurt_feedback()

	if curr_hp <= 0:
		is_dead = true
		died.emit(self)
		return

	get_tree().create_timer(invincibility_time).timeout.connect(
		func(): invincible = false
	)

func _on_damage_taken() -> void:
	pass

func apply_knockback(source_pos: Vector2, knockback: float):
	var dir = (global_position - source_pos).normalized()
	velocity += dir * knockback
	move_and_slide()

func play_hurt_feedback():
	anim.modulate = Color(1, 1, 1, 0.5)
	get_tree().create_timer(0.1).timeout.connect(
		func(): anim.modulate = Color.WHITE
	)
