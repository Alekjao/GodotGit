extends Position2D

var bullet = preload("res://src/Projeteis/Bullet.tscn")

export var bullet_speed = 1000
export var fire_rate = 0.2

var dir: = Vector2()
var can_fire = true
var horizontal_dir := -1

func _process(delta: float) -> void:
	set_direction_view()
	
	if Input.is_action_pressed("shoot") and can_fire:
		instanciate_bullet()
		
func get_direction() -> int:
	if Input.get_action_strength("move_left") :
		horizontal_dir = 1
	if Input.get_action_strength("move_right"):
		horizontal_dir = -1
	return horizontal_dir
	
func instanciate_bullet() ->void:
	var bullet_instance = bullet.instance()
	bullet_instance.position = get_global_position()
	bullet_instance.rotation_degrees = rotation_degrees
	bullet_instance.apply_impulse(Vector2(),Vector2(bullet_speed,0).rotated(rotation))
	get_tree().get_root().add_child((bullet_instance))
	can_fire = false
	yield(get_tree().create_timer(fire_rate), "timeout")
	can_fire = true

func set_direction_view() -> void:
	
	if get_direction() < 0:
		dir = Vector2(0, 0)
	if get_direction() > 0:
		dir = Vector2(-1, 0)
		
	if (get_direction() > 0 
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
		
	var new_dir: = Vector2()
	
#	print( dir )
	new_dir = dir
	rotation = new_dir.angle()
	
	
	
