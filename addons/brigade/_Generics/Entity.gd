extends KinematicBody2D

# Enums
enum JumpState {
	JUMP_INITIAL,
	JUMP_ON_AIR,
	REST
}
enum MoveState {
	LEFT, 
	RIGHT, 
	IDLE
}
const GravityState = preload("res://addons/brigade/GravityEnum.gd")
enum SkillState {
	SKILL1,
	SKILL2,
	SKILL3,
	SKILL4
}
enum AttackState {
	ONGOING,
	DONE
}

# World modifiable variables
export var GRAVITY = 400
export var SPEED = 10
export var FRICTION = 0.5
export var JUMP_FORCE = 250
export var CLIMB_SPEED = 10

export var health = 0
export var max_health = 100
export var mana = 0
export var max_mana = 100
export var focus = 0
export var max_focus = 100

var _velocity = Vector2()
var _current_state = MoveState.IDLE
var _current_jump_state = JumpState.REST
var _gravity_state = GravityState.FREEFALL
var _skill_state = SkillState.SKILL1
var _attack_state = AttackState.DONE

func _physics_process(delta):
	# Control L/R movements
	if _current_state != MoveState.IDLE:
		var speed = 0
		if _current_state == MoveState.RIGHT:
			speed = SPEED
		else:
			speed = -1 * SPEED
		_velocity.x += speed
	else:
		_velocity.x = lerp(_velocity.x, 0, FRICTION)
		
	# Control gravity
	if _gravity_state == GravityState.FREEFALL:
		_velocity.y += delta * GRAVITY
	else:
		_velocity.y = 0

	# Determine animation state by checking current velocities
	if round(_velocity.x * 1000) != 0 or $AnimatedSprite.frame != 0:
		$AnimatedSprite.flip_h = _velocity.x < 0
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	# Move the Entity
	_velocity = move_and_slide(_velocity, Vector2.UP)
	
	# Check if the Entity was grounded:
	if is_on_floor():
		_current_jump_state = JumpState.REST

func execute_light_attack():
	# Interface for Light Attack
	pass
	
func execute_heavy_attack():
	# Interface for Heavy Attack
	pass

func _debounce_light_attack():
	# Call this first to debounce press
	if _attack_state == AttackState.DONE:
		execute_light_attack()
	
func _debounce_heavy_attack():
	# Call this first to debounce press
	if _attack_state == AttackState.DONE:
		execute_heavy_attack()

func set_current_state(current_state):
	_current_state = current_state

func get_current_jump_state():
	return _current_jump_state
	
func initialize_jump():
	_velocity.y = -JUMP_FORCE
	_current_jump_state = JumpState.JUMP_INITIAL