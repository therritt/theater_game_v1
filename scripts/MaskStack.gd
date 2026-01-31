extends Node
class_name MaskStack

@export var max_masks := 10
@export var sliver_offset := 1

var masks: Array[Mask] = []
@onready var player = owner as Player

@onready var visual_root := self

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func add_mask(mask: Mask):
	if masks.size() >= max_masks:
		return

	masks.append(mask)
	update_visuals()

func pop_mask():
	if masks.is_empty():
		return
	masks.pop_back()
	update_visuals()
	
func move_mask(from_idx: int, to_idx: int):
	var mask := masks[from_idx]
	masks.remove_at(from_idx)
	masks.insert(to_idx, mask)
	update_visuals()
	
func update_visuals():
	for child in visual_root.get_children():
		child.queue_free()

	match player.curr_dir:
		Player.Direction.DOWN:
			_draw_front()
		Player.Direction.LEFT, Player.Direction.RIGHT, Player.Direction.UP:
			_draw_stack()

func _draw_front():
	if masks.is_empty():
		return

	var front_mask: Mask = masks.back()
	var sprite := Sprite2D.new()
	sprite.texture = front_mask.sprite_front
	sprite.z_index = 10
	sprite.position = Vector2.ZERO
	visual_root.add_child(sprite)

func _draw_stack():
	var y_offset := 0

	for mask in masks:
		var sprite := Sprite2D.new()

		if player.curr_dir == Player.Direction.DOWN:
			sprite.texture = mask.sprite_side
			sprite.flip_h = player.curr_dir == Player.Direction.LEFT
		else:
			sprite.texture = mask.sprite_back

		sprite.region_enabled = true
		sprite.region_rect = Rect2(
			0,
			0,
			sprite.texture.get_width(),
			sprite.texture.get_height()
		)

		sprite.position = Vector2(0, -y_offset)
		sprite.z_index = y_offset

		visual_root.add_child(sprite)
		y_offset += sliver_offset
