extends Node

static func is_within_bounds(x, y):
	if x >= 0 and x < 3 and y >= 0 and y < 5:
		return true
	return false

static func find_moves_for_card(matrix, x ,y, buttons):
	var foundMoves = false
	match matrix[x][y].cardID:
		#BASIC ROOK
		2:
			print('BASIC ROOK triggered on position:', x, ' ', y)
			for range in range(1, 4):
				if foundMoves == true:
					break
				var rook_moves = [[x - range, y], [x, y - range], [x, y + range], [x + range, y]]
				for move in rook_moves:
					var relativeX = move[0]
					var relativeY = move[1]
					if is_within_bounds(relativeX, relativeY):
						if matrix[relativeX][relativeY].cardID != 0:
							reveal_move_button(buttons, relativeX, relativeY)
							foundMoves = true
				if foundMoves == true:
					reveal_moving_button(buttons, x, y)
					return true
	return false

# (x1, y1) -> position of the moving tile
# (x2, y2) -> position of the taken tile
static func move_and_score(matrix, x1 ,y1, x2, y2):
	var current_mult = get_moving_tile_mult(matrix, x1 ,y1)
	var current_score = get_taken_tile_score(matrix, x2 ,y2)
	var tile_score =  current_mult * current_score
	move_card(matrix, x1 ,y1, x2, y2)

	print('card on position: ',x1 , ' ', y1 , ' will move to: ',x2 , ' ', y2)
	print('and add : ', str(current_score), ' to score')
	matrix[x2][y2].hasTriggered = true
	return tile_score

static func move_card(matrix, x1 ,y1, x2, y2):
	matrix[x2][y2].copy_card(matrix[x1][y1])
	matrix[x1][y1].fill_empty_card()

static func get_moving_tile_mult(matrix, x ,y):
	return matrix[x][y].mult
		
static func get_taken_tile_score(matrix, x ,y):
	return matrix[x][y].tvalue

static func remove_card_from_array(card_array: Array, card_to_remove: Card):
	for card in card_array:
		if card == card_to_remove:
			card_array.erase(card)
			break  

static func hide_buttons(tile_buttons):
	for x in range (0,2):
		for button in tile_buttons[x]:
			button.visible = false
			button.disabled = true

static func reveal_move_button(buttons, x, y):
		buttons[x][y].visible = true
		buttons[x][y].disabled = false
		buttons[x][y].icon = load("res://assets/yellow-border.png")
		
static func reveal_moving_button(buttons, x, y):
		buttons[x][y].visible = true
		buttons[x][y].disabled = true
		buttons[x][y].icon = load("res://assets/green-border.png")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




static func _on_button_tile_1_pressed():
	print('hello')
	pass # Replace with function body.


static func _on_button_tile_2_pressed():
	pass # Replace with function body.


static func _on_button_tile_3_pressed():
	pass # Replace with function body.


static func _on_button_tile_4_pressed():
	pass # Replace with function body.


static func _on_button_tile_5_pressed():
	pass # Replace with function body.
