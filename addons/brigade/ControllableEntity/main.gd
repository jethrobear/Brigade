tool
extends "res://addons/brigade/_Generics/Entity.gd"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Clean HUD
	update_skill_hud()
	
	set_current_state(MoveState.IDLE)
	if Input.is_action_pressed("ui_right"):
		set_current_state(MoveState.RIGHT)
	elif Input.is_action_pressed("ui_left"):
		set_current_state(MoveState.LEFT)
	
	# Allow only single jumping
	if (Input.is_action_pressed("ui_select") 
		and get_current_jump_state() == JumpState.REST):
		initialize_jump()
	
	# Change skill
	if Input.is_action_pressed("ui_skill_1"):
		_skill_state = SkillState.SKILL1
	elif Input.is_action_pressed("ui_skill_2"):
		_skill_state = SkillState.SKILL2
	elif Input.is_action_pressed("ui_skill_3"):
		_skill_state = SkillState.SKILL3
	elif Input.is_action_pressed("ui_skill_4"):
		_skill_state = SkillState.SKILL4
	
	# Execute Attacks
	if Input.is_action_pressed("ui_light_attack"):
		_debounce_light_attack()
	elif Input.is_action_pressed("ui_heavy_attack"):
		_debounce_heavy_attack()
	
	# If the Entity is inside a ladder then allow up/down buttons
	if _gravity_state == GravityState.LADDER:
		if Input.is_action_pressed("ui_up"):
			position.y -= CLIMB_SPEED
		elif Input.is_action_pressed("ui_down"):
			position.y += CLIMB_SPEED
	
	# Print debug labels
	$Label.text = "{X}, {Y}".format({"X": _velocity.x, "Y": _velocity.y})

	# Update the HUD
	process_hud()

func update_skill_hud():
	$PlayerHUD/Skill1.color = Color("#666666")
	$PlayerHUD/Skill2.color = Color("#666666")
	$PlayerHUD/Skill3.color = Color("#666666")
	$PlayerHUD/Skill4.color = Color("#666666")
	if _skill_state == SkillState.SKILL1:
		$PlayerHUD/Skill1.color = Color.darkred
	if _skill_state == SkillState.SKILL2:
		$PlayerHUD/Skill2.color = Color.darkred
	if _skill_state == SkillState.SKILL3:
		$PlayerHUD/Skill3.color = Color.darkred
	if _skill_state == SkillState.SKILL4:
		$PlayerHUD/Skill4.color = Color.darkred

func process_hud():
	$PlayerHUD/Health.rect_scale = Vector2(health / max_health, 1)
	$PlayerHUD/Mana.rect_scale = Vector2(mana / max_mana, 1)
	$PlayerHUD/Focus.rect_scale = Vector2(focus / max_focus, 1)
