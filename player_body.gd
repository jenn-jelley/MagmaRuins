extends KinematicBody2D

<<<<<<< HEAD
const UP = Vector2(0, -1)
const GRAVITY = 8
const ACCELERATION = 50
const MAX_SPEED = 450
const JUMP_HEIGHT = -360

=======
const SPEED = 450
const GRAVITY = 10
const JUMP_ACCELERATION = -350
const GROUND = Vector2(0, -1)
>>>>>>> 0f16b1f8caa70ff798cd4b34d9be5e4e8aa1cabb
const FIREBALL = preload("res://Fireball.tscn")

var motion = Vector2()
var is_dead = false

func _physics_process(delta):
<<<<<<< HEAD
	motion.y += GRAVITY
	var friction = false
	
	if is_dead == false:
		if Input.is_action_pressed("ui_right"):
			motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
			$player_sprite.flip_h = false
			$player_sprite.play("run")
			if sign($player_position.position.x) == -1:
				$player_position.position.x *= -1
			
		elif Input.is_action_pressed("ui_left"):
			motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
			$player_sprite.flip_h = true
			$player_sprite.play("run")
			if sign($player_position.position.x) == 1:
				$player_position.position.x *= -1
		else:
			$player_sprite.play("idle")
			friction = true


		if Input.is_action_just_pressed("ui_focus_next"):
				var fireball = FIREBALL.instance()
				if sign($player_position.position.x) == 1:
					fireball.set_fireball_direction(1)
				else:
					fireball.set_fireball_direction(-1)
				get_parent().add_child(fireball)
				fireball.position = $player_position.global_position



		if is_on_floor():
			if Input.is_action_just_pressed("ui_up"):
				motion.y = JUMP_HEIGHT
			if friction == true:
				motion.x = lerp(motion.x, 0, 0.2)
		else:
			if motion.y < 0:
				$player_sprite.play("up")
			else:
				$player_sprite.play("down")
			if friction == true:
				motion.x = lerp(motion.x, 0, 0.05)

		motion = move_and_slide(motion, UP)
=======

	
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		$player_sprite.play("run")
		$player_sprite.flip_h = false
		if sign($player_position.position.x) == -1:
			$player_position.position.x *= -1
	
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		$player_sprite.flip_h = true
		$player_sprite.play("run")
		if sign($player_position.position.x) == 1:
			$player_position.position.x *= -1
	else:
		velocity.x = 0
		if is_on_ground == true:
			$player_sprite.play("idle")
			
	
	if Input.is_action_pressed("ui_up"):
		if is_on_ground == true:
			velocity.y = JUMP_ACCELERATION
			is_on_ground = false
	if is_on_ground == false:
		if velocity.y < 0:
			$player_sprite.play("up")
		else:
			$player_sprite.play("down")
	
	
	if Input.is_action_just_pressed("ui_focus_next"):
		var fireball = FIREBALL.instance()
		if sign($player_position.position.x) == 1:
			fireball.set_fireball_direction(1)
		else:
			fireball.set_fireball_direction(-1)
		get_parent().add_child(fireball)
		fireball.position = $player_position.global_position
	velocity.y += GRAVITY
			
	velocity = move_and_slide(velocity, GROUND)
>>>>>>> 0f16b1f8caa70ff798cd4b34d9be5e4e8aa1cabb
		
	if get_slide_count() > 0:
		for i in range(get_slide_count()):
			if "Turret" in get_slide_collision(i).collider.name:
				dead()
			if "Dark_Enemy" in get_slide_collision(i).collider.name:
				dead()

	if is_on_floor() == true:
		is_on_ground = true
	else:
		is_on_ground = false


func dead():
	is_dead = true
	motion = Vector2(0,0)
	$player_sprite.play("dead")
	$player_shape.call_deferred("set_disabled", true)
	$Timer.start()

func _on_Timer_timeout():
	get_tree().change_scene("Level3.tscn")
