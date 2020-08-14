extends "res://_Generics/Entity.gd"

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
		
	# Print debug labels
	$Label.text = "{X}, {Y}".format({"X": _velocity.x, "Y": _velocity.y})

	# Update the HUD
	process_hud()

func process_hud():
	$PlayerHUD/Health.rect_scale = Vector2(health / max_health, 1)
	$PlayerHUD/Mana.rect_scale = Vector2(mana / max_mana, 1)
	$PlayerHUD/Focus.rect_scale = Vector2(focus / max_focus, 1)
