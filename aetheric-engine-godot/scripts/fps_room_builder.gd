extends Node3D
class_name FpsRoomBuilder

const PropsScript := preload("res://scripts/fps_props.gd")

const WALL_OVERLAP := 0.45
const WALL_TRIM_Y := 0.35
const WAINSCOT_H := 1.15

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

	# Solid perimeter with gaps at doorways so the player can stand in a door and press E.
	_add_bounds(w, d, h, doors)

	var features: Array = room.get("features", [])
	if not features.is_empty():
		PropsScript.spawn_features(self, features)

	var props: Array = room.get("props", [])
	if not props.is_empty():
		PropsScript.spawn_all(self, props)

	for door in doors:
		_add_door_trigger(door, w, d)

func _add_skirting(w: float, d: float, room_h: float = 3.5) -> void:
	## Period baseboard — thick enough to mask floor/wall join shimmer.
	var board_h := 0.14
	var thick := 0.055
	var half_w := w * 0.5 - 0.06
	var half_d := d * 0.5 - 0.06
	var boards := [
		[Vector3(0, board_h * 0.5, -half_d), Vector3(w - 0.15, board_h, thick)],
		[Vector3(0, board_h * 0.5, half_d), Vector3(w - 0.15, board_h, thick)],
		[Vector3(-half_w, board_h * 0.5, 0), Vector3(thick, board_h, d - 0.15)],
		[Vector3(half_w, board_h * 0.5, 0), Vector3(thick, board_h, d - 0.15)],
	]
	var wood_tex: Texture2D = _load_texture("res://assets/rooms/textures/victorian/furniture_wood.jpg")
	for i in boards.size():
		var mi := MeshInstance3D.new()
		mi.name = "Skirting_%d" % i
		var mesh := BoxMesh.new()
		mesh.size = boards[i][1]
		mi.mesh = mesh
		var mat := StandardMaterial3D.new()
		mat.roughness = 0.55
		mat.shading_mode = BaseMaterial3D.SHADING_MODE_PER_PIXEL
		if wood_tex:
			mat.albedo_texture = wood_tex
			mat.albedo_color = Color(0.75, 0.62, 0.5)
			mat.uv1_scale = Vector3(2.5, 0.6, 1.0)
		else:
			mat.albedo_color = Color(0.16, 0.09, 0.05)
		mi.material_override = mat
		mi.position = boards[i][0]
		add_child(mi)
	# Picture rail (period hang-line) + ceiling crown moulding
	var crown_y := 2.55
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
		var cmat := StandardMaterial3D.new()
		cmat.roughness = 0.5
		if wood_tex:
			cmat.albedo_texture = wood_tex
			cmat.albedo_color = Color(0.8, 0.68, 0.55)
		else:
			cmat.albedo_color = Color(0.16, 0.09, 0.05)
		cmi.material_override = cmat
		cmi.position = rails[i][0]
		add_child(cmi)
	# Crown moulding just under ceiling (breaks blank ceiling/wall join)
	var mould_y := room_h - 0.1
	var moulds := [
		[Vector3(0, mould_y, -half_d + 0.04), Vector3(w - 0.1, 0.1, 0.12)],
		[Vector3(0, mould_y, half_d - 0.04), Vector3(w - 0.1, 0.1, 0.12)],
		[Vector3(-half_w + 0.04, mould_y, 0), Vector3(0.12, 0.1, d - 0.1)],
		[Vector3(half_w - 0.04, mould_y, 0), Vector3(0.12, 0.1, d - 0.1)],
	]
	for i in moulds.size():
		var mmi := MeshInstance3D.new()
		mmi.name = "CrownMould_%d" % i
		var mm := BoxMesh.new()
		mm.size = moulds[i][1]
		mmi.mesh = mm
		var mmat := StandardMaterial3D.new()
		mmat.roughness = 0.55
		if wood_tex:
			mmat.albedo_texture = wood_tex
			mmat.albedo_color = Color(0.72, 0.6, 0.48)
		else:
			mmat.albedo_color = Color(0.2, 0.12, 0.07)
		mmi.material_override = mmat
		mmi.position = moulds[i][0]
		add_child(mmi)


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
	## Only one room is loaded at a time — a short Victorian passage behind the
	## door reads as a hallway (Myst-style portal), not a solid exterior wall.
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
	var depth := 3.0
	var root := Node3D.new()
	root.name = "DoorPortal"
	var floor_col := Color(0.22, 0.14, 0.09)
	var wall_col := Color(0.38, 0.32, 0.26)
	var paper_col := Color(0.42, 0.38, 0.32)
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
	# Orient local −Z along outward (into the portal)
	if absf(out_dir.x) > 0.5:
		root.rotation_degrees.y = -90.0 if out_dir.x > 0.0 else 90.0
	elif out_dir.z > 0.0:
		root.rotation_degrees.y = 180.0
	else:
		root.rotation_degrees.y = 0.0
	add_child(root)
	var wood_tex: Texture2D = _load_texture("res://assets/rooms/textures/victorian/furniture_wood.jpg")
	# Floor boards
	_add_portal_box(root, Vector3(0, 0.02, -depth * 0.5), Vector3(door_w + 0.2, 0.04, depth), floor_col, wood_tex, Vector3(1.5, 3.0, 1.0))
	# Ceiling (slightly warm plaster)
	_add_portal_box(root, Vector3(0, door_h + 0.08, -depth * 0.5), Vector3(door_w + 0.2, 0.08, depth), Color(0.55, 0.48, 0.38))
	# Side walls: wainscot band + upper paper tone
	var side_x := door_w * 0.5 + 0.05
	for sx in [-side_x, side_x]:
		_add_portal_box(root, Vector3(sx, 0.55, -depth * 0.5), Vector3(0.1, 1.1, depth), Color(0.28, 0.18, 0.12), wood_tex, Vector3(0.8, 2.0, 1.0))
		_add_portal_box(root, Vector3(sx, 1.1 + (door_h - 1.1) * 0.5, -depth * 0.5), Vector3(0.09, door_h - 1.1, depth), paper_col)
		# Chair rail
		_add_portal_box(root, Vector3(sx, 1.12, -depth * 0.5), Vector3(0.12, 0.04, depth), Color(0.2, 0.12, 0.08))
	# Far end: dark-but-not-black wall with a lit picture niche (reads as more house)
	_add_portal_box(root, Vector3(0, door_h * 0.5, -depth), Vector3(door_w + 0.25, door_h + 0.15, 0.1), Color(0.14, 0.11, 0.09))
	# Picture frame silhouette at far end
	_add_portal_box(root, Vector3(0, door_h * 0.55, -depth + 0.06), Vector3(0.55, 0.7, 0.04), Color(0.35, 0.25, 0.12))
	_add_portal_box(root, Vector3(0, door_h * 0.55, -depth + 0.08), Vector3(0.42, 0.55, 0.02), Color(0.25, 0.22, 0.28))
	# Console table silhouette at far end (depth cue)
	_add_portal_box(root, Vector3(0, 0.45, -depth + 0.35), Vector3(0.9, 0.06, 0.35), Color(0.18, 0.1, 0.06))
	_add_portal_box(root, Vector3(-0.35, 0.22, -depth + 0.35), Vector3(0.06, 0.44, 0.06), Color(0.16, 0.09, 0.05))
	_add_portal_box(root, Vector3(0.35, 0.22, -depth + 0.35), Vector3(0.06, 0.44, 0.06), Color(0.16, 0.09, 0.05))
	# Warm corridor lights (mid + far) so passage is readable, not a black slab
	var dim := OmniLight3D.new()
	dim.light_color = Color(1.0, 0.85, 0.6)
	dim.light_energy = 0.55
	dim.omni_range = depth + 1.5
	dim.position = Vector3(0, door_h * 0.65, -depth * 0.35)
	root.add_child(dim)
	var far_l := OmniLight3D.new()
	far_l.light_color = Color(1.0, 0.78, 0.5)
	far_l.light_energy = 0.4
	far_l.omni_range = 2.2
	far_l.position = Vector3(0, door_h * 0.55, -depth + 0.5)
	root.add_child(far_l)


func _add_portal_box(
	parent: Node3D,
	pos: Vector3,
	size: Vector3,
	color: Color,
	tex: Texture2D = null,
	uv_scale: Vector3 = Vector3(1, 1, 1)
) -> void:
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
	mi.position = pos
	parent.add_child(mi)


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
	var join := WAINSCOT_H
	var paper_overlap := 0.04  # paper tucks slightly behind rail
	var upper_h := cover_h - join + paper_overlap
	var upper_y := join - paper_overlap * 0.5 + upper_h * 0.5 - WALL_TRIM_Y
	var lower_y := join * 0.5
	# Wall normal (into room): for yaw 0 plane faces +Z from wall at -d/2, so inward is +Z.
	var yaw_rad := deg_to_rad(yaw_deg)
	var inward := Vector3(sin(yaw_rad), 0.0, cos(yaw_rad)) * 0.012

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
			mat.uv1_scale = Vector3(width * 0.22, depth * 0.22, 1.0)
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

func _add_chair_rail(
	wall_name: String,
	wall_pos: Vector3,
	yaw_deg: float,
	cover_w: float,
	join_y: float,
	inward: Vector3,
) -> void:
	## Mahogany dado rail — covers wallpaper/wainscot join (period + anti z-fight).
	var mi := MeshInstance3D.new()
	mi.name = wall_name + "ChairRail"
	var mesh := BoxMesh.new()
	mesh.size = Vector3(cover_w - 0.1, 0.08, 0.05)
	mi.mesh = mesh
	var mat := StandardMaterial3D.new()
	mat.roughness = 0.5
	var wood: Texture2D = _load_texture("res://assets/rooms/textures/victorian/furniture_wood.jpg")
	if wood:
		mat.albedo_texture = wood
		mat.albedo_color = Color(0.9, 0.82, 0.72)
		mat.uv1_scale = Vector3(cover_w * 0.3, 0.4, 1.0)
	else:
		mat.albedo_color = Color(0.22, 0.12, 0.07)
	mi.material_override = mat
	var yaw_rad := deg_to_rad(yaw_deg)
	var extra := Vector3(sin(yaw_rad), 0.0, cos(yaw_rad)) * 0.022
	mi.position = Vector3(wall_pos.x, join_y, wall_pos.z) + inward + extra
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
				# Smaller scale = less aggressive tiling / fewer obvious vertical seams
				mat.uv1_scale = Vector3(plane_size.x * 0.22, plane_size.y * 0.22, 1.0)
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
	var gap_half := 0.95  # half-width of walkable opening at each door

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
	var depth := 1.6  # how far into the room the trigger extends

	var dn := absf(pz + half_d)
	var ds := absf(pz - half_d)
	var dw := absf(px + half_w)
	var de := absf(px - half_w)
	var m := minf(minf(dn, ds), minf(dw, de))

	var pos := Vector3(px, 1.05, pz)
	var shape_size := Vector3(door_w, door_h, depth)
	if is_equal_approx(m, dn):
		# North wall → trigger extends south into room (+Z)
		pos = Vector3(px, 1.05, -half_d + depth * 0.5)
		shape_size = Vector3(door_w, door_h, depth)
	elif is_equal_approx(m, ds):
		pos = Vector3(px, 1.05, half_d - depth * 0.5)
		shape_size = Vector3(door_w, door_h, depth)
	elif is_equal_approx(m, dw):
		pos = Vector3(-half_w + depth * 0.5, 1.05, pz)
		shape_size = Vector3(depth, door_h, door_w)
	else:
		pos = Vector3(half_w - depth * 0.5, 1.05, pz)
		shape_size = Vector3(depth, door_h, door_w)

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