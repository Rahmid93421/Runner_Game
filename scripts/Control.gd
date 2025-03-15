extends Control

# References to your gridmap and editor controls
onready var gridmap = $GridMap
onready var tile_button = $TileButton
onready var delete_button = $DeleteButton
var is_deleting = false

# The tile ID that we will be adding/deleting in the GridMap
var tile_id = 0

# GridMap size (optional - you can adjust this as per your needs)
var grid_size = Vector3(10, 1, 10)

func _ready():
	# Setup editor buttons
	tile_button.connect("pressed", self, "_on_tile_button_pressed")
	delete_button.connect("pressed", self, "_on_delete_button_pressed")

	# Initialize GridMap (you could also load a gridmap resource)
#	gridmap.tile_set = preload("res://assets/misc/environment_props.tres")

	# Optional: Add an initial tile (or handle as necessary)
	add_tile_to_grid(Vector3(0, 0, 0))

# Function to add a tile at the specified position
func add_tile_to_grid(position: Vector3):
	gridmap.set_cell_item(position.x, position.y, position.z, tile_id)

# Function to delete a tile at the specified position
func delete_tile_from_grid(position: Vector3):
	gridmap.set_cell_item(position.x, position.y, position.z, -1)

# Handle the button press for adding a tile
func _on_tile_button_pressed():
	is_deleting = false

# Handle the button press for deleting a tile
func _on_delete_button_pressed():
	is_deleting = true

# Handling the input (mouse clicks)
func _input(event):
	if event is InputEventMouseButton and event.pressed:
		var mouse_position = get_global_mouse_position()
		var grid_position = world_to_grid(mouse_position)
		
		if is_deleting:
			delete_tile_from_grid(grid_position)
		else:
			add_tile_to_grid(grid_position)

# Convert world position to grid position (use a method to map the position to your grid)
func world_to_grid(world_pos: Vector2) -> Vector3:
	var cell_size = gridmap.cell_size
	return Vector3(floor(world_pos.x / cell_size.x), 0, floor(world_pos.y / cell_size.z))
