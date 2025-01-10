extends "res://Scripts/baseE.gd"
#extends CharacterBody2D


func _ready():
	
	
	
	greenkabluey = true

	speed = 0
	
	gravity = 0

	
	
	main_collision_shape = $main_collision_shape
	ani = $AnimationPlayer
	attack1d = $attack_detector1
	attack2d = $attack_detector2
	
	start_laser = $start_laser
	end_laser = $end_laser
	
	spawnerup = $"../../spawner;)"
	
	if randi_range(1,2)==1:
		mleft = true
		scale.x = -scale.x
	else:
		mleft = false
	
	
	
	ani.play("spawn")
