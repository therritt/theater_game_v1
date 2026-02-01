extends Area2D

@export var amount = 2
@export var interval = 1.0

const ENEMY_SPAWNER = preload("res://scenes/enemy_spawner.tscn")

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		var spawner = ENEMY_SPAWNER.instantiate()
		spawner.enemy_amount = amount
		spawner.enemy_interval = interval
		get_parent().get_parent().add_child.call_deferred(spawner)
		queue_free()
