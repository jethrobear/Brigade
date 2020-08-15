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

func interact_with_object():
	# Execute actionables() found in the interactive box
	_interactable_instance.call_interaction()
