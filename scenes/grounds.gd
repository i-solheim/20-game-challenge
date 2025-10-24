extends Node

class_name Ground

@export var speed = -150

@onready var ground1: Sprite2D = $Ground1/Sprite2D
@onready var ground2: Sprite2D = $Ground2/Sprite2D
@onready var ground3: Sprite2D = $Ground3/Sprite2D


func _ready():
	ground2.global_position.x = ground1.global_position.x + ground1.texture.get_width()
	ground3.global_position.x = ground2.global_position.x + ground2.texture.get_width()

func _process(delta):
	ground1.global_position.x += speed * delta
	ground2.global_position.x += speed * delta
	ground3.global_position.x += speed * delta
	
	if ground1.global_position.x < -ground1.texture.get_width():
		ground1.global_position.x = ground3.global_position.x + ground3.texture.get_width()
	if ground2.global_position.x < -ground2.texture.get_width():
		ground2.global_position.x = ground1.global_position.x + ground1.texture.get_width()
	if ground3.global_position.x < -ground3.texture.get_width():
		ground3.global_position.x = ground2.global_position.x + ground2.texture.get_width()
