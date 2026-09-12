@tool
extends EditorScript

# File > Run para recrear los archivos .tres

const CATS_PATH := "res://assets/characters/cats/"
const CATS: Array[String] = [
	"orange",
	"black",
	"calico"
]
const FPS := 5.0

func _run():
	print("")
	print("🐱 ===============================")
	print("🐱 GENERADOR DE SPRITEFRAMES")
	print("🐱 ===============================")

	for cat_name: String in CATS:
		generate_cat(cat_name)

	print("")
	print("✅ Generación terminada.")
	print("")

	
func generate_cat(cat_name: String):
	var cat_path := CATS_PATH + cat_name + "/"
	var output_path := cat_path + cat_name + "_sprite_frames.tres"
	
	print("🐱 Generando .tres para: ", cat_name)
	
	var sprite_frames := SpriteFrames.new()
	
	# Eliminar animación default
	if sprite_frames.has_animation("default"):
		sprite_frames.remove_animation("default")
	
	for direction in Global.ENEMY_DIRECTIONS:
		var animation_name : String = cat_name + "_walk_" + direction
		
		sprite_frames.add_animation(animation_name)
		sprite_frames.set_animation_loop(animation_name, true)
		
		if Global.CUSTOM_ANIMATIONS.has(direction):
			add_custom_animation(
				sprite_frames,
				animation_name,
				cat_path,
				cat_name,
				direction
			)
		else:
			add_default_animation(
				sprite_frames,
				animation_name,
				cat_path,
				cat_name,
				direction
			)
		
		var frame_count := sprite_frames.get_frame_count(animation_name)
		
		if frame_count == 0:
			print("⚠️ Sin frames para: ", animation_name)
		else:
			print(
				"   ",
				animation_name,
				" → ",
				frame_count,
				" frames"
			)
		
	var result: Error = ResourceSaver.save(sprite_frames, output_path)

	if result == OK:
		print("   ✅ ", output_path)
	else:
		print("   ❌ Error guardando: ", output_path)

func add_custom_animation(
	sprite_frames: SpriteFrames,
	animation_name: String,
	cat_path: String,
	cat_name: String,
	direction: String
) -> void:
	var frames: Array = Global.CUSTOM_ANIMATIONS[direction]

	# FPS como velocidad base.
	sprite_frames.set_animation_speed(animation_name, FPS)
	
	for frame_data: Array in frames:
		var frame_number: String = frame_data[0]
		var duration: float = frame_data[1]

		var filename: String = "%s_%s_%s.png" % [
			cat_name,
			direction,
			frame_number
		]

		var path: String = cat_path + filename

		if not ResourceLoader.exists(path):
			print("   ⚠️ No existe: ", path)
			continue

		var texture: Texture2D = load(path) as Texture2D

		if texture == null:
			print("   ⚠️ No se pudo cargar: ", path)
			continue

		var frame_duration: float = duration

		sprite_frames.add_frame(
			animation_name,
			texture,
			frame_duration
		)
func add_default_animation(
	sprite_frames: SpriteFrames,
	animation_name: String,
	cat_path: String,
	cat_name: String,
	direction: String
) -> void:

	sprite_frames.set_animation_speed(animation_name, FPS)

	var frame_number: int = 1

	while true:
		var filename: String = "%s_%s_%02d.png" % [
			cat_name,
			direction,
			frame_number
		]

		var path: String = cat_path + filename

		if not ResourceLoader.exists(path):
			break

		var texture: Texture2D = load(path) as Texture2D

		if texture == null:
			print("   ⚠️ No se pudo cargar: ", path)
			break

		sprite_frames.add_frame(
			animation_name,
			texture
		)

		frame_number += 1
