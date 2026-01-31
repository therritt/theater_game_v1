extends Node2D

@export var enemy_amount := 10
@export var enemy_interval := 2.0
@export var enemy_type := preload("res://scenes/enemies/floaty_head.tscn")


func _ready() -> void:
	while enemy_amount > 0:
		enemy_amount -= 1
		spawn_enemy(enemy_type)
		await get_tree().create_timer(enemy_interval).timeout


func spawn_enemy(type) -> Enemy:
	var enemy = type.instantiate() as Enemy
	var rng = RandomNumberGenerator.new()
	# top/bottom vs left/right
	if rng.randi_range(0,1):
		enemy.position.y += rng.randi_range(0,1) * 200
		enemy.position.x += rng.randi_range(0,330)
	else:
		enemy.position.x += rng.randi_range(0,1) * 330
		enemy.position.y += rng.randi_range(0,200)
	get_parent().add_child.call_deferred(enemy)
	return enemy
	
