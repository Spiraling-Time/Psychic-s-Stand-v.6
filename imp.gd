extends "res://Scripts/baseE.gd"
#extends CharacterBody2D


func _ready():
	
	
	
	
	imp = true
	
	ifireball = preload("res://Scenes/imp_fireball.tscn")

	
	
	
	
	gravity = 10
	speed = 15
	max_hp = 15
	hp = max_hp
	fly_vary = randi_range(-350,350)

	
	target_finder = $target_finder
	
	main_collision_shape = $main_collision_shape
	ani = $AnimationPlayer
	raycast1 = $turn_around_checker 
	attack1d = $attack_detector1
	enemydetector1 = $enemy_detector1
	
	spawnerup = $"../../spawner;)"
	
	if randi_range(1,2)==1:
		mleft = true
		scale.x = -scale.x
	else:
		mleft = false
	
	
	
	ani.play("spawn")
