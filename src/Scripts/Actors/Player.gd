extends Actor

export var stomp_impulse: = 1000.0
var jump_stop = Input.is_action_just_released("jump")

var dir: = Vector2()

func _on_EnemyDetector_area_entered(area: Area2D) -> void:
	_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)

func _on_EnemyDetector_body_entered(body: Node) -> void:
	queue_free()

func _physics_process(delta: float) -> void:
	set_animation_sprite()
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0 
	var direction: = get_direction()
	_velocity = calculate_move_velocity(_velocity,direction,speed,is_jump_interrupted)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)

func get_direction() -> Vector2:
	
	if Input.get_action_strength("move_left"):
		$Player.scale.x = -2.6
	if Input.get_action_strength("move_right"):
		$Player.scale.x = 2.6
	
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 0.0
	)

func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:
		
	var new_velocity: = linear_velocity
	new_velocity.x = speed.x * direction.x
	new_velocity.y += gravity * get_physics_process_delta_time()
	
	if direction.y == -1.0:
		new_velocity.y = speed.y * direction.y
		
	if is_jump_interrupted:
		new_velocity.y = 0.0
	return new_velocity
	
func calculate_stomp_velocity(linear_velocity: Vector2 ,impulse: float ) -> Vector2:
	var out: = linear_velocity
	out.y = -impulse
	return out
	
func set_animation_sprite() -> void:
	var direction = Vector2()
	if Input.is_action_pressed("move_left"):
		$AnimationPlayer.play("Run")
	elif Input.is_action_pressed("move_right"):
		direction += Vector2(1,1)
		
func set_direction_view() -> void:
	
	if get_direction().x < 0:
		dir = Vector2(0, 0)
	if get_direction().x > 0:
		dir = Vector2(-1, 0)
		
	if (get_direction().x > 0 
	and (Input.is_action_pressed("move_up") or Input.is_action_pressed("move_down")) 
	and !Input.is_action_pressed("move_left")):
		dir = Vector2(0, 0)
	
	if Input.is_action_pressed("move_right") :
		dir += Vector2(1 , 0)
	
	if Input.is_action_pressed("move_down"):
		dir.y += 1
		
	if Input.is_action_just_released("move_down"):
		dir += Vector2(dir.x , 0)
		
	if Input.is_action_pressed("move_up"):
		dir.y += -1
		
	if Input.is_action_just_released("move_up"):
		dir += Vector2(dir.x , 0)
		
	print(dir)
	var new_dir: = Vector2()
	
	

	
