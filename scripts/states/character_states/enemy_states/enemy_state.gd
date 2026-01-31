extends CharacterState
class_name EnemyState

var enemy: Enemy

func enter(prev_state: String, data = {}) -> void:
	super.enter(prev_state, data)
	enemy = owner as Enemy
	assert(enemy != null, "EnemyState must be used on an Enemy node.")
