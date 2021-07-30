extends KinematicBody


var velocity = Vector3.RIGHT * 5.0

var physics_translation = Vector3.ZERO
var physicsUpdate = 0

func _physics_process(delta):
	var now = OS.get_ticks_usec() / 1000000.0
	if physics_translation != Vector3.ZERO:
		self.translation = physics_translation 
	velocity = move_and_slide_with_snap(velocity, Vector3.DOWN, Vector3.UP, true, 1, deg2rad(45), false)
	physics_translation = self.translation
	physicsUpdate = OS.get_ticks_usec() / 1000000.0
	
	print("improved ", self.translation)

func _process(delta):
	var now = OS.get_ticks_usec() / 1000000.0
	var diff =  now - physicsUpdate
	if physics_translation != Vector3.ZERO:
		self.translation = physics_translation + velocity * diff
