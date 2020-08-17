extends KinematicBody2D

export var damage := 1
export var health := 2
export var knockback_strength := 200
export var friction := 10
export var gravity := 10

var velocity := Vector2.ZERO

func _ready():
	$AnimationPlayer.play("default")

func _physics_process(delta):
	if abs(velocity.x) < friction:
		velocity.x = 0
	elif velocity.x < 0:
		velocity.x += friction
	elif velocity.x > 0:
		velocity.x -= friction
	
	if not is_on_floor():
		velocity.y += gravity
	
	velocity = move_and_slide(velocity, Vector2.UP)

func _on_Area2D_body_entered(body):
	if body.has_method("hit"):
		body.hit(damage, global_position)

func hit(damage, from):
	velocity += (global_position - from).normalized() * knockback_strength
	health -= damage
	if health < 0:
		health = 0