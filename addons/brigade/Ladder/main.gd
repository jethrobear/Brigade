tool
extends Area2D

const GravityState = preload("res://addons/brigade/GravityEnum.gd")

func _enter_tree():
	connect("body_entered", self, "body_entered")
	connect("body_exited", self, "body_exited")

func body_entered(body):
	# If an Entity is inside the ladder, then allow the Entity to climb
	if body is PhysicsBody2D:
		# 1. Snap the Entity into the constraints of the area
		body._gravity_state = GravityState.LADDER

func body_exited(body):
	# If an Entity is outside the ladder, then let gravity do its stuff
	if body is PhysicsBody2D:
		# 1. Unsnap the Entity into the constraints of the area
		body._gravity_state = GravityState.FREEFALL
