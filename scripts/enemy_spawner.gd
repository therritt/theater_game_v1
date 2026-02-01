extends Node2D

@export var enemy_amount := 10
@export var enemy_interval := 2.0
@export var enemy_type := preload("res://scenes/enemies/floaty_head.tscn")
var dead_enemies = 0

func _ready() -> void:
	var remaining = enemy_amount
	while remaining > 0:
		remaining -= 1
		var curr_enemy = spawn_enemy(enemy_type)
		curr_enemy.died.connect(_on_enemy_death)
		await get_tree().create_timer(enemy_interval).timeout

func _on_enemy_death(dead_enemy: Enemy):
	dead_enemies += 1
	if dead_enemies >= enemy_amount:
		var room = get_parent()
		if room and room.name == "room5":
			(room.get_parent() as World).win()
		queue_free()

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
	
