extends Node2D





@onready var GW = preload("res://Scenes/goblin_warrior.tscn")




@onready var IMP = preload("res://Scenes/Imp.tscn")



@onready var orcy = preload("res://Scenes/Orcy.tscn")


@onready var greenkabluey = preload("res://Scenes/greenkabluey.tscn")

@onready var textures = [
	preload("res://Assets/Green_di_sprite_sheet.png"),
	preload("res://Assets/orangekablueyspritesheet.png"),
	preload("res://Assets/yellowspritesheetname.png"),
	preload("res://Assets/reddiamondthingspritesheetwithinconsistentandinnacuratenaming.png")
	]
	
	
@onready var lasers = [
	preload("res://Assets/Diamond Dive Bomb Sprite Sheet (04).png"),
	preload("res://Assets/Diamond Dive Bomb Sprite Sheet (09).png"),
	preload("res://Assets/Diamond Dive Bomb Sprite Sheet (14).png"),
	preload("res://Assets/Diamond Dive Bomb Sprite Sheet (19).png")
	]



var Nblockers = 0

var maxPWR = 0


var max_NGW = 20 #Number of Goblin Warriors 10
var NGW = 0
var GWPWR = 1


var max_IMPS = 20
var NIMPS = 0
var impPWR = 1


var max_orcys = 10
var Norcy = 0
var OrcyPWR = 5


var max_grnkblues = 4
var Ngrnkblues = 0
var grnkluesPWR = 3




var overlapping_bodies



var test = false




func _ready():
	var spawn_troops = [
	{"N": NGW, "max": max_NGW, "enemy_type": GW, "type": "Goblin_warrior"},
	{"N": NIMPS, "max": max_IMPS, "enemy_type": IMP, "type": "Imp"},
	{"N": Norcy, "max": max_orcys, "enemy_type": orcy, "type": "Orc"},
	{"N": Ngrnkblues, "max": max_grnkblues, "enemy_type": greenkabluey, "type": "green kabluey"}]
	for data in spawn_troops:
		var ene = data["enemy_type"].instantiate()
		ene.position = position
		get_parent().get_node("enemy_handler").add_child(ene)
		ene.queue_free()



func _on_timer_timeout():
	spawn_the_troops()



func spawn_the_troops():
	if test:
		spawn_goblinw()
	
	
	else:
		
		
		maxPWR = (ScoreManager.current_score)/10
		if maxPWR < 10: maxPWR = 10
		if ((NGW*GWPWR)+(NIMPS*impPWR)+(Norcy*OrcyPWR)+(Ngrnkblues*grnkluesPWR)) < maxPWR:
			var spawnlvl = randi_range(1, ScoreManager.current_score)
			if spawnlvl < 50:
				if randi_range(1,2) == 1: spawn_goblinw()
				else: spawn_IMP()
			#elif spawnlvl < 70:
			else:
				if randi_range(1,2) == 1: spawn_orcy()
				else: spawn_greenkabluey()

			
		
		
		
		
		
		
		#if ScoreManager.current_score <= 15:
			#max_NGW = 6
			#max_IMPS = 6
			#
			#
			#var randtroop = randi_range(1,2)
			#if randtroop == 1 and NGW < max_NGW:
				#spawn_goblinw()
			#else:
				#spawn_IMP()	
		#
		#
		#elif ScoreManager.current_score <= 50:
			#max_NGW = 10
			#max_IMPS = 10
			#
			#var randtroop = randi_range(1,2)
			#if randtroop == 1:
				#spawn_goblinw()
			#elif randtroop == 2:
				#spawn_IMP()
			##print("Nblockers: ", Nblockers)
		#
		#elif ScoreManager.current_score <= 100:
			#max_grnkblues = 2
			#max_orcys = 1
			#max_NGW = 1
			#
			#if Norcy < max_orcys:
				#spawn_orcy()
			#elif Ngrnkblues < max_grnkblues:
				#spawn_greenkabluey()
			#else:
				#spawn_goblinw()
			##print("Nblockers: ", Nblockers)
		#
		#
		#
		#elif ScoreManager.current_score <= 200:
			#max_NGW = 8
			#max_IMPS = 8
			#max_orcys = 2
			#
			#var randtroop = randi_range(1,5)
			#if randtroop == 1:
				#spawn_goblinw()
			#elif randtroop == 2:
				#spawn_IMP()
			#else:
				#spawn_orcy()
			##print("Nblockers: ", Nblockers)
#
#
#
#
		#elif ScoreManager.current_score <= 100000000:
			#max_NGW = 16
			#max_IMPS = 16
			#max_orcys = 2
			#
			#var randtroop = randi_range(1,5)
			#if randtroop == 1:
				#spawn_goblinw()
			#elif randtroop == 2:
				#spawn_IMP()
			#else:
				#spawn_orcy()
			##print("Nblockers: ", Nblockers)




func spawn_goblinw():
	var spawn_troops = [
	{"N": NGW, "max": max_NGW, "enemy_type": GW, "type": "Goblin_warrior"}]
	for data in spawn_troops:
		if data["N"] < data["max"]:
			position.x = randi_range(-1000,1000)
			position.y = 479
			var ene = data["enemy_type"].instantiate()
			if $Area2D:
				$Area2D.get_node("CollisionShape2D").shape = ene.get_node("main_collision_shape").shape
				overlapping_bodies = $Area2D.get_overlapping_bodies()
				if overlapping_bodies.size() <= 0:
					NGW += 1
					ene.position = position
					get_parent().get_node("enemy_handler").add_child(ene)
					print("There are ", data["N"], " ", data["type"], "s")
				else:
					ene.queue_free()


func spawn_IMP():
	var spawn_troops = [
	{"N": NIMPS, "max": max_IMPS, "enemy_type": IMP, "type": "Imp"}]
	for data in spawn_troops:
		if data["N"] < data["max"]:
			position.x = randi_range(-1000,1000)
			position.y = randi_range(-479,479)
			var ene = data["enemy_type"].instantiate()
			if $Area2D:
				$Area2D.get_node("CollisionShape2D").shape = ene.get_node("main_collision_shape").shape
				overlapping_bodies = $Area2D.get_overlapping_bodies()
				if overlapping_bodies.size() <= 0:
					NIMPS += 1
					ene.position = position
					get_parent().get_node("enemy_handler").add_child(ene)
					print("There are ", data["N"], " ", data["type"], "s")
				else:
					ene.queue_free()
			

func spawn_orcy():
	var spawn_troops = [
	{"N": Norcy, "max": max_orcys, "enemy_type": orcy, "type": "Orc"}]
	for data in spawn_troops:
		if data["N"] < data["max"]:
			position.x = randi_range(-1000,1000)
			position.y = 479
			var ene = data["enemy_type"].instantiate()
			if $Area2D:
				$Area2D.get_node("CollisionShape2D").shape = ene.get_node("main_collision_shape").shape
				overlapping_bodies = $Area2D.get_overlapping_bodies()
				if overlapping_bodies.size() <= 0:
					Norcy += 1
					ene.position = position
					get_parent().get_node("enemy_handler").add_child(ene)
					print("There are ", data["N"], " ", data["type"], "s")
				else:
					ene.queue_free()

func spawn_greenkabluey():
	var spawn_troops = [
	{"N": Ngrnkblues, "max": max_grnkblues, "enemy_type": greenkabluey, "type": "green kabluey"}]
	for data in spawn_troops:
		if data["N"] < data["max"]:
			position.x = randi_range(-1000,1000)
			position.y = randi_range(-479, 0)
			var ene = data["enemy_type"].instantiate()
			if $Area2D:
				$Area2D.get_node("CollisionShape2D").shape = ene.get_node("main_collision_shape").shape
				overlapping_bodies = $Area2D.get_overlapping_bodies()
				if overlapping_bodies.size() <= 0:
					Ngrnkblues += 1
					ene.position = position
					var random_color = randi_range(0, textures.size() - 1)
					ene.get_node("Sprite2D").texture = textures[random_color]
					ene.get_node("attack_detector1/Sprite2D2").texture = lasers[random_color]
					get_parent().get_node("enemy_handler").add_child(ene)
					print("There are ", data["N"], " ", data["type"], "s")
				else:
					ene.queue_free()
