extends "res://Scripts/baseE.gd"
#extends CharacterBody2D


func _ready():
	
	
	
	orcy = true

	
	
	speed = 10
	
	max_hp = 300
	hp = max_hp

	
	main_collision_shape = $main_collision_shape
	ani = $AnimationPlayer
	attack1d = $attack_detector1
	attack2d = $attack_detector2
	attack3d = $attack_detector3
	attack4d = $attack_detector4
	attack5d = 	$attack_detector5
	attack6d = 	$attack_detector6


	enemydetector1 = $enemy_detector1
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
