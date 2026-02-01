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
	print("first velocity", enemy.velocity)
	var soft_push = enemy.soft_collision.get_push_vector()
	enemy.velocity += soft_push
	print(soft_push)
	print("velocity + push", enemy.velocity)
	enemy.move_and_slide()

	# stop chasing if far away
	var dist = enemy.global_position.distance_to(enemy.target.global_position)
	if dist > enemy.chase_range:
		finished.emit("Idle")
		return
	elif dist <= enemy.stop_range:
		# Maybe change this to attack!
		enemy.velocity = Vector2.ZERO
