extends CharacterBody2D


@export var original_speed = 30  # Speed multiplier
@onready var health_bar = $"../Camera2D/Control/Health Bar"
@onready var energy_bar = $"../Camera2D/Control/Energy Bar"
@onready var timer = $Timer

var speed = original_speed
var space_pressed: bool = false
var down_pressed: bool = false
var key_pressed: bool = false
var recharge: bool = true
var gravity = 10
var max_hp = 1000
var hp = max_hp
var energy = 100
var fake_velocityx = 0
var spin= 0.0
#var myknockback = 0
var knockback_vector: Vector2

var selectdieornot: bool = false

var last_grit = 0
var beyond_death: bool = false

var being_hit: bool = false

var XPvalue: int = 0


func _ready():
	#gravity_scale = 1
	energy_bar.value = energy
	health_bar.value = hp
	await get_tree().create_timer(0.3).timeout
	take_damage("Melee", 870, true, false, false, false, randi_range(30000,40000))


func is_enemy():
	pass

func get_health():
	hp += 1
	health_bar.value = hp

func lose_health():
	hp -= 1
	health_bar.value = hp

func get_energy():
	energy += 1
	energy_bar.value = energy

func lose_energy():
	energy -= 1
	energy_bar.value = energy


	
func _process(delta: float) -> void:
	#invincible mode
	#hp = 1000
	#health_bar.value = hp

	# Apply rotation based on angular velocity
	rotation_degrees += spin * delta

	# Gradually reduce angular velocity due to friction
	spin *= .9

	# Stop spinning if angular velocity is very low
	if abs(spin) < 0.1:
		spin = 0.0

func _physics_process(delta):
	#move_and_slide()
	#if energy > 0 and !being_hit:
		## Check for user input and set axis_velocity accordingly
		##if Input.is_action_pressed("speed_up"):
			##lose_energy()
			##if speed < (original_speed*2):
				##speed += 18
			##space_pressed = true
		##if space_pressed == false:
			##speed = 18		
		##print("speed: ", speed)
		#if Input.is_action_pressed("ui_up"):
			#key_pressed = true
			#lose_energy()
			#velocity.y -= (speed*.7)
#
		#if Input.is_action_pressed("fast_fall"):
			#key_pressed = true
			#lose_energy()
			#if gravity < 50:
				##if space_pressed:
					##gravity += 10
				##else:
					##gravity += 1
				#gravity += (speed*.7)
				#if gravity > 50:
					#gravity = 50
			#down_pressed = true
		#if down_pressed == false:
			#gravity = 10
		#down_pressed = false
		#if Input.is_action_pressed("ui_left"):
			#key_pressed = true
			#lose_energy()
			#fake_velocityx -= speed
			#spin -= speed
		#if Input.is_action_pressed("ui_right"):
			#key_pressed = true
			#lose_energy()
			#fake_velocityx += speed
			#spin += speed
		##space_pressed = false
		## Normalize and scale the velocity vector
		#if energy < 100 and !key_pressed and recharge:
			#get_energy()
	#else:
		#if recharge:
			#get_energy()
			#recharge = false
			#timer.start()
	#key_pressed = false
	##myknockback += fake_velocityx
	#velocity.x = fake_velocityx
	#if fake_velocityx > 0:
		#if fake_velocityx > (original_speed*30):
			#fake_velocityx = (original_speed*30)
		#fake_velocityx -= 6
	#elif fake_velocityx < 0:
		#if fake_velocityx < -(original_speed*30):
			#fake_velocityx = -(original_speed*30)
		#fake_velocityx += 6
	#velocity.y += gravity
#

#PLEASE WORK

	move_and_slide()
	
	if abs(velocity.x) > 1.0:  # Only apply friction if moving
		velocity.x = lerp(velocity.x, 0.0, 0.7 * delta)
	else:
		velocity.x = 0.0  # Snap to 0 when close enough
	velocity.y += gravity
	key_pressed = false
	if energy > 0 and !being_hit:
		if Input.is_action_pressed("ui_up"):
			key_pressed = true
			lose_energy()
			velocity.y -= (speed*.6)

		if Input.is_action_pressed("fast_fall"):
			key_pressed = true
			lose_energy()
			if gravity < 50:
				#if space_pressed:
					#gravity += 10
				#else:
					#gravity += 1
				gravity += (speed*.6)
				if gravity > 50:
					gravity = 50
			down_pressed = true
		if down_pressed == false:
			gravity = 10
		down_pressed = false
		if Input.is_action_pressed("ui_left"):
			key_pressed = true
			lose_energy()
			velocity.x -= speed
			spin -= speed
		if Input.is_action_pressed("ui_right"):
			key_pressed = true
			lose_energy()
			velocity.x += speed
			spin += speed
		#space_pressed = false
		# Normalize and scale the velocity vector
		if energy < 100 and !key_pressed and recharge:
			get_energy()
	else:
		if recharge:
			get_energy()
			recharge = false
			timer.start()






func _on_timer_timeout():
	recharge = true


func take_damage(damage_TYPE, damage, up, down, LoR, other, knockback):
	being_hit = true
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

		
	health_bar.value = hp
	if hp <= 0:
		begin_to_end()
	being_hit = false

func begin_to_end():
	ScoreManager.grit += (ScoreManager.current_score-last_grit )
	last_grit = ScoreManager.current_score
	if !beyond_death:
		ScoreManager.nogritscore = ScoreManager.current_score
		beyond_death = true
	health_bar.visible = false
	energy_bar.visible = false
	$"../Camera2D/Control/Pause_button".visible = false
	$"../Camera2D/Control/Pause_button/Node2D".Ipaused = false

	$"../Camera2D/Control/Grit".visible = true
	$"../Camera2D/Control/Grit".text = "Grit: %d" % ScoreManager.grit
	
	$"../Camera2D/Control/gritpayamount".visible = true
	$"../Camera2D/Control/gritpayamount".text = "Pay: %d to live" % (ScoreManager.current_score * 2) 
	
	$"../Camera2D/Control/pay_grit".visible = true
	$"../Camera2D/Control/choose_death".visible = true
	
	$"../Camera2D/Control/gritstuffsprite".visible = true
	
	selectdieornot = true
	
	get_tree().paused = true

func XP(amountXP):
	hp += amountXP
	if hp > max_hp: hp = max_hp
	health_bar.value = hp
	energy +=amountXP
	if energy > 100: energy = 100
	energy_bar.value = energy
	XPvalue += amountXP
	ScoreManager.current_score += amountXP
	$AudioStreamPlayer2D.play()
	

func _on_pay_grit_button_up() -> void:
	if selectdieornot:
		if ScoreManager.grit >= ScoreManager.current_score*2:
			
			
			get_tree().paused = false
			
			$"../Camera2D/Control/Buttonaudio".play()

			
			ScoreManager.grit -= (ScoreManager.current_score)*2
			ScoreManager.score_grit_used += (ScoreManager.current_score)*2
			ScoreManager.save_scores()

			hp = 1000
			health_bar.value = hp
			energy = 100
			energy_bar.value = hp
			health_bar.visible = true
			energy_bar.visible = true
			$"../Camera2D/Control/Pause_button".visible = true
			$"../Camera2D/Control/Pause_button/Node2D".Ipaused = true
			
			$"../Camera2D/Control/Grit".visible = false
			
			$"../Camera2D/Control/gritpayamount".visible = false
			
			$"../Camera2D/Control/pay_grit".visible = false
			$"../Camera2D/Control/choose_death".visible = false
			
			$"../Camera2D/Control/gritstuffsprite".visible = false

			
			selectdieornot = false
			
			take_damage("Melee", 870, true, false, false, false, randi_range(30000,40000))



func _on_choose_death_button_down() -> void:
	$"../Camera2D/Control/Buttonaudio".play()


func _on_choose_death_button_up() -> void:
	if selectdieornot:
		get_tree().paused = false
		decide_to_end()

	
	
func decide_to_end():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")



	# Update high score if the current score is greater
	if ScoreManager.current_score > ScoreManager.high_score:
		ScoreManager.high_score = ScoreManager.current_score
		ScoreManager.high_score_grit_used = ScoreManager.score_grit_used
	
	if ScoreManager.high_score > ScoreManager.global_score:
		# Update global score
		ScoreManager.global_score = ScoreManager.high_score
		ScoreManager.global_score_grit_used = ScoreManager.high_score_grit_used
	
	if ScoreManager.nogritscore > ScoreManager.nogrithighscore:
		ScoreManager.nogrithighscore = ScoreManager.nogritscore
	
	if ScoreManager.nogrithighscore > ScoreManager.nogritglobalscore:
		ScoreManager.nogritglobalscore = ScoreManager.nogrithighscore
	
	
	# Save the scores
	ScoreManager.save_scores()
	
