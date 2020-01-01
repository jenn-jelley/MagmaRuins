extends RigidBody2D

signal Player

func _ready():
	randomize()
	angular_velocity = rand_range(-PI, PI)

func _on_Bomb_body_entered( body ):
	if body.get_name() == "CastleTiles":
		emit_signal("Player", position)
		queue_free()
