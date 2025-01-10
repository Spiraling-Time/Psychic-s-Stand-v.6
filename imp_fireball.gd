extends CharacterBody2D

var direction: Vector2
var speed: float = 300

func _ready() -> void:
	if direction.length() > 0:
		rotation = direction.angle()

func _physics_process(delta: float) -> void:
	if direction.length() > 0:
		velocity = direction * speed
		move_and_slide()


func _on_impfireball_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		var randknockback = randi_range(100, 200)
		body.take_damage("Fire", 5, false, false, "up", false, randknockback)
	queue_free()
