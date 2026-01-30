extends PlayerState

var attack_dir

func enter(prev_state: String, data = {}):
	super.enter(prev_state, data)
	
	# Don't move while attacking if you were idle
	if prev_state == IDLE:
		attack_dir = Vector2.ZERO
	else:
		attack_dir = player.velocity.normalized()
		
	player.velocity = Vector2.ZERO
	player.play_anim("attack")

func physics_update(delta: float) -> void:
	player.velocity = attack_dir * player.speed * 0.3
	player.move_and_slide()

func on_animation_finished(anim_name: String) -> void:
	if anim_name.ends_with("attack"):
		if player.is_moving():
			finished.emit(MOVING)
		else:
			finished.emit(IDLE)
