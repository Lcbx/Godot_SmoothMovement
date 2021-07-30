extends KinematicBody


var velocity = Vector3.RIGHT * 5.0

var physicsTranslation = Vector3.ZERO
var physicsUpdate = 0

func _physics_process(delta):
	var now = OS.get_ticks_usec() / 1000000.0
	if physicsTranslation != Vector3.ZERO:
		self.translation = physicsTranslation 
	velocity = move_and_slide_with_snap(velocity, Vector3.DOWN, Vector3.UP, true, 1, deg2rad(45), false)
	physicsTranslation = self.translation
	physicsUpdate = OS.get_ticks_usec() / 1000000.0
	
	print("improved ", self.translation)

func _process(delta):
	var now = OS.get_ticks_usec() / 1000000.0
	var diff =  now - physicsUpdate
	if physicsTranslation != Vector3.ZERO:
		self.translation = physicsTranslation + velocity * diff
