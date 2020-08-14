extends "res://_Generics/Entity.gd"

var _interact_object

func set_interact_object(interact_object):
	_interact_object = interact_object
	_interact_object.visible = false

func set_interaction_area(interact_area: Area2D):
	interact_area.connect("area_entered", self, "_on_interact_area_entered")
	interact_area.connect("area_exited", self, "_on_interact_area_exited")
