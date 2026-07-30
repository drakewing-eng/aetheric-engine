extends Node3D
class_name FpsRoomBuilder

const PropsScript := preload("res://scripts/fps_props.gd")

const WALL_OVERLAP := 0.45
const WALL_TRIM_Y := 0.35
const WAINSCOT_H := 1.15

var _wainscot_h: float = WAINSCOT_H

func build(room: Dictionary) -> void:
	_build_room(room)

func _build_room(room: Dictionary) -> void:
	for child in get_children():
		child.queue_free()

	var size: Array = room["size"]
	var w: float = size[0]
	var d: float = size[1]
	var h: float = size[2]
	var walls: Dictionary = room.get("walls", {})
	var backing := Color(0.22, 0.15, 0.10)
	var victorian: bool = room.get("wall_style", "") == "victorian"
	_wainscot_h = float(room.get("wainscot_height", WAINSCOT_H))

	_add_floor(w, d, room)
	var ceiling_tint: Color = room.get("ceiling_color", Color(0.18, 0.14, 0.11))
	_add_ceiling(w, d, h, ceiling_tint)
	_add_corner_posts(w, d, h, backing)

	var doors: Array = room.get("doors", [])

	if victorian:
		var paper: String = room.get("wallpaper", "")
		var wainscot: String = room.get("wainscot", "")
		# Split walls around door openings (no solid wall through an open door)
		_add_victorian_facade("North", 0.0, w, h, paper, wainscot, backing, doors, w, d)
		_add_victorian_facade("West", 90.0, d, h, paper, wainscot, backing, doors, w, d)
		_add_victorian_facade("East", -90.0, d, h, paper, wainscot, backing, doors, w, d)
		_add_victorian_facade("South", 180.0, w, h, paper, wainscot, backing, doors, w, d)
		_add_skirting(w, d, h)
		for door in doors:
			_add_door_portal(door, w, d, h)
	else:
		var backdrop_tex: String = walls.get("backdrop", walls.get("north", ""))
		if backdrop_tex != "":
			_add_stretched_wall("North", backdrop_tex, Vector3(0, h * 0.5, -d * 0.5), 0.0, w, h, backing)
			_add_wall_lamp(Vector3(0, h * 0.55, -d * 0.5 + 2.0), d)
		_add_stretched_wall("West", walls.get("west", ""), Vector3(-w * 0.5, h * 0.5, 0), 90.0, d, h, backing)
		_add_stretched_wall("East", walls.get("east", ""), Vector3(w * 0.5, h * 0.5, 0), -90.0, d, h, backing)
		_add_stretched_wall("South", walls.get("south", ""), Vector3(0, h * 0.5, d * 0.5), 180.0, w, h, backing)

	if victorian:
		var le: float = float(room.get("light_energy", 1.2))
		var lc: Color = room.get("light_color", Color(1.0, 0.9, 0.72))
		_add_wall_lamp(Vector3(0, h * 0.55, -1.5), d, le, lc)
		_add_wall_lamp(Vector3(w * 0.25, h * 0.5, d * 0.15), d * 0.85, le * 0.55, lc)
		if w >= 12.0 or d >= 11.0:
			_add_wall_lamp(Vector3(-w * 0.3, h * 0.48, -d * 0.2), d * 0.7, le * 0.4, lc)

	# Perimeter collision: small doorway approach gaps only (closed leaf blocks void).
	_add_bounds(w, d, h, doors)

	var features: Array = room.get("features", [])
	if not features.is_empty():
		PropsScript.spawn_features(self, features)

	var props: Array = room.get("props", [])
	if not props.is_empty():
		PropsScript.spawn_all(self, props)

	for door in doors:
		_add_door_trigger(door, w, d)

func _solid_trim_mat(color: Color, roughness: float = 0.72) -> StandardMaterial3D:
	## Loop 208: solid-mat architectural trim — no furniture_wood.jpg washout mid-FOV.
	var mat := StandardMaterial3D.new()
	mat.albedo_color = color
	mat.metallic = 0.0
	mat.roughness = roughness
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_PER_PIXEL
	return mat


func _add_skirting(w: float, d: float, room_h: float = 3.5) -> void:
	## Period baseboard — double-step + corner blocks; solid-mat mahogany (loop 208).
	var board_h := 0.2
	var thick := 0.08
	var half_w := w * 0.5 - 0.05
	var half_d := d * 0.5 - 0.05
	var boards := [
		[Vector3(0, board_h * 0.5, -half_d), Vector3(w - 0.12, board_h, thick)],
		[Vector3(0, board_h * 0.5, half_d), Vector3(w - 0.12, board_h, thick)],
		[Vector3(-half_w, board_h * 0.5, 0), Vector3(thick, board_h, d - 0.12)],
		[Vector3(half_w, board_h * 0.5, 0), Vector3(thick, board_h, d - 0.12)],
	]
	var mat_base := _solid_trim_mat(Color(0.22, 0.12, 0.07), 0.75)
	var mat_cap := _solid_trim_mat(Color(0.28, 0.15, 0.09), 0.7)
	var mat_corner := _solid_trim_mat(Color(0.18, 0.1, 0.06), 0.78)
	var mat_rail := _solid_trim_mat(Color(0.26, 0.14, 0.08), 0.72)
	var mat_crown := _solid_trim_mat(Color(0.24, 0.13, 0.07), 0.74)
	var mat_step := _solid_trim_mat(Color(0.3, 0.16, 0.09), 0.7)
	for i in boards.size():
		var mi := MeshInstance3D.new()
		mi.name = "Skirting_%d" % i
		var mesh := BoxMesh.new()
		mesh.size = boards[i][1]
		mi.mesh = mesh
		mi.material_override = mat_base
		mi.position = boards[i][0]
		add_child(mi)
		var cap := MeshInstance3D.new()
		cap.name = "SkirtingCap_%d" % i
		var cm := BoxMesh.new()
		var bs: Vector3 = boards[i][1]
		if bs.x > bs.z:
			cm.size = Vector3(bs.x * 0.98, 0.04, bs.z + 0.03)
		else:
			cm.size = Vector3(bs.x + 0.03, 0.04, bs.z * 0.98)
		cap.mesh = cm
		cap.material_override = mat_cap
		cap.position = boards[i][0] + Vector3(0, board_h * 0.45, 0)
		add_child(cap)
	for corner in [
		Vector3(-half_w, 0.1, -half_d), Vector3(half_w, 0.1, -half_d),
		Vector3(-half_w, 0.1, half_d), Vector3(half_w, 0.1, half_d),
	]:
		var blk := MeshInstance3D.new()
		blk.name = "SkirtingCorner"
		var bm := BoxMesh.new()
		bm.size = Vector3(0.14, 0.2, 0.14)
		blk.mesh = bm
		blk.material_override = mat_corner
		blk.position = corner
		add_child(blk)
	var crown_y := clampf(room_h * 0.72, 2.2, room_h - 0.55)
	var rails := [
		[Vector3(0, crown_y, -half_d), Vector3(w - 0.25, 0.045, 0.035)],
		[Vector3(0, crown_y, half_d), Vector3(w - 0.25, 0.045, 0.035)],
		[Vector3(-half_w, crown_y, 0), Vector3(0.035, 0.045, d - 0.25)],
		[Vector3(half_w, crown_y, 0), Vector3(0.035, 0.045, d - 0.25)],
	]
	for i in rails.size():
		var cmi := MeshInstance3D.new()
		cmi.name = "PictureRail_%d" % i
		var cm := BoxMesh.new()
		cm.size = rails[i][1]
		cmi.mesh = cm
		cmi.material_override = mat_rail
		cmi.position = rails[i][0]
		add_child(cmi)
	var mould_y := room_h - 0.12
	var moulds := [
		[Vector3(0, mould_y, -half_d + 0.05), Vector3(w - 0.08, 0.14, 0.16)],
		[Vector3(0, mould_y, half_d - 0.05), Vector3(w - 0.08, 0.14, 0.16)],
		[Vector3(-half_w + 0.05, mould_y, 0), Vector3(0.16, 0.14, d - 0.08)],
		[Vector3(half_w - 0.05, mould_y, 0), Vector3(0.16, 0.14, d - 0.08)],
	]
	for i in moulds.size():
		var mmi := MeshInstance3D.new()
		mmi.name = "CrownMould_%d" % i
		var mm := BoxMesh.new()
		mm.size = moulds[i][1]
		mmi.mesh = mm
		mmi.material_override = mat_crown
		mmi.position = moulds[i][0]
		add_child(mmi)
	var step_y := room_h - 0.22
	for i in moulds.size():
		var smi := MeshInstance3D.new()
		smi.name = "CrownStep_%d" % i
		var sm := BoxMesh.new()
		var s: Vector3 = moulds[i][1]
		sm.size = Vector3(s.x * 0.98, 0.06, s.z * 0.7 if s.z > s.x else s.z)
		if s.x < s.z:
			sm.size = Vector3(s.x * 0.7, 0.06, s.z * 0.98)
		smi.mesh = sm
		smi.material_override = mat_step
		smi.position = Vector3(moulds[i][0].x, step_y, moulds[i][0].z)
		add_child(smi)


func _add_wall_lamp(
	pos: Vector3,
	room_depth: float,
	energy: float = 1.1,
	color: Color = Color(1.0, 0.9, 0.72),
) -> void:
	var lamp := OmniLight3D.new()
	lamp.name = "RoomLight"
	lamp.light_color = color
	lamp.light_energy = energy
	lamp.omni_range = room_depth + 2.0
	lamp.position = pos
	add_child(lamp)

func _add_victorian_facade(
	wall_name: String,
	yaw_deg: float,
	plane_w: float,
	plane_h: float,
	paper_tex: String,
	wainscot_tex: String,
	fallback: Color,
	doors: Array,
	room_w: float,
	room_d: float,
) -> void:
	## Build this facade as horizontal segments with gaps where doors sit.
	var gaps: Array = _door_gaps_on_wall(wall_name, doors, room_w, room_d)
	var half := plane_w * 0.5
	var segs: Array = _segments_with_gaps(-half, half, gaps)
	var wall_center := _wall_center(wall_name, room_w, room_d, plane_h)
	var i := 0
	for seg in segs:
		var a: float = float(seg[0])
		var b: float = float(seg[1])
		var seg_w: float = b - a
		if seg_w < 0.12:
			continue
		var mid: float = (a + b) * 0.5
		var pos := wall_center + _wall_tangent(wall_name) * mid
		_add_victorian_wall(
			"%s_seg%d" % [wall_name, i],
			pos,
			yaw_deg,
			seg_w,
			plane_h,
			paper_tex,
			wainscot_tex,
			fallback,
			false  # no expand into door openings
		)
		i += 1
	# Lintel strip above each door opening (so the hole is door-height, not full wall)
	for g in gaps:
		var gc: float = float(g[0])
		var gh: float = float(g[1])
		var door_h: float = float(g[2]) if g.size() > 2 else 2.35
		var lintel_h: float = maxf(0.25, plane_h - door_h - 0.05)
		if lintel_h < 0.15:
			continue
		var lintel_y: float = door_h + lintel_h * 0.5
		var pos2 := wall_center + _wall_tangent(wall_name) * gc
		pos2.y = lintel_y
		_add_wall_plane(
			"%s_lintel" % wall_name,
			pos2,
			yaw_deg,
			Vector2(gh * 2.0 + 0.1, lintel_h),
			paper_tex,
			fallback,
			true
		)


func _wall_center(wall_name: String, room_w: float, room_d: float, plane_h: float) -> Vector3:
	var y := plane_h * 0.5
	match wall_name:
		"North":
			return Vector3(0, y, -room_d * 0.5)
		"South":
			return Vector3(0, y, room_d * 0.5)
		"West":
			return Vector3(-room_w * 0.5, y, 0)
		"East":
			return Vector3(room_w * 0.5, y, 0)
		_:
			return Vector3.ZERO


func _wall_tangent(wall_name: String) -> Vector3:
	## Unit axis along the wall (increasing gap coordinate).
	match wall_name:
		"North", "South":
			return Vector3(1, 0, 0)
		"West", "East":
			return Vector3(0, 0, 1)
		_:
			return Vector3(1, 0, 0)


func _door_gaps_on_wall(wall_name: String, doors: Array, room_w: float, room_d: float) -> Array:
	## Returns [center_along_wall, half_width, door_height] for doors on this wall.
	var out: Array = []
	var half_w := room_w * 0.5
	var half_d := room_d * 0.5
	for door in doors:
		var p: Array = door.get("pos", [0, 0, 0])
		var px := float(p[0])
		var pz := float(p[2])
		var s: Array = door.get("size", [1.6, 2.4, 0.3])
		var door_w: float = maxf(float(s[0]), 1.4)
		var door_h: float = maxf(float(s[1]), 2.2)
		var gap_half := door_w * 0.5 + 0.08
		var dn := absf(pz + half_d)
		var ds := absf(pz - half_d)
		var dw := absf(px + half_w)
		var de := absf(px - half_w)
		var m := minf(minf(dn, ds), minf(dw, de))
		if wall_name == "North" and is_equal_approx(m, dn):
			out.append([px, gap_half, door_h])
		elif wall_name == "South" and is_equal_approx(m, ds):
			out.append([px, gap_half, door_h])
		elif wall_name == "West" and is_equal_approx(m, dw):
			out.append([pz, gap_half, door_h])
		elif wall_name == "East" and is_equal_approx(m, de):
			out.append([pz, gap_half, door_h])
	return out


func _segments_with_gaps(left: float, right: float, gaps: Array) -> Array:
	## gaps: [center, half_width, ...]
	var cuts: Array = gaps.duplicate()
	cuts.sort_custom(func(a, b): return float(a[0]) < float(b[0]))
	var segs: Array = []
	var cursor := left
	for g in cuts:
		var c: float = float(g[0])
		var hh: float = float(g[1])
		var gl: float = c - hh
		var gr: float = c + hh
		if gl > cursor + 0.08:
			segs.append([cursor, gl])
		cursor = maxf(cursor, gr)
	if right > cursor + 0.08:
		segs.append([cursor, right])
	if segs.is_empty():
		segs.append([left, right])
	return segs


func _add_door_portal(door: Dictionary, room_w: float, room_d: float, room_h: float) -> void:
	## Closed-door design: shallow recess + SOLID backstop. No deep walkable
	## "closet" hallway (that caused fall-through). Transition is E + teleport.
	var p: Array = door.get("pos", [0, 0, 0])
	var px := float(p[0])
	var pz := float(p[2])
	var s: Array = door.get("size", [1.6, 2.4, 0.3])
	var door_w: float = maxf(float(s[0]), 1.4)
	var door_h: float = maxf(float(s[1]), 2.2)
	var half_w := room_w * 0.5
	var half_d := room_d * 0.5
	var dn := absf(pz + half_d)
	var ds := absf(pz - half_d)
	var dw := absf(px + half_w)
	var de := absf(px - half_w)
	var m := minf(minf(dn, ds), minf(dw, de))
	var depth := 0.28  # shallow jamb recess only — not a walk-in corridor
	var root := Node3D.new()
	# Unique names so multi-door rooms (hall) keep every portal in the tree
	root.name = "DoorPortal_%s" % str(door.get("target", "room"))
	var floor_col := Color(0.22, 0.14, 0.09)
	var out_dir := Vector3.ZERO
	if is_equal_approx(m, dn):
		out_dir = Vector3(0, 0, -1)
		root.position = Vector3(px, 0, -half_d)
	elif is_equal_approx(m, ds):
		out_dir = Vector3(0, 0, 1)
		root.position = Vector3(px, 0, half_d)
	elif is_equal_approx(m, dw):
		out_dir = Vector3(-1, 0, 0)
		root.position = Vector3(-half_w, 0, pz)
	else:
		out_dir = Vector3(1, 0, 0)
		root.position = Vector3(half_w, 0, pz)
	if absf(out_dir.x) > 0.5:
		root.rotation_degrees.y = -90.0 if out_dir.x > 0.0 else 90.0
	elif out_dir.z > 0.0:
		root.rotation_degrees.y = 180.0
	else:
		root.rotation_degrees.y = 0.0
	add_child(root)
	# Loop 208: solid-mat portal wood (no furniture_wood.jpg washout at thresholds)
	var seed0: int = int(absf(px * 7.0 + pz * 3.0 + float(hash(str(door.get("target", ""))) % 97)))
	var wood: Color
	var wood_d: Color
	var wood_p: Color
	match seed0 % 3:
		0:
			wood = Color(0.42, 0.28, 0.16)
			wood_d = Color(0.3, 0.18, 0.1)
			wood_p = Color(0.36, 0.24, 0.14)
		1:
			wood = Color(0.28, 0.16, 0.1)
			wood_d = Color(0.18, 0.1, 0.06)
			wood_p = Color(0.24, 0.14, 0.09)
		_:
			wood = Color(0.5, 0.36, 0.2)
			wood_d = Color(0.36, 0.24, 0.12)
			wood_p = Color(0.45, 0.32, 0.18)
	var brass := Color(0.72, 0.56, 0.28)
	var brass_d := Color(0.55, 0.42, 0.2)
	# Threshold + jambs (solid mats, null tex)
	_add_portal_box(root, Vector3(0, 0.03, -depth * 0.5), Vector3(door_w + 0.14, 0.06, depth), wood_d, null, Vector3.ONE)
	_add_portal_box(root, Vector3(0, 0.05, 0.02), Vector3(door_w * 0.92, 0.08, 0.1), wood, null, Vector3.ONE)
	var side_x := door_w * 0.5 + 0.04
	for sx in [-side_x, side_x]:
		_add_portal_box(root, Vector3(sx, door_h * 0.5, -depth * 0.5), Vector3(0.1, door_h + 0.05, depth), wood, null, Vector3.ONE)
	_add_portal_box(root, Vector3(0, door_h * 0.5, -depth), Vector3(door_w + 0.2, door_h + 0.1, 0.12), wood_d, null, Vector3.ONE, true)
	# Stronger warm leak under leaf (closet residual — next-room light)
	_add_portal_glow(root, Vector3(0, 0.035, -depth + 0.02), Vector3(door_w * 0.78, 0.022, 0.05))
	var leaf_h := door_h - 0.06
	var leaf_cy := 0.04 + leaf_h * 0.5
	var lz := -depth + 0.07
	var double_leaf := door_w >= 1.55
	if double_leaf:
		var leaf_half := door_w * 0.44
		for side in [-1.0, 1.0]:
			var cx: float = float(side) * (leaf_half * 0.52 + 0.02)
			_add_portal_leaf(root, cx, leaf_cy, lz, leaf_half, leaf_h, wood, wood_d, wood_p, brass, null, side > 0.0)
		_add_portal_box(root, Vector3(0, leaf_cy, lz + 0.03), Vector3(0.04, leaf_h * 0.96, 0.03), wood_d, null, Vector3.ONE)
	else:
		_add_portal_leaf(root, 0.0, leaf_cy, lz, door_w * 0.9, leaf_h, wood, wood_d, wood_p, brass, null, true)
	_add_portal_box(root, Vector3(0, door_h + 0.04, -depth * 0.5), Vector3(door_w + 0.22, 0.1, depth + 0.06), wood, null, Vector3.ONE)
	_add_portal_box(root, Vector3(0, door_h + 0.12, -depth * 0.35), Vector3(door_w + 0.1, 0.06, depth * 0.6), wood_p, null, Vector3.ONE)
	_add_portal_box(root, Vector3(0, door_h + 0.18, -depth * 0.3), Vector3(door_w * 0.35, 0.05, 0.08), brass_d, null, Vector3.ONE)
	var label_txt := str(door.get("label", "next room"))
	var plaque_y: float = clampf(leaf_cy + leaf_h * 0.18, 1.35, 1.85)
	_add_portal_box(root, Vector3(0, plaque_y, lz + 0.055), Vector3(minf(door_w * 0.55, 0.95), 0.11, 0.025), brass_d, null, Vector3.ONE)
	_add_portal_box(root, Vector3(0, plaque_y, lz + 0.07), Vector3(minf(door_w * 0.48, 0.85), 0.08, 0.018), Color(0.16, 0.1, 0.06), null, Vector3.ONE)
	var lbl := Label3D.new()
	lbl.name = "DoorDestination"
	lbl.text = label_txt
	lbl.font_size = 42
	lbl.modulate = Color(0.94, 0.84, 0.55)
	lbl.outline_modulate = Color(0.08, 0.04, 0.02)
	lbl.outline_size = 8
	lbl.position = Vector3(0, plaque_y, lz + 0.09)
	lbl.billboard = BaseMaterial3D.BILLBOARD_DISABLED
	lbl.pixel_size = 0.0042
	root.add_child(lbl)


func _add_portal_leaf(
	parent: Node3D,
	cx: float,
	leaf_cy: float,
	lz: float,
	leaf_w: float,
	leaf_h: float,
	wood: Color,
	wood_d: Color,
	wood_p: Color,
	brass: Color,
	wood_tex: Texture2D,
	knob_on_right: bool
) -> void:
	## One 4-panel closed leaf (loop 167 helper for single/double doors).
	_add_portal_box(parent, Vector3(cx, leaf_cy, lz), Vector3(leaf_w, leaf_h, 0.05), wood, wood_tex, Vector3(1.0, 2.0, 1.0), true)
	_add_portal_box(parent, Vector3(cx, 0.1, lz + 0.02), Vector3(leaf_w * 0.96, 0.1, 0.03), wood_d, wood_tex, Vector3(1.0, 0.5, 1.0))
	var stile := 0.09
	_add_portal_box(parent, Vector3(cx - leaf_w * 0.5 + stile * 0.5, leaf_cy, lz + 0.02), Vector3(stile, leaf_h * 0.96, 0.025), wood_d, wood_tex, Vector3(0.5, 2.0, 1.0))
	_add_portal_box(parent, Vector3(cx + leaf_w * 0.5 - stile * 0.5, leaf_cy, lz + 0.02), Vector3(stile, leaf_h * 0.96, 0.025), wood_d, wood_tex, Vector3(0.5, 2.0, 1.0))
	_add_portal_box(parent, Vector3(cx, 0.04 + leaf_h - stile * 0.5, lz + 0.02), Vector3(leaf_w * 0.94, stile, 0.025), wood_d, wood_tex, Vector3(1.0, 0.5, 1.0))
	_add_portal_box(parent, Vector3(cx, 0.04 + stile * 0.5, lz + 0.02), Vector3(leaf_w * 0.94, stile, 0.025), wood_d, wood_tex, Vector3(1.0, 0.5, 1.0))
	_add_portal_box(parent, Vector3(cx, leaf_cy, lz + 0.02), Vector3(leaf_w * 0.7, stile * 0.85, 0.025), wood_d, wood_tex, Vector3(1.0, 0.5, 1.0))
	_add_portal_box(parent, Vector3(cx, leaf_cy, lz + 0.02), Vector3(stile * 0.75, leaf_h * 0.75, 0.022), wood_d, wood_tex, Vector3(0.5, 2.0, 1.0))
	var pw := leaf_w * 0.32
	var ph := leaf_h * 0.28
	for sx in [-1.0, 1.0]:
		for sy in [-1.0, 1.0]:
			var px2: float = cx + float(sx) * leaf_w * 0.22
			var py2: float = leaf_cy + float(sy) * leaf_h * 0.2
			_add_portal_box(parent, Vector3(px2, py2, lz + 0.03), Vector3(pw, ph, 0.015), wood_p, wood_tex, Vector3(0.8, 1.0, 1.0))
			_add_portal_box(parent, Vector3(px2, py2, lz + 0.04), Vector3(pw * 0.72, ph * 0.68, 0.012), wood.lightened(0.08), wood_tex, Vector3(0.7, 0.9, 1.0))
	var kx: float = cx + (leaf_w * 0.28 if knob_on_right else -leaf_w * 0.28)
	_add_portal_box(parent, Vector3(kx, leaf_cy + 0.05, lz + 0.045), Vector3(0.09, 0.16, 0.02), brass.darkened(0.15), null, Vector3.ONE)
	_add_portal_box(parent, Vector3(kx, leaf_cy + 0.08, lz + 0.06), Vector3(0.06, 0.06, 0.04), brass, null, Vector3.ONE)
	_add_portal_box(parent, Vector3(kx, leaf_cy - 0.02, lz + 0.055), Vector3(0.05, 0.08, 0.02), brass.lightened(0.05), null, Vector3.ONE)
	var hx: float = cx + (-leaf_w * 0.42 if knob_on_right else leaf_w * 0.42)
	for hy_off in [-0.35, 0.0, 0.35]:
		_add_portal_box(parent, Vector3(hx, leaf_cy + hy_off * leaf_h * 0.5, lz + 0.05), Vector3(0.05, 0.14, 0.035), brass, null, Vector3.ONE)


func _add_portal_glow(parent: Node3D, pos: Vector3, size: Vector3) -> void:
	## Loop 208: stronger warm leak under closed leaf — next-room light, not closet void.
	var mi := MeshInstance3D.new()
	mi.name = "DoorLightLeak"
	var mesh := BoxMesh.new()
	mesh.size = size
	mi.mesh = mesh
	var mat := StandardMaterial3D.new()
	mat.albedo_color = Color(1.0, 0.8, 0.48, 0.9)
	mat.emission_enabled = true
	mat.emission = Color(1.0, 0.75, 0.4)
	mat.emission_energy_multiplier = 2.0
	mat.roughness = 0.55
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_PER_PIXEL
	mi.material_override = mat
	mi.position = pos
	parent.add_child(mi)
	var light := OmniLight3D.new()
	light.name = "DoorBeyondLight"
	light.light_color = Color(1.0, 0.86, 0.62)
	light.light_energy = 0.55
	light.omni_range = 1.8
	light.position = pos + Vector3(0, 0.55, -0.06)
	parent.add_child(light)
	# Secondary soft fill higher on leaf (reads as room glow through panels)
	var light2 := OmniLight3D.new()
	light2.name = "DoorBeyondLight2"
	light2.light_color = Color(1.0, 0.82, 0.55)
	light2.light_energy = 0.28
	light2.omni_range = 1.4
	light2.position = pos + Vector3(0, 1.1, -0.05)
	parent.add_child(light2)

func _add_portal_box(
	parent: Node3D,
	pos: Vector3,
	size: Vector3,
	color: Color,
	tex: Texture2D = null,
	uv_scale: Vector3 = Vector3(1, 1, 1),
	solid: bool = false
) -> void:
	var body: Node3D = StaticBody3D.new() if solid else Node3D.new()
	var mi := MeshInstance3D.new()
	var mesh := BoxMesh.new()
	mesh.size = size
	mi.mesh = mesh
	var mat := StandardMaterial3D.new()
	mat.albedo_color = color
	mat.roughness = 0.85
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_PER_PIXEL
	if tex:
		mat.albedo_texture = tex
		mat.uv1_scale = uv_scale
	mi.material_override = mat
	body.add_child(mi)
	if solid:
		var col := CollisionShape3D.new()
		var shape := BoxShape3D.new()
		shape.size = size
		col.shape = shape
		body.add_child(col)
	body.position = pos
	parent.add_child(body)


func _add_victorian_wall(
	wall_name: String,
	pos: Vector3,
	yaw_deg: float,
	plane_w: float,
	plane_h: float,
	paper_tex: String,
	wainscot_tex: String,
	fallback: Color,
	expand: bool = true,
) -> void:
	## Paper sits slightly in front of wainscot to kill coplanar z-fighting.
	## Chair rail covers the join (horizon shimmer when walking).
	var cover_w := plane_w + (WALL_OVERLAP * 2.0 if expand else 0.04)
	var cover_h := plane_h + WALL_TRIM_Y * 2.0
	# Leave a small vertical gap so layers don't share an edge in depth
	var join := minf(_wainscot_h, cover_h - 0.05)
	var paper_overlap := 0.04  # paper tucks slightly behind rail
	var full_panel := _wainscot_h >= plane_h - 0.15
	var upper_h := cover_h - join + paper_overlap
	var upper_y := join - paper_overlap * 0.5 + upper_h * 0.5 - WALL_TRIM_Y
	var lower_y := join * 0.5
	# Wall normal (into room): for yaw 0 plane faces +Z from wall at -d/2, so inward is +Z.
	var yaw_rad := deg_to_rad(yaw_deg)
	var inward := Vector3(sin(yaw_rad), 0.0, cos(yaw_rad)) * 0.012

	if full_panel:
		# Full-height paneling — both layers use panel texture so cream paper never peeks
		_add_wall_plane(
			wall_name + "Wainscot",
			pos + Vector3(0, 0, 0),
			yaw_deg,
			Vector2(cover_w, cover_h),
			wainscot_tex,
			fallback,
			true
		)
		_add_wall_plane(
			wall_name + "Paper",
			pos + inward,
			yaw_deg,
			Vector2(cover_w, cover_h),
			wainscot_tex if wainscot_tex != "" else paper_tex,
			fallback,
			true
		)
		# Upper picture rail only (not mid-wall)
		_add_chair_rail(wall_name, pos, yaw_deg, cover_w, plane_h - 0.35, inward)
	else:
		_add_wall_plane(
			wall_name + "Wainscot",
			pos + Vector3(0, lower_y - plane_h * 0.5, 0),
			yaw_deg,
			Vector2(cover_w, join + WALL_TRIM_Y * 0.5),
			wainscot_tex,
			fallback,
			true
		)
		# Wallpaper offset inward (toward room) — stops flicker vs wainscot
		_add_wall_plane(
			wall_name + "Paper",
			pos + Vector3(0, upper_y - plane_h * 0.5, 0) + inward,
			yaw_deg,
			Vector2(cover_w, upper_h),
			paper_tex,
			fallback,
			true
		)
		# Dado / chair rail at join — physical strip so the meeting line never shimmers
		_add_chair_rail(wall_name, pos, yaw_deg, cover_w, join, inward)

func _add_stretched_wall(
	wall_name: String,
	tex_path: String,
	pos: Vector3,
	yaw_deg: float,
	plane_w: float,
	plane_h: float,
	backing: Color,
) -> void:
	var cover_w := plane_w + WALL_OVERLAP * 2.0
	var cover_h := plane_h + WALL_TRIM_Y * 2.0
	if tex_path != "":
		_add_wall_plane(wall_name, pos, yaw_deg, Vector2(cover_w, cover_h), tex_path, backing, false)
	else:
		_add_wall_plane(wall_name, pos, yaw_deg, Vector2(cover_w, cover_h), "", backing, false)

func _add_corner_posts(w: float, d: float, h: float, color: Color) -> void:
	var hx := w * 0.5 - 0.02
	var hz := d * 0.5 - 0.02
	for corner in [Vector3(-hx, h * 0.5, -hz), Vector3(hx, h * 0.5, -hz), Vector3(-hx, h * 0.5, hz), Vector3(hx, h * 0.5, hz)]:
		var post := MeshInstance3D.new()
		var mesh := BoxMesh.new()
		mesh.size = Vector3(0.18, h + WALL_TRIM_Y * 2.0, 0.18)
		post.mesh = mesh
		var mat := StandardMaterial3D.new()
		mat.albedo_color = color
		mat.roughness = 0.7
		post.material_override = mat
		post.position = corner
		add_child(post)

func _add_floor(width: float, depth: float, room: Dictionary) -> void:
	var body := StaticBody3D.new()
	body.name = "Floor"
	var mesh := BoxMesh.new()
	mesh.size = Vector3(width + 0.4, 0.12, depth + 0.4)
	var mi := MeshInstance3D.new()
	mi.mesh = mesh
	var mat := StandardMaterial3D.new()
	var floor_tex: String = room.get("floor_texture", "")
	if floor_tex != "":
		var tex: Texture2D = _load_texture(floor_tex)
		if tex:
			mat.albedo_texture = tex
			# Loop 110: optional denser tile repeat (kitchen/conservatory flag/quarry plates)
			var uv_mul: float = float(room.get("floor_uv_scale", 0.22))
			mat.uv1_scale = Vector3(width * uv_mul, depth * uv_mul, 1.0)
			mat.roughness = 0.65
		else:
			mat.albedo_color = room.get("floor_color", Color(0.32, 0.22, 0.14))
	else:
		mat.albedo_color = room.get("floor_color", Color(0.32, 0.22, 0.14))
		mat.roughness = 0.75
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_PER_PIXEL
	mi.material_override = mat
	body.add_child(mi)
	var col := CollisionShape3D.new()
	var shape := BoxShape3D.new()
	shape.size = Vector3(width, 0.12, depth)
	col.shape = shape
	body.add_child(col)
	body.position = Vector3(0, -0.06, 0)
	add_child(body)

func _add_ceiling(width: float, depth: float, height: float, tint: Color = Color(0.18, 0.14, 0.11)) -> void:
	var mi := MeshInstance3D.new()
	mi.name = "Ceiling"
	var mesh := BoxMesh.new()
	mesh.size = Vector3(width + WALL_OVERLAP * 2.0, 0.08, depth + WALL_OVERLAP * 2.0)
	mi.mesh = mesh
	var mat := StandardMaterial3D.new()
	# Prefer plaster texture; fall back to warm plaster tint (not dark void)
	var plas: Texture2D = _load_texture("res://assets/rooms/textures/victorian/ceiling_plaster.jpg")
	if plas:
		mat.albedo_texture = plas
		mat.albedo_color = Color(1, 1, 1).lerp(tint.lightened(0.55), 0.25)
		mat.uv1_scale = Vector3(width * 0.15, depth * 0.15, 1.0)
	else:
		mat.albedo_color = Color(0.82, 0.78, 0.7).lerp(tint, 0.2)
	mat.roughness = 0.92
	mi.material_override = mat
	mi.position = Vector3(0, height, 0)
	add_child(mi)
	# Loop 113: ceiling rose / plaster medallion — breaks blank white expanse
	_add_ceiling_rose(0.0, 0.0, height, minf(width, depth))
	if width >= 12.0 or depth >= 11.0:
		# Long rooms get a second rose toward one end
		_add_ceiling_rose(0.0, depth * 0.22, height, minf(width, depth) * 0.85)


func _add_ceiling_rose(x: float, z: float, height: float, room_span: float) -> void:
	## Concentric plaster rings + bead under ceiling (period medallion).
	var y := height - 0.06
	var r_outer := clampf(room_span * 0.09, 0.55, 1.15)
	var plaster := Color(0.88, 0.84, 0.76)
	var plaster_d := Color(0.78, 0.72, 0.62)
	# Outer disc
	var outer := MeshInstance3D.new()
	outer.name = "CeilingRoseOuter"
	var om := CylinderMesh.new()
	om.top_radius = r_outer
	om.bottom_radius = r_outer
	om.height = 0.03
	outer.mesh = om
	var omat := StandardMaterial3D.new()
	omat.albedo_color = plaster
	omat.roughness = 0.9
	outer.material_override = omat
	outer.position = Vector3(x, y, z)
	add_child(outer)
	# Mid ring (stepped)
	var mid := MeshInstance3D.new()
	mid.name = "CeilingRoseMid"
	var mm := CylinderMesh.new()
	mm.top_radius = r_outer * 0.68
	mm.bottom_radius = r_outer * 0.72
	mm.height = 0.04
	mid.mesh = mm
	var mmat := StandardMaterial3D.new()
	mmat.albedo_color = plaster_d
	mmat.roughness = 0.88
	mid.material_override = mmat
	mid.position = Vector3(x, y - 0.02, z)
	add_child(mid)
	# Inner boss
	var inn := MeshInstance3D.new()
	inn.name = "CeilingRoseBoss"
	var im := CylinderMesh.new()
	im.top_radius = r_outer * 0.28
	im.bottom_radius = r_outer * 0.32
	im.height = 0.05
	inn.mesh = im
	var imat := StandardMaterial3D.new()
	imat.albedo_color = plaster.lightened(0.05)
	imat.roughness = 0.85
	inn.material_override = imat
	inn.position = Vector3(x, y - 0.035, z)
	add_child(inn)
	# Petal beads around mid ring
	for i in 8:
		var ang := float(i) * (TAU / 8.0)
		var bead := MeshInstance3D.new()
		var bm := SphereMesh.new()
		bm.radius = r_outer * 0.06
		bm.height = r_outer * 0.1
		bead.mesh = bm
		var bmat := StandardMaterial3D.new()
		bmat.albedo_color = plaster_d.darkened(0.05)
		bmat.roughness = 0.88
		bead.material_override = bmat
		bead.position = Vector3(x + cos(ang) * r_outer * 0.55, y - 0.025, z + sin(ang) * r_outer * 0.55)
		add_child(bead)
	# Tiny brass centre stud (gasolier mount suggestion)
	var stud := MeshInstance3D.new()
	var sm := CylinderMesh.new()
	sm.top_radius = 0.04
	sm.bottom_radius = 0.05
	sm.height = 0.03
	stud.mesh = sm
	var smat := StandardMaterial3D.new()
	smat.albedo_color = Color(0.72, 0.56, 0.28)
	smat.roughness = 0.35
	smat.metallic = 0.45
	stud.material_override = smat
	stud.position = Vector3(x, y - 0.05, z)
	add_child(stud)

func _add_chair_rail(
	wall_name: String,
	wall_pos: Vector3,
	yaw_deg: float,
	cover_w: float,
	join_y: float,
	inward: Vector3,
) -> void:
	## Period dado rail — solid-mat mahogany (loop 208; no pale wood-tex washout).
	var yaw_rad := deg_to_rad(yaw_deg)
	var extra := Vector3(sin(yaw_rad), 0.0, cos(yaw_rad)) * 0.022
	var base := Vector3(wall_pos.x, join_y, wall_pos.z) + inward + extra
	_add_trim_strip(wall_name + "ChairRail", base, yaw_deg, Vector3(cover_w - 0.1, 0.09, 0.055), Color(0.28, 0.15, 0.09))
	_add_trim_strip(
		wall_name + "ChairRailUnder",
		base + Vector3(0, -0.06, 0) + Vector3(sin(yaw_rad), 0.0, cos(yaw_rad)) * 0.01,
		yaw_deg,
		Vector3(cover_w - 0.14, 0.035, 0.04),
		Color(0.2, 0.11, 0.06)
	)
	_add_trim_strip(
		wall_name + "ChairRailBead",
		base + Vector3(0, 0.055, 0) + Vector3(sin(yaw_rad), 0.0, cos(yaw_rad)) * 0.008,
		yaw_deg,
		Vector3(cover_w - 0.12, 0.02, 0.035),
		Color(0.34, 0.18, 0.1)
	)


func _add_trim_strip(
	name: String,
	pos: Vector3,
	yaw_deg: float,
	size: Vector3,
	color: Color,
) -> void:
	var mi := MeshInstance3D.new()
	mi.name = name
	var mesh := BoxMesh.new()
	mesh.size = size
	mi.mesh = mesh
	mi.material_override = _solid_trim_mat(color, 0.7)
	mi.position = pos
	mi.rotation_degrees = Vector3(0, yaw_deg, 0)
	add_child(mi)


func _add_wall_plane(
	wall_name: String,
	pos: Vector3,
	yaw_deg: float,
	plane_size: Vector2,
	tex_path: String,
	fallback: Color,
	tiled: bool,
) -> void:
	# Visual only — solid collision comes from _add_bounds (with doorway gaps).
	# Use a thin BoxMesh instead of zero-thickness PlaneMesh to reduce z-fighting.
	var mi := MeshInstance3D.new()
	mi.name = wall_name
	var mesh := BoxMesh.new()
	mesh.size = Vector3(plane_size.x, plane_size.y, 0.02)
	mi.mesh = mesh
	mi.material_override = _make_mat(tex_path, fallback, plane_size, tiled)
	mi.position = pos
	mi.rotation_degrees = Vector3(0, yaw_deg, 0)
	add_child(mi)

func _make_mat(tex_path: String, fallback: Color, plane_size: Vector2, tiled: bool) -> StandardMaterial3D:
	var mat := StandardMaterial3D.new()
	mat.cull_mode = BaseMaterial3D.CULL_BACK
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_PER_PIXEL
	mat.roughness = 0.88
	# Reduce shimmer on large coplanar surfaces while walking
	mat.texture_filter = BaseMaterial3D.TEXTURE_FILTER_LINEAR_WITH_MIPMAPS_ANISOTROPIC
	if tex_path != "":
		var tex: Texture2D = _load_texture(tex_path)
		if tex:
			mat.albedo_texture = tex
			if tiled:
				# Damask denser (loop 77); service tiles denser so grout reads (loop 115)
				# Loop 209/228/229: dens raises for service walls mid-FOV Minecraft residual
				# Loop 233: kitchen metro = HORIZONTAL subway plate (not square bricks)
				var dens := 0.22
				if tex_path.find("wallpaper_drawing") >= 0 or tex_path.find("wallpaper_gallery") >= 0:
					dens = 0.28
				elif tex_path.find("wainscot_kitchen") >= 0:
					dens = 1.25  # horizontal subway courses ~8–10cm
				elif tex_path.find("wallpaper_kitchen") >= 0:
					dens = 1.2  # fine cream check (32×32 plate)
				elif tex_path.find("wallpaper_workshop") >= 0:
					dens = 1.15  # fine limewash brick (~10cm courses) + regen 18-row plate
				elif tex_path.find("wainscot_workshop") >= 0:
					dens = 0.78  # denser vertical board rhythm
				mat.uv1_scale = Vector3(plane_size.x * dens, plane_size.y * dens, 1.0)
			return mat
	mat.albedo_color = fallback
	return mat


## Load Texture2D even when .import is missing (new additive art).
static func _load_texture(tex_path: String) -> Texture2D:
	if tex_path == "":
		return null
	if ResourceLoader.exists(tex_path):
		var res = load(tex_path)
		if res is Texture2D:
			return res
	# Runtime filesystem load for freshly added PNGs/JPGs
	var abs_path := ProjectSettings.globalize_path(tex_path)
	if FileAccess.file_exists(abs_path):
		var img := Image.new()
		var err := img.load(abs_path)
		if err == OK:
			return ImageTexture.create_from_image(img)
	return null

func _add_bounds(w: float, d: float, h: float, doors: Array = []) -> void:
	## Invisible collision walls with openings where doors are so the player can
	## approach north/south as well as east/west doorways (old solid walls blocked
	## north/south triggers).
	var half_w := w * 0.5 - 0.2
	var half_d := d * 0.5 - 0.2
	var gap_half := 0.55  # narrow approach gap — closed solid leaf blocks walk-into-void

	# Collect door centers projected onto each wall
	var north_gaps: Array = []  # x positions
	var south_gaps: Array = []
	var west_gaps: Array = []   # z positions
	var east_gaps: Array = []
	for door in doors:
		var p: Array = door.get("pos", [0, 0, 0])
		var px := float(p[0])
		var pz := float(p[2])
		var dn := absf(pz + d * 0.5)
		var ds := absf(pz - d * 0.5)
		var dw := absf(px + w * 0.5)
		var de := absf(px - w * 0.5)
		var m := minf(minf(dn, ds), minf(dw, de))
		if is_equal_approx(m, dn):
			north_gaps.append(px)
		elif is_equal_approx(m, ds):
			south_gaps.append(px)
		elif is_equal_approx(m, dw):
			west_gaps.append(pz)
		else:
			east_gaps.append(pz)

	_add_bound_segments_along_x(-half_d, w, h, north_gaps, gap_half, "N")
	_add_bound_segments_along_x(half_d, w, h, south_gaps, gap_half, "S")
	_add_bound_segments_along_z(-half_w, d, h, west_gaps, gap_half, "W")
	_add_bound_segments_along_z(half_w, d, h, east_gaps, gap_half, "E")


func _add_bound_segments_along_x(
	z: float, room_w: float, h: float, gaps: Array, gap_half: float, tag: String
) -> void:
	## Horizontal wall at fixed z, spanning x from -room_w/2 to +room_w/2 with gaps.
	var left := -room_w * 0.5
	var right := room_w * 0.5
	var cuts: Array = gaps.duplicate()
	cuts.sort()
	var cursor := left
	var i := 0
	for g in cuts:
		var gx := float(g)
		var gap_l := gx - gap_half
		var gap_r := gx + gap_half
		if gap_l > cursor + 0.15:
			_add_bound_box(
				"Bound_%s_%d" % [tag, i],
				Vector3((cursor + gap_l) * 0.5, 1.0, z),
				Vector3(gap_l - cursor, h, 0.22)
			)
			i += 1
		cursor = maxf(cursor, gap_r)
	if right > cursor + 0.15:
		_add_bound_box(
			"Bound_%s_%d" % [tag, i],
			Vector3((cursor + right) * 0.5, 1.0, z),
			Vector3(right - cursor, h, 0.22)
		)


func _add_bound_segments_along_z(
	x: float, room_d: float, h: float, gaps: Array, gap_half: float, tag: String
) -> void:
	## Vertical wall at fixed x, spanning z from -room_d/2 to +room_d/2 with gaps.
	var back := -room_d * 0.5
	var front := room_d * 0.5
	var cuts: Array = gaps.duplicate()
	cuts.sort()
	var cursor := back
	var i := 0
	for g in cuts:
		var gz := float(g)
		var gap_b := gz - gap_half
		var gap_f := gz + gap_half
		if gap_b > cursor + 0.15:
			_add_bound_box(
				"Bound_%s_%d" % [tag, i],
				Vector3(x, 1.0, (cursor + gap_b) * 0.5),
				Vector3(0.22, h, gap_b - cursor)
			)
			i += 1
		cursor = maxf(cursor, gap_f)
	if front > cursor + 0.15:
		_add_bound_box(
			"Bound_%s_%d" % [tag, i],
			Vector3(x, 1.0, (cursor + front) * 0.5),
			Vector3(0.22, h, front - cursor)
		)


func _add_bound_box(box_name: String, pos: Vector3, size: Vector3) -> void:
	if size.x < 0.05 or size.z < 0.05:
		return
	var body := StaticBody3D.new()
	body.name = box_name
	var col := CollisionShape3D.new()
	var shape := BoxShape3D.new()
	shape.size = size
	col.shape = shape
	body.add_child(col)
	body.position = pos
	add_child(body)


func _add_door_trigger(door: Dictionary, room_w: float, room_d: float) -> void:
	## Place a deep Area3D *inside* the room so the player always overlaps it
	## when standing at a doorway (old trigger sat past the solid wall).
	var p: Array = door["pos"]
	var s: Array = door.get("size", [1.6, 2.4, 0.3])
	var px := float(p[0])
	var pz := float(p[2])
	var half_w := room_w * 0.5
	var half_d := room_d * 0.5
	var door_w: float = maxf(float(s[0]), 1.7)
	var door_h: float = maxf(float(s[1]), 2.2)
	# Loop 76: deeper/wider trigger so E works at closed leaf without walking into void
	var depth := 1.85
	var door_w_trig := door_w + 0.25

	var dn := absf(pz + half_d)
	var ds := absf(pz - half_d)
	var dw := absf(px + half_w)
	var de := absf(px - half_w)
	var m := minf(minf(dn, ds), minf(dw, de))

	var pos := Vector3(px, 1.05, pz)
	var shape_size := Vector3(door_w_trig, door_h, depth)
	if is_equal_approx(m, dn):
		# North wall → trigger extends south into room (+Z)
		pos = Vector3(px, 1.05, -half_d + depth * 0.5)
		shape_size = Vector3(door_w_trig, door_h, depth)
	elif is_equal_approx(m, ds):
		pos = Vector3(px, 1.05, half_d - depth * 0.5)
		shape_size = Vector3(door_w_trig, door_h, depth)
	elif is_equal_approx(m, dw):
		pos = Vector3(-half_w + depth * 0.5, 1.05, pz)
		shape_size = Vector3(depth, door_h, door_w_trig)
	else:
		pos = Vector3(half_w - depth * 0.5, 1.05, pz)
		shape_size = Vector3(depth, door_h, door_w_trig)

	var area := Area3D.new()
	area.name = "Door_%s" % str(door.get("target", "room"))
	area.collision_layer = 0
	area.collision_mask = 1
	area.monitoring = true
	area.monitorable = false
	var col := CollisionShape3D.new()
	var shape := BoxShape3D.new()
	shape.size = shape_size
	col.shape = shape
	area.add_child(col)
	area.position = pos
	area.set_meta("door", door)
	add_child(area)