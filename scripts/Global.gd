# Global.gd
extends Node

const EDGE_LEFT = "left"
const EDGE_RIGHT = "right"
const EDGE_TOP = "top"
const EDGE_BOTTOM = "bottom"

const ENEMY_SKINS = ["black", "calico", "orange"]
const ENEMY_DIRECTIONS = [
	"east",
	"southeast",
	"south",
	"southwest",
	"west",
	"northwest",
	"north",
	"northeast"
]

var speed: float = 200.0
var ADD_TO_BOSS_SCORE := 180
