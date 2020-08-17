tool
extends EditorPlugin


func _enter_tree():
	add_custom_type("Ladder", "Area2D", preload("Ladder/main.gd"), preload("Ladder/icon.png"))


func _exit_tree():
	remove_custom_type("Ladder")
