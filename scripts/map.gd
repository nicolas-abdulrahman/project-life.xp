extends TileMapLayer

@export var source_id: int = 0         # The ID of your tile source atlas
@export var atlas_coords: Vector2i = Vector2i(0, 0) # The specific hex tile inside the atlas

func _ready() -> void:
	clear() # Wipe any editor-placed tiles to start fresh
	generate_hexagon_cluster(20)

func generate_hexagon_cluster(target_count: int) -> void:
	# Step 1: Start at the absolute center origin (0, 0)
	var center := Vector2i(0, 0)
	set_cell(center, source_id, atlas_coords)
	
	# Keep track of coordinates we have already placed
	var placed_tiles := { center: true }
	
	# Step 2: Define the 6 axial neighbor directions for a hex grid
	# This matches our (+1, 0), (-1, 0), etc. geometric math
	var hex_directions := [
		Vector2i(1, 0),   # Right / Down-Right
		Vector2i(0, 1),   # Down
		Vector2i(-1, 1),  # Down-Left
		Vector2i(-1, 0),  # Left / Up-Left
		Vector2i(0, -1),  # Up
		Vector2i(1, -1)   # Up-Right
	]
	
	# A queue of tiles whose neighbors we want to look at next (Breadth-First Expansion)
	var queue: Array[Vector2i] = [center]
	var tiles_spawned := 1
	
	# Step 3: Loop and expand outward until we hit exactly 20 tiles
	while queue.size() > 0 and tiles_spawned < target_count:
		var current: Vector2i = queue.pop_front()
		
		# Check all 6 surrounding neighbor spots
		for dir in hex_directions:
			if tiles_spawned >= target_count:
				break
				
			var neighbor: Vector2i = current + dir
			
			# If we haven't put a hexagon here yet, stamp it down!
			if not placed_tiles.has(neighbor):
				set_cell(neighbor, source_id, atlas_coords)
				placed_tiles[neighbor] = true
				queue.append(neighbor) # Add this new tile to the expansion queue
				tiles_spawned += 1
				
	print("Successfully generated a perfect cluster of ", tiles_spawned, " hexagons!")
