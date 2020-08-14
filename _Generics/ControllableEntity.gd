extends "res://_Generics/Entity.gd"

var _interact_object

func set_interact_object(interact_object):
	_interact_object = interact_object
	_interact_object.visible = false

func set_interaction_area(interact_area: Area2D):
	interact_area.connect("area_entered", self, "_on_area_entered")
	interact_area.connect("area_exited", self, "_on_area_exited")

# Interaction has 2 sides:
# 1. Instant interaction (ie. NPCs, Next Level stuff)
# 2. Movement Limiters (ie. Ladders)
func _on_area_entered(area):
	_interact_object.visible = true
	
func _on_area_exited(area):
	_interact_object.visible = false
