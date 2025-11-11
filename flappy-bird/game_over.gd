extends CanvasLayer
@onready var restart_button: Button = $RestartButton
@onready var texture_rect: TextureRect = $TextureRect

signal restart


func _ready():
	restart_button.global_position = Vector2(84, 280)
	texture_rect.global_position = Vector2(48, 200)

func _on_restart_button_pressed() -> void:
	restart.emit()
