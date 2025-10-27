extends Node2D


var game_running : bool
var game_over : bool


func _ready():
	new_game()

func new_game():
	game_running = false
	game_over = false
	$Bird.reset()


func _input(event):
	if game_over == false:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				if game_running == false:
					start_game()
				else:
					if $Bird.flying:
						$Bird.flap()


func start_game():
	game_running = true
	$Bird.flying = true
	$Bird.flap()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
