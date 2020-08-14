extends "res://_Generics/ControllableEntity.gd"

func _ready():
	# TODO: This should be also somehow be generised
	set_interact_object($InteractionIndicator)
	$InteractionArea.connect("area_entered", self, "_on_InteractionArea_area_entered")
	$InteractionArea.connect("area_exited", self, "_on_InteractionArea_area_exited")

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
	
	# Print debug labels
	$Label.text = "{X}, {Y}".format({"X": _velocity.x, "Y": _velocity.y})
	$SkillIndicator.text = "Selected Skill: {skill}".format({"skill": _current_skill + 1})

	# Update the HUD
	process_hud()

func process_hud():
	$PlayerHUD/Health.rect_scale = Vector2(health / max_health, 1)
	$PlayerHUD/Mana.rect_scale = Vector2(mana / max_mana, 1)
	$PlayerHUD/Focus.rect_scale = Vector2(focus / max_focus, 1)

# Interaction has 2 sides:
# 1. Instant interaction (ie. NPCs, Next Level stuff)
# 2. Movement Limiters (ie. Ladders)
func _on_InteractionArea_area_entered(area):
	_interact_object.visible = true
	
func _on_InteractionArea_area_exited(area):
	_interact_object.visible = false
