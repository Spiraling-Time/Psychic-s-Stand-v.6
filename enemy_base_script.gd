extends Node2D

func take_damage(damage_TYPE, damage, knockback):
	if hp > 0:
		hp = hp - damage
		#add knockback
	#print(self, ": ", hp)
	if hp <= 0:
		start_to_die()
