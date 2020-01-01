extends Area2D

const SPEED = 450
var velocity = Vector2()
var direction = 1

func _ready():
	pass

func set_fireball_direction(dir):
	direction = dir
	if dir == -1:
		$fireball_sprite.flip_h = true

func _physics_process(delta):
	velocity.x = SPEED * delta * direction
	translate(velocity)

func _on_fireball_body_entered(body):
	if "magma_monster" in body.name:
		body.dead()

	if "Turret" in body.name:
		body.dead()
	if "Dark_Enemy" in body.name:
		body.dead()
	if "skeleton" in body.name:
		body.dead()
	queue_free()


func _on_fireball_notifier_screen_exited():
	queue_free()

