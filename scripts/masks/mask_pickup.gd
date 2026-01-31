extends Area2D
class_name MaskPickup

@export var mask: Mask

@onready var sprite := $Sprite2D

func _ready():
	body_entered.connect(_on_body_entered)
	
	if mask:
		sprite.texture = mask.sprite_front

func _on_body_entered(body):
	if body is Player:
		(body as Player).mask_stack.add_mask(mask)
		queue_free()
