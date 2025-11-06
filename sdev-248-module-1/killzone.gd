extends Area2D





func _on_body_entered(body: Node2D) -> void:
		# Use 'is_in_group("player")' to explicitly only care about the player object
	if body.name == "Player":
		# Reload the entire scene immediately
		get_tree().reload_current_scene()
	else:
		return
