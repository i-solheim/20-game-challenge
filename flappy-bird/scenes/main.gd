extends Node2D

@export var pipe_scene : PackedScene
@onready var sfx_die: AudioStreamPlayer2D = $sfx_die
@onready var sfx_hit: AudioStreamPlayer2D = $sfx_hit


var game_running : bool
var game_over : bool
var screen_size : Vector2i
var ground_height : int
var pipes : Array
const PIPE_DELAY : int = 1
const PIPE_RANGE : int = 100
const SCROLL_SPEED : int = 150
var score : int = 0
var sfx_played := false


func _ready():
	screen_size = get_window().size
	ground_height = $Ground.get_node("Ground1/Sprite2D").texture.get_height()
	new_game()

func new_game():
	game_running = false
	game_over = false
	$Bird.reset()
	$Ground.speed = -150
	$GameOver.hide()
	get_tree().call_group("pipes", "queue_free")
	pipes.clear()
	score = 0
	$ScoreLabel.text = str(score)
	$ScoreLabel.global_position = Vector2(136, 20)
	


func _input(event):
	if game_over == false:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				if game_running == false:
					start_game()
				else:
					if $Bird.flying:
						$Bird.flap()
						check_top()


func start_game():
	game_running = true
	$Bird.flying = true
	$Bird.flap()
	$PipeTimer.start()
	sfx_played = false


func _process(delta):
	if !game_running:
		return
	for pipe in pipes:
		pipe.position.x -= SCROLL_SPEED * delta


func _on_pipe_timer_timeout() -> void:
	generate_pipes()


func generate_pipes():
	var pipe = pipe_scene.instantiate()
	pipe.position.x = screen_size.x + PIPE_DELAY
	pipe.position.y = (screen_size.y - ground_height) / 2 + randi_range(-PIPE_RANGE, PIPE_RANGE)
	pipe.hit.connect(bird_hit)
	pipe.score.connect(scored)
	add_child(pipe)
	pipes.append(pipe)


func check_top():
	if $Bird.position.y < 0:
		$Bird.falling = true
		stop_game()


func stop_game():
	$PipeTimer.stop()
	$Bird.flying = false
	game_running = false
	game_over = true
	$Ground.speed = 0
	$GameOver.show()
	if not sfx_played:
		sfx_die.play()
		sfx_played = true


func bird_hit():
	$Bird.falling = true
	stop_game()



func _on_ground_hit() -> void:
	$Bird.falling = false
	stop_game()


func scored():
	score += 1
	$ScoreLabel.text = str(score)


func _on_game_over_restart() -> void:
	new_game()
