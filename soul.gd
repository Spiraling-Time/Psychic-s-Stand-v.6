extends Node2D

var fall = 10
var XPamountstuff = 0

func ready():
	scale = 1+(XPamountstuff/10)
	rotation = randf_range(0, TAU)


func _process(delta: float) -> void:
	$Sprite2D.frame +=1
	if $Sprite2D.frame > 2:
		$Sprite2D.frame = 0
	if $Area2D.get_overlapping_bodies().size() >= 1:
		for body in $Area2D.get_overlapping_bodies():
			if body.has_method("XP"):
				body.XP(2+round(XPamountstuff/2))
				print("gave ", 2+round(XPamountstuff/2), " XP" )
				queue_free()
			else:
				if fall > 0:
					fall = 0



func _physics_process(delta: float) -> void:
	position.y += fall
		
		


func _on_timer_timeout() -> void:
	queue_free()
