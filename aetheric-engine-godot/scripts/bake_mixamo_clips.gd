extends SceneTree
## Bake Mixamo FBX activity clips into a shared AnimationLibrary for Bell (and future skeletal NPCs).
## Godot --headless --path . --script res://scripts/bake_mixamo_clips.gd
##
## Sources (under res://assets/characters/mixamo/source/):
##   standing_idle.fbx / idle.fbx → idle
##   start_walking.fbx           → walk
##   sitting_idle.fbx            → sit
##
## Output: res://assets/characters/mixamo/mixamo_activity_clips.res

const SRC_DIR := "res://assets/characters/mixamo/source/"
const PACK_GLB := "res://assets/characters/mixamo/mixamo_activity_pack.glb"
const OUT_PATH := "res://assets/characters/mixamo/mixamo_activity_clips.res"

## Preferred per-clip FBX sources (if pack GLB not available).
const CLIP_SOURCES := {
	"idle": ["standing_idle.fbx", "idle.fbx"],
	"walk": ["start_walking.fbx"],
	"sit": ["sitting_idle.fbx", "sitting_idle_alt.fbx"],
}


func _init() -> void:
	print("=== bake_mixamo_clips ===")
	var failed := 0
	var lib := AnimationLibrary.new()

	# Preferred: single Blender-converted pack with named idle/walk/sit
	var pack_anims := _extract_named_anims(PACK_GLB)
	if not pack_anims.is_empty():
		print("OK using pack ", PACK_GLB, " keys=", pack_anims.keys())
		for clip_name in ["idle", "walk", "sit"]:
			if not pack_anims.has(clip_name):
				print("FAIL pack missing ", clip_name)
				failed += 1
				continue
			var anim: Animation = (pack_anims[clip_name] as Animation).duplicate(true) as Animation
			_finalize_clip(anim, clip_name)
			if lib.has_animation(clip_name):
				lib.remove_animation(clip_name)
			lib.add_animation(clip_name, anim)
			print(
				"OK baked ",
				clip_name,
				" from pack len=",
				anim.length,
				" tracks=",
				anim.get_track_count()
			)
	else:
		print("NOTE pack missing/empty — falling back to per-file FBX")
		for clip_name in ["idle", "walk", "sit"]:
			var sources: Array = CLIP_SOURCES.get(clip_name, [])
			var anim: Animation = null
			var used := ""
			for src in sources:
				var path := SRC_DIR + str(src)
				var abs_path := ProjectSettings.globalize_path(path)
				if not FileAccess.file_exists(abs_path):
					print("NOTE missing source ", path)
					continue
				anim = _extract_first_animation(path)
				if anim != null:
					used = path
					break
			if anim == null:
				print("FAIL no animation for clip ", clip_name)
				failed += 1
				continue
			anim = anim.duplicate(true) as Animation
			_finalize_clip(anim, clip_name)
			if lib.has_animation(clip_name):
				lib.remove_animation(clip_name)
			lib.add_animation(clip_name, anim)
			print(
				"OK baked ",
				clip_name,
				" from ",
				used,
				" len=",
				anim.length,
				" tracks=",
				anim.get_track_count()
			)

	if failed > 0:
		print("=== BAKE FAILED count=", failed, " ===")
		quit(1)
		return

	# Ensure output dir
	var out_abs := ProjectSettings.globalize_path(OUT_PATH)
	var out_dir := out_abs.get_base_dir()
	DirAccess.make_dir_recursive_absolute(out_dir)
	var err := ResourceSaver.save(lib, OUT_PATH)
	if err != OK:
		print("FAIL ResourceSaver ", err, " path=", OUT_PATH)
		quit(1)
		return
	print("OK saved ", OUT_PATH)
	# Verify reload
	var reloaded = load(OUT_PATH)
	if reloaded is AnimationLibrary:
		var names := (reloaded as AnimationLibrary).get_animation_list()
		print("OK reloaded clips=", names)
		if not ("idle" in names and "walk" in names and "sit" in names):
			print("FAIL missing required clip names")
			quit(1)
			return
	else:
		print("FAIL reload not AnimationLibrary")
		quit(1)
		return
	print("=== BAKE COMPLETE ===")
	quit(0)


func _finalize_clip(anim: Animation, clip_name: String) -> void:
	if clip_name == "sit":
		# Sitting Idle loops well for long sits
		anim.loop_mode = Animation.LOOP_LINEAR if anim.length >= 1.0 else Animation.LOOP_NONE
	else:
		anim.loop_mode = Animation.LOOP_LINEAR
	_zero_root_position_tracks(anim)
	_normalize_bone_track_names(anim)


func _extract_named_anims(path: String) -> Dictionary:
	## Load a multi-clip GLB/FBX and map idle/walk/sit by name.
	var out := {}
	var abs_path := ProjectSettings.globalize_path(path)
	if not FileAccess.file_exists(abs_path):
		return out
	var packed = load(path)
	if packed == null or not (packed is PackedScene):
		print("NOTE pack load failed ", path)
		return out
	var root: Node = (packed as PackedScene).instantiate()
	if root == null:
		return out
	var ap := _find_ap(root)
	if ap == null:
		print("NOTE no AnimationPlayer in ", path)
		root.free()
		return out
	for c in ap.get_animation_list():
		var cl := String(c).to_lower()
		var a: Animation = ap.get_animation(c)
		if a == null:
			continue
		var copy: Animation = a.duplicate(true) as Animation
		if cl == "idle" or (cl.contains("idle") and not cl.contains("sit") and not cl.contains("walk")):
			if not out.has("idle"):
				out["idle"] = copy
		elif cl == "walk" or cl.contains("walk"):
			if not out.has("walk"):
				out["walk"] = copy
		elif cl == "sit" or cl.contains("sit"):
			if not out.has("sit"):
				out["sit"] = copy
	print("  pack source clips=", ap.get_animation_list())
	root.free()
	return out


func _extract_first_animation(path: String) -> Animation:
	## Load FBX/GLB PackedScene and return the best animation resource found.
	var packed = load(path)
	if packed == null:
		print("NOTE load null ", path)
		return null
	if not (packed is PackedScene):
		print("NOTE not PackedScene ", path, " type=", typeof(packed))
		return null
	var root: Node = (packed as PackedScene).instantiate()
	if root == null:
		return null
	var ap := _find_ap(root)
	var best: Animation = null
	var best_name := ""
	if ap:
		for c in ap.get_animation_list():
			var a: Animation = ap.get_animation(c)
			if a == null:
				continue
			# Prefer longest non-empty clip
			if best == null or a.length > best.length:
				best = a
				best_name = String(c)
	else:
		# Some imports store AnimationLibrary on root meta or AnimationPlayer missing —
		# search AnimationPlayer deeper already; try AnimationTree skip.
		print("NOTE no AnimationPlayer in ", path)
	if best:
		print("  source clip '", best_name, "' tracks=", best.get_track_count(), " len=", best.length)
		best = best.duplicate(true) as Animation
	root.free()
	return best


func _find_ap(n: Node) -> AnimationPlayer:
	if n is AnimationPlayer:
		return n
	for c in n.get_children():
		var f := _find_ap(c)
		if f:
			return f
	return null


func _zero_root_position_tracks(anim: Animation) -> void:
	## Keep feet-planted in place: remove hip/root translation so AI owns move.
	var remove: Array[int] = []
	for ti in anim.get_track_count():
		var p := String(anim.track_get_path(ti))
		var ttype := anim.track_get_type(ti)
		var low := p.to_lower()
		var is_rootish := (
			"hips" in low
			or low.ends_with(":root")
			or low.ends_with("/root")
			or low == "root"
			or "mixamorig:hips" in low
			or "mixamorig_hips" in low
		)
		if is_rootish and ttype == Animation.TYPE_POSITION_3D:
			remove.append(ti)
	# Remove high indices first
	remove.sort()
	remove.reverse()
	for ti in remove:
		anim.remove_track(ti)


func _normalize_bone_track_names(anim: Animation) -> void:
	## Ensure track bone suffixes use a consistent mixamorig_ form for remap helpers.
	for ti in anim.get_track_count():
		var p := String(anim.track_get_path(ti))
		var colon := p.rfind(":")
		if colon < 0:
			continue
		var bone := p.substr(colon + 1)
		# mixamorig:Hips → mixamorig_Hips (Godot FBX often uses underscore)
		if bone.begins_with("mixamorig:") and not bone.begins_with("mixamorig_"):
			bone = "mixamorig_" + bone.substr("mixamorig:".length())
			var prefix := p.substr(0, colon + 1)
			anim.track_set_path(ti, NodePath(prefix + bone))
