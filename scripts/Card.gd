extends TextureRect

class_name Card

const EMPTY_TEXTURE = preload("res://assets/empty.jpg")
enum ChessPieceType {ROOK, KNIGHT, PAWN, QUEEN, BISHOP, KING}
enum Rarity {COMMON, UNCOMMON, RARE, EPIC, LEGENDARY}

var cardID : int
var hasTriggered : bool

var image :Texture 
var description :String
var rarity : Rarity
var type : ChessPieceType

var mult : float
var tvalue : float

func fill_empty_card():
	cardID = 0
	image = EMPTY_TEXTURE
	description = ''
	
	hasTriggered = false
	self.texture = image



func fill_card(id, img, dsc, rrt, typ, multi, tv):
	cardID = id
	image = img
	description = dsc
	rarity = rrt
	type = typ
	
	mult = multi
	tvalue = tv
	
	hasTriggered = false
	self.texture = image
	return self
	
func copy_card(card):
	cardID = card.cardID
	image = card.image
	description = card.description
	rarity = card.rarity
	type = card.type
	
	hasTriggered = card.hasTriggered
	tvalue = card.tvalue
	mult = card.mult
	self.texture = image

func untrigger():
	hasTriggered = false


