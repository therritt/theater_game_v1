extends Character
class_name Player

@export var default_attack: Attack
@onready var mask_stack: MaskStack = $MaskStack

var attack_target_pos: Vector2

func _ready() -> void:
	super._ready()

func add_mask(mask: Mask):
	max_hp += 1
	curr_hp += 1
	mask_stack.add_mask(mask)
	
	print("Player max hp: ", max_hp)
	print("Player curr hp:", curr_hp)

func drop_mask():
	max_hp -= 1
	mask_stack.pop_mask()

func _on_damage_taken() -> void:
	drop_mask()

func get_active_attack() -> Attack:
	var top_mask := mask_stack.get_top_mask()
	if top_mask and top_mask.attack:
		return top_mask.attack
	return default_attack

func set_attack_target_from_mouse():
	attack_target_pos = get_global_mouse_position()
	
func perform_attack(target_pos: Vector2) -> AttackBase:
	var attack_data := get_active_attack()
	var dir := (target_pos - global_position).normalized()

	var attack_instance: AttackBase = attack_data.attack_scene.instantiate()
	attack_instance.global_position = global_position + Vector2(0, -24)
	attack_instance.setup(self, dir, attack_data)

	get_parent().add_child(attack_instance)
	return attack_instance


func get_movement_input() -> Vector2:
	return Input.get_vector("left", "right", "up", "down")

func is_moving() -> bool:
	return get_movement_input() != Vector2.ZERO
