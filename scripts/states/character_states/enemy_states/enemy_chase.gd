extends EnemyState

func enter(prev_state: String, data = {}) -> void:
	super.enter(prev_state, data)
	enemy.play_anim("move", false, false)

func physics_update(delta: float) -> void:
	if enemy.target == null:
		finished.emit("Idle")
		return

	var dir = (enemy.target.global_position - enemy.global_position).normalized()
	enemy.update_direction(dir)

	enemy.velocity = dir * enemy.speed
	enemy.move_and_slide()

	# stop chasing if far away
	var dist = enemy.global_position.distance_to(enemy.target.global_position)
	if dist > enemy.chase_range:
		finished.emit("Idle")
		return

	# stop if close enough
	# Maybe change this to attack!
	if dist <= enemy.stop_range:
		enemy.velocity = Vector2.ZERO
		enemy.play_anim("idle")
