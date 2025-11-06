extends Area2D

@export var value: int = 1 #how many points this pick up gives

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	
func _on_body_entered(body):
	if body.name == "Player": #only when player picks up item
		body.collect_items(value)
		queue_free()# remove pickup from screen
