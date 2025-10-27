extends CharacterBody2D


const GRAVITY : int = 1000          # How quickly the bird drops
const MAX_VELOCITY : int = 600      # Limits the maximum speed of the bird
const FLAP_SPEED: int = -500        # How much the bird jumps up
var flying : bool = false           # Flag active while no collision
var falling : bool = false          # Flag active when bird hits a pipe or the ground
const START_POS = Vector2(48, 256)  # Start position of the bird on the screen


func _ready():
	reset()


# Reset game
func reset():
	flying = false
	falling = false
	position = START_POS
	set_rotation(0)
	

# Bird movement
func _physics_process(delta):
	# If the bird is in the air, apply gravity
	if flying or falling:
		velocity.y += GRAVITY * delta
	
		# Apply terminal velocity
		if velocity.y > MAX_VELOCITY:
			velocity.y = MAX_VELOCITY
		
		# The faster the bird moves down or up, the more it tilts
		if flying:
			set_rotation(deg_to_rad(velocity.y * 0.05))    # Tilting motion is dependent on vertical velocity
														   # 0.05 is a constant to control the rotation (scaling factor)
			$AnimatedSprite2D.play()
		
		# The bird moves vertically downwards when falling
		elif falling:
			set_rotation(PI/2)
			$AnimatedSprite2D.stop()
	
		# Move the bird
		move_and_collide(velocity * delta)
		
	else:
		$AnimatedSprite2D.stop()

func flap():
	velocity.y = FLAP_SPEED
