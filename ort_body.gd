extends KinematicBody2D
const GRAVITY = 10
const SPEED = 25
const FLOOR = Vector2(0, -1)

var velocity = Vector2()

var direction = -1

var is_dead = false

func is_dead():
	return is_dead

func dead():
	is_dead = true
	velocity = Vector2(0,0)
	$ort_sprite.play("dead")
	$ort_shape.set_disabled(true)
	$ort_area/ort_area_shape.set_disabled(true)
	
	$Timer.start()

func _physics_process(delta):
	if is_dead == false:
		velocity.x = SPEED * direction
		if direction == -1:
			$ort_sprite.flip_h = false
		else:
			$ort_sprite.flip_h = true
		$ort_sprite.play("idle")

		velocity.y += GRAVITY

		velocity = move_and_slide(velocity, FLOOR)

	if is_on_wall():
		direction = direction * -1
		$ort_ray.position.x *= -1

	if $ort_ray.is_colliding() == false:
		direction = direction * -1
		$ort_ray.position.x *= -1

		
func _on_Timer_timeout():
	queue_free()