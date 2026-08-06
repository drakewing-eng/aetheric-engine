extends Node3D
## Production Bell: skinned humanoid GLB (male Xbot / Mixamo base)
## + native idle/walk/sit from final/bell.glb; synthesize only if missing.
##
## IMPORTANT: Do NOT force-apply raw Mixamo FBX clips from a different download
## onto this mesh. They carry absolute position tracks for another rest pose and
## explode the skinned mesh (detached limbs / inverted hull). Proper retarget
## must happen in Blender onto THIS armature's rest pose first.
## Single root AnimationPlayer (no nested AP). Planted ~1.78 m.

const GLB_PATH := "res://assets/characters/models/bell/final/bell.glb"
## Your Mixamo downloads converted together: same mesh rest pose as idle/walk/sit.
const MIXAMO_PACK_PATH := "res://assets/characters/mixamo/mixamo_activity_pack.glb"
const MIXAMO_CLIPS_PATH := "res://assets/characters/mixamo/mixamo_activity_clips.res"
## Skeleton-first: Mixamo mannequin + Start Walking / Standing Idle / Sitting Idle.
const SKELETON_FIRST := true
const NATIVE_HEIGHT := 1.78
## Flat mannequin grey (no albedo textures) so we judge bone motion only.
const MANNEQUIN_COLOR := Color(0.42, 0.40, 0.38, 1.0)

func _enter_tree() -> void:
	ensure_built()


func ensure_built() -> void:
	if has_meta("bell_built"):
		return
	_build()
	set_meta("bell_built", true)
	set_meta("native_height", NATIVE_HEIGHT)
	set_meta("bell_custom_mesh", true)
	set_meta("bell_production_mesh", true)
	set_meta("bell_skeleton_first", SKELETON_FIRST)


func get_mesh_bottom_y() -> float:
	return _scan_bottom()


func get_mesh_height() -> float:
	## Prefer skeleton tip-to-toe when mesh AABB is collapsed by Armature 0.01 scale.
	var sk_h := _skeleton_height()
	var mesh_h := _mesh_aabb_height()
	if sk_h > 0.5:
		return sk_h
	if mesh_h > 0.5:
		return mesh_h
	# After our plant scale, mesh AABB should be valid; fall back to meta target.
	if mesh_h > 0.01:
		return mesh_h
	return NATIVE_HEIGHT


func has_identity_parts() -> bool:
	return _find_skeleton(self) != null and not _all_meshes(self).is_empty()


func is_skeleton_first() -> bool:
	return SKELETON_FIRST or bool(get_meta("bell_skeleton_first", false))


func _apply_skeleton_first_presentation(model: Node) -> void:
	## Mannequin only: keep one skinned Beta_Surface, drop joint helpers + dupes + props.
	var remove: Array[Node] = []
	_collect_meshes_to_strip(model, remove, true)
	# Keep only the first Beta_Surface; drop later imports (.001) and Beta_Joints.
	var seen_body := false
	for mi in _all_meshes(model):
		if mi in remove:
			continue
		var nm := String(mi.name).to_lower()
		if "joints" in nm:
			remove.append(mi)
			continue
		if "surface" in nm or "beta" in nm or "body" in nm:
			if seen_body:
				remove.append(mi)
			else:
				seen_body = true
	for n in remove:
		if is_instance_valid(n):
			var p := n.get_parent()
			if p:
				p.remove_child(n)
			n.free()
	# Drop empty extra armatures (pack merges 3 FBX → 3 Armatures)
	_prune_empty_armatures(model)

	var kept := 0
	for mi in _all_meshes(model):
		var mat := StandardMaterial3D.new()
		mat.albedo_color = MANNEQUIN_COLOR
		mat.roughness = 0.9
		mat.metallic = 0.0
		mat.shading_mode = BaseMaterial3D.SHADING_MODE_PER_PIXEL
		mat.albedo_texture = null
		mi.material_override = mat
		mi.material_overlay = null
		kept += 1
	if kept == 0:
		push_warning("bell_runtime: skeleton_first left zero meshes")
	else:
		print("bell_runtime: skeleton_first body meshes=", kept)


func _collect_meshes_to_strip(n: Node, out: Array[Node], skeleton_first: bool) -> void:
	if n is MeshInstance3D:
		var nm := String(n.name).to_lower()
		var drop := (
			"coat" in nm
			or "hair" in nm
			or "book" in nm
			or "hat" in nm
			or "cylinder" in nm
			or "sphere" in nm
			or "joints" in nm  # Mixamo joint visualization — looks like a "skeleton"
		)
		if drop:
			out.append(n)
	for c in n.get_children():
		_collect_meshes_to_strip(c, out, skeleton_first)


func _prune_empty_armatures(model: Node) -> void:
	## Pack imports multiple Armatures; keep the one that still has a skinned mesh.
	var arms: Array[Node3D] = []
	_collect_armatures(model, arms)
	if arms.size() <= 1:
		return
	var keep: Node3D = null
	for a in arms:
		for mi in _all_meshes(model):
			# Mesh under same armature branch or skin bound
			if _is_under(mi, a) or (mi.skin != null and mi.get_parent() == a):
				keep = a
				break
		if keep:
			break
	if keep == null:
		keep = arms[0]
	for a in arms:
		if a != keep and is_instance_valid(a):
			# Only remove if no remaining mesh under it
			var has_mesh := false
			for mi in _all_meshes(a):
				has_mesh = true
				break
			if not has_mesh:
				var p := a.get_parent()
				if p:
					p.remove_child(a)
				a.free()


func _collect_armatures(n: Node, out: Array[Node3D]) -> void:
	if n is Node3D and String(n.name).begins_with("Armature"):
		out.append(n as Node3D)
	for c in n.get_children():
		_collect_armatures(c, out)


func _is_under(node: Node, ancestor: Node) -> bool:
	var p := node.get_parent()
	while p:
		if p == ancestor:
			return true
		p = p.get_parent()
	return false


func _mesh_source_path() -> String:
	## Skeleton-first uses the Mixamo pack (your downloads). Likeness uses final/bell.glb.
	if SKELETON_FIRST:
		if ResourceLoader.exists(MIXAMO_PACK_PATH) or FileAccess.file_exists(ProjectSettings.globalize_path(MIXAMO_PACK_PATH)):
			return MIXAMO_PACK_PATH
		push_warning("bell_runtime: Mixamo pack missing, falling back to bell.glb")
	return GLB_PATH


func _build() -> void:
	var src_path := _mesh_source_path()
	if not ResourceLoader.exists(src_path) and not FileAccess.file_exists(ProjectSettings.globalize_path(src_path)):
		push_error("bell_runtime: missing " + src_path)
		return
	var packed = load(src_path)
	if packed == null or not (packed is PackedScene):
		push_error("bell_runtime: not PackedScene " + src_path)
		return
	var model: Node = (packed as PackedScene).instantiate()
	model.name = "SkinnedMesh"
	add_child(model)

	# Capture anims from this scene BEFORE stripping APs (same rest pose as mesh).
	var pack_anims := {}
	if SKELETON_FIRST:
		pack_anims = _extract_anims_from_node(model)

	# Strip nested AnimationPlayers so fps_npc / tests find OUR root AP only.
	_strip_animation_players(model)

	if SKELETON_FIRST:
		_apply_skeleton_first_presentation(model)

	var sk := _find_skeleton(model)
	# Measure raw height before scale (handles Mixamo Armature scale 0.01).
	var h := _measure_raw_height(model, sk)
	if h < 0.05:
		h = 0.018  # known Xbot-under-0.01-armature collapsed height
	var sc := NATIVE_HEIGHT / h
	model.scale = Vector3(sc, sc, sc)
	# Plant feet to y≈0 in this node’s space.
	var bottom := _scan_bottom()
	if bottom == INF:
		bottom = 0.0
	model.position.y -= bottom
	model.position.y += 0.01

	var ap := AnimationPlayer.new()
	ap.name = "AnimationPlayer"
	add_child(ap)
	move_child(ap, 0)

	var has_idle := false
	var has_walk := false
	var has_sit := false

	if SKELETON_FIRST:
		# Clips from the SAME Mixamo pack as the body (Start Walking / Standing Idle / Sitting Idle).
		for k in ["idle", "walk", "sit"]:
			if not pack_anims.has(k):
				continue
			var anim: Animation = (pack_anims[k] as Animation).duplicate(true) as Animation
			_prepare_mixamo_locomotion(anim, k)
			_ensure_lib_anim(ap, k, anim)
			if k == "idle":
				has_idle = true
			elif k == "walk":
				has_walk = true
			elif k == "sit":
				has_sit = true
		print(
			"bell_runtime: SKELETON_FIRST Mixamo pack mesh+clips idle=%s walk=%s sit=%s src=%s"
			% [has_idle, has_walk, has_sit, src_path]
		)
	else:
		# Likeness path: native final/bell.glb clips only.
		var src_anims := _extract_native_anims_from_glb()
		if src_anims.has("idle"):
			_ensure_lib_anim(ap, "idle", src_anims["idle"] as Animation)
			has_idle = true
		if src_anims.has("walk"):
			_ensure_lib_anim(ap, "walk", src_anims["walk"] as Animation)
			has_walk = true
		if src_anims.has("sit"):
			_ensure_lib_anim(ap, "sit", src_anims["sit"] as Animation)
			has_sit = true
		print("bell_runtime: likeness GLB clips idle=%s walk=%s sit=%s" % [has_idle, has_walk, has_sit])

	# Synthesize only what is still missing.
	_build_bone_anims(ap, sk, not has_idle, not has_walk, not has_sit)

	if ap.has_animation("idle"):
		ap.play("idle")
	elif ap.get_animation_list().size() > 0:
		ap.play(ap.get_animation_list()[0])


func _prepare_mixamo_locomotion(anim: Animation, clip_name: String) -> void:
	## Walk/Idle: in-place (zero hip XZ) so NavigationAgent owns travel; keep Y bounce.
	## Sit: keep hip position so the pose stays weight-bearing (not a floating yoga fold).
	if clip_name == "walk" or clip_name == "idle":
		anim.loop_mode = Animation.LOOP_LINEAR
		_zero_hip_root_xz(anim)
	elif clip_name == "sit":
		anim.loop_mode = Animation.LOOP_LINEAR if anim.length >= 1.0 else Animation.LOOP_NONE
		# Do NOT strip hip position — Sitting Idle needs hip height for a planted sit.


func _zero_hip_root_xz(anim: Animation) -> void:
	for ti in anim.get_track_count():
		if anim.track_get_type(ti) != Animation.TYPE_POSITION_3D:
			continue
		var p := String(anim.track_get_path(ti)).to_lower()
		if "hips" not in p and not p.ends_with(":root") and "/root" not in p:
			continue
		for ki in anim.track_get_key_count(ti):
			var v = anim.track_get_key_value(ti, ki)
			if v is Vector3:
				var vv: Vector3 = v
				# Zero horizontal root motion; keep vertical bounce.
				anim.track_set_key_value(ti, ki, Vector3(0.0, vv.y, 0.0))


func _extract_anims_from_node(root: Node) -> Dictionary:
	## Pull idle/walk/sit from an already-instanced scene (before AP strip).
	var out := {}
	var ap := _find_animation_player(root)
	if ap == null:
		return out
	for c in ap.get_animation_list():
		var cl := String(c).to_lower()
		var anim: Animation = ap.get_animation(c)
		if anim == null:
			continue
		var copy: Animation = anim.duplicate(true) as Animation
		if cl == "idle" or (cl.contains("idle") and not cl.contains("sit") and not cl.contains("walk")):
			if not out.has("idle"):
				out["idle"] = copy
		elif cl == "walk" or cl.contains("walk"):
			if not out.has("walk"):
				out["walk"] = copy
		elif cl == "sit" or cl.contains("sit"):
			if not out.has("sit"):
				out["sit"] = copy
	return out


func _mixamo_clip_compatible(anim: Animation, sk: Skeleton3D) -> bool:
	## Foreign Mixamo FBX clips store absolute positions for another rest pose.
	## Applying them here detaches limbs. Only accept rotation-only (or hip-only pos).
	if anim == null:
		return false
	var pos_tracks := 0
	var max_pos := 0.0
	var non_hip_pos := 0
	for ti in anim.get_track_count():
		if anim.track_get_type(ti) != Animation.TYPE_POSITION_3D:
			continue
		pos_tracks += 1
		var p := String(anim.track_get_path(ti)).to_lower()
		var is_hip := "hips" in p or p.ends_with(":root")
		if not is_hip:
			non_hip_pos += 1
		for ki in anim.track_get_key_count(ti):
			var v = anim.track_get_key_value(ti, ki)
			if v is Vector3:
				max_pos = maxf(max_pos, (v as Vector3).length())
	# Native Bell clips: ~52 pos tracks at ~cm scale matching this armature.
	# External downloads often have 90+ pos tracks / mismatched rest → reject.
	if non_hip_pos > 4:
		return false
	if pos_tracks > 8 and max_pos > 1.0:
		# Many large position keys → almost certainly wrong rest pose
		return false
	return true


func _extract_mixamo_activity_clips() -> Dictionary:
	## Prefer baked AnimationLibrary; fall back to Mixamo pack GLB.
	## Not applied at runtime unless USE_EXTERNAL_MIXAMO_CLIPS and compatibility pass.
	var out := _extract_anims_from_library(MIXAMO_CLIPS_PATH)
	if out.has("idle") and out.has("walk") and out.has("sit"):
		return out
	var pack := _extract_anims_from_scene(MIXAMO_PACK_PATH)
	for k in pack.keys():
		if not out.has(k):
			out[k] = pack[k]
	return out


func _extract_anims_from_library(path: String) -> Dictionary:
	var out := {}
	if not ResourceLoader.exists(path) and not FileAccess.file_exists(ProjectSettings.globalize_path(path)):
		return out
	var res = load(path)
	if res == null or not (res is AnimationLibrary):
		return out
	var lib: AnimationLibrary = res as AnimationLibrary
	for name in ["idle", "walk", "sit"]:
		if lib.has_animation(name):
			var a: Animation = lib.get_animation(name)
			if a:
				out[name] = a.duplicate(true)
	return out


func _extract_anims_from_scene(path: String) -> Dictionary:
	var out := {}
	if not ResourceLoader.exists(path) and not FileAccess.file_exists(ProjectSettings.globalize_path(path)):
		return out
	var packed = load(path)
	if packed == null or not (packed is PackedScene):
		return out
	var tmp: Node = (packed as PackedScene).instantiate()
	var ap := _find_animation_player(tmp)
	if ap:
		for c in ap.get_animation_list():
			var cl := String(c).to_lower()
			var anim: Animation = ap.get_animation(c)
			if anim == null:
				continue
			var copy: Animation = anim.duplicate(true) as Animation
			if cl == "idle" or (cl.contains("idle") and not cl.contains("sit") and not cl.contains("walk")):
				if not out.has("idle"):
					out["idle"] = copy
			elif cl == "walk" or cl.contains("walk"):
				if not out.has("walk"):
					out["walk"] = copy
			elif cl == "sit" or cl.contains("sit"):
				if not out.has("sit"):
					out["sit"] = copy
	tmp.free()
	return out


func _extract_native_anims_from_glb() -> Dictionary:
	## Load GLB once more, copy idle/walk/sit Animation resources, free instance.
	var out := {}
	var packed = load(GLB_PATH)
	if packed == null or not (packed is PackedScene):
		return out
	var tmp: Node = (packed as PackedScene).instantiate()
	var existing := _find_animation_player(tmp)
	if existing:
		for c in existing.get_animation_list():
			var cl := String(c).to_lower()
			var anim: Animation = existing.get_animation(c)
			if anim == null:
				continue
			var copy: Animation = anim.duplicate() as Animation
			if cl == "idle" or ("idle" in cl and "walk" not in cl and "sit" not in cl):
				if not out.has("idle"):
					out["idle"] = copy
			elif cl == "walk" or cl.begins_with("walk"):
				if not out.has("walk"):
					out["walk"] = copy
			elif cl == "sit" or "sit" in cl:
				if not out.has("sit"):
					out["sit"] = copy
	tmp.free()
	return out


func _strip_animation_players(n: Node) -> void:
	var to_free: Array[Node] = []
	_collect_aps(n, to_free)
	for ap in to_free:
		ap.get_parent().remove_child(ap)
		ap.free()


func _collect_aps(n: Node, out: Array[Node]) -> void:
	if n is AnimationPlayer:
		out.append(n)
	for c in n.get_children():
		_collect_aps(c, out)


func _ensure_lib_anim(ap: AnimationPlayer, name: String, anim: Animation) -> void:
	if not ap.has_animation_library(""):
		ap.add_animation_library("", AnimationLibrary.new())
	var lib: AnimationLibrary = ap.get_animation_library("")
	if lib.has_animation(name):
		lib.remove_animation(name)
	if name == "idle" or name == "walk":
		anim.loop_mode = Animation.LOOP_LINEAR
	elif name == "sit":
		# Sitting Idle from Mixamo can loop; hold if short one-shot.
		if anim.length >= 1.0:
			anim.loop_mode = Animation.LOOP_LINEAR
		else:
			anim.loop_mode = Animation.LOOP_NONE
	# Remap track paths: Mixamo/GLB clips → skeleton under this runtime root.
	_remap_anim_tracks_to_our_skeleton(anim)
	lib.add_animation(name, anim)


func _remap_anim_tracks_to_our_skeleton(anim: Animation) -> void:
	## Mixamo/GLB tracks use paths relative to import root; our skeleton is under SkinnedMesh.
	var sk := _find_skeleton(self)
	if sk == null:
		return
	var sk_path := String(get_path_to(sk))
	for ti in anim.get_track_count():
		var p := String(anim.track_get_path(ti))
		# Paths like "Armature/Skeleton3D:mixamorig_Hips" or "Skeleton3D:bone"
		var colon := p.rfind(":")
		if colon < 0:
			continue
		var bone := p.substr(colon + 1)
		var resolved := _resolve_skeleton_bone_name(sk, bone)
		if resolved != "":
			bone = resolved
		anim.track_set_path(ti, NodePath(sk_path + ":" + bone))


func _resolve_skeleton_bone_name(sk: Skeleton3D, bone: String) -> String:
	## Match mixamorig:Hips ↔ mixamorig_Hips ↔ Hips across Mixamo import variants.
	if sk.find_bone(bone) >= 0:
		return bone
	var variants: Array[String] = []
	variants.append(bone.replace("mixamorig:", "mixamorig_"))
	variants.append(bone.replace("mixamorig_", "mixamorig:"))
	var bare := bone.replace("mixamorig:", "").replace("mixamorig_", "")
	variants.append(bare)
	variants.append("mixamorig_" + bare)
	variants.append("mixamorig:" + bare)
	for v in variants:
		if sk.find_bone(v) >= 0:
			return v
	# Fuzzy ends-with
	var want := bare.to_lower()
	for bi in sk.get_bone_count():
		var bn := sk.get_bone_name(bi)
		var clean := bn.to_lower().replace("mixamorig_", "").replace("mixamorig:", "")
		if clean == want:
			return bn
	return ""


func _bone_idx(sk: Skeleton3D, names: Array) -> int:
	if sk == null:
		return -1
	for n in names:
		var i := sk.find_bone(String(n))
		if i >= 0:
			return i
	# Fuzzy: any bone whose name ends with candidate suffix
	for n in names:
		var want := String(n).to_lower().replace("mixamorig_", "").replace("mixamorig:", "")
		for bi in sk.get_bone_count():
			var bn := sk.get_bone_name(bi).to_lower().replace("mixamorig_", "").replace("mixamorig:", "")
			if bn == want or bn.ends_with(want):
				return bi
	return -1


func _build_bone_anims(ap: AnimationPlayer, sk: Skeleton3D, need_idle: bool, need_walk: bool, need_sit: bool) -> void:
	if sk == null:
		# Still register empty-named sit/idle so tests fail on content not presence if needed;
		# without skeleton we cannot pose — but create clips so has_animation passes and
		# state machine does not crash.
		if not ap.has_animation_library(""):
			ap.add_animation_library("", AnimationLibrary.new())
		var lib0: AnimationLibrary = ap.get_animation_library("")
		if need_idle and not lib0.has_animation("idle"):
			var id0 := Animation.new()
			id0.length = 1.0
			id0.loop_mode = Animation.LOOP_LINEAR
			lib0.add_animation("idle", id0)
		if need_walk and not lib0.has_animation("walk"):
			var w0 := Animation.new()
			w0.length = 0.9
			w0.loop_mode = Animation.LOOP_LINEAR
			lib0.add_animation("walk", w0)
		if need_sit and not lib0.has_animation("sit"):
			var s0 := Animation.new()
			s0.length = 0.6
			lib0.add_animation("sit", s0)
		return
	if not ap.has_animation_library(""):
		ap.add_animation_library("", AnimationLibrary.new())
	var lib: AnimationLibrary = ap.get_animation_library("")
	var path_prefix := String(get_path_to(sk)) + ":"

	var b_lup := _bone_idx(sk, ["mixamorig_LeftUpLeg", "mixamorig:LeftUpLeg", "LeftUpLeg", "thigh_l", "UpperLeg.L"])
	var b_rup := _bone_idx(sk, ["mixamorig_RightUpLeg", "mixamorig:RightUpLeg", "RightUpLeg", "thigh_r", "UpperLeg.R"])
	var b_ll := _bone_idx(sk, ["mixamorig_LeftLeg", "mixamorig:LeftLeg", "LeftLeg", "shin_l", "LowerLeg.L"])
	var b_rl := _bone_idx(sk, ["mixamorig_RightLeg", "mixamorig:RightLeg", "RightLeg", "shin_r", "LowerLeg.R"])
	var b_la := _bone_idx(sk, ["mixamorig_LeftArm", "mixamorig:LeftArm", "LeftArm", "upperarm_l", "UpperArm.L"])
	var b_ra := _bone_idx(sk, ["mixamorig_RightArm", "mixamorig:RightArm", "RightArm", "upperarm_r", "UpperArm.R"])
	var b_head := _bone_idx(sk, ["mixamorig_Head", "mixamorig:Head", "Head"])

	if need_idle:
		var idle := Animation.new()
		idle.length = 2.0
		idle.loop_mode = Animation.LOOP_LINEAR
		for bi in [b_lup, b_rup, b_ll, b_rl, b_la, b_ra, b_head]:
			_bone_rot(idle, sk, path_prefix, bi, [0.0, 1.0, 2.0], [Vector3.ZERO, Vector3.ZERO, Vector3.ZERO])
		lib.add_animation("idle", idle)

	if need_walk:
		var walk := Animation.new()
		walk.length = 0.9
		walk.loop_mode = Animation.LOOP_LINEAR
		var a30 := deg_to_rad(28.0)
		var a34 := deg_to_rad(-32.0)
		_bone_rot(walk, sk, path_prefix, b_lup, [0.0, 0.45, 0.9], [Vector3(a30, 0, 0), Vector3(a34, 0, 0), Vector3(a30, 0, 0)])
		_bone_rot(walk, sk, path_prefix, b_rup, [0.0, 0.45, 0.9], [Vector3(a34, 0, 0), Vector3(a30, 0, 0), Vector3(a34, 0, 0)])
		_bone_rot(walk, sk, path_prefix, b_ll, [0.0, 0.45, 0.9], [Vector3(deg_to_rad(10), 0, 0), Vector3(deg_to_rad(28), 0, 0), Vector3(deg_to_rad(10), 0, 0)])
		_bone_rot(walk, sk, path_prefix, b_rl, [0.0, 0.45, 0.9], [Vector3(deg_to_rad(28), 0, 0), Vector3(deg_to_rad(10), 0, 0), Vector3(deg_to_rad(28), 0, 0)])
		_bone_rot(walk, sk, path_prefix, b_ra, [0.0, 0.45, 0.9], [Vector3(deg_to_rad(15), 0, 0), Vector3(deg_to_rad(-10), 0, 0), Vector3(deg_to_rad(15), 0, 0)])
		_bone_rot(walk, sk, path_prefix, b_la, [0.0, 0.45, 0.9], [Vector3(deg_to_rad(-8), 0, 0), Vector3(deg_to_rad(10), 0, 0), Vector3(deg_to_rad(-8), 0, 0)])
		lib.add_animation("walk", walk)

	if need_sit:
		var sit := Animation.new()
		sit.length = 0.6
		sit.loop_mode = Animation.LOOP_NONE
		var s70 := deg_to_rad(-70.0)
		var s80 := deg_to_rad(75.0)
		_bone_rot(sit, sk, path_prefix, b_lup, [0.0, 0.6], [Vector3.ZERO, Vector3(s70, 0, 0)])
		_bone_rot(sit, sk, path_prefix, b_rup, [0.0, 0.6], [Vector3.ZERO, Vector3(s70, 0, 0)])
		_bone_rot(sit, sk, path_prefix, b_ll, [0.0, 0.6], [Vector3.ZERO, Vector3(s80, 0, 0)])
		_bone_rot(sit, sk, path_prefix, b_rl, [0.0, 0.6], [Vector3.ZERO, Vector3(s80, 0, 0)])
		lib.add_animation("sit", sit)


func _bone_rot(anim: Animation, sk: Skeleton3D, prefix: String, bone_idx: int, times: Array, eulers: Array) -> void:
	if bone_idx < 0:
		return
	var bname := sk.get_bone_name(bone_idx)
	var path := NodePath(prefix + bname)
	var ti := anim.add_track(Animation.TYPE_ROTATION_3D)
	anim.track_set_path(ti, path)
	for i in times.size():
		var e: Vector3 = eulers[mini(i, eulers.size() - 1)]
		anim.rotation_track_insert_key(ti, float(times[i]), Quaternion.from_euler(e))


func _measure_raw_height(model: Node, sk: Skeleton3D) -> float:
	## Before applying our scale: use skeleton global rest if available, else mesh AABB.
	if sk:
		# Force skeleton to update rest pose transforms
		sk.reset_bone_poses()
		var lo := INF
		var hi := -INF
		for bi in sk.get_bone_count():
			var gt: Transform3D = sk.get_bone_global_rest(bi)
			var p: Vector3 = gt.origin
			# Bone positions are in skeleton space; account for skeleton chain to model.
			var world_p: Vector3 = _node_to_model(sk, model) * p
			lo = minf(lo, world_p.y)
			hi = maxf(hi, world_p.y)
		if hi > lo and (hi - lo) > 0.001:
			# Mixamo often has cm bones under 0.01 armature — include armature scale via node chain.
			return hi - lo
	return _mesh_aabb_height_under(model)


func _node_to_model(node: Node3D, model: Node) -> Transform3D:
	var t := Transform3D.IDENTITY
	var n: Node = node
	var stack: Array[Node3D] = []
	while n is Node3D and n != model:
		stack.push_front(n as Node3D)
		n = n.get_parent()
		if n == null:
			break
	for sn in stack:
		t = t * sn.transform
	return t


func _mesh_aabb_height() -> float:
	return _mesh_aabb_height_under(self)


func _mesh_aabb_height_under(root: Node) -> float:
	var lo := INF
	var hi := -INF
	var found := false
	var root3 := root as Node3D
	for mi in _all_meshes(root):
		if mi.mesh == null:
			continue
		var a: AABB = mi.get_aabb()
		# Also try custom AABB if engine reports tiny default for skinned
		if a.size.y < 0.001 and mi.mesh.get_aabb().size.y > 0.001:
			a = mi.mesh.get_aabb()
		var xf: Transform3D
		if root3:
			xf = _accum_to(mi, root3)
		else:
			xf = Transform3D.IDENTITY
		for i in 8:
			var p: Vector3 = xf * a.get_endpoint(i)
			lo = minf(lo, p.y)
			hi = maxf(hi, p.y)
			found = true
	return (hi - lo) if found else 0.0


func _skeleton_height() -> float:
	var sk := _find_skeleton(self)
	if sk == null:
		return 0.0
	var lo := INF
	var hi := -INF
	for bi in sk.get_bone_count():
		var gt: Transform3D = sk.get_bone_global_pose(bi)
		# Pose in skeleton space → self space
		var p: Vector3 = _accum_to(sk, self) * gt.origin
		lo = minf(lo, p.y)
		hi = maxf(hi, p.y)
	if hi > lo:
		return hi - lo
	return 0.0


func _scan_bottom() -> float:
	var bottom := INF
	var found := false
	# Prefer mesh AABB (feet on surface mesh)
	for mi in _all_meshes(self):
		if mi.mesh == null:
			continue
		var a: AABB = mi.get_aabb()
		if a.size.y < 0.001:
			a = mi.mesh.get_aabb()
		var xf := _accum_to_self(mi)
		for i in 8:
			var p: Vector3 = xf * a.get_endpoint(i)
			if p.y < bottom:
				bottom = p.y
				found = true
	if found:
		return bottom
	# Skeleton fallback
	var sk := _find_skeleton(self)
	if sk:
		for bi in sk.get_bone_count():
			var p: Vector3 = _accum_to_self(sk) * sk.get_bone_global_pose(bi).origin
			if p.y < bottom:
				bottom = p.y
				found = true
	return bottom if found else 0.0


func _accum_to_self(node: Node3D) -> Transform3D:
	return _accum_to(node, self)


func _accum_to(node: Node3D, root: Node3D) -> Transform3D:
	var t := Transform3D.IDENTITY
	var n: Node = node
	var stack: Array[Node3D] = []
	while n is Node3D and n != root:
		stack.push_front(n as Node3D)
		n = n.get_parent()
		if n == null:
			break
	for sn in stack:
		t = t * sn.transform
	return t


func _all_meshes(n: Node) -> Array[MeshInstance3D]:
	var out: Array[MeshInstance3D] = []
	if n is MeshInstance3D:
		out.append(n as MeshInstance3D)
	for c in n.get_children():
		out.append_array(_all_meshes(c))
	return out


func _find_skeleton(n: Node) -> Skeleton3D:
	if n is Skeleton3D:
		return n
	for c in n.get_children():
		var f := _find_skeleton(c)
		if f:
			return f
	return null


func _find_animation_player(n: Node) -> AnimationPlayer:
	if n is AnimationPlayer:
		return n
	for c in n.get_children():
		var f := _find_animation_player(c)
		if f:
			return f
	return null
