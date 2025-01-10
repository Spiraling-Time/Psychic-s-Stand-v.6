extends Node2D

func take_damage(damage_TYPE, damage, LoR, knockback):
	if hp > 0:
		hp = hp - damage
		if LoR:
			knockback_vector.x -= knockback
		else:
			knockback_vector.x += knockback
		knockback_vector.y = -knockback * 0.1  # Apply upward knockback with reduced strength
		velocity = knockback_vector
		move_and_slide()
		knockback_vector = Vector2.ZERO
	#print(self, ": ", hp)
	if hp <= 0:
		start_to_die()
