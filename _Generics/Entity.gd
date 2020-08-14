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
enum SkillState {
	SKILL1,
	SKILL2,
	SKILL3,
	SKILL4
}
enum AttackState {
	GOING,
	DONE
}

# World modifiable variables
export var GRAVITY = 400
export var SPEED = 10
export var FRICTION = 0.5
export var JUMP_FORCE = 250

export var health = 0
export var max_health = 100
export var mana = 0
export var max_mana = 100
export var focus = 0
export var max_focus = 100

var _velocity = Vector2()
var _current_state = MoveState.IDLE
var _current_jump_state = JumpState.REST
var _current_skill = SkillState.SKILL1
var _current_attack = AttackState.DONE

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
	_velocity.y += delta * GRAVITY

	# Determine animation state by checking current velocities
	if round(_velocity.x * 1000) != 0 or $AnimatedSprite.frame != 0:
		$AnimatedSprite.flip_h = _velocity.x < 0
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	# Move the Entity
	_velocity = move_and_slide(_velocity, Vector2.UP)

func set_skill(current_skill):
	_current_skill = current_skill

func set_current_state(current_state):
	_current_state = current_state

func get_current_jump_state():
	return _current_jump_state

func get_attack_state():
	return _current_attack
	
func set_attack_state(current_attack):
	_current_attack = current_attack

func initialize_jump():
	_velocity.y = -JUMP_FORCE
	_current_jump_state = JumpState.JUMP_INITIAL
