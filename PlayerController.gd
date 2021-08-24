extends KinematicBody2D

# Movement Constants
export var WALK_SPEED 		= 25.0
export var ROTATION_SPEED 	= 1.0
export var FRICTION 		= 0.3
export var MAX_ACCELERATION		= 65
export var MAX_DECELERATION		= 35

var g_Velocity = Vector2()

func handle_player_rotation(acceleration):
	# Rotation
	rotation_degrees += (Input.get_action_strength("rotate_right") - \
						Input.get_action_strength("rotate_left")) * \
						ROTATION_SPEED
						
	# Velocity bounds checking
	var velocity_magnitude = sqrt((g_Velocity.x*g_Velocity.x) \
								+ (g_Velocity.y*g_Velocity.y))
	print("Velocity mag: ", velocity_magnitude)
	if acceleration > 0:
		if velocity_magnitude > MAX_ACCELERATION:
			g_Velocity.x = MAX_ACCELERATION * sin(rotation)
			g_Velocity.y = -1 * MAX_ACCELERATION * cos(rotation)
	elif acceleration < 0:
		if velocity_magnitude > MAX_DECELERATION:
			g_Velocity.x = MAX_DECELERATION * sin(rotation) * -1
			g_Velocity.y = MAX_DECELERATION * cos(rotation) 
#		if abs(g_Velocity.x) > MAX_DECELERATION:
#			g_Velocity.x = sign(g_Velocity.x) * MAX_DECELERATION
#		if abs(g_Velocity.y) > MAX_DECELERATION:
#			g_Velocity.y = sign(g_Velocity.y) * MAX_DECELERATION

func handle_player_friction(acceleration):
	if acceleration == 0:
		if g_Velocity.x != 0:
			g_Velocity.x -= g_Velocity.x * FRICTION
		if g_Velocity.y != 0:
			g_Velocity.y -= g_Velocity.y * FRICTION
	
# Player input should be tank movement.
func handle_player_input():
	# Input
	var acceleration = (Input.get_action_strength("forward") - Input.get_action_strength("reverse")) \
				* WALK_SPEED
	
	# Rotation controls
	handle_player_rotation(acceleration)

	# Forward/Backwards
	g_Velocity.x += (sin(rotation) * acceleration)
	g_Velocity.y -= (cos(rotation) * acceleration)
	
	# Friction
	handle_player_friction(acceleration)
	
	# DEBUG
	#print("g_Velocity:", g_Velocity)

# Called when the node enters the scene tree for the first time.
func _ready():
	set_rotation_degrees(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	handle_player_input()
	g_Velocity = move_and_slide(g_Velocity, Vector2(0, 0))
