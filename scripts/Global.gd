# Global.gd
extends Node

const EDGE_LEFT = "left"
const EDGE_RIGHT = "right"
const EDGE_TOP = "top"
const EDGE_BOTTOM = "bottom"

var speed: float = 200.0
var ADD_TO_BOSS_SCORE := 180

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
const CUSTOM_ANIMATIONS = {
	"east": [
		["04", 1.0],
		["02", 0.4],
		["01", 0.6],
		["03", 1.0],
		["01", 1.0]
	],
	"north": [
		["02", 1.0],
		["04", 1.0],
		["01", 1.0],
		["03", 1.0],
		["01", 1.0],
		["04", 1.0]
	],
	"northeast": [
		["01", 0.5],
		["03", 0.5],
		["02", 1.0]
	],
	"northwest": [
		["01", 0.5],
		["03", 0.5],
		["04", 1.0]
	],
	"south": [
		["01", 1.0],
		["02", 1.0],
		["04", 1.0],
		["03", 1.0]
	],
	"southeast": [
		["01", 1.0],
		["04", 0.8],
		["02", 0.3],
		["03", 1.0],
		["04", 0.8],
		["02", 0.3]
	],
	"southwest": [
		["01", 1.0],
		["04", 0.8],
		["02", 0.3],
		["03", 1.0],
		["04", 0.8],
		["02", 0.3]
	],
	"west": [
		["04", 1.0],
		["02", 0.4],
		["01", 0.6],
		["03", 1.0],
		["01", 1.0]
	]
}
