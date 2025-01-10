extends Node

enum States {Idle, Chase, Attack1, Attack2, Teleport}

var state = States.Idle


func change_state(newState):
	state = newState

func _physics_process(delta):
	match state:
		States.Idle:
			idle()
		States.Chase:
			chase()
		States.Attack1:
			attack1()
		States.Attack2:
			attack2()
		States.Teleport:
			teleport()


func idle():
	pass
func chase():
	pass
func attack1():
	pass
func attack2():
	pass
func teleport():
	pass	
