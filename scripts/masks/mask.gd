extends Resource
class_name Mask

@export var display_name: String
@export var max_hp: int = 1 # usually 1, but future-proof
@export var defense_bonus: int = 0
@export var speed_modifier: float = 1.0

@export var sprite_front: Texture2D
@export var sprite_side: Texture2D
@export var sprite_back: Texture2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
