@tool
extends EditorScript

#orange_sprite_frames.tres
#black_sprite_frames.tres
#calico_sprite_frames.tres

const CATS_PATH := "res://assets/characters/cats/"
const DIRECTIONS := [
	"north",
	"northeast",
	"east",
	"southeast",
	"south",
	"southwest",
	"west",
	"northwest"
]
const FPS := 5.0

func _run():
	var dir := DirAccess.open(CATS_PATH)
	
	if dir == null:
		print("No se encontró: ", CATS_PATH)
		return
	
	dir.list_dir_begin()
	var folder_name := dir.get_next()
	
	while folder_name != "":
		if dir.current_is_dir() and not folder_name.begins_with("."):
			generate_cat(folder_name)
		
		folder_name = dir.get_next()
		
	dir.list_dir_end()
	print("✅ Generación terminada.")
	
func generate_cat(cat_name: String):
	var cat_path := CATS_PATH + cat_name + "/"
	var output_path := cat_path + cat_name + "_sprite_frames.tres"
	
	print("🐱 Generando .tres para: ", cat_name)
	
	var sprite_frames := SpriteFrames.new()
	
	# Eliminar animación default
	sprite_frames.remove_animation("default")
	
	for direction in DIRECTIONS:
		var animation_name : String = cat_name + "_walk_" + direction
		
		sprite_frames.add_animation(animation_name)
		sprite_frames.set_animation_speed(animation_name, FPS)
		sprite_frames.set_animation_loop(animation_name, true)
		
		var frame_number := 1

		while true:
			var filename := "%s_%s_%02d.png" % [
				cat_name,
				direction,
				frame_number
			]
			
			var path := cat_path + filename

			if not ResourceLoader.exists(path):
				break
				
			var texture := load(path) as Texture2D
			if texture == null:
				print("⚠️ No se pudo cargar: ", path)
				break

			sprite_frames.add_frame(
				animation_name,
				texture
			)
			
			frame_number += 1
		
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
		
	var result := ResourceSaver.save(sprite_frames, output_path)

	if result == OK:
		print("   ✅ ", output_path)
	else:
		print("   ❌ Error guardando: ", output_path)
