extends Node2D

@export var pipe_scene : PackedScene

var game_running : bool
var game_over : bool
var screen_size : Vector2i
var ground_height : int
var pipes : Array
const PIPE_DELAY : int = 1
const PIPE_RANGE : int = 100
const SCROLL_SPEED : int = 150


func _ready():
	screen_size = get_window().size
	ground_height = $Ground.get_node("Ground1/Sprite2D").texture.get_height()
	new_game()

func new_game():
	game_running = false
	game_over = false
	$Bird.reset()
	pipes.clear()


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
	$PipeTimer.start()


func _process(delta):
	for pipe in pipes:
		pipe.position.x -= SCROLL_SPEED * delta
	

func _on_pipe_timer_timeout() -> void:
	generate_pipes()


func generate_pipes():
	var pipe = pipe_scene.instantiate()
	pipe.position.x = screen_size.x + PIPE_DELAY
	pipe.position.y = (screen_size.y - ground_height) / 2 + randi_range(-PIPE_RANGE, PIPE_RANGE)
	pipe.hit.connect(bird_hit)
	add_child(pipe)
	pipes.append(pipe)

func bird_hit():
	pass
