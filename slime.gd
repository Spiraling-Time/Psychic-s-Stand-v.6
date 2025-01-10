extends CharacterBody2D

@onready var detectC = $detection_area/CollisionShape2D
@onready var animate = $AnimatedSprite2D
@onready var hitbox = $hitbox


var speed = 50

var health = 100

var can_attack: bool = true
var should_attack: bool = false

var dead = false
var enemy_in_area = false
var enemy

func _ready():
	dead = false
	
func _physics_process(delta):
	if !dead:
		detectC.disabled = false
		if enemy_in_area:
			position += (enemy.position - position) / speed
			if (enemy.position.x - position.x) > 0:
				scale.x = 1
			else:
				scale.x = -1
			animate.play("chase")
			await get_tree().create_timer(0.67).timeout
		else:
			animate.play("idle")
			await get_tree().create_timer(2).timeout
		if should_attack and can_attack:
			can_attack = false
			animate.play("attack1")
			hitbox.monitoring = true
			print("attacked")
			await get_tree().create_timer(0.8).timeout
			
			
	if dead:
		detectC.disabled = true

func _on_detection_area_body_entered(body):
	if body.has_method("is_enemy") and body != self:
		print(body, " is_enemy")
		if enemy_in_area == false:
			print("true")
			enemy_in_area = true
			enemy = body


func _on_detection_area_body_exited(body):
	if body.has_method("is_enemy") and body != self:
		if enemy == body:
			print("enemyleft")
			enemy_in_area = false
		
func damages_50():
	pass

func _on_hurtbox_area_entered(area):
	var damage
	if area.has_method("damages_50"):
		damage = 50
		take_damage(damage)

func take_damage(damage):
	health = health - damage
	print("health: ", health)
	if health <= 0 and !dead:
		death()

func death():
	dead = true
	animate.play("death")
	await get_tree().create_timer(0.6).timeout
	queue_free()
	
func is_enemy():
	pass
	


func _on_cooldown_timer_timeout():
	can_attack = true
	hitbox.monitoring = false




func _on_hitbox_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(20)


func _on_attack_body_entered(body):
	should_attack = true

func _on_attack_body_exited(body):
	should_attack = false
