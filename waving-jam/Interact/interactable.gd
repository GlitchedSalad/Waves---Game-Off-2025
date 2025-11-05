extends CollisionObject3D
class_name Interactable

signal interacted(body)

@export var enabled := true
@export var promt_message := "debug"

func interact(body):
	if not enabled:
		return
	interacted.emit(body)
