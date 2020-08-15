extends "res://_Generics/ControllableEntity.gd"

func _ready():
	set_interact_object($InteractionIndicator)
	set_interaction_area($InteractionArea)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	set_current_state(MoveState.IDLE)
	if Input.is_action_pressed("ui_right"):
		set_current_state(MoveState.RIGHT)
	elif Input.is_action_pressed("ui_left"):
		set_current_state(MoveState.LEFT)
	
	# Allow only single jumping
	if (Input.is_action_pressed("ui_select") 
			and get_current_jump_state() == JumpState.REST):
		initialize_jump()
	
	# Change skill to be used
	if Input.is_action_pressed("ui_skill_1"):
		set_skill(SkillState.SKILL1)
	elif Input.is_action_pressed("ui_skill_2"):
		set_skill(SkillState.SKILL2)
	elif Input.is_action_pressed("ui_skill_3"):
		set_skill(SkillState.SKILL3)
	elif Input.is_action_pressed("ui_skill_4"):
		set_skill(SkillState.SKILL4)
	
	# Check if attacking
	if (Input.is_action_pressed("ui_light") 
			and get_attack_state() == AttackState.DONE):
		set_attack_state(AttackState.GOING)
	elif (Input.is_action_pressed("ui_heavy") 
			and get_attack_state() == AttackState.DONE):
		set_attack_state(AttackState.GOING)

	# Object was X-Locked, ui_up/ui_down is now toggled
	if _movement_state == MovementState.LIMITED_X:
		if Input.is_action_pressed("ui_up"):
			move_up()
		elif Input.is_action_pressed("ui_down"):
			move_down()
		else:
			rest()
	else:
		# Interact with objects
		if Input.is_action_pressed("ui_up") and has_interactable():
			interact_with_object()
	
	# Print debug labels
	$Label.text = "{X}, {Y}".format({"X": _velocity.x, "Y": _velocity.y})
	$SkillIndicator.text = "Selected Skill: {skill}".format({"skill": _current_skill + 1})

	# Update the HUD
	process_hud()

func process_hud():
	$PlayerHUD/Health.rect_scale = Vector2(health / max_health, 1)
	$PlayerHUD/Mana.rect_scale = Vector2(mana / max_mana, 1)
	$PlayerHUD/Focus.rect_scale = Vector2(focus / max_focus, 1)
