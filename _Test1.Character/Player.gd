extends "res://addons/brigade/ControllableEntity/main.gd"

func execute_light_attack():
	print("LH")
	_attack_state = AttackState.DONE
	
func execute_heavy_attack():
	print("HH")
	_attack_state = AttackState.DONE
