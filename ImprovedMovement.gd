extends KinematicBody

class_name ImprovedKinematicBody

var velocity : Vector3

var _physicsTranslation = Vector3.ZERO
var _physicsUpdate = 0

func _getTime():
	return OS.get_ticks_usec() / 1000000.0

func _physics_process(delta):
	if _physicsTranslation != Vector3.ZERO:
		self.translation = _physicsTranslation 
	
	_implementMovement(delta)
	
	_physicsTranslation = self.translation
	_physicsUpdate = _getTime()

func _process(delta):
	var now = _getTime()
	var diff =  now - _physicsUpdate
	if _physicsTranslation != Vector3.ZERO and diff > 0:
		self.translation = _physicsTranslation + velocity * diff

func _implementMovement(delta):
	# implement movement here. Ex:
	#velocity = move_and_slide_with_snap(velocity, Vector3.DOWN, Vector3.UP, true, 1, deg2rad(45), false)
	pass
