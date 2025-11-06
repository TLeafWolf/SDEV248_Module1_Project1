extends CanvasLayer

@onready var label = $ItemCountLabel
@onready var player = get_parent().get_node("Player")

# Reference the HBoxContainer holding the life icons (assuming it's a direct child of the CanvasLayer)
@onready var life_counter_container: HBoxContainer = $LifeCounter

# An array to hold references to the individual TextureRect nodes
var life_icons: Array = []

func _ready():
	update_ui()
	
		# Initialize the lives UI references
	life_icons = life_counter_container.get_children()
	# Call the lives update function once at start
	update_lives_ui() 
	
func update_ui():
	label.text ="Coins: %d" % player.items_collected

# Function to update the visual representation of lives
func update_lives_ui():
	var current_lives = player.lives
	var max_lives = life_icons.size()
	
	for i in range(max_lives):
		var icon = life_icons[i]
		if i < current_lives:
			# Makes the icon visible if the player has that many lives or more
			icon.visible = true
		else:
			# Hides the icon if the player has fewer lives than the icon number
			icon.visible = false
