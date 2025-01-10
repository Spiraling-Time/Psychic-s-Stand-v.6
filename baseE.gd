extends CharacterBody2D



#goblinw
@onready var main_collision_shape = null
@onready var ani = null
@onready var attack1d = null
@onready var attack2d = null
@onready var attack3d = null
@onready var attack4d = null
@onready var attack5d = 	null
@onready var attack6d = 	null
@onready var attack7d = null
@onready var enemydetector1 = null
@onready var enemydetector2 = null
@onready var enemydetector3 = null
@onready var raycast1 = null 
@onready var jump_f_clear = null
@onready var jump_b_clear = null



@onready var Soul = preload("res://Scenes/soul.tscn")



@onready var ifireball = null





#imp
@onready var target_finder = null

#kablueys
@onready var start_laser = null
@onready var end_laser = null






@onready var spawnerup = null




#WHO ARE YOU
var goblinw: bool = false
var imp: bool = false
var orcy: bool = false
var greenkabluey: bool = false



var gravity = 10

var mleft: bool = false
var speed = 5
var max_hp: int = 50
var hp: int = max_hp
#var myknockback = 0

var knockback_vector: Vector2

var xpast_position = 0


var fly_vary = null


var detected_bodies1: Array = []
var detected_bodies2: Array = []
var detected_bodies3: Array = []

var overlapping_bodies1: Array
var overlapping_bodies2: Array
var overlapping_bodies3: Array



var XPvalue: int = 0

var decide

func _ready():
	pass



func _process(delta):
	if !greenkabluey and nothing_important_going_on():
		ani.play("walk")
		start_walk()
	elif greenkabluey:
		if mleft:
			rotation_degrees += 1
		else:
			rotation_degrees += -1
	if imp: aim()


func _physics_process(delta):
	detect_turn_around()
	move_and_slide()
	
	if abs(velocity.x) > 1.0:  # Only apply friction if moving
		velocity.x = lerp(velocity.x, 0.0, 0.7 * delta)
	else:
		velocity.x = 0.0  # Snap to 0 when close enough
	velocity.y += gravity
	xpast_position = position.x
	if not_spawning_or_dying():
		movement_attacks()
		if imp:
			if position.y > fly_vary: gravity = randi_range(-5,-15)
			else: gravity = randi_range(5,15)

				
					

func movement_attacks():
	if nothing_important_going_on() and !greenkabluey:
		if mleft == false:
			velocity.x += speed
		else:
			velocity.x += -speed

	if orcy:
		if ani.current_animation in ["attack2"]:
			if mleft == false:
				velocity.x += speed*1.5
			else:
				velocity.x += -speed*1.5
		if ani.current_animation in ["attack3"]:
			if ani.current_animation_position >= 0.0 and ani.current_animation_position <= 0.4:
				if mleft == false:
					velocity.x += speed*2
				else:
					velocity.x += -speed*2



#func do_walk():
	#if not_spawning_or_dying():
		#pass



	
func detect_turn_around():
	if raycast1:
		if raycast1.is_colliding() and nothing_important_going_on():
			scale.x = -scale.x
			mleft = !mleft


func hit(attack_number: int) -> void:
	var attack_name = "attack_detector" + str(attack_number)
	var detector = get_node_or_null(attack_name)
	if detector:
		detector.monitoring = true
		#print("Enabled monitoring for ", attack_name)

	else:
		pass
		#print("Error: Detector not found:", attack_name)

func end_hit(attack_number: int) -> void:
	var attack_name = "attack_detector" + str(attack_number)
	var detector = get_node_or_null(attack_name)
	if detector:
		detector.monitoring = false
		#print("Disabled monitoring for ", attack_name)
	else:
		pass
		#print("Error: Detector not found:", attack_name)




func start_walk():

	if goblinw:
		
		#if nothing_important_going_on():
		if enemydetector1 and enemydetector2 and enemydetector3:
			overlapping_bodies1 = enemydetector3.get_overlapping_bodies()
			overlapping_bodies2 = enemydetector1.get_overlapping_bodies()
			overlapping_bodies3 = enemydetector2.get_overlapping_bodies()

			if overlapping_bodies1.size() >= 1:
				for body in overlapping_bodies1:
					if body.has_method("take_damage") and body != self and is_on_floor():
						ani.play("upward_attack")
						return
						
						
			if overlapping_bodies2.size() >= 1:
				for body in overlapping_bodies2:
					if body.has_method("take_damage") and body != self and is_on_floor():
						ani.play("attack1")
						return
		
			if overlapping_bodies3.size() >= 1:
				for body in overlapping_bodies3:
					if is_on_floor() and !jump_f_clear.is_colliding() and !jump_b_clear.is_colliding() and body.has_method("take_damage") and body != self:
						ani.play("jump_attack")
						return
							
		decide = randi_range(1,5) 
		if decide <= 1 and jump_b_clear and !jump_b_clear.is_colliding and is_on_floor():
			ani.play("retreat")


	if imp:
		if enemydetector1:
			overlapping_bodies1 = enemydetector1.get_overlapping_bodies()
			if overlapping_bodies1.size() >= 1:
				for body in overlapping_bodies1:
					if body.has_method("take_damage") and body != self:
						ani.play("upward_attack")
						return

	if orcy:
		if enemydetector1:
			overlapping_bodies1 = enemydetector1.get_overlapping_bodies()


			if overlapping_bodies1.size() >= 1:
				for body in overlapping_bodies1:
					if body.has_method("take_damage") and body != self and is_on_floor():
						var rand_attack = (randi_range(1,5))
						if rand_attack == 1:
							ani.play("attack1")
						elif rand_attack == 2:
							ani.play("upward_attack")
						elif rand_attack == 3:
							ani.play("attack2")
						elif rand_attack == 4:
							ani.play("attack3")
						elif rand_attack == 5:
							ani.play("jump")
						
						return



func take_damage(damage_TYPE, damage, up, down, LoR, other, knockback):
	if not_spawning_or_dying():

		if goblinw: #add this for every enemy
			end_hit(1)
			end_hit(2)
		if orcy:
			end_hit(1)
			end_hit(2)
			end_hit(3)
			end_hit(4)
			end_hit(5)
			end_hit(6)
		if greenkabluey:
			attack1d.visible = false
			end_hit(1)
			ani.stop()
			velocity.x = 0
			ani.play("death")
		else:
			ani.stop()
			ani.play("flinch")
			if hp > 0:
				hp = hp - damage
				if down: velocity.y = knockback*0.1
				else: velocity.y = knockback*-0.1
				#velocity.x = 0
				#move_and_slide()
				#velocity.y = 0
				if !up and !down and !other:
					if LoR:
						velocity.x += knockback*-1
					else:
						velocity.x += knockback*1
				#hp = hp - damage
				#if up:
					#knockback_vector.y = -knockback
				#elif down:
					#knockback_vector.y = knockback
					#
				#else:
					#if LoR:
						#knockback_vector.x -= knockback
					#else:
						#knockback_vector.x += knockback
					#knockback_vector.y = -knockback * 0.5  # Apply upward knockback with reduced strengthaaaaaaaaaaaaaaaaaaaaa
				#velocity = knockback_vector
				#move_and_slide()
				#knockback_vector = Vector2.ZERO
			#print(self, ": ", hp)
			if hp <= 0:
				ani.stop()
				velocity.x = 0
				ani.play("death")





func jump(jumprange1: int, jumprange2: int, speed_modifier1: int, speed_modifier2: int):
	if is_on_floor():
		var randomjump = randi_range(-1*jumprange1, -1*jumprange2)
		velocity.y = randomjump
		var randspdmod = randi_range(speed_modifier1, speed_modifier2)
		if mleft == false:
			velocity.x += speed*randspdmod
		else:
			velocity.x += -speed*randspdmod




func _on_attack_detector_1_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage") and body != self:
		if goblinw:
			var randknockback = randi_range(200,300)
			body.take_damage("Melee", 10, false, false, mleft, false, randknockback)
		elif imp:
			var randknockback = randi_range(4000,5000)
			body.take_damage("Melee", 30, true, false, mleft, false, randknockback)
		elif orcy:
			var randknockback = randi_range(2000,3300)
			body.take_damage("Melee", 30, false, false, mleft, false, randknockback)
		elif greenkabluey:
			var randknockback = randi_range(500,600)
			body.take_damage("Ranged", 10, true, false, mleft, false, randknockback)
			
			
			

func _on_attack_detector_2_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage") and body != self:
		if goblinw:
			var randknockback = randi_range(4000,5000)
			body.take_damage("Melee", 10, true, false, mleft, false, randknockback)
		elif orcy:
			var randknockback = randi_range(6000,7000)
			body.take_damage("Melee", 40, true, false, mleft, false, randknockback)
		elif greenkabluey:
			var randknockback = randi_range(70000,75000)
			body.take_damage("Melee", 50, true, false, mleft, false, randknockback)


func _on_attack_detector_3_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage") and body != self:
		if orcy:
			var randknockback = randi_range(5000,5500)
			body.take_damage("Melee", 60, true, false, mleft, false, randknockback)


func _on_attack_detector_4_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage") and body != self:
		if orcy:
			var randknockback = randi_range(1000,4500)
			body.take_damage("Melee", 20, false, false, mleft, false, randknockback)

func _on_attack_detector_5_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage") and body != self:
		if orcy:
			var randknockback = randi_range(2000,3000)
			body.take_damage("Melee", 30, false, false, mleft, false, randknockback)

func _on_attack_detector_6_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage") and body != self:
		if orcy:
			var randknockback = randi_range(20000,30000)
			body.take_damage("Melee", 100, true, false, mleft, false, randknockback)








func retreat():
	if is_on_floor():
		var randomjump = randi_range(-250, -350)
		velocity.y = randomjump
		if mleft == false:
			velocity.x = speed*-.5
		else:
			velocity.x = -speed*-.5





#IMP
func aim():
	if target_finder.enabled:
		target_finder.target_position.y = (randi_range(-100,100))
		if target_finder.is_colliding() and nothing_important_going_on():
			#ani.stop()
			ani.play("ranged_attack")


func shoot():
	target_finder.enabled = false
	var Ifire = ifireball.instantiate()
	Ifire.position.y = position.y
	if mleft:
		Ifire.position.x = position.x - 70
		Ifire.direction = -1*(target_finder.target_position).normalized()

	else:
		Ifire.position.x = position.x + 70
		Ifire.direction = (target_finder.target_position).normalized()
	Ifire.rotation = Ifire.direction.angle()
	get_tree().current_scene.add_child(Ifire)
	target_finder.enabled = true

#general

func nothing_important_going_on() -> bool:
	if ani.current_animation not in ["retreat", "flinch"] and not_mid_attacking() and not_spawning_or_dying():
		return true
	else:
		return false

func not_mid_attacking() -> bool:
	if ani.current_animation not in ["attack1", "attack2", "attack3", "jump_attack", "upward_attack", "jump", "ranged_attack",] and not_spawning_or_dying():
		return true
	else:
		return false

func not_spawning_or_dying() -> bool:
	if ani.current_animation not in ["spawn", "death"]:
		return true
	else:
		return false

func die():
	if goblinw: spawnerup.NGW -=1 # do this for every enemy
	if imp: spawnerup.NIMPS -=1
	if orcy: spawnerup.Norcy -=1
	elif greenkabluey:
		spawnerup.Ngrnkblues -=1
		queue_free()
	var souldeath = Soul.instantiate()
	souldeath.XPamountstuff = XPvalue
	souldeath.position = position
	get_tree().current_scene.add_child(souldeath)
	queue_free()

	

func XP(amountXP):
	hp += amountXP
	if hp > max_hp: hp = max_hp
	XPvalue += amountXP
	
	


func _on_start_laser_timeout() -> void:
	if not_spawning_or_dying():
		ani.play("attack1")
		attack1d.visible = true
		hit(1)
		end_laser.wait_time = randi_range(3,7)
		end_laser.start()


func _on_end_laser_timeout() -> void:
	if not_spawning_or_dying():
		ani.play("Idle")
		attack1d.visible = false
		end_hit(1)
		start_laser.wait_time = randi_range(2,5)
		start_laser.start()
