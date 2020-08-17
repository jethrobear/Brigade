extends "res://_Generics/ControllableEntity.gd"

func execute_light_attack():
	print("LH")
	_attack_state = AttackState.DONE
	
func execute_heavy_attack():
	print("HH")
	_attack_state = AttackState.DONE
