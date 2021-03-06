Follow-up to Garbaj's [Fixing Jittery Movement In Godot](https://www.youtube.com/watch?v=pqrD3B75yKo "link to video") video    

Relevant script is [ImprovedMovement.gd](https://github.com/Lcbx/Godot_SmoothMovement/blob/master/ImprovedMovement.gd "link to script")  
The project has a main scene with default(simple) vs improved movement.
  
This version :
* is simpler than his solution
* doesn't lag behind the physics model
* uses extrapolation rather than interpolation
* as such, needs a velocity vector
* requires special care when teleporting it around (see 'How to use')
    
### How to use
- Add [ImprovedMovement.gd](https://github.com/Lcbx/Godot_SmoothMovement/blob/master/ImprovedMovement.gd "link to script")   to the project files  
- change the type of existing _KinematicBody_ to _ImprovedKinematicBody_
- modify scripts to contain _'extends ImprovedKinematicBody'_ 
- modify scripts to implement the function **_implementMovement(delta)** as if it was **_physics_process**
- use the **velocity** variable to control it's movement the way you would a _RigidBody_
- call _changeTransform(newTransform)_ when changing the Node's translation directly

You can use the demo scene as a template.

