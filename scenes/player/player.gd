extends CharacterBody2D

@onready var screensize=get_viewport_rect().size  # 螢幕尺寸
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 200.0
const JUMP_VELOCITY = -250.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	start()
	
func start()->void:
	position=Vector2(200,200)
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		animated_sprite_2d.play("Walk")
		velocity.x = direction * SPEED
		animated_sprite_2d.scale.x=direction
	else:
		animated_sprite_2d.play("Idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	if position.y>screensize.y:
		start()
