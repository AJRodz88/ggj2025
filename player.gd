extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -600.0
const GRAVITY_MOD = 1.3

var canAirJump: bool = false


func _physics_process(delta: float) -> void:
	if GameManager.playerIsDead == true:
		return
		
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * GRAVITY_MOD * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and (is_on_floor() || canAirJump):
		velocity.y = JUMP_VELOCITY
		canAirJump = false
		$Jump.play()

	#CheckTiles()
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
		#CheckTiles()
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func TakeHit():
	GameManager.playerIsDead = true
	$AnimationPlayer.play("Dead")
	


func Jump():
	velocity.y = JUMP_VELOCITY
	move_and_slide()
	canAirJump = true
	pass
	
func CheckTiles():
	for t in get_tree().get_nodes_in_group("Tile"):
		if t.IsClean == false and t.position.x < position.x + 128 and t.position.x > position.x - 128 and t.position.y < position.y + 128 and t.position.y > position.y - 128:
			t.CleanTile()
