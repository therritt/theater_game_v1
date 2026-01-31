extends Node2D
class_name MaskStack

@export var max_masks := 10
@export var sliver_offset := 1

const FACE_HEIGHT = 33
var masks: Array[Mask] = []
var last_dir = null
@onready var player = owner as Player
@onready var visual_root := self


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta):
	if player.curr_dir != last_dir:
		last_dir = player.curr_dir
		update_visuals()

func add_mask(mask: Mask):
	if masks.size() >= max_masks:
		return
	
	masks.append(mask.duplicate())
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

	for mask in masks:
		var sprite := Sprite2D.new()
		sprite.texture = mask.sprite_front
		sprite.z_index = 10
		sprite.position = Vector2(0, -FACE_HEIGHT)
		visual_root.add_child(sprite)

func _draw_stack():
	var y_offset := 0

	for mask in masks:
		var sprite := Sprite2D.new()

		if player.curr_dir in [Player.Direction.LEFT, Player.Direction.RIGHT]:
			sprite.texture = mask.sprite_side
			var is_left = player.curr_dir == Player.Direction.LEFT
			sprite.flip_h = is_left
			var pos_mod = -1 if is_left else 1
			sprite.position = Vector2(pos_mod * (y_offset + 1), -FACE_HEIGHT)
		else:
			sprite.texture = mask.sprite_back
			sprite.position = Vector2(0, -FACE_HEIGHT - y_offset)

		sprite.region_enabled = true
		sprite.region_rect = Rect2(
			0,
			0,
			sprite.texture.get_width(),
			sprite.texture.get_height()
		)

		sprite.z_index = y_offset

		visual_root.add_child(sprite)
		y_offset += sliver_offset
