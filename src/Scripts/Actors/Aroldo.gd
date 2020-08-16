extends Actor

onready var Player = get_parent().get_node("Player")

export var stomp_impulse: = 1000.0

var react_time = 400
var dir = 0
var next_dir = 0
var next_dir_time = 0

func _ready():
	set_process(true)


#func _physics_process(delta: float) -> void:
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0 
	var direction: = get_direction()
#	_velocity = calculate_move_velocity(_velocity,speed,direction,is_jump_interrupted)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
func get_direction() -> Vector2:
	if Player.position.x < position.x and next_dir != -1:
		next_dir = -1
		next_dir_time = OS.get_ticks_msec() + react_time
		$AnimationPlayer.play("Run")
		$Aroldo.scale.x = -2.6
	elif Player.position.x > position.x and next_dir != 1:
		next_dir = 1
		next_dir_time = OS.get_ticks_msec() + react_time
		$Aroldo.scale.x = 2.6
		$AnimationPlayer.play("Run")
	elif Player.position.x == position.x and next_dir != 0:
		next_dir = 0
		next_dir_time = OS.get_ticks_msec() + react_time
		$AnimationPlayer.play("Idle")
		
		if OS.get_ticks_msec() > next_dir_time:
			dir = next_dir
		_velocity.x = dir * 500
	return Vector2(0,0)
	
