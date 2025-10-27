extends Node2D


class_name Ground


@export var speed : int = -150

@onready var ground_1 = $Ground1/Sprite2D
@onready var ground_2 = $Ground2/Sprite2D
@onready var ground_3 = $Ground3/Sprite2D


func _ready():
	ground_1.global_position = Vector2(168, 456)
	ground_2.global_position = Vector2(ground_1.global_position.x + ground_1.texture.get_width(), ground_1.global_position.y)
	ground_3.global_position = Vector2(ground_2.global_position.x + ground_2.texture.get_width(), ground_2.global_position.y)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	ground_1.global_position.x += speed * delta
	ground_2.global_position.x += speed * delta
	ground_3.global_position.x += speed * delta
	
	if ground_1.global_position.x < -ground_1.texture.get_width():
		ground_1.global_position.x = ground_3.global_position.x + ground_3.texture.get_width()
		
	if ground_2.global_position.x < -ground_2.texture.get_width():
		ground_2.global_position.x = ground_1.global_position.x + ground_1.texture.get_width()

	if ground_3.global_position.x < -ground_3.texture.get_width():
		ground_3.global_position.x = ground_2.global_position.x + ground_2.texture.get_width()
