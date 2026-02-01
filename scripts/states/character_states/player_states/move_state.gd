extends PlayerState

func enter(prev_state: String, data = {}) -> void:
	super.enter(prev_state, data)
	
func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		finished.emit("Attack")


func physics_update(delta: float) -> void:
	if not player.is_moving():
		finished.emit(IDLE)
		return

	var input_vector = player.get_movement_input()
	player.update_direction(input_vector)
	player.velocity = input_vector * owner.speed
	
	var soft_push = player.soft_collision.get_push_vector()
	player.velocity += soft_push
	
	player.play_anim("walk")
	player.move_and_slide()
