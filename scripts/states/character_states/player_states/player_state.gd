class_name PlayerState extends CharacterState

const IDLE = "Idle"
const MOVING = "Moving"
const DEATH = "Death"
const ATTACK = "Attack"

var player: Player

func enter(prev_state: String, data = {}) -> void:
	player = owner as Player
	assert(player != null, "The PlayerState state type must be used only in the player scene. It needs the owner to be a Player node.")
