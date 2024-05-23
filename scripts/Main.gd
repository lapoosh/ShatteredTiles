extends Node2D

const TileOperations = preload("res://scripts/TileOperations.gd")
const Card = preload("res://scripts/Card.gd")


const EMPTY_TEXTURE = preload("res://assets/empty.jpg")

var all_cards: Array[Card] = []
var needsInput: bool = false
var tile_chosen: int = -1 
var score: float = 0

@onready var tile_matrix = [
	[$Tile1, $Tile2, $Tile3, $Tile4, $Tile5],
	[$Tile6, $Tile7, $Tile8, $Tile9, $Tile10],
	[$Tile11, $Tile12, $Tile13, $Tile14, $Tile15]
]
@onready var tile_buttons = [
	[$Tile1/ButtonTile1, $Tile2/ButtonTile2, $Tile3/ButtonTile3, $Tile4/ButtonTile4, $Tile5/ButtonTile5],
	[$Tile6/ButtonTile6, $Tile7/ButtonTile7, $Tile8/ButtonTile8, $Tile9/ButtonTile9, $Tile10/ButtonTile10],
	[$Tile11/ButtonTile11, $Tile12/ButtonTile12, $Tile13/ButtonTile13, $Tile14/ButtonTile14, $Tile15/ButtonTile15]
]

func hide_buttons():
	for x in range (0,3):
		for button in tile_buttons[x]:
			button.visible = false
			button.disabled = true

func empty_tile_matrix():
	for x in range (0,3):
		for y in range (0,5):
			tile_matrix[x][y].fill_empty_card()

func reset_score():
	$TextEdit.text = 'Score : ' + str(score)

func untrigger_cards():
	for x in range (0,3):
		for y in range (0,5):
			tile_matrix[x][y].untrigger()
	
func load_all_cards():
	#var texture = load("res://assets/knight.jpg") + load("res://assets/yellow-border.png")
	all_cards.append(Card.new().fill_card(4, load("res://assets/knight.jpg"), "Move: Default", Card.Rarity.UNCOMMON, Card.ChessPieceType.KNIGHT, 2, 125))
	all_cards.append(Card.new().fill_card(2, load("res://assets/rook.jpg"), "Move: Default", Card.Rarity.UNCOMMON, Card.ChessPieceType.ROOK, 1.5, 150))
	all_cards.append(Card.new().fill_card(1, load("res://assets/pawn.jpg"), "Move: Default", Card.Rarity.UNCOMMON, Card.ChessPieceType.PAWN, 1, 200))
	all_cards.append(Card.new().fill_card(2, load("res://assets/rook.jpg"), "Move: Default", Card.Rarity.UNCOMMON, Card.ChessPieceType.ROOK, 1.5, 150))
	all_cards.append(Card.new().fill_card(4, load("res://assets/knight.jpg"), "Move: Default", Card.Rarity.UNCOMMON, Card.ChessPieceType.KNIGHT, 2, 125))
	all_cards.append(Card.new().fill_card(2, load("res://assets/rook.jpg"), "Move: Default", Card.Rarity.UNCOMMON, Card.ChessPieceType.ROOK, 1.5, 150))
	all_cards.append(Card.new().fill_card(1, load("res://assets/pawn.jpg"), "Move: Default", Card.Rarity.UNCOMMON, Card.ChessPieceType.PAWN, 1, 200))
	all_cards.append(Card.new().fill_card(2, load("res://assets/rook.jpg"), "Move: Default", Card.Rarity.UNCOMMON, Card.ChessPieceType.ROOK, 1.5, 150))
	

#func load_shown_tiles():
	#for x in range (0, 3):
		#for y in range (0, 5):
			#shown_tiles[x][y].texture = EMPTY_TEXTURE
		
func add_card_to_tile(positionX ,positionY, chance, available_cards):
	#shown_tiles[positionX][positionY].texture = available_cards[chance - 1].image
	tile_matrix[positionX][positionY].copy_card(available_cards[chance - 1])
	TileOperations.remove_card_from_array(available_cards, available_cards[chance - 1])

func determine_cards_placed():
	var available_cards = all_cards.duplicate(true)
	var number_of_cards = available_cards.size()
	var possibilities =  15 if number_of_cards <= 15 else number_of_cards
	
	for x in range (0,3):
		for y in range (0,5):
			var chance = randi_range(1, possibilities)
			if chance <= available_cards.size():
				add_card_to_tile(x, y, chance, available_cards)
			else:
				tile_matrix[x][y].fill_empty_card()
			possibilities -= 1

func start_actions_for_cards():
	for x in range (0,3):
		for y in range (0,5):
			if tile_matrix[x][y].hasTriggered == true:
				continue
			needsInput = TileOperations.find_moves_for_card(tile_matrix, x ,y, tile_buttons)
			if needsInput == true:
				while needsInput == true:
					await get_tree().process_frame
				var move_to_X = (tile_chosen - 1) / 5
				var move_to_Y = (tile_chosen - 1) % 5
				score += TileOperations.move_and_score(tile_matrix, x ,y, move_to_X, move_to_Y)
				$TextEdit.text = 'Score : ' + str(score)
				tile_chosen = -1



func spin():
	empty_tile_matrix()
	hide_buttons()
	determine_cards_placed()
	#untrigger_cards()
	start_actions_for_cards()

	
func _ready():
	reset_score()
	empty_tile_matrix()
	hide_buttons()
	load_all_cards()
	#load_shown_tiles()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	spin()



func _on_button_tile_1_pressed():
	needsInput = false
	tile_chosen = 1
	hide_buttons()
	pass # Replace with function body.


func _on_button_tile_2_pressed():
	needsInput = false
	tile_chosen = 2
	hide_buttons()
	pass # Replace with function body.


func _on_button_tile_3_pressed():
	needsInput = false
	tile_chosen = 3
	hide_buttons()
	pass # Replace with function body.


func _on_button_tile_4_pressed():
	needsInput = false
	tile_chosen = 4
	hide_buttons()
	pass # Replace with function body.


func _on_button_tile_5_pressed():
	needsInput = false
	tile_chosen = 5
	hide_buttons()
	pass # Replace with function body.


func _on_button_tile_6_pressed():
	needsInput = false
	tile_chosen = 6
	hide_buttons()
	pass # Replace with function body.


func _on_button_tile_7_pressed():
	needsInput = false
	tile_chosen = 7
	hide_buttons()
	pass # Replace with function body.


func _on_button_tile_8_pressed():
	needsInput = false
	tile_chosen = 8
	hide_buttons()
	pass # Replace with function body.


func _on_button_tile_9_pressed():
	needsInput = false
	tile_chosen = 9
	hide_buttons()
	pass # Replace with function body.


func _on_button_tile_10_pressed():
	needsInput = false
	tile_chosen = 10
	hide_buttons()
	pass # Replace with function body.


func _on_button_tile_11_pressed():
	needsInput = false
	tile_chosen = 11
	hide_buttons()
	pass # Replace with function body.


func _on_button_tile_12_pressed():
	needsInput = false
	tile_chosen = 12
	hide_buttons()
	pass # Replace with function body.


func _on_button_tile_13_pressed():
	needsInput = false
	tile_chosen = 13
	hide_buttons()
	pass # Replace with function body.


func _on_button_tile_14_pressed():
	needsInput = false
	tile_chosen = 14
	hide_buttons()
	pass # Replace with function body.


func _on_button_tile_15_pressed():
	needsInput = false
	tile_chosen = 15
	hide_buttons()
	pass # Replace with function body.
