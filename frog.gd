extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var chase = false
var speed = 50
var damage = 15

func _ready():
	# default to idle animation
	get_node("AnimatedSprite2D").play("Idle")

func _physics_process(delta):
	# Gravity for frog
	velocity.y += gravity * delta
	
	if chase == true:
		if get_node("AnimatedSprite2D").animation != "Death":
			get_node("AnimatedSprite2D").play("Jump")
			# Get the player from the player node
			player = get_node("../../player/player")
			
			# Get the direction of the player realitive to self
			var direction = (player.position - self.position).normalized()
			if direction.x > 0:
				get_node("AnimatedSprite2D").flip_h = true
				
			else:
				get_node("AnimatedSprite2D").flip_h = false
			velocity.x = direction.x * speed	
	else:
		if get_node("AnimatedSprite2D").animation != "Death":
			get_node("AnimatedSprite2D").play("Idle")
		velocity.x = 0
	# move and slice is required for movement
	move_and_slide()
	
func death():
	Game.gold += 1
	Utility.saveGame()
	chase = false
	get_node("AnimatedSprite2D").play("Death")
	await get_node("AnimatedSprite2D").animation_finished
	self.queue_free()
		
func _on_player_detection_body_entered(body):
	if body.name == "player":
		chase = true

func _on_player_detection_body_exited(body):
	if body.name == "player":
		chase = false

func _on_player_death_body_entered(body):
	if body.name == "player":
		death()

func _on_player_collision_body_entered(body):
	if body.name == "player":
		Game.playerHealth -= damage
		death()
