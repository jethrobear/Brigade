tool
extends EditorPlugin


func _enter_tree():
	add_custom_type("Ladder", "Area2D", preload("Ladder/main.gd"), preload("Ladder/ladder-svgrepo-com.svg"))
	add_custom_type("Entity", "KinematicBody2D", preload("Entity/main.gd"), preload("Entity/user-svgrepo-com.svg"))


func _exit_tree():
	remove_custom_type("Ladder")
	remove_custom_type("Entity")
