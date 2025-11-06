extends RigidBody2D

var acceleration : float = 25.0

var Jump_acceleration : float = -400.0
@onready var sprite = $AnimatedSprite2D
var is_jumping = false
var can_move = true #variable to enable/diable movement
var items_collected: int = 0
var lives: int = 3 
func _ready() -> void:
	pass



func _physics_process(delta: float) -> void:
	if not can_move:
		return
	if Input.is_action_pressed("foward"):
		apply_central_impulse(Vector2(acceleration, 1.0))
		if not is_jumping:
			sprite.animation ="Walk"
	elif Input.is_action_pressed("backward"):
		apply_central_impulse(Vector2(-acceleration, 1.0))
		if not is_jumping:
			sprite.animation ="Walk"
	else:
		apply_central_impulse(Vector2.ZERO)
		if not is_jumping:
			sprite.animation = "Idle"

	if Input.is_action_just_pressed("jump") and not is_jumping:
		apply_central_impulse(Vector2(0, Jump_acceleration))
		sprite.animation = "Jump"
		is_jumping = true
		#Wait, then go back to idle
		await get_tree().create_timer(0.7).timeout
		is_jumping = false
		sprite.animation = "Idle"
		
func take_damage(amount: int) -> void:
	if can_move: 
		lives -= amount
		update_ui() 
		
		if lives <= 0:
			die()

func die():
	can_move = false
	set_physics_process(false)
	var game_over_screen = get_tree().current_scene.get_node("GameOverScreen") 
	if game_over_screen and game_over_screen.has_method("show_game_over"):
		game_over_screen.show_game_over()
	
func collect_items(amount: int) -> void:
	items_collected += amount
	update_ui()

func update_ui():
	var ui = get_parent().get_node("UI")
	if ui:
		ui.update_ui()
		ui.update_lives_ui()
