extends KinematicBody
tool

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

func _process(_delta):
	var now = _getTime()
	var diff =  now - _physicsUpdate
	if _physicsTranslation != Vector3.ZERO and diff > 0:
		self.translation = _physicsTranslation + velocity * diff

func _implementMovement(delta):
	# implement movement here. Ex:
	#velocity = move_and_slide_with_snap(velocity, Vector3.DOWN, Vector3.UP, true, 1, deg2rad(45), false)
	pass

#############
# workaround for bug :
# when you set this node's translation, it reverts back because of _physicsTranslation still being the old position
# I would have liked to override _set_transform and _set_translation accordingly, but it isn't possible from GDscript
func changeTransform(new_transform):
	_physicsUpdate = _getTime()
	_physicsTranslation = new_transform.origin
	self.transform = new_transform

# to show warning about teleport
func _get_configuration_warning():
	return "use changeTransform(new_transform) when teleporting this node !"
