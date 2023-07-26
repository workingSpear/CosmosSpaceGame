extends CSGSphere3D


func _when_interacted(player):
	if(scale.x!=1):
		scale = Vector3(1,1,1)
	else:
		scale *= 3
