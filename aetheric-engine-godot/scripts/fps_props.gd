extends RefCounted
class_name FpsProps

## Victorian 1856 furniture + set dressing for Richmond House (hybrid Myst approach).
## Painted billboards for hero pieces; multi-part meshes for architecture/function props.

const MAHOGANY := Color(0.30, 0.14, 0.08)
const MAHOGANY_DARK := Color(0.18, 0.09, 0.05)
const OAK := Color(0.42, 0.28, 0.14)
const VELVET_RED := Color(0.55, 0.12, 0.16)
const VELVET_GREEN := Color(0.24, 0.34, 0.24)
const VELVET_GREEN_DEEP := Color(0.18, 0.28, 0.18)
const LINEN := Color(0.78, 0.72, 0.58)
const PAPER := Color(0.84, 0.78, 0.62)
const BRASS := Color(0.74, 0.58, 0.28)
const COPPER := Color(0.72, 0.42, 0.22)
const IRON := Color(0.22, 0.22, 0.24)
const MARBLE := Color(0.82, 0.80, 0.76)
const INK := Color(0.10, 0.10, 0.14)
const CANDLE := Color(0.95, 0.82, 0.45)
const CREAM := Color(0.90, 0.86, 0.76)
const LEAF := Color(0.22, 0.42, 0.18)
const LEAF_DARK := Color(0.12, 0.28, 0.12)
# g high enough to avoid wood auto-texture (was brown → furniture_wood barrels)
const CLAY := Color(0.78, 0.48, 0.28)
const STONE := Color(0.55, 0.52, 0.46)
const CHALK := Color(0.35, 0.38, 0.32)

const TEX_WOOD := "res://assets/rooms/textures/victorian/furniture_wood.jpg"
const TEX_WOOD_MAHOGANY := "res://assets/rooms/textures/wood/wood_mahogany.jpg"
const TEX_WOOD_OAK := "res://assets/rooms/textures/wood/wood_oak.jpg"
const TEX_WOOD_PINE := "res://assets/rooms/textures/wood/wood_pine.jpg"
const TEX_WOOD_SCRUBBED := "res://assets/rooms/textures/wood/wood_scrubbed.jpg"
const TEX_WOOD_EBONY := "res://assets/rooms/textures/wood/wood_ebony.jpg"
const TEX_VELVET_RED := "res://assets/rooms/textures/victorian/fabric_velvet_red.jpg"
const TEX_VELVET_GREEN := "res://assets/rooms/textures/victorian/fabric_velvet_green.jpg"
const TEX_VELVET_GREEN_DEEP := "res://assets/rooms/textures/victorian/fabric_velvet_green_deep.jpg"
const TEX_WALLPAPER := "res://assets/rooms/textures/victorian/wallpaper_drawing.jpg"
const TEX_COPPER := "res://assets/rooms/textures/victorian/metal_copper.jpg"
const TEX_IRON := "res://assets/rooms/textures/victorian/metal_iron.jpg"
const TEX_BRASS := "res://assets/rooms/textures/victorian/metal_brass.jpg"
const TEX_LINEN := "res://assets/rooms/textures/victorian/fabric_linen.jpg"
const TEX_STONE := "res://assets/rooms/textures/victorian/stone_flag.jpg"
const TEX_PLASTER := "res://assets/rooms/textures/victorian/plaster_cream.jpg"
const TEX_MARBLE := "res://assets/rooms/textures/victorian/marble.jpg"

# Victorian wall art — NEVER use room photos as paintings (reads as wrong window).
const ART_LANDSCAPES := [
	"res://assets/rooms/textures/art/landscape_pastoral.jpg",
	"res://assets/rooms/textures/art/landscape_pastoral2.jpg",
	"res://assets/rooms/textures/art/landscape_seascape.jpg",
	"res://assets/rooms/textures/art/landscape_storm.jpg",
	"res://assets/rooms/textures/art/landscape_park.jpg",
]
const ART_STILL_LIFES := [
	"res://assets/rooms/textures/art/still_life_fruit.jpg",
	"res://assets/rooms/textures/art/still_life_dark.jpg",
]
const VIEW_EXTERIORS := [
	"res://assets/rooms/textures/views/view_garden.jpg",
	"res://assets/rooms/textures/views/view_garden2.jpg",
	"res://assets/rooms/textures/views/view_yard.jpg",
	"res://assets/rooms/textures/views/view_street.jpg",
	"res://assets/rooms/textures/views/view_night.jpg",
]

# Cached procedural textures (performance: generate once per process)
static var _tex_cache: Dictionary = {}

static func spawn_all(parent: Node3D, props: Array) -> void:
	var root := Node3D.new()
	root.name = "Props"
	parent.add_child(root)
	for prop in props:
		var node := _build(prop)
		if node:
			root.add_child(node)

static func spawn_features(parent: Node3D, features: Array) -> void:
	var root := Node3D.new()
	root.name = "Features"
	parent.add_child(root)
	for feat in features:
		var node := _build_feature(feat)
		if node:
			root.add_child(node)

static func _build(prop: Dictionary) -> Node3D:
	var kind: String = prop.get("kind", "")
	var node: Node3D = null
	match kind:
		"desk":
			node = _make_desk(prop)
		"chair":
			node = _make_chair(prop)
		"armchair":
			node = _make_armchair(prop)
		"sofa":
			node = _make_sofa(prop)
		"ottoman":
			node = _make_ottoman(prop)
		"rug":
			node = _make_rug(prop)
		"bookshelf":
			node = _make_bookshelf(prop)
		"crock_shelf":
			node = _make_crock_shelf(prop)
		"tool_shelf":
			node = _make_tool_shelf(prop)
		"side_table":
			node = _make_side_table(prop)
		"fireplace":
			node = _make_fireplace(prop)
		"hall_table":
			node = _make_hall_table(prop)
		"workbench":
			node = _make_workbench(prop)
		"machine":
			node = _make_machine(prop)
		"aetheric_machine":
			node = _make_aetheric_machine(prop)
		"kitchen_range":
			node = _make_kitchen_range(prop)
		"dresser":
			node = _make_dresser(prop)
		"sink":
			node = _make_sink(prop)
		"prep_table":
			node = _make_prep_table(prop)
		"coat_stand":
			node = _make_coat_stand(prop)
		"umbrella_stand":
			node = _make_umbrella_stand(prop)
		"plant":
			node = _make_plant(prop)
		"tool_rack":
			node = _make_tool_rack(prop)
		"crate":
			node = _make_crate(prop)
		"stool":
			node = _make_stool(prop)
		"copper_pot":
			node = _make_copper_pot(prop)
		"pot_rack":
			node = _make_pot_rack(prop)
		"wall_shelf":
			node = _make_wall_shelf(prop)
		"wall_vine":
			node = _make_wall_vine(prop)
		"floor_path":
			node = _make_floor_path(prop)
		"wall_sconce":
			node = _make_wall_sconce(prop)
		"chandelier":
			node = _make_chandelier(prop)
		"chalk_board":
			node = _make_chalk_board(prop)
		"billboard_prop":
			node = _make_billboard_prop(prop)
		_:
			return null
	var pos: Array = prop.get("pos", [0, 0, 0])
	node.position = Vector3(pos[0], pos[1], pos[2])
	node.rotation_degrees.y = prop.get("yaw", 0.0)
	return node

static func _build_feature(feat: Dictionary) -> Node3D:
	match feat.get("kind", ""):
		"window":
			return _make_window(feat)
		"door_frame":
			return _make_door_frame(feat)
		"mirror":
			return _make_mirror(feat)
		"painting":
			return _make_painting(feat)
		"glass_wall":
			return _make_glass_wall(feat)
		_:
			return null

# ─── Drawing-room / gentry furniture ─────────────────────────────────────────

static func _make_desk(prop: Dictionary) -> Node3D:
	## Partner-style writing desk: leather top, pedestals, brass pulls, full still-life.
	if prop.get("billboard", false) and prop.get("texture", "") != "":
		return _make_billboard_prop(prop)
	var root := Node3D.new()
	root.name = "Desk"
	var top_y := 0.78
	# Top + edge banding
	_add_box(root, Vector3(0, top_y, 0), Vector3(1.55, 0.055, 0.82), MAHOGANY, true, 0.45)
	_add_box(root, Vector3(0, top_y + 0.03, 0), Vector3(1.42, 0.014, 0.7), Color(0.10, 0.16, 0.10), false, 0.72)
	_add_box(root, Vector3(0, top_y - 0.04, 0), Vector3(1.52, 0.03, 0.8), MAHOGANY_DARK, false, 0.4)
	# Kneehole + twin pedestals
	_add_box(root, Vector3(-0.52, 0.38, 0), Vector3(0.42, 0.72, 0.74), MAHOGANY_DARK, true, 0.42)
	_add_box(root, Vector3(0.52, 0.38, 0), Vector3(0.42, 0.72, 0.74), MAHOGANY_DARK, true, 0.42)
	# Drawers (3 per pedestal)
	for side in [-1.0, 1.0]:
		for i in 3:
			var dy := 0.18 + i * 0.2
			_add_box(root, Vector3(side * 0.52, dy, 0.35), Vector3(0.36, 0.16, 0.05), MAHOGANY, false, 0.48)
			_add_cylinder(root, Vector3(side * 0.52, dy, 0.39), 0.014, 0.022, BRASS, false, 0.3, true)
	# Center drawer over kneehole
	_add_box(root, Vector3(0, top_y - 0.12, 0.34), Vector3(0.55, 0.12, 0.05), MAHOGANY, false, 0.48)
	_add_cylinder(root, Vector3(0, top_y - 0.12, 0.38), 0.014, 0.022, BRASS, false, 0.3, true)
	# Turned legs under pedestals
	for lx in [-0.62, -0.42, 0.42, 0.62]:
		for lz in [-0.28, 0.28]:
			_add_cylinder(root, Vector3(lx, 0.08, lz), 0.035, 0.14, MAHOGANY_DARK, true)
			_add_cylinder(root, Vector3(lx, 0.02, lz), 0.05, 0.035, MAHOGANY, true)
	# Back gallery shelf
	_add_box(root, Vector3(0, top_y + 0.22, -0.32), Vector3(1.4, 0.35, 0.06), MAHOGANY, false, 0.45)
	_add_box(root, Vector3(0, top_y + 0.08, -0.28), Vector3(1.35, 0.04, 0.2), MAHOGANY_DARK, false, 0.45)
	# Still life
	_add_box(root, Vector3(0.28, top_y + 0.04, 0.12), Vector3(0.34, 0.012, 0.24), PAPER, false)
	_add_box(root, Vector3(0.32, top_y + 0.05, 0.08), Vector3(0.22, 0.01, 0.16), PAPER.darkened(0.05), false)
	_add_box(root, Vector3(-0.25, top_y + 0.04, -0.05), Vector3(0.28, 0.01, 0.2), PAPER, false)
	_add_box(root, Vector3(0.05, top_y + 0.06, -0.12), Vector3(0.055, 0.05, 0.055), INK, false)
	_add_cylinder(root, Vector3(0.12, top_y + 0.09, -0.08), 0.012, 0.14, MAHOGANY, false)
	_add_cylinder(root, Vector3(-0.35, top_y + 0.08, 0.15), 0.03, 0.18, CANDLE, false)
	_add_cylinder(root, Vector3(-0.35, top_y + 0.01, 0.15), 0.05, 0.04, BRASS, false, 0.3, true)
	_add_box(root, Vector3(0.45, top_y + 0.05, -0.15), Vector3(0.12, 0.04, 0.08), Color(0.55, 0.12, 0.1), false)
	_add_contact_shadow(root, 0.9, 0.55)
	var flame := OmniLight3D.new()
	flame.light_color = Color(1.0, 0.78, 0.42)
	flame.light_energy = 0.45
	flame.omni_range = 2.6
	flame.position = Vector3(-0.35, top_y + 0.28, 0.15)
	root.add_child(flame)
	return root

static func _make_chair(prop: Dictionary) -> Node3D:
	## Victorian side chair: balloon-ish back, upholstered seat, carved rail, splayed legs, stretcher.
	if prop.get("billboard", false) and prop.get("texture", "") != "":
		return _make_billboard_prop(prop)
	var root := Node3D.new()
	root.name = "Chair"
	var fabric: Color = prop.get("fabric", VELVET_GREEN)
	# Seat box + cushion
	_add_box(root, Vector3(0, 0.44, 0.02), Vector3(0.52, 0.07, 0.5), MAHOGANY, true, 0.48)
	_add_box(root, Vector3(0, 0.5, 0.02), Vector3(0.48, 0.07, 0.46), fabric, true, 0.9)
	_add_box(root, Vector3(0, 0.55, 0.02), Vector3(0.44, 0.035, 0.42), fabric.darkened(0.1), false, 0.92)
	# Nailhead band
	for i in 6:
		var nx := -0.2 + i * 0.08
		_add_cylinder(root, Vector3(nx, 0.47, 0.26), 0.01, 0.015, BRASS, false, 0.3, true)
	# Back frame
	_add_box(root, Vector3(0, 0.95, -0.2), Vector3(0.5, 0.85, 0.06), MAHOGANY, true, 0.45)
	_add_box(root, Vector3(0, 1.28, -0.18), Vector3(0.46, 0.14, 0.07), MAHOGANY_DARK, false, 0.42)
	# Pierced splat suggestion
	_add_box(root, Vector3(0, 0.95, -0.17), Vector3(0.18, 0.55, 0.03), MAHOGANY_DARK, false, 0.5)
	_add_box(root, Vector3(-0.12, 0.95, -0.17), Vector3(0.04, 0.5, 0.03), MAHOGANY, false, 0.5)
	_add_box(root, Vector3(0.12, 0.95, -0.17), Vector3(0.04, 0.5, 0.03), MAHOGANY, false, 0.5)
	# Side uprights
	for sx in [-1.0, 1.0]:
		_add_box(root, Vector3(sx * 0.23, 0.85, -0.12), Vector3(0.05, 0.7, 0.08), MAHOGANY, true, 0.48)
	# Cabriole-ish front legs (tapered stacked cylinders) + rear legs
	for offset in [Vector3(-0.2, 0.22, 0.18), Vector3(0.2, 0.22, 0.18)]:
		_add_cylinder(root, offset, 0.032, 0.42, MAHOGANY_DARK, true)
		_add_cylinder(root, Vector3(offset.x, 0.02, offset.z), 0.045, 0.04, MAHOGANY, true)
	for offset in [Vector3(-0.2, 0.22, -0.18), Vector3(0.2, 0.22, -0.18)]:
		_add_cylinder(root, offset, 0.028, 0.42, MAHOGANY_DARK, true)
		_add_cylinder(root, Vector3(offset.x, 0.02, offset.z), 0.04, 0.035, MAHOGANY, true)
	# H-stretcher
	_add_box(root, Vector3(0, 0.14, 0.0), Vector3(0.38, 0.03, 0.03), MAHOGANY, false, 0.5)
	_add_box(root, Vector3(-0.19, 0.14, 0.0), Vector3(0.03, 0.03, 0.32), MAHOGANY, false, 0.5)
	_add_box(root, Vector3(0.19, 0.14, 0.0), Vector3(0.03, 0.03, 0.32), MAHOGANY, false, 0.5)
	_add_contact_shadow(root, 0.42, 0.4)
	return root

static func _make_armchair(prop: Dictionary) -> Node3D:
	## Wing chair: deep seat, buttoned back suggestion, scrolled arms, claw feet.
	if prop.get("billboard", false) and prop.get("texture", "") != "":
		return _make_billboard_prop(prop)
	var root := Node3D.new()
	root.name = "Armchair"
	var fabric: Color = prop.get("fabric", VELVET_RED)
	# Seat base + plush cushion
	_add_box(root, Vector3(0, 0.32, 0.06), Vector3(0.95, 0.18, 0.88), MAHOGANY_DARK, true, 0.42)
	_add_box(root, Vector3(0, 0.46, 0.08), Vector3(0.88, 0.16, 0.78), fabric, true, 0.9)
	_add_box(root, Vector3(0, 0.56, 0.1), Vector3(0.78, 0.08, 0.68), fabric.darkened(0.12), false, 0.92)
	# Button tufts on seat
	for bx in [-0.2, 0.0, 0.2]:
		for bz in [-0.1, 0.12]:
			_add_cylinder(root, Vector3(bx, 0.6, bz), 0.018, 0.02, fabric.darkened(0.25), false, 0.95)
	# High back + wings
	_add_box(root, Vector3(0, 0.95, -0.3), Vector3(0.9, 0.95, 0.16), fabric, true, 0.9)
	_add_box(root, Vector3(0, 1.35, -0.28), Vector3(0.82, 0.18, 0.12), MAHOGANY, false, 0.42)
	# Wings
	for sx in [-1.0, 1.0]:
		_add_box(root, Vector3(sx * 0.42, 1.05, -0.12), Vector3(0.14, 0.7, 0.45), fabric, true, 0.88)
	# Arms
	for sx in [-1.0, 1.0]:
		_add_box(root, Vector3(sx * 0.42, 0.62, 0.08), Vector3(0.16, 0.22, 0.72), fabric, true, 0.88)
		_add_box(root, Vector3(sx * 0.42, 0.74, 0.18), Vector3(0.14, 0.1, 0.45), fabric.darkened(0.08), false, 0.9)
		_add_cylinder(root, Vector3(sx * 0.4, 0.55, 0.35), 0.06, 0.12, MAHOGANY, false, 0.45)
	# Legs + feet
	for sx in [-1.0, 1.0]:
		_add_cylinder(root, Vector3(sx * 0.36, 0.14, 0.3), 0.04, 0.26, MAHOGANY_DARK, true)
		_add_cylinder(root, Vector3(sx * 0.36, 0.02, 0.3), 0.055, 0.04, MAHOGANY, true)
		_add_cylinder(root, Vector3(sx * 0.34, 0.14, -0.3), 0.038, 0.26, MAHOGANY_DARK, true)
		_add_cylinder(root, Vector3(sx * 0.34, 0.02, -0.3), 0.05, 0.04, MAHOGANY, true)
	# Skirt
	_add_box(root, Vector3(0, 0.2, 0.08), Vector3(0.88, 0.08, 0.82), MAHOGANY_DARK, false, 0.42)
	_add_contact_shadow(root, 0.72, 0.68)
	return root

static func _make_ottoman(prop: Dictionary) -> Node3D:
	## Low tufted footstool — sits in front of sofa, never under it.
	var root := Node3D.new()
	root.name = "Ottoman"
	var fabric: Color = prop.get("fabric", VELVET_GREEN.darkened(0.08))
	var w: float = float(prop.get("width", 0.72))
	var d: float = float(prop.get("depth", 0.5))
	# Short mahogany base + padded top
	_add_box(root, Vector3(0, 0.16, 0), Vector3(w, 0.1, d), MAHOGANY_DARK, true, 0.42)
	_add_box(root, Vector3(0, 0.28, 0), Vector3(w * 0.96, 0.16, d * 0.96), fabric, true, 0.9)
	_add_box(root, Vector3(0, 0.38, 0), Vector3(w * 0.88, 0.06, d * 0.88), fabric.darkened(0.1), false, 0.92)
	# Button tufts
	for bx in [-0.15, 0.0, 0.15]:
		for bz in [-0.08, 0.08]:
			_add_cylinder(root, Vector3(bx * w / 0.72, 0.42, bz * d / 0.5), 0.016, 0.02, fabric.darkened(0.22), false, 0.95)
	# Four short turned feet
	for sx in [-1.0, 1.0]:
		for sz in [-1.0, 1.0]:
			_add_cylinder(root, Vector3(sx * w * 0.38, 0.06, sz * d * 0.35), 0.035, 0.12, MAHOGANY, true)
	_add_contact_shadow(root, w * 0.55, d * 0.55)
	return root


static func _make_sofa(prop: Dictionary) -> Node3D:
	## Chesterfield-style sofa: buttoned back, rolled arms, carved feet, skirt.
	if prop.get("billboard", false) and prop.get("texture", "") != "":
		return _make_billboard_prop(prop)
	var root := Node3D.new()
	root.name = "Sofa"
	var width: float = prop.get("width", 2.3)
	var fabric: Color = prop.get("fabric", VELVET_GREEN)
	# Base frame
	_add_box(root, Vector3(0, 0.22, 0.08), Vector3(width, 0.14, 0.92), MAHOGANY_DARK, true, 0.4)
	# Seat body + 3 cushions
	_add_box(root, Vector3(0, 0.4, 0.1), Vector3(width - 0.08, 0.2, 0.86), fabric, true, 0.9)
	for i in 3:
		var cx: float = (i - 1) * (width * 0.28)
		_add_box(root, Vector3(cx, 0.54, 0.12), Vector3(width * 0.26, 0.12, 0.72), fabric.darkened(0.08), false, 0.92)
		# button row
		for j in 2:
			_add_cylinder(root, Vector3(cx + (j - 0.5) * 0.12, 0.61, 0.05 + j * 0.15), 0.02, 0.02, fabric.darkened(0.22), false, 0.95)
	# Back with button grid
	_add_box(root, Vector3(0, 0.85, -0.3), Vector3(width, 0.78, 0.18), fabric, true, 0.9)
	_add_box(root, Vector3(0, 1.18, -0.28), Vector3(width - 0.1, 0.12, 0.1), MAHOGANY, false, 0.42)
	for i in 5:
		for j in 3:
			var bx := (i - 2) * (width * 0.16)
			var by := 0.7 + j * 0.18
			_add_cylinder(root, Vector3(bx, by, -0.2), 0.018, 0.02, fabric.darkened(0.25), false, 0.95)
	# Rolled arms
	for sx in [-1.0, 1.0]:
		_add_box(root, Vector3(sx * (width * 0.5 - 0.12), 0.6, 0.06), Vector3(0.22, 0.48, 0.86), fabric, true, 0.88)
		_add_cylinder(root, Vector3(sx * (width * 0.5 - 0.12), 0.82, 0.2), 0.11, 0.35, fabric.darkened(0.05), false, 0.9)
		_add_cylinder(root, Vector3(sx * (width * 0.5 - 0.12), 0.55, 0.38), 0.07, 0.14, MAHOGANY, false, 0.45)
	# Turned legs
	for x in range(-2, 3):
		var lx := x * (width * 0.2)
		_add_cylinder(root, Vector3(lx, 0.08, 0.32), 0.035, 0.14, MAHOGANY, true)
		_add_cylinder(root, Vector3(lx, 0.08, -0.28), 0.035, 0.14, MAHOGANY, true)
		_add_cylinder(root, Vector3(lx, 0.02, 0.32), 0.045, 0.03, MAHOGANY_DARK, true)
	_add_contact_shadow(root, width * 0.5, 0.55)
	return root

static func _make_rug(prop: Dictionary) -> Node3D:
	var root := Node3D.new()
	root.name = "Rug"
	var size: Array = prop.get("size", [4.6, 3.4])
	var tex_path: String = prop.get("texture", "")
	var body := Node3D.new()
	var mesh := PlaneMesh.new()
	mesh.orientation = PlaneMesh.FACE_Y
	mesh.size = Vector2(size[0], size[1])
	var mi := MeshInstance3D.new()
	mi.mesh = mesh
	var mat := StandardMaterial3D.new()
	if tex_path != "":
		var tex: Texture2D = _load_tex(tex_path)
		if tex:
			mat.albedo_texture = tex
			mat.uv1_scale = Vector3(size[0] * 0.35, size[1] * 0.35, 1.0)
	mat.roughness = 0.95
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_PER_PIXEL
	mi.material_override = mat
	body.add_child(mi)
	# Lift rug off floor to stop z-fight shimmer when walking
	body.position = Vector3(0, 0.035, 0)
	root.add_child(body)
	return root

static func _make_bookshelf(prop: Dictionary) -> Node3D:
	## Open shelves with leather/cloth spines — period library, not Minecraft cubes.
	## Case is oak (not same mahogany as chairs/tables).
	var root := Node3D.new()
	root.name = "Bookshelf"
	var width: float = prop.get("width", 1.7)
	var height: float = prop.get("height", 2.5)
	var depth: float = prop.get("depth", 0.36)
	var seed0: int = int(prop.get("seed", 0))
	var case_col := Color(0.48, 0.34, 0.18)  # oak case
	var case_dark := Color(0.36, 0.24, 0.12)
	# Back panel (lighter wood so it doesn't read as a black monolith)
	_add_box(root, Vector3(0, height * 0.5, -depth * 0.35), Vector3(width, height, 0.04), case_col, true, 0.55)
	# Sides
	_add_box(root, Vector3(-width * 0.5 + 0.03, height * 0.5, 0), Vector3(0.06, height, depth), case_dark, true, 0.52)
	_add_box(root, Vector3(width * 0.5 - 0.03, height * 0.5, 0), Vector3(0.06, height, depth), case_dark, true, 0.52)
	# Crown + base
	_add_box(root, Vector3(0, height - 0.05, 0.02), Vector3(width + 0.06, 0.1, depth + 0.06), case_col, false, 0.5)
	_add_box(root, Vector3(0, 0.06, 0.02), Vector3(width + 0.04, 0.12, depth + 0.04), case_dark, true, 0.5)
	# Shelves + dense book rows (varied width/height/spine colour per seed)
	for i in 5:
		var y: float = 0.38 + i * (height - 0.55) / 4.0
		_add_box(root, Vector3(0, y, 0.02), Vector3(width * 0.92, 0.04, depth * 0.9), Color(0.5, 0.36, 0.2), false, 0.55)
		var x := -width * 0.38
		var bi := 0
		while x < width * 0.38:
			var bw: float = 0.055 + float((i + bi + seed0) % 5) * 0.022
			var bh: float = 0.14 + float((i * 3 + bi + seed0) % 5) * 0.035
			_add_box(
				root,
				Vector3(x + bw * 0.5, y + 0.02 + bh * 0.5, depth * 0.05),
				Vector3(bw * 0.92, bh, depth * 0.55),
				_book_color(i + bi + seed0 * 7),
				false,
				0.72
			)
			# Occasional gilt band on spine
			if (bi + i + seed0) % 5 == 0:
				_add_box(
					root,
					Vector3(x + bw * 0.5, y + 0.02 + bh * 0.55, depth * 0.22),
					Vector3(bw * 0.7, 0.012, 0.01),
					BRASS,
					false,
					0.35
				)
			x += bw + 0.008
			bi += 1
	_add_contact_shadow(root, width * 0.55, depth * 0.7)
	return root


static func _make_crock_shelf(prop: Dictionary) -> Node3D:
	## Kitchen open shelf: plates, crocks, copper — never library books.
	var root := Node3D.new()
	root.name = "CrockShelf"
	var width: float = float(prop.get("width", 1.4))
	var height: float = float(prop.get("height", 1.7))
	var depth: float = float(prop.get("depth", 0.32))
	var seed0: int = int(prop.get("seed", 1))
	_add_box(root, Vector3(0, height * 0.5, -depth * 0.35), Vector3(width, height, 0.04), OAK, true, 0.52)
	_add_box(root, Vector3(-width * 0.48, height * 0.5, 0), Vector3(0.05, height, depth), OAK.darkened(0.08), true, 0.5)
	_add_box(root, Vector3(width * 0.48, height * 0.5, 0), Vector3(0.05, height, depth), OAK.darkened(0.08), true, 0.5)
	_add_box(root, Vector3(0, 0.05, 0.01), Vector3(width + 0.04, 0.1, depth + 0.04), OAK.darkened(0.12), true, 0.5)
	_add_box(root, Vector3(0, height - 0.04, 0.01), Vector3(width + 0.05, 0.08, depth + 0.04), OAK, false, 0.5)
	var shelves := 3
	for i in shelves:
		var y: float = 0.35 + float(i) * ((height - 0.5) / float(maxi(shelves - 1, 1)))
		_add_box(root, Vector3(0, y, 0.02), Vector3(width * 0.9, 0.035, depth * 0.88), OAK.lightened(0.05), false, 0.55)
		var n := 3 + (i + seed0) % 2
		for j in n:
			var x := -width * 0.32 + float(j) * (width * 0.64 / float(maxi(n - 1, 1)))
			var kind := (i * 3 + j + seed0) % 4
			if kind == 0:
				_add_cylinder(root, Vector3(x, y + 0.04, 0.04), 0.09, 0.03, CREAM, false, 0.75)
			elif kind == 1:
				_add_cylinder(root, Vector3(x, y + 0.1, 0.04), 0.07, 0.16, CLAY if (j + seed0) % 2 == 0 else CLAY.lightened(0.08), false, 0.8)
			elif kind == 2:
				_add_cylinder(root, Vector3(x, y + 0.09, 0.04), 0.08, 0.12, COPPER, false, 0.35, true)
			else:
				_add_cylinder(root, Vector3(x, y + 0.05, 0.04), 0.1, 0.04, CREAM.darkened(0.08), false, 0.7)
				_add_cylinder(root, Vector3(x, y + 0.12, 0.04), 0.05, 0.1, CREAM.darkened(0.05), false, 0.75)
	_add_contact_shadow(root, width * 0.5, depth * 0.6)
	return root


static func _make_tool_shelf(prop: Dictionary) -> Node3D:
	## Workshop shelf: timber, parts, tools — not books.
	var root := Node3D.new()
	root.name = "ToolShelf"
	var width: float = float(prop.get("width", 1.3))
	var height: float = float(prop.get("height", 1.9))
	var depth: float = float(prop.get("depth", 0.34))
	var seed0: int = int(prop.get("seed", 2))
	_add_box(root, Vector3(0, height * 0.5, -depth * 0.35), Vector3(width, height, 0.04), MAHOGANY_DARK, true, 0.55)
	_add_box(root, Vector3(-width * 0.48, height * 0.5, 0), Vector3(0.05, height, depth), OAK.darkened(0.15), true, 0.55)
	_add_box(root, Vector3(width * 0.48, height * 0.5, 0), Vector3(0.05, height, depth), OAK.darkened(0.15), true, 0.55)
	_add_box(root, Vector3(0, 0.05, 0.01), Vector3(width + 0.04, 0.1, depth + 0.04), MAHOGANY_DARK, true, 0.5)
	for i in 4:
		var y: float = 0.32 + float(i) * ((height - 0.45) / 3.0)
		_add_box(root, Vector3(0, y, 0.02), Vector3(width * 0.9, 0.035, depth * 0.88), OAK, false, 0.55)
		# Timber scrap / tool / box variety
		var n := 2 + (i + seed0) % 2
		for j in n:
			var x := -width * 0.28 + float(j) * (width * 0.55 / float(maxi(n - 1, 1)))
			var kind := (i + j + seed0) % 3
			if kind == 0:
				_add_box(root, Vector3(x, y + 0.06, 0.04), Vector3(0.28, 0.06, 0.12), OAK.lightened(0.1), false, 0.6)
			elif kind == 1:
				_add_box(root, Vector3(x, y + 0.08, 0.04), Vector3(0.18, 0.12, 0.14), MAHOGANY, false, 0.5)
				_add_cylinder(root, Vector3(x, y + 0.12, 0.12), 0.015, 0.2, IRON, false, 0.4)
			else:
				_add_cylinder(root, Vector3(x, y + 0.1, 0.04), 0.06, 0.14, COPPER.darkened(0.1), false, 0.4, true)
	_add_contact_shadow(root, width * 0.5, depth * 0.6)
	return root

static func _make_side_table(prop: Dictionary) -> Node3D:
	## Tripod pedestal table with gallery rim; seed varies top dressing.
	if prop.get("billboard", false) and prop.get("texture", "") != "":
		return _make_billboard_prop(prop)
	var root := Node3D.new()
	root.name = "SideTable"
	var seed0: int = int(prop.get("seed", 0))
	# Top with rim
	_add_cylinder(root, Vector3(0, 0.62, 0), 0.3, 0.04, MAHOGANY, true)
	_add_cylinder(root, Vector3(0, 0.65, 0), 0.31, 0.02, MAHOGANY_DARK, false)
	# Turned pedestal
	_add_cylinder(root, Vector3(0, 0.48, 0), 0.08, 0.12, MAHOGANY, true)
	_add_cylinder(root, Vector3(0, 0.32, 0), 0.045, 0.28, MAHOGANY_DARK, true)
	_add_cylinder(root, Vector3(0, 0.14, 0), 0.1, 0.08, MAHOGANY, true)
	# Tripartite feet
	for a in [0.0, 120.0, 240.0]:
		var rad := deg_to_rad(a)
		_add_box(root, Vector3(cos(rad) * 0.16, 0.04, sin(rad) * 0.16), Vector3(0.22, 0.04, 0.06), MAHOGANY_DARK, true, 0.45)
	# Top dressing varies by seed (lamp / books / vase) — no identical still-lifes
	var style := seed0 % 3
	if style == 0:
		_add_cylinder(root, Vector3(0, 0.69, 0), 0.09, 0.06, BRASS, false, 0.28, true)
		_add_cylinder(root, Vector3(0, 0.8, 0), 0.028, 0.18, BRASS, false, 0.3, true)
		_add_cylinder(root, Vector3(0, 0.92, 0), 0.05, 0.04, BRASS, false, 0.28, true)
		_add_cylinder(root, Vector3(0, 1.08, 0), 0.04, 0.3, Color(0.9, 0.86, 0.72), false, 0.45)
		_add_cylinder(root, Vector3(0, 1.25, 0), 0.03, 0.035, BRASS, false, 0.28, true)
		_add_sphere_blob(root, Vector3(0, 0.98, 0), 0.03, Color(1.0, 0.8, 0.4))
		_add_box(root, Vector3(0.12, 0.68, 0.08), Vector3(0.12, 0.14, 0.09), _book_color(2 + seed0), false)
	elif style == 1:
		_add_box(root, Vector3(-0.05, 0.7, 0.02), Vector3(0.14, 0.05, 0.18), _book_color(seed0), false)
		_add_box(root, Vector3(0.02, 0.75, 0.0), Vector3(0.12, 0.04, 0.16), _book_color(seed0 + 3), false)
		_add_box(root, Vector3(0.08, 0.8, -0.02), Vector3(0.1, 0.035, 0.14), _book_color(seed0 + 5), false)
		_add_cylinder(root, Vector3(0.12, 0.72, 0.1), 0.04, 0.12, CREAM.darkened(0.1), false, 0.75)
	else:
		_add_cylinder(root, Vector3(0, 0.72, 0), 0.07, 0.12, CLAY, false, 0.75)
		_add_cylinder(root, Vector3(0, 0.85, 0), 0.05, 0.14, CLAY.lightened(0.08), false, 0.75)
		_add_sphere_blob(root, Vector3(0.02, 0.98, 0.02), 0.05, Color(0.55, 0.2, 0.2))
		_add_sphere_blob(root, Vector3(-0.03, 0.95, -0.02), 0.04, Color(0.7, 0.65, 0.3))
	_add_contact_shadow(root, 0.34, 0.34)
	if style == 0:
		var lamp := OmniLight3D.new()
		lamp.light_color = Color(1.0, 0.85, 0.55)
		lamp.light_energy = 0.55
		lamp.omni_range = 2.6
		lamp.position = Vector3(0, 1.0, 0)
		root.add_child(lamp)
	return root

static func _make_hall_table(_prop: Dictionary) -> Node3D:
	## Console table with oil lamp, card tray, gloves — entrance hall still-life.
	var root := Node3D.new()
	root.name = "HallTable"
	_add_box(root, Vector3(0, 0.82, 0), Vector3(1.4, 0.05, 0.5), MAHOGANY, true, 0.48)
	_add_box(root, Vector3(0, 0.78, 0), Vector3(1.35, 0.04, 0.46), MAHOGANY_DARK, false, 0.45)
	_add_box(root, Vector3(0, 0.4, 0), Vector3(1.15, 0.03, 0.4), MAHOGANY_DARK, false, 0.45)
	for sx in [-1, 1]:
		_add_cylinder(root, Vector3(sx * 0.52, 0.4, 0.12), 0.045, 0.78, MAHOGANY_DARK, true)
		_add_cylinder(root, Vector3(sx * 0.52, 0.4, -0.12), 0.045, 0.78, MAHOGANY_DARK, true)
		_add_cylinder(root, Vector3(sx * 0.52, 0.02, 0.12), 0.06, 0.04, MAHOGANY, true)
		_add_cylinder(root, Vector3(sx * 0.52, 0.02, -0.12), 0.06, 0.04, MAHOGANY, true)
	# Calling-card tray + letters
	_add_box(root, Vector3(-0.3, 0.88, 0.05), Vector3(0.38, 0.035, 0.24), MAHOGANY_DARK, false, 0.4)
	_add_box(root, Vector3(-0.3, 0.91, 0.05), Vector3(0.3, 0.01, 0.18), PAPER, false)
	_add_box(root, Vector3(-0.28, 0.925, 0.02), Vector3(0.22, 0.008, 0.12), PAPER.darkened(0.08), false)
	# Gloves / handkerchief
	_add_box(root, Vector3(0.15, 0.87, 0.1), Vector3(0.16, 0.02, 0.1), CREAM.darkened(0.1), false, 0.9)
	# Argand oil lamp (solid frosted chimney — alpha glass reads black)
	_add_cylinder(root, Vector3(0.4, 0.9, -0.05), 0.07, 0.05, BRASS, false, 0.3, true)
	_add_cylinder(root, Vector3(0.4, 1.0, -0.05), 0.028, 0.18, BRASS.darkened(0.05), false, 0.3, true)
	_add_cylinder(root, Vector3(0.4, 1.15, -0.05), 0.04, 0.22, Color(0.88, 0.9, 0.85), false, 0.4)
	_add_cylinder(root, Vector3(0.4, 1.28, -0.05), 0.025, 0.03, BRASS, false, 0.3, true)
	_add_sphere_blob(root, Vector3(0.4, 1.08, -0.05), 0.025, Color(1.0, 0.8, 0.4))
	# Small clock / vase
	_add_cylinder(root, Vector3(-0.05, 0.95, -0.1), 0.05, 0.16, BRASS, false, 0.3, true)
	_add_box(root, Vector3(-0.05, 1.05, -0.1), Vector3(0.08, 0.08, 0.04), Color(0.85, 0.82, 0.75), false, 0.5)
	var lamp := OmniLight3D.new()
	lamp.light_color = Color(1.0, 0.85, 0.55)
	lamp.light_energy = 0.6
	lamp.omni_range = 3.2
	lamp.position = Vector3(0.4, 1.2, -0.05)
	root.add_child(lamp)
	_add_contact_shadow(root, 0.78, 0.38)
	return root

# ─── Kitchen identity ────────────────────────────────────────────────────────

static func _make_kitchen_range(_prop: Dictionary) -> Node3D:
	## Cast-iron Victorian kitchen range — large signature read from doorway.
	var root := Node3D.new()
	root.name = "KitchenRange"
	# Plinth / hearth base (stone)
	_add_box(root, Vector3(0, 0.08, 0.05), Vector3(2.35, 0.16, 1.0), STONE, true, 0.7)
	# Main iron body (wider/taller for doorway silhouette)
	_add_box(root, Vector3(0, 0.65, 0), Vector3(2.15, 1.1, 0.85), IRON, true, 0.55)
	# Side panels with rivet strip suggestion
	_add_box(root, Vector3(-1.05, 0.65, 0.1), Vector3(0.08, 1.0, 0.7), IRON.darkened(0.08), false, 0.5)
	_add_box(root, Vector3(1.05, 0.65, 0.1), Vector3(0.08, 1.0, 0.7), IRON.darkened(0.08), false, 0.5)
	# Oven doors (fielded) + brass handles
	_add_box(root, Vector3(-0.5, 0.48, 0.42), Vector3(0.68, 0.52, 0.06), IRON.lightened(0.1), false, 0.5)
	_add_box(root, Vector3(0.5, 0.48, 0.42), Vector3(0.68, 0.52, 0.06), IRON.lightened(0.1), false, 0.5)
	_add_box(root, Vector3(-0.5, 0.48, 0.46), Vector3(0.5, 0.36, 0.02), IRON.darkened(0.05), false, 0.55)
	_add_box(root, Vector3(0.5, 0.48, 0.46), Vector3(0.5, 0.36, 0.02), IRON.darkened(0.05), false, 0.55)
	_add_cylinder(root, Vector3(-0.5, 0.48, 0.5), 0.03, 0.18, BRASS, false, 0.3, true)
	_add_cylinder(root, Vector3(0.5, 0.48, 0.5), 0.03, 0.18, BRASS, false, 0.3, true)
	# Firebox opening glow
	_add_box(root, Vector3(0, 0.35, 0.44), Vector3(0.55, 0.35, 0.04), Color(0.55, 0.22, 0.06), false, 0.9)
	# Hotplate top with rings
	_add_box(root, Vector3(0, 1.22, 0), Vector3(2.2, 0.09, 0.88), IRON.darkened(0.12), true, 0.4)
	_add_cylinder(root, Vector3(-0.55, 1.3, 0.05), 0.22, 0.04, IRON.lightened(0.08), false, 0.35)
	_add_cylinder(root, Vector3(-0.55, 1.32, 0.05), 0.12, 0.03, IRON.darkened(0.05), false, 0.4)
	_add_cylinder(root, Vector3(0.55, 1.3, 0.05), 0.22, 0.04, IRON.lightened(0.08), false, 0.35)
	_add_cylinder(root, Vector3(0.55, 1.32, 0.05), 0.12, 0.03, IRON.darkened(0.05), false, 0.4)
	# Mantel shelf + kettle / crock still-life
	_add_box(root, Vector3(0, 1.45, 0.15), Vector3(2.3, 0.06, 0.55), IRON.lightened(0.05), false, 0.45)
	_add_cylinder(root, Vector3(-0.55, 1.58, 0.15), 0.08, 0.18, COPPER, false, 0.35, true)
	_add_cylinder(root, Vector3(0.5, 1.55, 0.15), 0.07, 0.14, CREAM.darkened(0.15), false, 0.8)
	_add_box(root, Vector3(0.1, 1.52, 0.2), Vector3(0.2, 0.04, 0.12), MAHOGANY, false, 0.5)
	# Chimney flue + crown
	_add_box(root, Vector3(0, 1.95, -0.12), Vector3(0.55, 1.2, 0.45), IRON, true, 0.5)
	_add_box(root, Vector3(0, 2.55, -0.12), Vector3(0.7, 0.1, 0.55), IRON.darkened(0.05), false, 0.5)
	# Hanging pan rail above range
	_add_box(root, Vector3(0, 1.75, 0.35), Vector3(1.6, 0.04, 0.05), MAHOGANY_DARK, false, 0.5)
	_add_cylinder(root, Vector3(-0.4, 1.55, 0.38), 0.1, 0.08, COPPER, false, 0.35, true)
	_add_cylinder(root, Vector3(0.35, 1.52, 0.38), 0.09, 0.07, COPPER.lightened(0.05), false, 0.35, true)
	var fire := OmniLight3D.new()
	fire.light_color = Color(1.0, 0.5, 0.18)
	fire.light_energy = 1.5
	fire.omni_range = 5.8
	fire.position = Vector3(0, 0.55, 0.55)
	root.add_child(fire)
	# Copper kettle on hotplate
	_add_cylinder(root, Vector3(-0.55, 1.45, 0.05), 0.13, 0.22, COPPER, false, 0.35, true)
	_add_cylinder(root, Vector3(-0.55, 1.58, 0.05), 0.05, 0.1, COPPER, false, 0.35, true)
	_add_box(root, Vector3(-0.35, 1.48, 0.05), Vector3(0.18, 0.03, 0.03), COPPER, false, 0.35)
	# Iron skillet
	_add_cylinder(root, Vector3(0.55, 1.36, 0.05), 0.16, 0.05, IRON.darkened(0.1), false, 0.4)
	_add_contact_shadow(root, 1.2, 0.55)
	return root

static func _make_dresser(prop: Dictionary) -> Node3D:
	## Welsh dresser / plate rack — kitchen identity; seed varies plate/crock mix.
	var root := Node3D.new()
	root.name = "Dresser"
	var seed0: int = int(prop.get("seed", 0))
	var w := 1.7
	# Base cupboard
	_add_box(root, Vector3(0, 0.55, 0), Vector3(w, 1.05, 0.42), OAK, true, 0.5)
	_add_box(root, Vector3(-0.35, 0.55, 0.2), Vector3(0.7, 0.85, 0.04), OAK.darkened(0.1), false, 0.5)
	_add_box(root, Vector3(0.35, 0.55, 0.2), Vector3(0.7, 0.85, 0.04), OAK.darkened(0.1), false, 0.5)
	_add_cylinder(root, Vector3(-0.35, 0.55, 0.24), 0.02, 0.08, BRASS, false, 0.3, true)
	_add_cylinder(root, Vector3(0.35, 0.55, 0.24), 0.02, 0.08, BRASS, false, 0.3, true)
	# Upper plate rack open shelves
	_add_box(root, Vector3(0, 1.55, -0.05), Vector3(w, 0.08, 0.36), OAK, true, 0.5)
	_add_box(root, Vector3(0, 2.0, -0.05), Vector3(w, 0.08, 0.36), OAK, true, 0.5)
	_add_box(root, Vector3(0, 2.4, -0.05), Vector3(w, 0.1, 0.38), OAK, true, 0.5)
	_add_box(root, Vector3(-w * 0.48, 1.75, -0.05), Vector3(0.06, 1.3, 0.36), OAK, true, 0.5)
	_add_box(root, Vector3(w * 0.48, 1.75, -0.05), Vector3(0.06, 1.3, 0.36), OAK, true, 0.5)
	_add_box(root, Vector3(0, 1.75, -0.2), Vector3(w * 0.95, 1.3, 0.04), OAK.darkened(0.15), false, 0.55)
	# Plates / crocks / copper mixed by seed
	for i in 5:
		var px := -0.6 + i * 0.3
		var kind := (i + seed0) % 3
		if kind == 0:
			_add_cylinder(root, Vector3(px, 1.62, 0.02), 0.09, 0.03, CREAM if i % 2 == 0 else CREAM.darkened(0.08), false)
		elif kind == 1:
			_add_cylinder(root, Vector3(px, 1.7, 0.02), 0.06, 0.14, CLAY, false, 0.8)
		else:
			_add_cylinder(root, Vector3(px, 1.68, 0.02), 0.07, 0.1, COPPER, false, 0.35, true)
		_add_cylinder(root, Vector3(px + 0.05, 2.08, 0.02), 0.08 + float(i % 2) * 0.015, 0.03, CREAM.darkened(0.05 * float((i + seed0) % 3)), false)
		if (i + seed0) % 2 == 0:
			_add_cylinder(root, Vector3(px, 2.48, 0.0), 0.08, 0.025, CREAM.darkened(0.1), false)
		else:
			_add_cylinder(root, Vector3(px, 2.52, 0.0), 0.05, 0.1, CLAY.lightened(0.05), false, 0.8)
	# Jars + copper base
	_add_cylinder(root, Vector3(0.5, 1.2, 0.05), 0.07, 0.18, CLAY if seed0 % 2 == 0 else CLAY.darkened(0.08), false)
	_add_cylinder(root, Vector3(0.65, 1.15, 0.0), 0.06, 0.14, CLAY.lightened(0.1), false)
	_add_cylinder(root, Vector3(-0.5, 1.18, 0.05), 0.08, 0.16, COPPER if seed0 % 2 == 0 else COPPER.darkened(0.1), false, 0.35, true)
	_add_cylinder(root, Vector3(-0.3, 1.16, 0.0), 0.06, 0.12, COPPER.darkened(0.08), false, 0.35, true)
	_add_contact_shadow(root, 0.9, 0.3)
	return root

static func _make_sink(_prop: Dictionary) -> Node3D:
	var root := Node3D.new()
	root.name = "Sink"
	_add_box(root, Vector3(0, 0.45, 0), Vector3(1.1, 0.85, 0.55), OAK, true, 0.5)
	# Cupboard doors
	_add_box(root, Vector3(-0.25, 0.4, 0.26), Vector3(0.48, 0.7, 0.04), OAK.darkened(0.08), false, 0.5)
	_add_box(root, Vector3(0.25, 0.4, 0.26), Vector3(0.48, 0.7, 0.04), OAK.darkened(0.08), false, 0.5)
	_add_cylinder(root, Vector3(-0.15, 0.4, 0.3), 0.015, 0.05, BRASS, false, 0.3, true)
	_add_cylinder(root, Vector3(0.15, 0.4, 0.3), 0.015, 0.05, BRASS, false, 0.3, true)
	# Stoneware basin
	_add_box(root, Vector3(0, 0.92, 0.05), Vector3(0.85, 0.12, 0.42), STONE, false, 0.4)
	_add_box(root, Vector3(0, 0.88, 0.05), Vector3(0.7, 0.08, 0.3), Color(0.35, 0.4, 0.45), false, 0.25)
	# Pump / spout
	_add_cylinder(root, Vector3(0.25, 1.15, -0.1), 0.03, 0.35, BRASS, false, 0.3, true)
	_add_box(root, Vector3(0.1, 1.28, 0.0), Vector3(0.35, 0.04, 0.04), BRASS, false, 0.3)
	_add_cylinder(root, Vector3(-0.05, 1.25, 0.05), 0.025, 0.08, BRASS, false, 0.3, true)
	# Soap dish + cloth + jug
	_add_box(root, Vector3(-0.3, 0.98, 0.12), Vector3(0.14, 0.04, 0.1), CREAM, false)
	_add_box(root, Vector3(-0.15, 0.95, 0.18), Vector3(0.2, 0.02, 0.12), Color(0.7, 0.75, 0.8), false)
	_add_cylinder(root, Vector3(0.35, 1.0, 0.12), 0.05, 0.12, CREAM.darkened(0.1), false, 0.8)
	_add_contact_shadow(root, 0.6, 0.35)
	return root

static func _make_prep_table(prop: Dictionary) -> Node3D:
	## Scrubbed kitchen prep table — not a lab workbench. seed varies still-life.
	var root := Node3D.new()
	root.name = "PrepTable"
	var width: float = prop.get("width", 1.8)
	var seed0: int = int(prop.get("seed", 0))
	# Scrubbed pale work-top (reads as board, not mahogany furniture)
	_add_box(root, Vector3(0, 0.82, 0), Vector3(width, 0.06, 0.85), Color(0.72, 0.62, 0.42), true, 0.72)
	_add_box(root, Vector3(0, 0.72, 0), Vector3(width - 0.1, 0.12, 0.78), Color(0.55, 0.42, 0.28), false, 0.55)
	for lx in [-width * 0.4, width * 0.4]:
		for lz in [-0.32, 0.32]:
			_add_box(root, Vector3(lx, 0.4, lz), Vector3(0.08, 0.78, 0.08), Color(0.38, 0.26, 0.14), true, 0.55)
	# Stretchers
	_add_box(root, Vector3(0, 0.18, 0), Vector3(width * 0.75, 0.04, 0.7), OAK.darkened(0.08), false, 0.55)
	# Varied still-life — avoid clone white cylinders
	if seed0 % 2 == 0:
		_add_cylinder(root, Vector3(-0.45, 0.98, 0.12), 0.13, 0.24, CREAM.darkened(0.1), false, 0.92)
		_add_cylinder(root, Vector3(-0.45, 1.12, 0.12), 0.09, 0.05, CREAM.darkened(0.18), false, 0.9)
		_add_box(root, Vector3(0.1, 0.88, -0.12), Vector3(0.28, 0.05, 0.2), CREAM.darkened(0.05), false, 0.8)
		_add_box(root, Vector3(0.42, 0.875, 0.12), Vector3(0.32, 0.02, 0.2), MAHOGANY, false, 0.55)
		_add_box(root, Vector3(0.5, 0.89, 0.12), Vector3(0.22, 0.015, 0.04), IRON, false, 0.4)
		_add_cylinder(root, Vector3(-0.12, 0.95, 0.22), 0.1, 0.18, COPPER, false, 0.35, true)
		_add_cylinder(root, Vector3(0.32, 0.9, -0.22), 0.025, 0.3, MAHOGANY_DARK, false, 0.55)
		_add_cylinder(root, Vector3(0.55, 0.95, 0.0), 0.08, 0.16, COPPER.darkened(0.08), false, 0.35, true)
		_add_cylinder(root, Vector3(-0.2, 0.9, -0.2), 0.04, 0.06, Color(0.55, 0.35, 0.15), false, 0.8)
	else:
		# Bread board, pie dish, tall crock, copper ladle
		_add_box(root, Vector3(-0.4, 0.875, 0.1), Vector3(0.45, 0.025, 0.28), OAK.lightened(0.2), false, 0.65)
		_add_cylinder(root, Vector3(-0.35, 0.92, 0.1), 0.12, 0.06, CREAM.darkened(0.12), false, 0.85)
		_add_cylinder(root, Vector3(0.15, 1.0, 0.05), 0.09, 0.28, CLAY, false, 0.8)
		_add_cylinder(root, Vector3(0.15, 1.16, 0.05), 0.07, 0.04, CLAY.darkened(0.1), false, 0.8)
		_add_cylinder(root, Vector3(0.45, 0.95, -0.1), 0.11, 0.14, COPPER.lightened(0.05), false, 0.35, true)
		_add_box(root, Vector3(0.55, 0.95, 0.05), Vector3(0.03, 0.2, 0.03), IRON, false, 0.4)
		_add_cylinder(root, Vector3(-0.1, 0.9, -0.2), 0.05, 0.08, Color(0.6, 0.4, 0.2), false, 0.8)
		_add_box(root, Vector3(0.3, 0.88, 0.2), Vector3(0.2, 0.03, 0.14), CREAM, false, 0.75)
	_add_contact_shadow(root, width * 0.5, 0.5)
	return root


static func _make_floor_path(prop: Dictionary) -> Node3D:
	## Stone flag path — breaks plain floors (conservatory / hall).
	var root := Node3D.new()
	root.name = "FloorPath"
	var length: float = float(prop.get("length", 3.5))
	var width: float = float(prop.get("width", 0.9))
	var n := int(clampf(length / 0.55, 3.0, 12.0))
	for i in n:
		var z := -length * 0.5 + 0.3 + float(i) * (length / float(n))
		var ox := 0.03 * float((i % 3) - 1)
		_add_box(root, Vector3(ox, 0.02, z), Vector3(width * (0.85 + float(i % 2) * 0.1), 0.04, 0.48), STONE, false, 0.7)
	return root


static func _make_wall_sconce(prop: Dictionary) -> Node3D:
	## Brass wall light — period sconce with warm omni.
	var root := Node3D.new()
	root.name = "WallSconce"
	var y: float = float(prop.get("height", 2.1))
	_add_box(root, Vector3(0, y, 0), Vector3(0.08, 0.12, 0.06), BRASS, false, 0.3)
	_add_box(root, Vector3(0, y, 0.08), Vector3(0.04, 0.04, 0.12), BRASS.darkened(0.05), false, 0.3)
	_add_cylinder(root, Vector3(0, y - 0.05, 0.16), 0.05, 0.1, Color(0.9, 0.85, 0.7), false, 0.45)
	var lamp := OmniLight3D.new()
	lamp.light_color = Color(1.0, 0.85, 0.55)
	lamp.light_energy = 0.55
	lamp.omni_range = 3.5
	lamp.position = Vector3(0, y - 0.05, 0.2)
	root.add_child(lamp)
	return root


static func _make_wall_vine(prop: Dictionary) -> Node3D:
	## Dense climbing ivy mat on plaster — not balloon poles.
	var root := Node3D.new()
	root.name = "WallVine"
	var height: float = float(prop.get("height", 1.8))
	var width: float = float(prop.get("width", 1.4))
	var leaf_a := Color(0.2, 0.4, 0.16)
	var leaf_b := Color(0.14, 0.32, 0.1)
	var leaf_c := Color(0.26, 0.46, 0.18)
	# Thin guide stems (short, many)
	for i in 6:
		var x := -width * 0.4 + float(i) * (width * 0.16)
		var sh := height * (0.45 + float(i % 3) * 0.12)
		_add_cylinder(root, Vector3(x, 0.25 + sh * 0.5, 0.01), 0.008, sh, Color(0.18, 0.26, 0.1), false, 0.92)
	# Dense leaf mat (many small spheres packed flat to wall)
	for j in 28:
		var t := float(j)
		var fx := -width * 0.42 + fmod(t * 0.29, width * 0.84)
		var fy := 0.2 + fmod(t * 0.41, height * 0.85)
		var fz := 0.04 + float(j % 3) * 0.02
		var r := 0.07 + float(j % 4) * 0.015
		var col := leaf_a if j % 3 == 0 else (leaf_b if j % 3 == 1 else leaf_c)
		_add_sphere_blob(root, Vector3(fx, fy, fz), r, col)
	# Soft base mound
	_add_sphere_blob(root, Vector3(0, 0.25, 0.08), 0.18, leaf_b)
	_add_sphere_blob(root, Vector3(-0.2, 0.2, 0.07), 0.14, leaf_a)
	_add_sphere_blob(root, Vector3(0.22, 0.22, 0.07), 0.15, leaf_c)
	return root


static func _make_wall_shelf(prop: Dictionary) -> Node3D:
	## Long mid-wall plate shelf — breaks empty plaster (keep clear of door openings).
	var root := Node3D.new()
	root.name = "WallShelf"
	var width: float = float(prop.get("width", 2.4))
	var y: float = float(prop.get("shelf_y", 1.85))
	var seed0: int = int(prop.get("seed", 0))
	# Bracketed shelf: main board + two supports + back rail
	_add_box(root, Vector3(0, y, 0.04), Vector3(width, 0.05, 0.16), MAHOGANY, true, 0.5)
	_add_box(root, Vector3(0, y + 0.08, -0.02), Vector3(width * 0.98, 0.04, 0.04), MAHOGANY_DARK, false, 0.5)
	for sx in [-width * 0.4, width * 0.4]:
		_add_box(root, Vector3(sx, y - 0.12, 0.0), Vector3(0.05, 0.2, 0.12), MAHOGANY_DARK, false, 0.5)
	var n := int(clampf(width / 0.38, 3.0, 8.0))
	for i in n:
		var x := -width * 0.38 + float(i) * (width * 0.76 / float(maxi(n - 1, 1)))
		var kind := (i + seed0) % 4
		if kind == 0:
			_add_cylinder(root, Vector3(x, y + 0.07, 0.04), 0.07 + float(i % 2) * 0.015, 0.035, CREAM if (i + seed0) % 2 == 0 else CREAM.darkened(0.08), false, 0.7)
		elif kind == 1:
			_add_cylinder(root, Vector3(x, y + 0.09, 0.04), 0.05 + float((i + seed0) % 3) * 0.01, 0.1, COPPER if i % 2 == 0 else COPPER.darkened(0.1), false, 0.35, true)
		elif kind == 2:
			_add_cylinder(root, Vector3(x, y + 0.1, 0.04), 0.055, 0.12, CLAY if (i + seed0) % 2 == 0 else CLAY.lightened(0.1), false, 0.75)
		else:
			_add_cylinder(root, Vector3(x, y + 0.08, 0.04), 0.06, 0.05, Color(0.72, 0.68, 0.6), false, 0.65)
	return root


static func _make_pot_rack(prop: Dictionary) -> Node3D:
	## Wall copper pan rail — varied pan sizes/colours (no identical row).
	var root := Node3D.new()
	root.name = "PotRack"
	var seed0: int = int(prop.get("seed", 0))
	_add_box(root, Vector3(0, 2.2, 0), Vector3(2.0, 0.08, 0.12), MAHOGANY_DARK, true, 0.5)
	_add_box(root, Vector3(-0.95, 1.75, 0), Vector3(0.07, 0.95, 0.07), MAHOGANY, true, 0.5)
	_add_box(root, Vector3(0.95, 1.75, 0), Vector3(0.07, 0.95, 0.07), MAHOGANY, true, 0.5)
	# Fewer identical pans: 4 hangers, strong size/shape variation
	for i in 4:
		var x := -0.55 + i * 0.38
		_add_cylinder(root, Vector3(x, 2.08, 0.06), 0.015, 0.14, IRON, false, 0.4)
		var pr: float = 0.09 + float((i * 3 + seed0) % 5) * 0.03
		var ph: float = 0.06 + float((i + seed0 * 2) % 4) * 0.035
		var pcols: Array[Color] = [
			COPPER,
			COPPER.darkened(0.12),
			COPPER.lightened(0.08),
			Color(0.55, 0.32, 0.18),
		]
		var pcol: Color = pcols[(i + seed0) % 4]
		var shape := (i + seed0) % 3
		if shape == 0:
			_add_cylinder(root, Vector3(x, 1.82, 0.1), pr, ph, pcol, false, 0.35, true)
			_add_cylinder(root, Vector3(x, 1.72, 0.1), pr + 0.02, 0.03, pcol.lightened(0.08), false, 0.35, true)
		elif shape == 1:
			_add_cylinder(root, Vector3(x, 1.78, 0.1), pr * 1.25, ph * 0.7, pcol, false, 0.35, true)
			_add_box(root, Vector3(x + pr * 0.9, 1.78, 0.1), Vector3(0.1, 0.025, 0.04), pcol, false, 0.35)
		else:
			_add_cylinder(root, Vector3(x, 1.85, 0.1), pr * 0.75, ph * 1.3, pcol.darkened(0.05), false, 0.35, true)
			_add_cylinder(root, Vector3(x, 1.98, 0.1), 0.03, 0.04, BRASS, false, 0.3, true)
	return root

static func _make_copper_pot(prop: Dictionary) -> Node3D:
	## seed picks kettle / wide pan / tall stockpot so still-lifes aren't clones.
	var root := Node3D.new()
	root.name = "CopperPot"
	var scale: float = prop.get("scale", 1.0)
	var seed0: int = int(prop.get("seed", 0))
	var style := seed0 % 3
	var col := COPPER if style != 2 else COPPER.darkened(0.08)
	if style == 0:
		# Classic kettle
		_add_cylinder(root, Vector3(0, 0.12 * scale, 0), 0.14 * scale, 0.22 * scale, col, true, 0.35, true)
		_add_cylinder(root, Vector3(0, 0.24 * scale, 0), 0.15 * scale, 0.03 * scale, col.lightened(0.1), false, 0.3, true)
		_add_cylinder(root, Vector3(0, 0.25 * scale, 0), 0.1 * scale, 0.03 * scale, Color(0.18, 0.1, 0.06), false)
		_add_box(root, Vector3(0.16 * scale, 0.14 * scale, 0), Vector3(0.04 * scale, 0.08 * scale, 0.12 * scale), col, false, 0.35)
		_add_box(root, Vector3(-0.16 * scale, 0.14 * scale, 0), Vector3(0.04 * scale, 0.08 * scale, 0.12 * scale), col, false, 0.35)
		_add_box(root, Vector3(0, 0.3 * scale, 0), Vector3(0.34 * scale, 0.02 * scale, 0.02 * scale), col.darkened(0.05), false, 0.35)
	elif style == 1:
		# Wide shallow pan
		_add_cylinder(root, Vector3(0, 0.08 * scale, 0), 0.18 * scale, 0.12 * scale, col.lightened(0.05), true, 0.35, true)
		_add_cylinder(root, Vector3(0, 0.15 * scale, 0), 0.19 * scale, 0.025 * scale, col, false, 0.3, true)
		_add_box(root, Vector3(0.2 * scale, 0.1 * scale, 0), Vector3(0.12 * scale, 0.03 * scale, 0.05 * scale), col, false, 0.35)
		_add_box(root, Vector3(-0.2 * scale, 0.1 * scale, 0), Vector3(0.12 * scale, 0.03 * scale, 0.05 * scale), col, false, 0.35)
	else:
		# Tall stockpot with lid knob
		_add_cylinder(root, Vector3(0, 0.16 * scale, 0), 0.12 * scale, 0.3 * scale, col.darkened(0.05), true, 0.35, true)
		_add_cylinder(root, Vector3(0, 0.32 * scale, 0), 0.125 * scale, 0.03 * scale, col, false, 0.3, true)
		_add_cylinder(root, Vector3(0, 0.36 * scale, 0), 0.04 * scale, 0.05 * scale, BRASS, false, 0.3, true)
		_add_box(root, Vector3(0.13 * scale, 0.2 * scale, 0), Vector3(0.03 * scale, 0.1 * scale, 0.08 * scale), col, false, 0.35)
		_add_box(root, Vector3(-0.13 * scale, 0.2 * scale, 0), Vector3(0.03 * scale, 0.1 * scale, 0.08 * scale), col, false, 0.35)
	_add_contact_shadow(root, 0.18 * scale, 0.18 * scale)
	return root

# ─── Workshop ────────────────────────────────────────────────────────────────

static func _make_workbench(prop: Dictionary) -> Node3D:
	## Scrubbed oak top (reads lighter than dark legs) + cluttered tools.
	var root := Node3D.new()
	root.name = "Workbench"
	var width: float = prop.get("width", 2.8)
	# Light work surface — was all mahogany-dark and read as black slabs
	_add_box(root, Vector3(0, 0.86, 0), Vector3(width, 0.08, 0.95), OAK.lightened(0.08), true, 0.55)
	_add_box(root, Vector3(0, 0.8, 0), Vector3(width - 0.05, 0.05, 0.9), OAK, false, 0.5)
	for lx in [-width * 0.38, width * 0.38]:
		_add_box(root, Vector3(lx, 0.4, 0), Vector3(0.1, 0.8, 0.85), MAHOGANY, true, 0.5)
	_add_box(root, Vector3(0, 0.38, 0), Vector3(width * 0.72, 0.08, 0.78), MAHOGANY_DARK, false, 0.5)
	# Lower shelf with drawers suggestion
	_add_box(root, Vector3(-width * 0.2, 0.35, 0.35), Vector3(width * 0.28, 0.22, 0.12), MAHOGANY, false, 0.48)
	_add_box(root, Vector3(width * 0.2, 0.35, 0.35), Vector3(width * 0.28, 0.22, 0.12), MAHOGANY, false, 0.48)
	_add_cylinder(root, Vector3(-width * 0.2, 0.35, 0.42), 0.02, 0.06, BRASS, false, 0.3, true)
	_add_cylinder(root, Vector3(width * 0.2, 0.35, 0.42), 0.02, 0.06, BRASS, false, 0.3, true)
	# Tools / gauges / paper / wrench / vice suggestion
	_add_box(root, Vector3(-0.4, 0.93, 0.15), Vector3(0.35, 0.04, 0.25), BRASS, false, 0.3)
	_add_box(root, Vector3(0.3, 0.92, -0.1), Vector3(0.4, 0.03, 0.3), PAPER, false)
	_add_box(root, Vector3(0.35, 0.94, -0.08), Vector3(0.28, 0.01, 0.2), PAPER.darkened(0.08), false)
	_add_cylinder(root, Vector3(0.6, 0.97, 0.1), 0.06, 0.18, BRASS, false, 0.3, true)
	_add_cylinder(root, Vector3(-0.7, 0.97, -0.15), 0.05, 0.14, COPPER, false, 0.35, true)
	_add_box(root, Vector3(0.0, 0.94, 0.25), Vector3(0.55, 0.03, 0.08), IRON, false, 0.4)
	_add_box(root, Vector3(-0.15, 0.95, 0.3), Vector3(0.08, 0.04, 0.22), IRON.lightened(0.1), false, 0.4)
	_add_box(root, Vector3(0.75, 0.98, -0.2), Vector3(0.2, 0.12, 0.15), IRON, false, 0.4)
	_add_cylinder(root, Vector3(0.75, 1.08, -0.2), 0.03, 0.1, IRON.lightened(0.1), false, 0.4)
	_add_box(root, Vector3(-0.55, 0.95, 0.0), Vector3(0.25, 0.02, 0.18), Color(0.2, 0.14, 0.1), false, 0.6)
	_add_cylinder(root, Vector3(0.15, 0.98, 0.15), 0.04, 0.1, COPPER, false, 0.35, true)
	_add_contact_shadow(root, width * 0.5, 0.55)
	return root

static func _make_tool_rack(_prop: Dictionary) -> Node3D:
	## Wall rack with hanging hammers, wrenches, tongs — not bare iron bars.
	var root := Node3D.new()
	root.name = "ToolRack"
	_add_box(root, Vector3(0, 1.35, 0), Vector3(1.55, 0.1, 0.1), MAHOGANY_DARK, true, 0.5)
	_add_box(root, Vector3(0, 0.55, 0), Vector3(1.55, 0.08, 0.1), MAHOGANY_DARK, true, 0.5)
	_add_box(root, Vector3(-0.72, 0.95, 0), Vector3(0.08, 0.9, 0.08), MAHOGANY, true, 0.5)
	_add_box(root, Vector3(0.72, 0.95, 0), Vector3(0.08, 0.9, 0.08), MAHOGANY, true, 0.5)
	# Pegs + denser tools (two rows)
	for i in 7:
		var x := -0.6 + i * 0.2
		_add_cylinder(root, Vector3(x, 1.28, 0.08), 0.015, 0.1, OAK, false, 0.55)
		_add_box(root, Vector3(x, 0.95, 0.1), Vector3(0.035, 0.55, 0.035), Color(0.25, 0.18, 0.1), false, 0.55)
		if i % 3 == 0:
			_add_box(root, Vector3(x, 0.68, 0.12), Vector3(0.16, 0.08, 0.08), IRON, false, 0.4)
		elif i % 3 == 1:
			_add_box(root, Vector3(x, 0.7, 0.14), Vector3(0.12, 0.05, 0.18), IRON.lightened(0.08), false, 0.4)
			_add_box(root, Vector3(x + 0.04, 0.66, 0.2), Vector3(0.04, 0.1, 0.04), IRON, false, 0.4)
		else:
			_add_box(root, Vector3(x, 0.72, 0.12), Vector3(0.08, 0.04, 0.14), IRON, false, 0.4)
			_add_box(root, Vector3(x - 0.05, 0.68, 0.18), Vector3(0.04, 0.08, 0.04), IRON, false, 0.4)
			_add_box(root, Vector3(x + 0.05, 0.68, 0.18), Vector3(0.04, 0.08, 0.04), IRON, false, 0.4)
	# Short tools on lower pegs
	for i in 4:
		var x2 := -0.4 + i * 0.28
		_add_cylinder(root, Vector3(x2, 0.58, 0.08), 0.012, 0.08, OAK, false, 0.55)
		_add_box(root, Vector3(x2, 0.4, 0.1), Vector3(0.03, 0.28, 0.03), Color(0.22, 0.15, 0.1), false, 0.55)
		_add_box(root, Vector3(x2, 0.28, 0.12), Vector3(0.1, 0.05, 0.06), IRON, false, 0.4)
	# Lower shelf with spare bolts / copper bits
	_add_cylinder(root, Vector3(-0.35, 0.62, 0.08), 0.04, 0.08, COPPER, false, 0.35, true)
	_add_cylinder(root, Vector3(-0.2, 0.62, 0.08), 0.035, 0.07, BRASS, false, 0.3, true)
	_add_box(root, Vector3(0.25, 0.62, 0.08), Vector3(0.2, 0.04, 0.1), IRON, false, 0.45)
	_add_cylinder(root, Vector3(0.45, 0.62, 0.08), 0.03, 0.06, COPPER, false, 0.35, true)
	return root

static func _make_crate(prop: Dictionary) -> Node3D:
	var root := Node3D.new()
	root.name = "Crate"
	var s: float = prop.get("scale", 1.0)
	var seed0: int = int(prop.get("seed", 0))
	var wood := OAK if seed0 % 2 == 0 else OAK.darkened(0.12)
	var h: float = 0.38 + float(seed0 % 3) * 0.04
	_add_box(root, Vector3(0, h * 0.5 * s, 0), Vector3(0.55 * s, h * s, 0.45 * s), wood, true, 0.6)
	_add_box(root, Vector3(0, h * s, 0), Vector3(0.52 * s, 0.04 * s, 0.42 * s), wood.darkened(0.1), false, 0.55)
	# Batten straps (orientation varies by seed)
	if seed0 % 2 == 0:
		_add_box(root, Vector3(0, h * 0.5 * s, 0.22 * s), Vector3(0.52 * s, 0.06 * s, 0.03 * s), wood.darkened(0.15), false, 0.55)
		_add_box(root, Vector3(0, h * 0.5 * s, -0.22 * s), Vector3(0.52 * s, 0.06 * s, 0.03 * s), wood.darkened(0.15), false, 0.55)
	else:
		_add_box(root, Vector3(0.22 * s, h * 0.5 * s, 0), Vector3(0.03 * s, 0.06 * s, 0.42 * s), wood.darkened(0.15), false, 0.55)
		_add_box(root, Vector3(-0.22 * s, h * 0.5 * s, 0), Vector3(0.03 * s, 0.06 * s, 0.42 * s), wood.darkened(0.15), false, 0.55)
	if seed0 % 3 == 0:
		_add_box(root, Vector3(0, h * 0.55 * s, 0.24 * s), Vector3(0.08 * s, 0.04 * s, 0.02 * s), IRON, false, 0.4)
	_add_contact_shadow(root, 0.3 * s, 0.25 * s)
	return root

static func _make_stool(prop: Dictionary) -> Node3D:
	## seed: 0 tripod oak · 1 four-leg square · 2 padded seat
	var root := Node3D.new()
	root.name = "Stool"
	var seed0: int = int(prop.get("seed", 0))
	var style := seed0 % 3
	if style == 0:
		_add_cylinder(root, Vector3(0, 0.48, 0), 0.2, 0.06, OAK, true, 0.55)
		_add_cylinder(root, Vector3(0, 0.45, 0), 0.16, 0.03, OAK.darkened(0.1), false, 0.55)
		for a in [0.0, 120.0, 240.0]:
			var rad := deg_to_rad(a)
			_add_cylinder(root, Vector3(cos(rad) * 0.13, 0.24, sin(rad) * 0.13), 0.028, 0.48, MAHOGANY_DARK, true)
			_add_cylinder(root, Vector3(cos(rad) * 0.13, 0.03, sin(rad) * 0.13), 0.035, 0.04, MAHOGANY, true)
		_add_box(root, Vector3(0, 0.15, 0), Vector3(0.22, 0.025, 0.22), MAHOGANY_DARK, false, 0.5)
	elif style == 1:
		_add_box(root, Vector3(0, 0.5, 0), Vector3(0.36, 0.05, 0.36), OAK.lightened(0.05), true, 0.55)
		for sx in [-1.0, 1.0]:
			for sz in [-1.0, 1.0]:
				_add_box(root, Vector3(sx * 0.13, 0.24, sz * 0.13), Vector3(0.04, 0.48, 0.04), MAHOGANY_DARK, true, 0.5)
		_add_box(root, Vector3(0, 0.14, 0), Vector3(0.28, 0.03, 0.28), MAHOGANY, false, 0.5)
	else:
		_add_cylinder(root, Vector3(0, 0.5, 0), 0.18, 0.08, VELVET_GREEN.darkened(0.05), true, 0.9)
		_add_cylinder(root, Vector3(0, 0.44, 0), 0.16, 0.04, MAHOGANY, false, 0.45)
		for a in [0.0, 90.0, 180.0, 270.0]:
			var rad := deg_to_rad(a)
			_add_cylinder(root, Vector3(cos(rad) * 0.11, 0.22, sin(rad) * 0.11), 0.025, 0.44, MAHOGANY_DARK, true)
	_add_contact_shadow(root, 0.22, 0.22)
	return root

# ─── Gallery / aetheric ──────────────────────────────────────────────────────

static func _make_machine(prop: Dictionary) -> Node3D:
	## Secondary apparatus — continuous column (no floating caps) + gauges/pipes.
	var root := Node3D.new()
	root.name = "Machine"
	var height: float = prop.get("height", 2.6)
	var col_h: float = maxf(height * 0.72, 1.4)
	var col_mid: float = 0.35 + col_h * 0.5
	_add_box(root, Vector3(0, 0.15, 0), Vector3(0.95, 0.3, 0.85), MAHOGANY_DARK, true, 0.45)
	# Continuous brass body
	_add_cylinder(root, Vector3(0, col_mid, 0), 0.34, col_h, BRASS, true, 0.35, true)
	# Coil bands clamped to column (no floating disks)
	for i in 3:
		var y: float = 0.55 + i * (col_h * 0.28)
		_add_cylinder(root, Vector3(0, y, 0), 0.4, 0.07, COPPER, false, 0.35, true)
	# Cap sits ON column top
	var top_y: float = 0.35 + col_h
	_add_cylinder(root, Vector3(0, top_y, 0), 0.38, 0.1, BRASS.lightened(0.05), false, 0.32, true)
	_add_cylinder(root, Vector3(0, top_y + 0.12, 0), 0.14, 0.18, Color(0.62, 0.5, 0.22), false, 0.4, true)
	# Side instruments
	_add_box(root, Vector3(0.42, 0.55, 0.15), Vector3(0.28, 0.4, 0.32), MAHOGANY, true, 0.45)
	_add_cylinder(root, Vector3(0.42, 0.82, 0.15), 0.08, 0.06, BRASS, false, 0.3, true)
	_add_box(root, Vector3(-0.4, 0.5, 0.2), Vector3(0.25, 0.35, 0.28), MAHOGANY, true, 0.45)
	_add_cylinder(root, Vector3(-0.4, 0.75, 0.2), 0.06, 0.05, BRASS, false, 0.3, true)
	# Pipe elbows grounded on body
	_add_cylinder(root, Vector3(-0.38, 0.75, 0.0), 0.05, 0.5, COPPER, false, 0.35, true)
	_add_box(root, Vector3(-0.38, 1.02, 0.15), Vector3(0.1, 0.1, 0.35), COPPER, false, 0.35)
	_add_cylinder(root, Vector3(0.35, 0.9, -0.2), 0.04, 0.4, COPPER.darkened(0.05), false, 0.35, true)
	var glow := OmniLight3D.new()
	glow.light_color = Color(0.55, 0.75, 0.85)
	glow.light_energy = 0.55
	glow.omni_range = 3.2
	glow.position = Vector3(0, col_mid, 0.2)
	root.add_child(glow)
	_add_contact_shadow(root, 0.55, 0.5)
	return root

static func _make_aetheric_machine(prop: Dictionary) -> Node3D:
	## Hero gallery machine: base plinth + brass column + coils + glass chamber + cyan glow.
	var root := Node3D.new()
	root.name = "AethericMachine"
	var height: float = prop.get("height", 3.2)
	# Stone/mahogany plinth
	_add_box(root, Vector3(0, 0.2, 0), Vector3(1.4, 0.4, 1.2), MAHOGANY_DARK, true, 0.4)
	_add_box(root, Vector3(0, 0.45, 0), Vector3(1.15, 0.12, 0.95), MARBLE, true, 0.3)
	# Main column
	_add_cylinder(root, Vector3(0, height * 0.4, 0), 0.28, height * 0.55, BRASS, true, 0.3, true)
	# Coil rings (tighter stack)
	for i in 5:
		var y := 0.65 + i * 0.28
		_add_cylinder(root, Vector3(0, y, 0), 0.5 - float(i) * 0.02, 0.07, COPPER, false, 0.35, true)
	# Glass aether chamber — solid cyan glass (alpha read black)
	_add_cylinder(root, Vector3(0, height * 0.72, 0), 0.36, height * 0.28, Color(0.55, 0.8, 0.9), false, 0.25, true)
	# Cap
	_add_cylinder(root, Vector3(0, height * 0.88, 0), 0.42, 0.12, BRASS, true, 0.3, true)
	_add_cylinder(root, Vector3(0, height * 0.96, 0), 0.14, 0.22, BRASS.lightened(0.1), true, 0.25, true)
	# Side instrument boxes + gauges
	_add_box(root, Vector3(0.65, 0.85, 0.1), Vector3(0.35, 0.55, 0.4), MAHOGANY, true, 0.45)
	_add_box(root, Vector3(-0.65, 0.75, -0.1), Vector3(0.3, 0.4, 0.35), MAHOGANY, true, 0.45)
	_add_cylinder(root, Vector3(0.65, 1.2, 0.1), 0.08, 0.12, BRASS, false, 0.3, true)
	_add_cylinder(root, Vector3(-0.65, 1.05, -0.1), 0.07, 0.1, BRASS, false, 0.3, true)
	# Cool aetheric glow
	var glow := OmniLight3D.new()
	glow.light_color = Color(0.45, 0.85, 0.95)
	glow.light_energy = 1.4
	glow.omni_range = 6.5
	glow.position = Vector3(0, height * 0.65, 0)
	root.add_child(glow)
	var warm := OmniLight3D.new()
	warm.light_color = Color(0.9, 0.7, 0.4)
	warm.light_energy = 0.35
	warm.omni_range = 3.0
	warm.position = Vector3(0.5, 0.9, 0.3)
	root.add_child(warm)
	_add_contact_shadow(root, 0.85, 0.7)
	return root

static func _make_chalk_board(_prop: Dictionary) -> Node3D:
	var root := Node3D.new()
	root.name = "ChalkBoard"
	_add_box(root, Vector3(0, 1.2, 0), Vector3(1.4, 1.0, 0.06), MAHOGANY_DARK, true, 0.45)
	_add_box(root, Vector3(0, 1.2, 0.03), Vector3(1.25, 0.85, 0.02), CHALK, false, 0.85)
	# Chalk marks / diagrams
	_add_box(root, Vector3(-0.2, 1.35, 0.05), Vector3(0.55, 0.015, 0.01), Color(0.92, 0.92, 0.9), false, 0.95)
	_add_box(root, Vector3(0.15, 1.25, 0.05), Vector3(0.4, 0.012, 0.01), Color(0.9, 0.9, 0.88), false, 0.95)
	_add_box(root, Vector3(-0.1, 1.1, 0.05), Vector3(0.7, 0.01, 0.01), Color(0.88, 0.88, 0.85), false, 0.95)
	_add_cylinder(root, Vector3(0.25, 1.05, 0.05), 0.12, 0.01, Color(0.9, 0.9, 0.88), false, 0.95)
	# Chalk tray + sticks
	_add_box(root, Vector3(0, 0.7, 0.05), Vector3(1.3, 0.05, 0.1), MAHOGANY, false, 0.5)
	_add_cylinder(root, Vector3(-0.3, 0.76, 0.06), 0.012, 0.08, CREAM, false)
	_add_cylinder(root, Vector3(-0.15, 0.76, 0.05), 0.012, 0.07, CREAM.darkened(0.1), false)
	_add_cylinder(root, Vector3(0.2, 0.76, 0.06), 0.012, 0.09, Color(0.4, 0.55, 0.7), false)
	return root

# ─── Conservatory / hall ─────────────────────────────────────────────────────

static func _make_plant(prop: Dictionary) -> Node3D:
	## Prefer painted plant card when texture actually loads; else mesh canopy.
	## Never ship a solid brown quad (billboard fallback without texture).
	var tex_path: String = prop.get("texture", "")
	if tex_path != "":
		var tex := _load_tex(tex_path)
		if tex != null:
			var bp := prop.duplicate()
			bp["kind"] = "billboard_prop"
			bp["texture"] = tex_path
			bp["width"] = prop.get("width", 0.9 * float(prop.get("scale", 1.0)))
			bp["height"] = prop.get("height", 1.4 * float(prop.get("scale", 1.0)))
			bp["solid"] = true
			# FIXED_Y only — cross_planes doubled the pot silhouette.
			# Mesh terracotta pot under card so feet never float if PNG pot is sparse.
			bp["face_camera"] = true
			bp["cross_planes"] = false
			# Short/wide cards; deep sink grounds pot in FIXED_Y view
			var ph: float = float(bp.get("height", 1.1))
			var pw: float = float(bp.get("width", 0.95))
			if ph > 1.1:
				ph = 1.1
			if pw < 1.0:
				pw = maxf(pw, 1.0)
			if pw < ph * 0.9:
				pw = ph * 0.95
			bp["height"] = ph
			bp["width"] = pw
			bp["sink"] = 0.28
			bp["mesh_pot"] = false
			var root_plant := _make_billboard_prop(bp)
			_add_contact_shadow(root_plant, pw * 0.45, pw * 0.35)
			# Subtle flat leaves for side volume (small, dark — not obvious cards)
			var leaf_h := ph * 0.55
			var leaf_a := Color(0.16, 0.34, 0.1)
			for i in 3:
				var ang := float(i) * 2.1
				var lx := cos(ang) * 0.1 * pw
				var lz := sin(ang) * 0.1 * pw
				_add_box(root_plant, Vector3(lx, leaf_h + float(i) * 0.06, lz), Vector3(0.1 * pw, 0.015, 0.12 * pw), leaf_a, false, 0.92)
			return root_plant
	var root := Node3D.new()
	root.name = "Plant"
	var scale: float = prop.get("scale", 1.0)
	var tall: bool = prop.get("tall", false)
	var leaf_a := Color(0.26, 0.46, 0.2)
	var leaf_b := Color(0.18, 0.36, 0.14)
	var leaf_c := Color(0.32, 0.5, 0.24)
	var stem_col := Color(0.2, 0.3, 0.12)
	# Terracotta pot + soil
	_add_cylinder(root, Vector3(0, 0.18 * scale, 0), 0.2 * scale, 0.34 * scale, CLAY, true, 0.88)
	_add_cylinder(root, Vector3(0, 0.35 * scale, 0), 0.24 * scale, 0.05 * scale, CLAY.lightened(0.1), false, 0.88)
	_add_cylinder(root, Vector3(0, 0.37 * scale, 0), 0.17 * scale, 0.04 * scale, Color(0.16, 0.1, 0.06), false, 0.9)
	var stem_h := 0.42 * scale if tall else 0.22 * scale
	_add_cylinder(root, Vector3(0, 0.4 * scale + stem_h * 0.5, 0), 0.025 * scale, stem_h, stem_col, false, 0.9)
	# Bush canopy: layered horizontal discs + small spheres (no look_at pinwheels)
	var crown_y := 0.42 * scale + stem_h
	var layers := 4 if tall else 3
	for li in layers:
		var ly := crown_y + float(li) * 0.09 * scale
		var lr := (0.22 - float(li) * 0.03) * scale
		_add_cylinder(root, Vector3(0, ly, 0), lr, 0.05 * scale, leaf_a if li % 2 == 0 else leaf_b, false, 0.92)
		_add_sphere_blob(root, Vector3(lr * 0.4, ly + 0.02 * scale, 0), lr * 0.45, leaf_c)
		_add_sphere_blob(root, Vector3(-lr * 0.35, ly, lr * 0.3), lr * 0.4, leaf_a)
		_add_sphere_blob(root, Vector3(0.05 * scale, ly + 0.03 * scale, -lr * 0.35), lr * 0.38, leaf_b)
	_add_sphere_blob(root, Vector3(0, crown_y + float(layers) * 0.09 * scale, 0), 0.1 * scale, leaf_c)
	_add_contact_shadow(root, 0.22 * scale, 0.22 * scale)
	return root


static func _add_sphere_blob(parent: Node3D, pos: Vector3, radius: float, color: Color) -> void:
	## Soft foliage mass — sphere mesh, untextured leaf color (no iron/velvet).
	var mi := MeshInstance3D.new()
	var mesh := SphereMesh.new()
	mesh.radius = radius
	mesh.height = radius * 1.55
	mesh.radial_segments = 10
	mesh.rings = 6
	mi.mesh = mesh
	var mat := StandardMaterial3D.new()
	mat.albedo_color = color
	mat.roughness = 0.92
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_PER_PIXEL
	mi.material_override = mat
	mi.position = pos
	parent.add_child(mi)

static func _make_coat_stand(_prop: Dictionary) -> Node3D:
	## Turned hall tree with brass hooks — 1850s entrance hall staple.
	var root := Node3D.new()
	root.name = "CoatStand"
	_add_cylinder(root, Vector3(0, 0.95, 0), 0.045, 1.85, MAHOGANY, true, 0.45)
	_add_cylinder(root, Vector3(0, 0.35, 0), 0.07, 0.25, MAHOGANY_DARK, true, 0.45)
	_add_cylinder(root, Vector3(0, 0.05, 0), 0.28, 0.08, MAHOGANY, true, 0.45)
	# Turned rings
	for y in [0.55, 0.85, 1.25, 1.55]:
		_add_cylinder(root, Vector3(0, y, 0), 0.06, 0.04, MAHOGANY_DARK, false, 0.4)
	# Brass hat hooks
	for a in [0.0, 72.0, 144.0, 216.0, 288.0]:
		var rad := deg_to_rad(a)
		_add_box(root, Vector3(cos(rad) * 0.16, 1.62, sin(rad) * 0.16), Vector3(0.16, 0.025, 0.025), BRASS, false, 0.3)
		_add_cylinder(root, Vector3(cos(rad) * 0.22, 1.62, sin(rad) * 0.22), 0.02, 0.04, BRASS, false, 0.28, true)
	# Hanging coat / cloak suggestion (draped wool)
	_add_box(root, Vector3(0.14, 1.15, 0.06), Vector3(0.22, 0.85, 0.1), Color(0.18, 0.14, 0.12), false, 0.88)
	_add_box(root, Vector3(-0.1, 1.05, -0.08), Vector3(0.18, 0.55, 0.08), Color(0.22, 0.12, 0.1), false, 0.88)
	# Top hat on stand
	_add_cylinder(root, Vector3(0.05, 1.85, 0.05), 0.1, 0.04, Color(0.08, 0.08, 0.09), false, 0.7)
	_add_cylinder(root, Vector3(0.05, 1.95, 0.05), 0.07, 0.16, Color(0.1, 0.1, 0.11), false, 0.7)
	_add_contact_shadow(root, 0.32, 0.32)
	return root

static func _make_umbrella_stand(_prop: Dictionary) -> Node3D:
	## Ceramic/mahogany stick stand with brass rim (wet-day hall piece).
	var root := Node3D.new()
	root.name = "UmbrellaStand"
	_add_cylinder(root, Vector3(0, 0.32, 0), 0.15, 0.6, MAHOGANY_DARK, true, 0.45)
	_add_cylinder(root, Vector3(0, 0.62, 0), 0.17, 0.04, BRASS, false, 0.3, true)
	_add_cylinder(root, Vector3(0, 0.05, 0), 0.18, 0.06, MAHOGANY, true, 0.45)
	# Walking sticks / umbrella shafts
	_add_cylinder(root, Vector3(0.05, 0.95, 0.02), 0.018, 0.7, Color(0.2, 0.12, 0.08), false, 0.55)
	_add_cylinder(root, Vector3(-0.04, 0.88, -0.03), 0.016, 0.58, Color(0.12, 0.1, 0.1), false, 0.5)
	_add_cylinder(root, Vector3(0.02, 0.82, -0.05), 0.015, 0.5, Color(0.35, 0.22, 0.12), false, 0.55)
	_add_cylinder(root, Vector3(-0.06, 0.9, 0.04), 0.014, 0.55, Color(0.15, 0.12, 0.1), false, 0.5)
	# Crook handle
	_add_box(root, Vector3(0.05, 1.32, 0.02), Vector3(0.1, 0.03, 0.03), Color(0.2, 0.12, 0.08), false, 0.55)
	_add_contact_shadow(root, 0.2, 0.2)
	return root

# ─── Features ────────────────────────────────────────────────────────────────

static func _make_chandelier(_prop: Dictionary) -> Node3D:
	## Brass gasolier — warm glass shades (never black iron).
	var root := Node3D.new()
	root.name = "Chandelier"
	var hang: float = float(_prop.get("hang", 2.95))
	_add_cylinder(root, Vector3(0, hang + 0.25, 0), 0.02, 0.5, BRASS, false, 0.3, true)
	_add_cylinder(root, Vector3(0, hang, 0), 0.12, 0.06, BRASS, false, 0.28, true)
	_add_cylinder(root, Vector3(0, hang - 0.08, 0), 0.22, 0.04, BRASS.darkened(0.08), false, 0.3, true)
	for a in [0.0, 60.0, 120.0, 180.0, 240.0, 300.0]:
		var rad := deg_to_rad(a)
		var ax := cos(rad) * 0.28
		var az := sin(rad) * 0.28
		_add_box(root, Vector3(ax * 0.5, hang - 0.02, az * 0.5), Vector3(0.28, 0.025, 0.025), BRASS, false, 0.3)
		_add_cylinder(root, Vector3(ax, hang - 0.12, az), 0.04, 0.08, BRASS, false, 0.28, true)
		# Frosted glass shade — solid warm cream (alpha glass read black under metal mat)
		_add_cylinder(root, Vector3(ax, hang - 0.22, az), 0.055, 0.12, Color(0.92, 0.86, 0.7), false, 0.55)
	var light := OmniLight3D.new()
	light.light_color = Color(1.0, 0.88, 0.6)
	light.light_energy = 0.95
	light.omni_range = 7.0
	light.position = Vector3(0, hang - 0.2, 0)
	root.add_child(light)
	return root


static func _make_fireplace(_prop: Dictionary) -> Node3D:
	## Marble surround + dark firebox + logs — not a white Minecraft slab.
	var root := Node3D.new()
	root.name = "Fireplace"
	# Outer surround
	_add_box(root, Vector3(0, 0.72, -0.05), Vector3(1.75, 1.45, 0.42), MARBLE, true, 0.35)
	# Inner dark firebox recess
	_add_box(root, Vector3(0, 0.55, 0.12), Vector3(0.95, 0.85, 0.28), Color(0.06, 0.05, 0.05), false, 0.9)
	# Mantel shelf + ornaments
	_add_box(root, Vector3(0, 1.45, 0.02), Vector3(1.95, 0.1, 0.55), MARBLE, true, 0.3)
	_add_cylinder(root, Vector3(-0.55, 1.58, 0.05), 0.06, 0.18, BRASS, false, 0.3, true)
	_add_cylinder(root, Vector3(0.55, 1.58, 0.05), 0.06, 0.18, BRASS, false, 0.3, true)
	_add_box(root, Vector3(0, 1.55, 0.08), Vector3(0.2, 0.12, 0.1), Color(0.12, 0.1, 0.1), false, 0.4)
	# Columns / pilasters
	_add_box(root, Vector3(-0.72, 0.7, 0.12), Vector3(0.16, 1.25, 0.22), MARBLE, false, 0.32)
	_add_box(root, Vector3(0.72, 0.7, 0.12), Vector3(0.16, 1.25, 0.22), MARBLE, false, 0.32)
	# Hearth slab
	_add_box(root, Vector3(0, 0.04, 0.35), Vector3(1.5, 0.08, 0.55), STONE, true, 0.55)
	# Logs + glow
	_add_box(root, Vector3(-0.12, 0.22, 0.18), Vector3(0.55, 0.1, 0.16), MAHOGANY_DARK, false, 0.7)
	_add_box(root, Vector3(0.15, 0.28, 0.2), Vector3(0.45, 0.09, 0.14), MAHOGANY, false, 0.7)
	_add_box(root, Vector3(0.0, 0.34, 0.16), Vector3(0.35, 0.08, 0.12), Color(0.25, 0.12, 0.06), false, 0.8)
	var fire := OmniLight3D.new()
	fire.light_color = Color(1.0, 0.5, 0.2)
	fire.light_energy = 1.25
	fire.omni_range = 5.5
	fire.position = Vector3(0, 0.48, 0.35)
	root.add_child(fire)
	# Warm emissive card in firebox
	var em := MeshInstance3D.new()
	var em_mesh := BoxMesh.new()
	em_mesh.size = Vector3(0.7, 0.35, 0.04)
	em.mesh = em_mesh
	var emat := StandardMaterial3D.new()
	emat.albedo_color = Color(1.0, 0.45, 0.12)
	emat.emission_enabled = true
	emat.emission = Color(1.0, 0.4, 0.08)
	emat.emission_energy_multiplier = 2.4
	em.material_override = emat
	em.position = Vector3(0, 0.42, 0.22)
	root.add_child(em)
	_add_contact_shadow(root, 0.95, 0.55)
	return root

static func _make_window(feat: Dictionary) -> Node3D:
	## Sash-style window with OUTSIDE view plate behind glass (garden/street/yard).
	## Never a room photo — that reads as a painting/mirror mistake.
	var root := Node3D.new()
	root.name = "Window"
	var pos: Array = feat.get("pos", [0, 0, 0])
	root.position = Vector3(pos[0], pos[1], pos[2])
	root.rotation_degrees.y = feat.get("yaw", 0.0)
	var w: float = feat.get("width", 1.1)
	var h: float = feat.get("height", 1.85)
	var seed0: int = int(feat.get("seed", int(absf(pos[0] * 10.0 + pos[2] * 3.0))))
	_add_box(root, Vector3(0, h * 0.5, 0), Vector3(w + 0.08, h + 0.08, 0.14), MAHOGANY, true, 0.35)
	# Architrave + sill (period sash)
	_add_box(root, Vector3(0, h + 0.04, 0.02), Vector3(w + 0.18, 0.08, 0.16), MAHOGANY_DARK, false, 0.4)
	_add_box(root, Vector3(0, 0.04, 0.08), Vector3(w + 0.2, 0.08, 0.22), MAHOGANY, false, 0.42)
	# Mullion cross
	_add_box(root, Vector3(0, h * 0.5, 0.05), Vector3(0.05, h - 0.15, 0.04), MAHOGANY_DARK, false, 0.4)
	_add_box(root, Vector3(0, h * 0.5, 0.05), Vector3(w - 0.15, 0.05, 0.04), MAHOGANY_DARK, false, 0.4)
	# Exterior view plate (behind glass)
	var view_path: String = str(feat.get("view", ""))
	if view_path == "" or view_path.find("richmond_") >= 0 or view_path.find("wallpaper_") >= 0:
		view_path = VIEW_EXTERIORS[seed0 % VIEW_EXTERIORS.size()]
	var view_mi := MeshInstance3D.new()
	var vm := BoxMesh.new()
	vm.size = Vector3(w * 0.92, h * 0.92, 0.02)
	view_mi.mesh = vm
	var vmat := StandardMaterial3D.new()
	var vtex := _load_tex(view_path)
	if vtex:
		vmat.albedo_texture = vtex
		vmat.albedo_color = Color(0.95, 0.95, 0.92)
	else:
		vmat.albedo_color = Color(0.45, 0.62, 0.78)
	vmat.roughness = 0.95
	vmat.shading_mode = BaseMaterial3D.SHADING_MODE_PER_PIXEL
	view_mi.material_override = vmat
	view_mi.position = Vector3(0, h * 0.5, -0.07)
	root.add_child(view_mi)
	# Cool glass panes over view (slight alpha so exterior reads through)
	var gmat := StandardMaterial3D.new()
	gmat.albedo_color = Color(0.7, 0.82, 0.9, 0.22)
	gmat.metallic = 0.15
	gmat.roughness = 0.08
	gmat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	gmat.cull_mode = BaseMaterial3D.CULL_DISABLED
	for ox in [-1.0, 1.0]:
		for oy in [0.72, 0.28]:
			var pane := MeshInstance3D.new()
			var pm := BoxMesh.new()
			pm.size = Vector3(w * 0.38, h * 0.36, 0.015)
			pane.mesh = pm
			pane.material_override = gmat
			pane.position = Vector3(ox * w * 0.22, h * oy, 0.04)
			root.add_child(pane)
	# One fill light only (perf: not every pane)
	var fill := OmniLight3D.new()
	fill.light_color = Color(0.78, 0.88, 0.98)
	fill.light_energy = 0.4
	fill.omni_range = 3.5
	fill.position = Vector3(0, h * 0.55, 0.35)
	root.add_child(fill)
	return root

static func _make_glass_wall(feat: Dictionary) -> Node3D:
	## Conservatory iron-framed glass with garden exterior (not blank white void).
	var root := Node3D.new()
	root.name = "GlassWall"
	var pos: Array = feat.get("pos", [0, 0, 0])
	root.position = Vector3(pos[0], pos[1], pos[2])
	root.rotation_degrees.y = feat.get("yaw", 0.0)
	var w: float = feat.get("width", 2.5)
	var h: float = feat.get("height", 3.2)
	# Exterior garden: sky gradient suggestion + lawn + deep hedge bank
	_add_box(root, Vector3(0, h * 0.72, -0.26), Vector3(w + 0.2, h * 0.8, 0.04), Color(0.48, 0.62, 0.78), false, 0.98)
	_add_box(root, Vector3(0, h * 0.45, -0.25), Vector3(w + 0.2, h * 0.2, 0.04), Color(0.55, 0.68, 0.82), false, 0.98)
	_add_box(root, Vector3(0, h * 0.1, -0.22), Vector3(w + 0.2, h * 0.2, 0.05), Color(0.28, 0.42, 0.2), false, 0.92)
	_add_box(root, Vector3(0, h * 0.18, -0.17), Vector3(w * 0.96, h * 0.14, 0.16), Color(0.12, 0.3, 0.1), false, 0.88)
	_add_box(root, Vector3(0, h * 0.26, -0.15), Vector3(w * 0.9, h * 0.1, 0.12), Color(0.16, 0.36, 0.12), false, 0.88)
	for i in 7:
		var fx := -w * 0.42 + i * (w * 0.14)
		_add_sphere_blob(root, Vector3(fx, h * 0.3, -0.12), 0.11 + (i % 2) * 0.03, Color(0.16, 0.36, 0.12))
		_add_sphere_blob(root, Vector3(fx * 0.9, h * 0.22, -0.1), 0.09, Color(0.2, 0.4, 0.14))
	# Perimeter iron
	var bar := 0.06
	_add_box(root, Vector3(0, bar * 0.5, 0), Vector3(w, bar, 0.08), IRON, true, 0.45)
	_add_box(root, Vector3(0, h - bar * 0.5, 0), Vector3(w, bar, 0.08), IRON, true, 0.45)
	_add_box(root, Vector3(-w * 0.5 + bar * 0.5, h * 0.5, 0), Vector3(bar, h, 0.08), IRON, true, 0.45)
	_add_box(root, Vector3(w * 0.5 - bar * 0.5, h * 0.5, 0), Vector3(bar, h, 0.08), IRON, true, 0.45)
	# Mullion grid
	for i in 4:
		var fx2 := -w * 0.35 + i * (w * 0.23)
		_add_box(root, Vector3(fx2, h * 0.5, 0.01), Vector3(0.035, h - 0.12, 0.04), IRON.lightened(0.08), false, 0.45)
	for j in 3:
		var fy := h * 0.22 * (j + 1)
		_add_box(root, Vector3(0, fy, 0.01), Vector3(w - 0.12, 0.035, 0.04), IRON.lightened(0.08), false, 0.45)
	# Glass panes — low alpha cool blue-green
	var glass := MeshInstance3D.new()
	var gm := BoxMesh.new()
	gm.size = Vector3(w - 0.12, h - 0.12, 0.015)
	glass.mesh = gm
	var gmat := StandardMaterial3D.new()
	gmat.albedo_color = Color(0.65, 0.78, 0.82, 0.28)
	gmat.metallic = 0.2
	gmat.roughness = 0.1
	gmat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	gmat.cull_mode = BaseMaterial3D.CULL_DISABLED
	glass.material_override = gmat
	glass.position = Vector3(0, h * 0.5, 0.03)
	root.add_child(glass)
	var fill := OmniLight3D.new()
	fill.light_color = Color(0.78, 0.9, 0.95)
	fill.light_energy = 0.45
	fill.omni_range = 4.5
	fill.position = Vector3(0, h * 0.55, 0.55)
	root.add_child(fill)
	return root

static func _make_door_frame(feat: Dictionary) -> Node3D:
	## Mid-Victorian 4-panel door + architrave + brass furniture (c.1850s).
	## Root sits on floor at doorway center (ignores feature y so doors don't float).
	var root := Node3D.new()
	root.name = "DoorFrame"
	var pos: Array = feat.get("pos", [0, 0, 0])
	root.position = Vector3(float(pos[0]), 0.0, float(pos[2]))
	root.rotation_degrees.y = feat.get("yaw", 0.0)
	var w: float = feat.get("width", 1.5)
	var h: float = feat.get("height", 2.35)
	var jamb := 0.12
	var depth := 0.18
	# Outer architrave (doorcase)
	_add_box(root, Vector3(-w * 0.5 - 0.06, h * 0.5, 0), Vector3(0.14, h + 0.08, depth + 0.06), MAHOGANY_DARK, true, 0.4)
	_add_box(root, Vector3(w * 0.5 + 0.06, h * 0.5, 0), Vector3(0.14, h + 0.08, depth + 0.06), MAHOGANY_DARK, true, 0.4)
	_add_box(root, Vector3(0, h + 0.05, 0), Vector3(w + 0.34, 0.14, depth + 0.08), MAHOGANY, true, 0.4)
	# Inner stop mould
	_add_box(root, Vector3(-w * 0.5 + 0.02, h * 0.5, 0.06), Vector3(0.04, h - 0.05, 0.04), MAHOGANY, false, 0.45)
	_add_box(root, Vector3(w * 0.5 - 0.02, h * 0.5, 0.06), Vector3(0.04, h - 0.05, 0.04), MAHOGANY, false, 0.45)
	# Threshold / saddle (stone + wood — grounds the doorway)
	_add_box(root, Vector3(0, 0.025, 0.02), Vector3(w + 0.14, 0.05, depth + 0.18), STONE, false, 0.65)
	_add_box(root, Vector3(0, 0.055, 0.02), Vector3(w + 0.08, 0.04, depth + 0.1), MAHOGANY_DARK, false, 0.45)
	# --- Door leaf CLOSED (E teleports; do not leave walk-into-void gap) ---
	var leaf_w := w - 0.1
	var leaf_h := h - 0.12
	var leaf := Node3D.new()
	leaf.name = "DoorLeaf"
	leaf.position = Vector3(-w * 0.5 + 0.05, 0.07, 0.04)
	leaf.rotation_degrees.y = 0.0  # closed — room change is interact/teleport only
	root.add_child(leaf)
	# Polished mid-mahogany slab — colors biased so auto-mat picks WOOD not red velvet
	var door_wood := Color(0.42, 0.28, 0.16)
	var door_frame_col := Color(0.34, 0.22, 0.12)
	var panel_field := Color(0.36, 0.24, 0.14)
	# solid=true so player cannot walk through the closed leaf into void
	_add_box(leaf, Vector3(leaf_w * 0.5, leaf_h * 0.5, 0), Vector3(leaf_w, leaf_h, 0.048), door_wood, true, 0.42)
	# Stiles & rails (classic 4-panel)
	var stile := 0.11
	var mid_rail_y := leaf_h * 0.4
	_add_box(leaf, Vector3(stile * 0.5, leaf_h * 0.5, 0.028), Vector3(stile, leaf_h, 0.025), door_frame_col, false, 0.4)
	_add_box(leaf, Vector3(leaf_w - stile * 0.5, leaf_h * 0.5, 0.028), Vector3(stile, leaf_h, 0.025), door_frame_col, false, 0.4)
	_add_box(leaf, Vector3(leaf_w * 0.5, leaf_h - stile * 0.5, 0.028), Vector3(leaf_w, stile, 0.025), door_frame_col, false, 0.4)
	_add_box(leaf, Vector3(leaf_w * 0.5, stile * 0.5, 0.028), Vector3(leaf_w, stile, 0.025), door_frame_col, false, 0.4)
	_add_box(leaf, Vector3(leaf_w * 0.5, mid_rail_y, 0.028), Vector3(leaf_w - stile * 1.8, stile * 0.9, 0.025), door_frame_col, false, 0.4)
	_add_box(leaf, Vector3(leaf_w * 0.5, leaf_h * 0.5, 0.028), Vector3(stile * 0.8, leaf_h - stile * 2.0, 0.022), door_frame_col, false, 0.4)
	# Four fielded panels — raised lip + recessed field (readable silhouette)
	var pw := (leaf_w - stile * 2.4) * 0.44
	var ph_lo := mid_rail_y - stile * 1.5
	var ph_hi := leaf_h - mid_rail_y - stile * 1.5
	for side in [-1.0, 1.0]:
		var sx: float = float(side)
		var lx: float = leaf_w * 0.5 + sx * (pw * 0.55 + stile * 0.2)
		# lower panels
		_add_box(leaf, Vector3(lx, mid_rail_y * 0.52, 0.02), Vector3(pw, ph_lo * 0.78, 0.018), panel_field, false, 0.5)
		_add_box(leaf, Vector3(lx, mid_rail_y * 0.52, 0.035), Vector3(pw * 0.78, ph_lo * 0.58, 0.012), door_wood.lightened(0.1), false, 0.48)
		# upper panels
		var uy: float = mid_rail_y + (leaf_h - mid_rail_y) * 0.52
		_add_box(leaf, Vector3(lx, uy, 0.02), Vector3(pw, ph_hi * 0.78, 0.018), panel_field, false, 0.5)
		_add_box(leaf, Vector3(lx, uy, 0.035), Vector3(pw * 0.78, ph_hi * 0.58, 0.012), door_wood.lightened(0.1), false, 0.48)
	# Brass mortice-lock furniture (reads clearly on closed leaf)
	var knob_x := leaf_w - 0.18
	var knob_y := mid_rail_y + 0.08
	_add_box(leaf, Vector3(knob_x, knob_y - 0.02, 0.04), Vector3(0.08, 0.14, 0.02), BRASS.darkened(0.15), false, 0.3)
	_add_cylinder(leaf, Vector3(knob_x, knob_y, 0.06), 0.045, 0.02, BRASS, false, 0.28, true)
	_add_cylinder(leaf, Vector3(knob_x, knob_y, 0.1), 0.035, 0.05, BRASS.lightened(0.1), false, 0.25, true)
	_add_box(leaf, Vector3(knob_x, knob_y - 0.1, 0.055), Vector3(0.05, 0.09, 0.016), BRASS, false, 0.28)
	# Three butt hinges on hinge stile
	for hy in [0.32, leaf_h * 0.5, leaf_h - 0.38]:
		_add_box(leaf, Vector3(0.04, hy, 0.045), Vector3(0.05, 0.16, 0.04), BRASS, false, 0.32)
	return root

static func _make_mirror(feat: Dictionary) -> Node3D:
	## Victorian overmantel / wall mirror: gilt frame + silvered glass that
	## *reads as reflective* (metallic + env) — not a room photo in a frame.
	var root := Node3D.new()
	root.name = "Mirror"
	var pos: Array = feat.get("pos", [0, 0, 0])
	root.position = Vector3(pos[0], pos[1], pos[2])
	root.rotation_degrees.y = feat.get("yaw", 0.0)
	var w: float = float(feat.get("width", 1.05))
	var h: float = float(feat.get("height", 1.45))
	# Ornate gilt frame + dark liner
	_add_box(root, Vector3(0, 0, 0), Vector3(w + 0.08, h + 0.08, 0.1), BRASS, true, 0.32)
	_add_box(root, Vector3(0, 0, 0.03), Vector3(w - 0.02, h - 0.02, 0.04), BRASS.darkened(0.15), false, 0.35)
	_add_box(root, Vector3(0, 0, 0.04), Vector3(w - 0.12, h - 0.12, 0.03), Color(0.18, 0.12, 0.08), false, 0.55)
	# Crest
	_add_box(root, Vector3(0, h * 0.5 + 0.06, 0.02), Vector3(0.18, 0.1, 0.05), BRASS.lightened(0.08), false, 0.3)
	# Silvered plate — high metal, low roughness so room lights/env reflect
	var glass := MeshInstance3D.new()
	var gm := BoxMesh.new()
	gm.size = Vector3(w - 0.18, h - 0.18, 0.015)
	glass.mesh = gm
	var gmat := StandardMaterial3D.new()
	gmat.albedo_color = Color(0.55, 0.62, 0.68)
	gmat.metallic = 0.95
	gmat.roughness = 0.06
	gmat.specular_mode = BaseMaterial3D.SPECULAR_SCHLICK_GGX
	gmat.shading_mode = BaseMaterial3D.SHADING_MODE_PER_PIXEL
	glass.material_override = gmat
	glass.position = Vector3(0, 0, 0.055)
	root.add_child(glass)
	# Soft catch-light so glass never reads as a black painting hole
	var catch_l := OmniLight3D.new()
	catch_l.light_color = Color(0.9, 0.92, 1.0)
	catch_l.light_energy = 0.25
	catch_l.omni_range = 1.6
	catch_l.position = Vector3(0.15, 0.2, 0.35)
	root.add_child(catch_l)
	return root

static func _make_painting(feat: Dictionary) -> Node3D:
	## Gilt-frame oil: landscape / still life / portrait — NEVER a room photo
	## (room photos read as windows or nonsense mirrors).
	var root := Node3D.new()
	root.name = "Painting"
	var pos: Array = feat.get("pos", [0, 0, 0])
	root.position = Vector3(pos[0], pos[1], pos[2])
	root.rotation_degrees.y = feat.get("yaw", 0.0)
	var w: float = feat.get("width", 0.85)
	var h: float = feat.get("height", 1.05)
	var seed0: int = int(feat.get("seed", int(absf(pos[0] * 7.0 + pos[2] * 5.0 + w * 11.0))))
	var kind: String = str(feat.get("art", "auto"))
	# Outer gilt frame + dark liner + hanging cord knob
	_add_box(root, Vector3(0, 0, 0), Vector3(w + 0.06, h + 0.06, 0.1), BRASS, true, 0.32)
	_add_box(root, Vector3(0, 0, 0.028), Vector3(w - 0.02, h - 0.02, 0.04), BRASS.darkened(0.12), false, 0.35)
	_add_box(root, Vector3(0, 0, 0.035), Vector3(w - 0.12, h - 0.12, 0.03), Color(0.2, 0.12, 0.07), false, 0.55)
	_add_box(root, Vector3(0, h * 0.5 + 0.09, 0.01), Vector3(0.04, 0.1, 0.03), BRASS.darkened(0.1), false, 0.35)
	var canvas := MeshInstance3D.new()
	var cm := BoxMesh.new()
	cm.size = Vector3(w - 0.18, h - 0.18, 0.02)
	canvas.mesh = cm
	var cmat := StandardMaterial3D.new()
	var tex_path: String = str(feat.get("texture", ""))
	# Reject wrong textures that look like windows into rooms
	var bad := (
		tex_path == ""
		or tex_path.find("wallpaper_") >= 0
		or tex_path.find("richmond_") >= 0
		or tex_path.find("view_") >= 0
		or tex_path == TEX_WALLPAPER
	)
	if bad:
		if kind == "still_life" or (kind == "auto" and seed0 % 5 == 0):
			tex_path = ART_STILL_LIFES[seed0 % ART_STILL_LIFES.size()]
		elif kind == "portrait" or (kind == "auto" and seed0 % 5 == 1):
			# Character portraits as framed oils (period salon practice)
			var portraits := [
				"res://assets/portraits/portrait_bell.jpg",
				"res://assets/portraits/portrait_selina.jpg",
				"res://assets/portraits/portrait_amara.jpg",
				"res://assets/portraits/portrait_clara.jpg",
				"res://assets/portraits/portrait_rooke.jpg",
				"res://assets/portraits/portrait_elspeth.jpg",
			]
			tex_path = portraits[seed0 % portraits.size()]
		else:
			tex_path = ART_LANDSCAPES[seed0 % ART_LANDSCAPES.size()]
	var tex := _load_tex(tex_path)
	if tex == null:
		tex = _load_tex(ART_LANDSCAPES[0])
	if tex:
		cmat.albedo_texture = tex
		cmat.albedo_color = Color(0.92, 0.88, 0.78)  # varnish warmth
		cmat.uv1_scale = Vector3(1.0, 1.0, 1.0)
	else:
		cmat.albedo_color = Color(0.28, 0.35, 0.28)
	cmat.roughness = 0.7
	cmat.shading_mode = BaseMaterial3D.SHADING_MODE_PER_PIXEL
	canvas.material_override = cmat
	canvas.position = Vector3(0, 0, 0.05)
	root.add_child(canvas)
	return root

# ─── Billboard hero furniture (painted cards) ────────────────────────────────

static func _make_billboard_prop(prop: Dictionary) -> Node3D:
	## Alpha-cut painted card. Ground-aligned (bottom of quad on floor).
	## face_camera=true → FIXED_Y billboard (plants); false → fixed room yaw (furniture).
	## cross_planes=true (default for face_camera plants) → second card at 90° so
	## the silhouette has volume from every angle (classic FPS tree trick).
	var root := Node3D.new()
	root.name = "BillboardProp"
	var tex_path: String = prop.get("texture", "")
	var width: float = prop.get("width", 1.0)
	var height: float = prop.get("height", 1.1)
	# Ground align: center of quad is at height/2 so feet sit on floor (y=0)
	var y_off: float = prop.get("y_offset", height * 0.5)
	# Slight sink so transparent padding doesn't make objects float
	var sink: float = float(prop.get("sink", 0.04))
	y_off = y_off - sink
	var solid: bool = prop.get("solid", true)
	var face_camera: bool = bool(prop.get("face_camera", false))
	var cross_planes: bool = bool(prop.get("cross_planes", face_camera))
	var mesh_pot: bool = bool(prop.get("mesh_pot", false))

	if mesh_pot:
		# Compact terracotta under card (not wood-textured barrels)
		var pot_r: float = clampf(width * 0.22, 0.16, 0.32)
		_add_cylinder(root, Vector3(0, 0.16, 0), pot_r, 0.28, CLAY, true, 0.85)
		_add_cylinder(root, Vector3(0, 0.3, 0), pot_r * 1.12, 0.04, CLAY.lightened(0.12), false, 0.85)
		_add_cylinder(root, Vector3(0, 0.32, 0), pot_r * 0.85, 0.03, Color(0.2, 0.14, 0.08), false, 0.9)

	var mesh := QuadMesh.new()
	mesh.size = Vector2(width, height)
	var mat := StandardMaterial3D.new()
	var tex := _load_tex(tex_path)
	if tex:
		mat.albedo_texture = tex
		mat.albedo_color = Color(1, 1, 1)
	else:
		mat.albedo_color = MAHOGANY
	mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA_SCISSOR
	# Plants: low scissor keeps stem links; furniture cards keep cleaner cutouts
	var is_plant_card := tex_path.find("plant_") >= 0
	mat.alpha_scissor_threshold = 0.28 if is_plant_card else 0.48
	mat.cull_mode = BaseMaterial3D.CULL_DISABLED
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_PER_PIXEL
	mat.texture_filter = BaseMaterial3D.TEXTURE_FILTER_LINEAR_WITH_MIPMAPS
	mat.depth_draw_mode = BaseMaterial3D.DEPTH_DRAW_OPAQUE_ONLY
	if face_camera and not cross_planes:
		mat.billboard_mode = BaseMaterial3D.BILLBOARD_FIXED_Y
	else:
		mat.billboard_mode = BaseMaterial3D.BILLBOARD_DISABLED

	var mi := MeshInstance3D.new()
	mi.mesh = mesh
	mi.material_override = mat
	mi.position = Vector3(0, y_off, 0)
	root.add_child(mi)

	if cross_planes:
		# Second card at 90° — reads as a plant from any walk-around angle
		var mi_x := MeshInstance3D.new()
		mi_x.mesh = mesh
		mi_x.material_override = mat
		mi_x.position = Vector3(0, y_off, 0)
		mi_x.rotation_degrees.y = 90.0
		root.add_child(mi_x)
	elif not face_camera:
		# Back face for fixed furniture cards only
		var mi_b := MeshInstance3D.new()
		mi_b.mesh = mesh
		mi_b.material_override = mat
		mi_b.position = Vector3(0, y_off, -0.05)
		mi_b.rotation_degrees.y = 180.0
		root.add_child(mi_b)

	if solid:
		var body := StaticBody3D.new()
		var col := CollisionShape3D.new()
		var shape := BoxShape3D.new()
		var depth_col: float = width * 0.45 if cross_planes else 0.35
		shape.size = Vector3(width * 0.65, height * 0.75, depth_col)
		col.shape = shape
		col.position = Vector3(0, maxf(y_off * 0.85, 0.35), 0)
		body.add_child(col)
		root.add_child(body)

	_add_contact_shadow(root, width * 0.4, 0.32)
	return root

# ─── Materials / primitives ──────────────────────────────────────────────────

static func _book_color(seed: int) -> Color:
	## Leather / cloth bindings — avoid bright Minecraft green blocks.
	var hues := [
		Color(0.38, 0.14, 0.10),  # oxblood
		Color(0.16, 0.20, 0.30),  # navy
		Color(0.34, 0.22, 0.12),  # tan leather
		Color(0.48, 0.12, 0.10),  # crimson
		Color(0.22, 0.18, 0.14),  # dark brown
		Color(0.28, 0.24, 0.18),  # buff
		Color(0.14, 0.16, 0.14),  # near-black green-brown
		Color(0.40, 0.30, 0.18),  # mustard cloth
	]
	return hues[seed % hues.size()]

static func _load_tex(path: String) -> Texture2D:
	if path == "":
		return null
	if ResourceLoader.exists(path):
		var r = load(path)
		if r is Texture2D:
			return r
	var abs_path := ProjectSettings.globalize_path(path)
	if FileAccess.file_exists(abs_path):
		var img := Image.new()
		if img.load(abs_path) == OK:
			return ImageTexture.create_from_image(img)
	return null

static func _wood_path_for_color(color: Color, size: Vector3) -> String:
	## Species by colour + size: cutting boards/light oak ≠ polished mahogany tables.
	var area := size.x * size.z
	var bright := color.v
	# Tiny light boards (prep surfaces, boxes) → scrubbed / pine
	if bright > 0.55 or (area < 0.35 and bright > 0.4):
		if color.g > color.r * 0.85 and bright > 0.6:
			return TEX_WOOD_SCRUBBED
		return TEX_WOOD_PINE
	# Very dark frames / ebony accents
	if bright < 0.22 or color.r < 0.2:
		return TEX_WOOD_EBONY
	# Red-brown polished furniture → mahogany
	if color.r > color.g + 0.06 and color.r > 0.22 and bright < 0.45:
		return TEX_WOOD_MAHOGANY
	# Mid warm brown → oak (shelves, kitchen oak)
	if bright >= 0.35:
		return TEX_WOOD_OAK
	# Fallback generic furniture wood
	return TEX_WOOD


static func _mat_for(color: Color, roughness: float, size: Vector3) -> StandardMaterial3D:
	## Auto-pick wood/fabric/metal texture so furniture isn't flat Minecraft blocks.
	## Wood species vary so boards ≠ tables ≠ shelves.
	var mat := StandardMaterial3D.new()
	mat.roughness = roughness
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_PER_PIXEL
	var tex_path := ""
	var metallic := 0.0
	var wood_tint := 0.32
	# Copper
	if color.r > 0.55 and color.g > 0.25 and color.g < 0.55 and color.b < 0.35 and color.r > color.g:
		tex_path = TEX_COPPER
		metallic = 0.75
		mat.roughness = minf(roughness, 0.4)
	# Brass / gold
	elif color.r > 0.55 and color.g > 0.4 and color.b < 0.4 and color.r >= color.g:
		tex_path = TEX_BRASS
		metallic = 0.7
		mat.roughness = minf(roughness, 0.4)
	# Iron / dark metal (exclude plant greens — LEAF_DARK was matching iron)
	elif (
		color.r < 0.32 and color.g < 0.32 and color.b < 0.35 and color.v < 0.35
		and color.g <= color.r + 0.04
	):
		tex_path = TEX_IRON
		metallic = 0.65
		mat.roughness = minf(roughness, 0.55)
	# Mahogany / wood browns / oak FIRST — dark red-browns are wood, not velvet.
	# Exclude terracotta/clay (g around 0.45–0.55 with high r).
	elif (
		color.r > 0.12 and color.r >= color.g * 0.85 and color.r > color.b
		and color.g < 0.42 and color.g > 0.08
		and color.r < 0.72
	):
		tex_path = _wood_path_for_color(color, size)
		# Larger furniture: coarser UV; small boards: finer grain
		wood_tint = 0.38 if size.x * size.z < 0.4 else 0.26
	# Light scrubbed oak / pale wood (prep tops)
	elif color.r > 0.55 and color.g > 0.4 and color.b > 0.2 and color.r < 0.85 and color.g < 0.7:
		tex_path = TEX_WOOD_SCRUBBED if color.v > 0.55 else TEX_WOOD_PINE
		wood_tint = 0.42
	# Red velvet (true fabric reds — high r, low g relative, not brown wood)
	elif color.r > 0.45 and color.g < 0.22 and color.b < 0.22 and color.r > color.g + 0.25:
		tex_path = TEX_VELVET_RED
	# Green velvet (muted furniture fabric only — NOT bright plant leaf greens)
	elif (
		color.g > color.r + 0.02
		and color.g > color.b * 0.85
		and color.g > 0.15
		and color.g < 0.38
		and absf(color.r - color.b) < 0.12
	):
		if color.g < 0.28:
			tex_path = TEX_VELVET_GREEN_DEEP
		else:
			tex_path = TEX_VELVET_GREEN
	# Linen / cream fabric
	elif color.r > 0.7 and color.g > 0.65 and color.b > 0.5 and color.r - color.b < 0.25:
		tex_path = TEX_LINEN
	# Marble (very pale)
	elif color.r > 0.75 and color.g > 0.72 and color.b > 0.68 and absf(color.r - color.g) < 0.08:
		tex_path = TEX_MARBLE
	# Stone / mid grey-brown
	elif color.r > 0.45 and color.g > 0.42 and color.b > 0.36 and absf(color.r - color.g) < 0.1:
		tex_path = TEX_STONE

	var tex := _load_tex(tex_path)
	if tex:
		mat.albedo_texture = tex
		mat.albedo_color = Color(1, 1, 1).lerp(color, wood_tint if tex_path.begins_with("res://assets/rooms/textures/wood") or tex_path == TEX_WOOD else 0.28)
		mat.metallic = metallic
		var u: float = clampf(size.x * 1.2 + size.z * 0.8, 0.5, 5.0)
		var v: float = clampf(size.y * 1.4, 0.5, 5.0)
		# Small boards: denser grain; large tabletops: broader planks
		if size.x * size.z < 0.25:
			u = clampf(u * 1.8, 1.0, 6.0)
			v = clampf(v * 1.8, 1.0, 6.0)
		mat.uv1_scale = Vector3(u, v, 1.0)
	else:
		mat.albedo_color = color
		mat.metallic = metallic
	return mat

static func _add_contact_shadow(parent: Node3D, rx: float, rz: float) -> void:
	## Soft dark disc under furniture for grounding (Myst still-life weight).
	var mi := MeshInstance3D.new()
	mi.name = "ContactShadow"
	var mesh := CylinderMesh.new()
	mesh.top_radius = rx
	mesh.bottom_radius = rx
	mesh.height = 0.015
	mi.mesh = mesh
	var mat := StandardMaterial3D.new()
	mat.albedo_color = Color(0.02, 0.015, 0.01, 0.45)
	mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	mat.cull_mode = BaseMaterial3D.CULL_DISABLED
	mi.material_override = mat
	# Above floor, below rug — avoid coplanar flicker
	mi.position = Vector3(0, 0.02, 0)
	mi.scale = Vector3(1.0, 1.0, rz / maxf(rx, 0.01))
	parent.add_child(mi)

static func _add_box(
	parent: Node3D,
	pos: Vector3,
	size: Vector3,
	color: Color,
	solid: bool,
	roughness: float = 0.8,
) -> void:
	var body := StaticBody3D.new() if solid else Node3D.new()
	var mesh := BoxMesh.new()
	mesh.size = size
	var mi := MeshInstance3D.new()
	mi.mesh = mesh
	mi.material_override = _mat_for(color, roughness, size)
	body.add_child(mi)
	if solid:
		var col := CollisionShape3D.new()
		var shape := BoxShape3D.new()
		shape.size = size
		col.shape = shape
		body.add_child(col)
	body.position = pos
	parent.add_child(body)

static func _add_cylinder(
	parent: Node3D,
	pos: Vector3,
	radius: float,
	height: float,
	color: Color,
	solid: bool,
	roughness: float = 0.75,
	use_metal_tex: bool = false,
) -> void:
	var body := StaticBody3D.new() if solid else Node3D.new()
	var mesh := CylinderMesh.new()
	mesh.top_radius = radius
	mesh.bottom_radius = radius
	mesh.height = height
	var mi := MeshInstance3D.new()
	mi.mesh = mesh
	if use_metal_tex or color.a >= 0.99:
		mi.material_override = _mat_for(color, roughness, Vector3(radius * 2.0, height, radius * 2.0))
		# Preserve alpha for glass-like cylinders
		if color.a < 0.98:
			var m: StandardMaterial3D = mi.material_override
			m.albedo_color = color
			m.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
			m.metallic = 0.2
			m.roughness = 0.12
	else:
		var mat := StandardMaterial3D.new()
		mat.albedo_color = color
		mat.roughness = roughness
		mat.shading_mode = BaseMaterial3D.SHADING_MODE_PER_PIXEL
		if color.a < 0.98:
			mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
		mi.material_override = mat
	body.add_child(mi)
	if solid:
		var col := CollisionShape3D.new()
		var shape := CylinderShape3D.new()
		shape.radius = radius
		shape.height = height
		col.shape = shape
		body.add_child(col)
	body.position = pos
	parent.add_child(body)
