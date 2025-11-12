extends Area2D
signal hit
signal score
@onready var sfx_score: AudioStreamPlayer2D = $sfx_score
@onready var sfx_hit_pipe: AudioStreamPlayer2D = $sfx_hit_pipe

func _on_body_entered(body):
	hit.emit()
	sfx_hit_pipe.play()


func _on_score_area_body_entered(body):
	score.emit()
	sfx_score.play()
