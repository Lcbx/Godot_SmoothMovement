extends Spatial
tool

class_name TimestepExtrapolation


#
#	this class smoothes movement of it's children via extrapolation based on it's parent movement
#	maxLinearDist is the maximum distance from physics position allowed
#

export(float) var maxLinearDist = .5

var linearVelocity = Vector3.ZERO
#var angularVelocity = Vector3.ZERO

var _physicsTranslation = Vector3.ZERO
#var _physicsRotation = Vector3.ZERO

var _physicsUpdate = 0
var _physicsTimeAccumulator = 0

func _getTime():
	return OS.get_ticks_usec() / 1000000.0

func _physics_process(delta):
	var newTranslation = (self.get_parent() as Spatial).translation
	#var newRotation = (self.get_parent() as Spatial).rotation
	
	# using an accumulator to smooth the timestep and reduce jitter
	_physicsTimeAccumulator *= 2.0
	_physicsTimeAccumulator += (_getTime()-_physicsUpdate)
	_physicsTimeAccumulator /= 3.0
	_physicsTimeAccumulator = clamp(_physicsTimeAccumulator, 1.0/Engine.iterations_per_second, 1.0)
	
	if _physicsTranslation != Vector3.ZERO:
		linearVelocity = (newTranslation - _physicsTranslation)/ _physicsTimeAccumulator
	#if _physicsRotation != Vector3.ZERO:
	#	angularVelocity = (newRotation - _physicsRotation)/ _physicsTimeAccumulator
	
	_physicsTranslation = newTranslation
	#_physicsRotation = newRotation
	_physicsUpdate = _getTime()

func _process(_delta):
	var time = clamp(Engine.get_physics_interpolation_fraction(), 0,1) / Engine.iterations_per_second
	var linearOffset = linearVelocity * time
	#self.translation = linearOffset
	self.translation = linearOffset.normalized() * clamp(linearOffset.length(), 0, maxLinearDist)
	#self.rotation = angularVelocity * time
