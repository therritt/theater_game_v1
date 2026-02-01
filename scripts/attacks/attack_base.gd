extends Node2D
class_name AttackBase

var data: Attack
var attacker: Player
var direction: Vector2

signal done

@onready var hitbox: Area2D = $Hitbox
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

func setup(char: Player, dir: Vector2, attack_data: Attack):
	attacker = char
	direction = dir
	data = attack_data

func _ready():
	rotation = direction.angle()
	print(data.range)
	print(position)
	position += direction * data.range
	print(position)
	
	anim.animation_finished.connect(_on_animation_finished)
	anim.play("attack")

	hitbox.area_entered.connect(_on_area_entered)

func _on_animation_finished() -> void:
	done.emit()
	queue_free()

func _on_area_entered(area: Area2D):
	var character := area.get_parent()
	if not character is Character or character == attacker:
		return

	if character.has_method("take_damage"):
		(character as Character).take_damage(data.damage, data.knockback, global_position)
