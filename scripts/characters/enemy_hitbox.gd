extends Area2D
class_name EnemyHitbox

@onready var enemy = owner as Enemy;

var damage_timer := 0.0
var overlapping_hurtboxes := []

func _ready():
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _on_area_entered(area):
	if area.owner is Player:
		overlapping_hurtboxes.append(area)

func _on_area_exited(area):
	overlapping_hurtboxes.erase(area)

func _physics_process(delta):
	damage_timer -= delta
	if damage_timer > 0:
		return

	if overlapping_hurtboxes.is_empty():
		return

	for hurtbox in overlapping_hurtboxes:
		var player = hurtbox.owner as Player
		player.take_damage(enemy.damage, enemy.knockback_str, enemy.global_position)

	damage_timer = enemy.damage_interval
