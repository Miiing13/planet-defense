extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	play_all_animations(self)

func play_all_animations(node: Node):
	for child in node.get_children():
		if child is AnimatedSprite2D:
			child.z_index = -1
			child.play()

		play_all_animations(child)
	
