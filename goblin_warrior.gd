extends "res://Scripts/baseE.gd"
#extends CharacterBody2D


func _ready():
	
	
	
	goblinw = true

	
	
	
	main_collision_shape = $main_collision_shape
	ani = $AnimationPlayer
	attack1d = $attack_detector1
	attack2d = $attack_detector2
	enemydetector1 = $enemy_detector1
	enemydetector2 = $enemy_detector2
	enemydetector3 = $enemy_detector3
	raycast1 = $turn_around_checker 
	jump_f_clear = $jump_f_clear
	jump_b_clear = $jump_b_clear
	
	
	
	spawnerup = $"../../spawner;)"
	#$"../../Spawner"
	
	if randi_range(1,2)==1:
		mleft = true
		scale.x = -scale.x
	else:
		mleft = false
	
	
	
	ani.play("spawn")
	
	
