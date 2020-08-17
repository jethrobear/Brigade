extends "res://_Generics/Entity.gd"

var _interact_object
var _interactable_instance

func set_interact_object(interact_object):
	_interact_object = interact_object
	_interact_object.visible = false

func set_interaction_area(interact_area):
	interact_area.connect("area_entered", self, "_on_area_entered")
	interact_area.connect("area_exited", self, "_on_area_exited")

func has_interactable():
	return _interactable_instance != null

# Interaction has 2 sides:
# 1. Instant interaction (ie. NPCs, Next Level stuff)
# 2. Movement Limiters (ie. Ladders)
func _on_area_entered(area):
	_interact_object.visible = true
	_interactable_instance = area
	
func _on_area_exited(area):
	_interact_object.visible = false
	_interactable_instance = null
	_movement_state = MovementState.OPEN

func interact_with_object():
	# Execute actionables() found in the interactive box
	_interactable_instance.call_interaction(self)

func limit_movement_y(interaction_area, speed):
	# Set gravity pull
	_movement_state = MovementState.LIMITED_X
	_climb_speed = speed
	
	# Align Entity with left of object
	global_position.x = interaction_area.global_position.x
	
	# Added buffer to not immediately exit LOCKED mode
	if interaction_area.global_position.y <= global_position.y:
		# The Entity's top-left point is below Entity
		global_position.y -= 10  
	else:
		# The Entity's top-left point is above Entity
		global_position.y = interaction_area.global_position.y 
		
func move_up():
	.move_up()
	
	# If the Entity hits a ceiling, then release it
	if is_on_ceiling():
		# Determine the max height of the collider
		var collider_height = 0
		for slide_idx in get_slide_count():
			collider_height = max(
					get_slide_collision(slide_idx).collider.cell_size.y, 
					collider_height
			)
		
		# Find the collision for the Entity
		var entity_height = 0
		for child in get_children():
			if child.get("shape"):
				entity_height = max(child.shape.height, entity_height)
		global_position.y -= collider_height + entity_height
		_movement_state = MovementState.OPEN
