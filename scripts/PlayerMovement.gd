extends KinematicBody2D

export (int) var speed = 400
export (int) var gravity = 100;
export (float) var gravity_scale = 0.5
export (int) var jumpPower = 1000;
export (int) var coyote_time = 6 # number of frames of 'coyote time'
export (int) var max_jumps = 1
export (int) var fire_cooldown = 4
export (PackedScene) var bullet_scene
export (int) var num_bullets = 1
export var airControl = 0.1

#var bullet_scene = load("res://Bullet.tscn")
var velocity = Vector2()
var low_gravity = gravity * gravity_scale
var jumps = 0
var coyote_timer = 0
var is_grounded = false
var facing = false
var fire_timer = 0
var space_state = null
var launched = false

func probe_check():
	space_state = get_world_2d().direct_space_state
	var probe = self.position + Vector2.DOWN * 60
	var offset = Vector2.RIGHT * 30
	var testLeft = space_state.intersect_ray(self.position - offset, probe - offset, [self])
	var testRight = space_state.intersect_ray(self.position + offset, probe + offset, [self])
	is_grounded = len(testLeft) != 0 or len(testRight) != 0

func handle_animation():
	if is_grounded:
		if velocity.x != 0:
			$AnimatedSprite.play("run")
		else:
			$AnimatedSprite.play("idle")
	else:
		if velocity.y < 0:
			$AnimatedSprite.play('jump')
		else:
			$AnimatedSprite.play('fall')
	$AnimatedSprite.set_flip_h(facing)

func fire_control():
	if fire_timer == 0:
		for i in range(num_bullets):
			var bullet = bullet_scene.instance()
			owner.add_child(bullet)
			bullet.position = self.position
			bullet.velocity.y = 500 * (i - floor(num_bullets / 2))
		fire_timer = fire_cooldown
	else:
		fire_timer -= 1
		
func set_velocity(vel):
	velocity = vel
	jumps = max_jumps
	launched = true

func get_input():
	var vel = Vector2()
	if Input.is_action_pressed('right'):
		vel.x = speed
		facing = false
	elif Input.is_action_pressed('left'):
		vel.x = -speed
		facing = true
	if is_grounded:
		launched = false
	if launched:
		velocity.x += vel.x * airControl
	else:
		velocity.x = vel.x
	if Input.is_action_pressed("jump"):
		velocity.y += low_gravity
	else:
		velocity.y += gravity
	if is_grounded:
		if coyote_timer == 0:
			jumps = max_jumps
		coyote_timer = coyote_time
	else:
		if coyote_timer > 0:
			coyote_timer -= 1
		if velocity.y < 0:
			pass
		else:
			pass
	if Input.is_action_just_pressed("jump") and (jumps > 0 or coyote_timer > 0):
		if coyote_timer == 0:
			jumps -= 1
		velocity.y = -jumpPower
		
func handle_pushing(_delta):
	if velocity.x != 0:
		var probe = Vector2(sign(velocity.x)* 60, 0)
		var test = space_state.intersect_ray(self.position, self.position + probe, [self])
		if len(test) > 0 and test.collider.is_in_group("box"):
			test.collider.transform[2][0] += velocity.x * _delta
			#test.collider.call("add_velocity", Vector2(velocity.x, 0))

func _physics_process(_delta):
	probe_check()
	get_input()
	handle_animation()
	#fire_control()
	handle_pushing(_delta)
	velocity = move_and_slide(velocity)

func _ready():
	low_gravity = gravity * gravity_scale


func _on_Button_body_entered(body):
	pass # Replace with function body.
