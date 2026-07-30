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
# Loop 69: full oil plates (not flat clip-art) — pastoral, storm, park, ruin, still-life, botanical.
const ART_LANDSCAPES := [
	"res://assets/rooms/textures/art/landscape_pastoral.jpg",
	"res://assets/rooms/textures/art/landscape_pastoral2.jpg",
	"res://assets/rooms/textures/art/landscape_seascape.jpg",
	"res://assets/rooms/textures/art/landscape_storm.jpg",
	"res://assets/rooms/textures/art/landscape_park.jpg",
	"res://assets/rooms/textures/art/landscape_ruin.jpg",
]
const ART_STILL_LIFES := [
	"res://assets/rooms/textures/art/still_life_fruit.jpg",
	"res://assets/rooms/textures/art/still_life_dark.jpg",
	"res://assets/rooms/textures/art/still_life_kitchen.jpg",
]
const ART_BOTANICALS := [
	"res://assets/rooms/textures/art/botanical_palm.jpg",
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
		"letter_stack":
			node = _make_letter_stack(prop)
		"tea_tray":
			node = _make_tea_tray(prop)
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
		"wicker_basket":
			node = _make_wicker_basket(prop)
		"stool":
			node = _make_stool(prop)
		"copper_pot":
			node = _make_copper_pot(prop)
		"copper_scrap":
			node = _make_copper_scrap(prop)
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
		"oil_lamp":
			node = _make_oil_lamp(prop)
		"chandelier":
			node = _make_chandelier(prop)
		"chalk_board":
			node = _make_chalk_board(prop)
		"garden_bench":
			node = _make_garden_bench(prop)
		"dust_motes":
			node = _make_dust_motes(prop)
		"urn":
			node = _make_urn(prop)
		"watering_can":
			node = _make_watering_can(prop)
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
	# Loop 88: open pigeonhole gallery (not solid black slab from behind)
	_add_box(root, Vector3(0, top_y + 0.08, -0.3), Vector3(1.38, 0.04, 0.22), MAHOGANY_DARK, false, 0.45)
	_add_box(root, Vector3(0, top_y + 0.38, -0.32), Vector3(1.4, 0.05, 0.08), MAHOGANY, false, 0.45)
	# Side uprights + open compartments
	for sx in [-1.0, 1.0]:
		_add_box(root, Vector3(sx * 0.68, top_y + 0.23, -0.3), Vector3(0.05, 0.3, 0.2), MAHOGANY, false, 0.45)
	for i in 3:
		var gx := -0.4 + float(i) * 0.4
		_add_box(root, Vector3(gx, top_y + 0.23, -0.32), Vector3(0.03, 0.28, 0.06), MAHOGANY_DARK, false, 0.48)
	# Letters / ink in pigeonholes (low so not a dark wall)
	_add_box(root, Vector3(-0.4, top_y + 0.14, -0.28), Vector3(0.12, 0.08, 0.08), PAPER.darkened(0.05), false)
	_add_box(root, Vector3(0.0, top_y + 0.14, -0.28), Vector3(0.1, 0.06, 0.08), PAPER, false)
	_add_box(root, Vector3(0.4, top_y + 0.14, -0.28), Vector3(0.08, 0.1, 0.08), Color(0.35, 0.18, 0.1), false, 0.6)
	# Loop 126 still-life: papers + ink + proper candlestick (not brass disc + stick)
	_add_box(root, Vector3(0.28, top_y + 0.04, 0.12), Vector3(0.34, 0.012, 0.24), PAPER, false)
	_add_box(root, Vector3(0.32, top_y + 0.05, 0.08), Vector3(0.22, 0.01, 0.16), PAPER.darkened(0.05), false)
	_add_box(root, Vector3(-0.25, top_y + 0.04, -0.05), Vector3(0.28, 0.01, 0.2), PAPER, false)
	_add_box(root, Vector3(0.05, top_y + 0.06, -0.12), Vector3(0.055, 0.05, 0.055), INK, false)
	_add_cylinder(root, Vector3(0.12, top_y + 0.09, -0.08), 0.012, 0.14, MAHOGANY, false)
	# Candlestick: wood base + drip pan + cream taper
	_add_cylinder(root, Vector3(-0.35, top_y + 0.02, 0.15), 0.055, 0.035, MAHOGANY_DARK, false, 0.5)
	_add_cylinder(root, Vector3(-0.35, top_y + 0.08, 0.15), 0.028, 0.09, MAHOGANY, false, 0.48)
	_add_cylinder(root, Vector3(-0.35, top_y + 0.13, 0.15), 0.045, 0.02, BRASS.darkened(0.2), false, 0.35, true)
	_add_cylinder(root, Vector3(-0.35, top_y + 0.26, 0.15), 0.02, 0.22, CANDLE, false, 0.6)
	_add_sphere_blob(root, Vector3(-0.35, top_y + 0.38, 0.15), 0.028, Color(1.0, 0.78, 0.4))
	_add_box(root, Vector3(0.45, top_y + 0.05, -0.15), Vector3(0.12, 0.04, 0.08), Color(0.55, 0.12, 0.1), false)
	_add_contact_shadow(root, 0.9, 0.55)
	var flame := OmniLight3D.new()
	flame.light_color = Color(1.0, 0.78, 0.42)
	flame.light_energy = 0.45
	flame.omni_range = 2.6
	flame.position = Vector3(-0.35, top_y + 0.36, 0.15)
	root.add_child(flame)
	return root

static func _make_chair(prop: Dictionary) -> Node3D:
	## Victorian side chair (loop 134): open back with elegant splat, padded seat,
	## turned legs — not a stack of wood blocks from the side.
	if prop.get("billboard", false) and prop.get("texture", "") != "":
		return _make_billboard_prop(prop)
	var root := Node3D.new()
	root.name = "Chair"
	var seed0: int = int(prop.get("seed", 0))
	var fabric: Color = prop.get("fabric", VELVET_GREEN if seed0 % 2 == 0 else VELVET_RED.darkened(0.15))
	var fabric_d := fabric.darkened(0.12)
	# Seat rail + deep cushion (one mass)
	_add_box(root, Vector3(0, 0.42, 0.02), Vector3(0.5, 0.08, 0.5), MAHOGANY, true, 0.48)
	_add_box(root, Vector3(0, 0.5, 0.02), Vector3(0.46, 0.1, 0.46), fabric, true, 0.9)
	_add_box(root, Vector3(0, 0.56, 0.02), Vector3(0.4, 0.04, 0.4), fabric_d, false, 0.92)
	# Seat piping
	_add_box(root, Vector3(0, 0.52, 0.25), Vector3(0.44, 0.012, 0.018), fabric.darkened(0.18), false, 0.9)
	for i in 5:
		_add_cylinder(root, Vector3(-0.18 + float(i) * 0.09, 0.46, 0.26), 0.009, 0.012, BRASS, false, 0.3, true)
	# Slim uprights (not thick posts)
	for sx in [-1.0, 1.0]:
		_add_box(root, Vector3(sx * 0.21, 0.95, -0.2), Vector3(0.045, 0.9, 0.05), MAHOGANY, true, 0.48)
		_add_cylinder(root, Vector3(sx * 0.21, 0.95, -0.2), 0.022, 0.85, MAHOGANY_DARK, false, 0.48)
	# Crest rail
	_add_box(root, Vector3(0, 1.36, -0.19), Vector3(0.46, 0.08, 0.055), MAHOGANY, false, 0.45)
	_add_box(root, Vector3(0, 1.42, -0.18), Vector3(0.28, 0.04, 0.04), MAHOGANY.lightened(0.06), false, 0.45)
	# Lower back rail
	_add_box(root, Vector3(0, 0.58, -0.2), Vector3(0.4, 0.05, 0.04), MAHOGANY_DARK, false, 0.48)
	# Splat by seed
	match seed0 % 3:
		0:
			# Open vertical bars (air between — not solid slab)
			for bx in [-0.1, 0.0, 0.1]:
				_add_box(root, Vector3(bx, 0.98, -0.18), Vector3(0.035, 0.65, 0.03), MAHOGANY, false, 0.5)
			_add_box(root, Vector3(0, 1.15, -0.18), Vector3(0.32, 0.03, 0.03), MAHOGANY_DARK, false, 0.5)
		1:
			# Padded balloon insert in wood oval rim
			_add_box(root, Vector3(0, 1.02, -0.2), Vector3(0.32, 0.55, 0.04), MAHOGANY, false, 0.48)
			_add_box(root, Vector3(0, 1.02, -0.15), Vector3(0.26, 0.48, 0.05), fabric, false, 0.88)
			_add_cylinder(root, Vector3(0, 1.05, -0.13), 0.12, 0.35, fabric_d, false, 0.88)
			for bi in 2:
				_add_cylinder(root, Vector3((float(bi) - 0.5) * 0.1, 1.05, -0.1), 0.012, 0.014, fabric.darkened(0.2), false, 0.9)
		_:
			# Lyre splat
			_add_box(root, Vector3(0, 0.98, -0.18), Vector3(0.06, 0.65, 0.035), MAHOGANY_DARK, false, 0.5)
			_add_box(root, Vector3(0, 1.2, -0.17), Vector3(0.26, 0.05, 0.03), MAHOGANY, false, 0.5)
			for sx in [-1.0, 1.0]:
				_add_box(root, Vector3(sx * 0.1, 0.9, -0.18), Vector3(0.035, 0.4, 0.028), MAHOGANY, false, 0.5)
	# Turned legs (tapered look via stacked radii)
	for offset in [Vector3(-0.18, 0.2, 0.18), Vector3(0.18, 0.2, 0.18)]:
		_add_cylinder(root, offset, 0.028, 0.38, MAHOGANY_DARK, true)
		_add_cylinder(root, Vector3(offset.x, 0.08, offset.z), 0.032, 0.08, MAHOGANY, true)
		_add_cylinder(root, Vector3(offset.x, 0.02, offset.z), 0.04, 0.03, MAHOGANY_DARK, true)
	for offset in [Vector3(-0.18, 0.2, -0.18), Vector3(0.18, 0.2, -0.18)]:
		_add_cylinder(root, offset, 0.025, 0.38, MAHOGANY_DARK, true)
		_add_cylinder(root, Vector3(offset.x, 0.02, offset.z), 0.036, 0.03, MAHOGANY, true)
	# H-stretcher (slim)
	_add_box(root, Vector3(0, 0.12, 0.0), Vector3(0.34, 0.025, 0.025), MAHOGANY, false, 0.5)
	_add_box(root, Vector3(-0.17, 0.12, 0.0), Vector3(0.025, 0.025, 0.3), MAHOGANY, false, 0.5)
	_add_box(root, Vector3(0.17, 0.12, 0.0), Vector3(0.025, 0.025, 0.3), MAHOGANY, false, 0.5)
	_add_contact_shadow(root, 0.4, 0.38)
	return root

static func _make_armchair(prop: Dictionary) -> Node3D:
	## Loop 165: Victorian wing — single side envelope (no nested depth stairs).
	## Side FOV must be ONE tall plane + leading roll; front detail is inset only.
	if prop.get("billboard", false) and prop.get("texture", "") != "":
		return _make_billboard_prop(prop)
	var root := Node3D.new()
	root.name = "Armchair"
	var fabric: Color = prop.get("fabric", VELVET_RED)
	var fabric_d := fabric.darkened(0.1)
	var fabric_dd := fabric.darkened(0.2)
	var fabric_l := fabric.lightened(0.05)
	# Slim mahogany seat rail
	_add_box(root, Vector3(0, 0.22, 0.02), Vector3(0.78, 0.055, 0.7), MAHOGANY_DARK, true, 0.42)
	_add_box(root, Vector3(0, 0.26, 0.02), Vector3(0.82, 0.022, 0.72), MAHOGANY, false, 0.45)
	# Seat + front bolster
	_add_box(root, Vector3(0, 0.4, 0.08), Vector3(0.7, 0.16, 0.56), fabric, true, 0.9)
	_add_box(root, Vector3(0, 0.5, 0.1), Vector3(0.62, 0.04, 0.48), fabric_d, false, 0.92)
	_add_cylinder_rotated(root, Vector3(0, 0.44, 0.34), 0.065, 0.66, fabric_l, Vector3(0, 0, PI * 0.5), 0.9)
	for bx in [-0.14, 0.0, 0.14]:
		for bz in [-0.04, 0.1]:
			_add_cylinder(root, Vector3(bx, 0.53, bz), 0.011, 0.01, fabric_dd, false, 0.95)
	# Back: ONE deep shell (not 3 nested stairs). Front pad is coplanar inset only.
	_add_box(root, Vector3(0, 0.95, -0.12), Vector3(0.62, 0.95, 0.28), fabric, true, 0.9)
	# Front-facing pad only (same Z extent as shell face — no extra depth step)
	_add_box(root, Vector3(0, 0.96, 0.0), Vector3(0.5, 0.78, 0.06), fabric_d, false, 0.9)
	_add_box(root, Vector3(0, 0.98, 0.02), Vector3(0.4, 0.55, 0.03), fabric_l, false, 0.92)
	# Crown roll (horizontal, sits on shell top — not a third terrace slab)
	_add_cylinder_rotated(root, Vector3(0, 1.38, -0.1), 0.09, 0.55, fabric, Vector3(0, 0, PI * 0.5), 0.88)
	_add_cylinder_rotated(root, Vector3(0, 1.42, -0.14), 0.055, 0.38, fabric_d, Vector3(0, 0, PI * 0.5), 0.88)
	_add_box(root, Vector3(0, 1.44, -0.2), Vector3(0.26, 0.035, 0.07), MAHOGANY, false, 0.45)
	# Wings: full-height outer envelope (same depth as back shell so side is continuous)
	for sx in [-1.0, 1.0]:
		# Outer ear — tall + deep enough to mask arm/seat as separate steps from side
		_add_box(root, Vector3(sx * 0.36, 0.92, 0.0), Vector3(0.2, 0.95, 0.52), fabric, true, 0.88)
		# Leading vertical roll (full height of ear)
		_add_cylinder(root, Vector3(sx * 0.36, 0.92, 0.24), 0.1, 0.9, fabric, false, 0.88)
		_add_cylinder(root, Vector3(sx * 0.36, 1.1, 0.18), 0.075, 0.5, fabric_d, false, 0.88)
		# Outer bevel (thin, same height)
		_add_box(root, Vector3(sx * 0.46, 0.92, 0.0), Vector3(0.02, 0.88, 0.42), fabric_dd, false, 0.9)
		# Arm integrated under wing (not a separate side box)
		_add_cylinder_rotated(root, Vector3(sx * 0.36, 0.56, 0.1), 0.055, 0.42, fabric_l, Vector3(PI * 0.5, 0, 0), 0.88)
		_add_cylinder(root, Vector3(sx * 0.36, 0.56, 0.32), 0.045, 0.06, fabric, false, 0.88)
		_add_cylinder(root, Vector3(sx * 0.36, 0.34, 0.18), 0.022, 0.14, MAHOGANY_DARK, true, 0.45)
		_add_cylinder(root, Vector3(sx * 0.36, 0.27, 0.24), 0.03, 0.05, MAHOGANY, false, 0.45)
	# Diamond button tufts on front pad only
	for row in 4:
		var by := 0.72 + float(row) * 0.15
		var odd := row % 2 == 1
		var cols: Array = [-0.09, 0.09] if odd else [-0.13, 0.0, 0.13]
		for bx_v in cols:
			_add_cylinder(root, Vector3(float(bx_v), by, 0.04), 0.011, 0.01, fabric_dd, false, 0.95)
	# Turned legs + slim H-stretcher
	for sx in [-1.0, 1.0]:
		_add_cylinder(root, Vector3(sx * 0.28, 0.1, 0.24), 0.026, 0.17, MAHOGANY_DARK, true)
		_add_cylinder(root, Vector3(sx * 0.28, 0.02, 0.24), 0.036, 0.022, MAHOGANY, true)
		_add_cylinder(root, Vector3(sx * 0.26, 0.1, -0.2), 0.024, 0.17, MAHOGANY_DARK, true)
		_add_cylinder(root, Vector3(sx * 0.26, 0.02, -0.2), 0.034, 0.022, MAHOGANY, true)
	_add_box(root, Vector3(0, 0.1, 0.02), Vector3(0.5, 0.016, 0.016), MAHOGANY, false, 0.48)
	_add_box(root, Vector3(-0.26, 0.1, 0.02), Vector3(0.016, 0.016, 0.38), MAHOGANY, false, 0.48)
	_add_box(root, Vector3(0.26, 0.1, 0.02), Vector3(0.016, 0.016, 0.38), MAHOGANY, false, 0.48)
	_add_contact_shadow(root, 0.55, 0.5)
	return root

static func _make_ottoman(prop: Dictionary) -> Node3D:
	## Loop 161 — soft tufted footstool (not a green Minecraft brick).
	## Uses velvet-mat cylinders/boxes only (no foliage sphere_blob).
	## seed: 0 square chesterfield · 1 round drum · 2 long fringe bench.
	var root := Node3D.new()
	root.name = "Ottoman"
	var fabric: Color = prop.get("fabric", VELVET_GREEN.darkened(0.08))
	var fabric_d := fabric.darkened(0.12)
	var fabric_dd := fabric.darkened(0.24)
	var fabric_l := fabric.lightened(0.05)
	var seed0: int = int(prop.get("seed", 0))
	var style := seed0 % 3
	var w: float = float(prop.get("width", 0.78 if style != 2 else 0.95))
	var d: float = float(prop.get("depth", 0.56 if style != 1 else 0.52))
	if style == 1:
		# Round drum — stepped dome + button ring, turned feet (morning)
		var r: float = w * 0.4
		_add_cylinder(root, Vector3(0, 0.08, 0), r * 0.92, 0.08, MAHOGANY_DARK, true, 0.42)
		_add_cylinder(root, Vector3(0, 0.14, 0), r * 0.98, 0.05, MAHOGANY, false, 0.45)
		_add_cylinder(root, Vector3(0, 0.28, 0), r, 0.22, fabric, true, 0.9)
		_add_cylinder(root, Vector3(0, 0.4, 0), r * 0.9, 0.1, fabric_d, false, 0.92)
		_add_cylinder(root, Vector3(0, 0.46, 0), r * 0.72, 0.06, fabric_l, false, 0.92)
		_add_cylinder(root, Vector3(0, 0.5, 0), r * 0.45, 0.04, fabric_d, false, 0.93)
		_add_cylinder(root, Vector3(0, 0.18, 0), r * 1.02, 0.04, fabric_dd, false, 0.88)
		# Button ring (readable mid-FOV)
		for i in 8:
			var ang := float(i) * TAU / 8.0
			_add_cylinder(root, Vector3(cos(ang) * r * 0.42, 0.48, sin(ang) * r * 0.42), 0.02, 0.018, fabric_dd, false, 0.95)
		_add_cylinder(root, Vector3(0, 0.52, 0), 0.022, 0.02, fabric_dd, false, 0.95)
		# Side bolster ring (reads as soft roll, not wood barrel)
		_add_cylinder(root, Vector3(0, 0.34, 0), r * 1.04, 0.06, fabric_l, false, 0.9)
		for i in 4:
			var ang2 := float(i) * TAU / 4.0 + 0.35
			var fx := cos(ang2) * r * 0.62
			var fz := sin(ang2) * r * 0.62
			_add_cylinder(root, Vector3(fx, 0.05, fz), 0.032, 0.1, MAHOGANY, true)
			_add_cylinder(root, Vector3(fx, 0.01, fz), 0.042, 0.025, MAHOGANY_DARK, true)
	elif style == 2:
		# Long fringe bench — rolled ends, diamond tufts, mahogany rail
		_add_box(root, Vector3(0, 0.12, 0), Vector3(w * 0.96, 0.08, d * 0.9), MAHOGANY_DARK, true, 0.42)
		_add_box(root, Vector3(0, 0.17, 0), Vector3(w, 0.03, d * 0.96), MAHOGANY, false, 0.45)
		_add_box(root, Vector3(0, 0.3, 0), Vector3(w * 0.94, 0.2, d * 0.88), fabric, true, 0.9)
		_add_box(root, Vector3(0, 0.42, 0), Vector3(w * 0.86, 0.06, d * 0.78), fabric_d, false, 0.92)
		# Cushion pads as short vertical cylinders (velvet mat), not foliage spheres
		for i in 4:
			var bx := (float(i) / 3.0 - 0.5) * w * 0.68
			_add_cylinder(root, Vector3(bx, 0.46, 0), d * 0.28, 0.08, fabric_l, false, 0.92)
		# Horizontal edge bolsters
		_add_cylinder_rotated(root, Vector3(0, 0.36, d * 0.38), 0.05, w * 0.88, fabric_l, Vector3(0, 0, PI * 0.5), 0.9)
		_add_cylinder_rotated(root, Vector3(0, 0.36, -d * 0.38), 0.05, w * 0.88, fabric_l, Vector3(0, 0, PI * 0.5), 0.9)
		for sx in [-1.0, 1.0]:
			_add_cylinder_rotated(root, Vector3(sx * w * 0.42, 0.36, 0), 0.055, d * 0.7, fabric_d, Vector3(PI * 0.5, 0, 0), 0.9)
			_add_cylinder(root, Vector3(sx * w * 0.44, 0.4, 0), 0.06, 0.08, fabric, false, 0.9)
		# Diamond tufts
		for i in 5:
			for j in 2:
				var bx2 := (float(i) / 4.0 - 0.5) * w * 0.72
				var bz2 := (float(j) - 0.5) * d * 0.32
				_add_cylinder(root, Vector3(bx2, 0.5, bz2), 0.018, 0.016, fabric_dd, false, 0.95)
		# Fringe strips (vertical, not a second slab)
		for i in 9:
			var fx := (float(i) / 8.0 - 0.5) * w * 0.88
			_add_box(root, Vector3(fx, 0.1, d * 0.44), Vector3(0.04, 0.1, 0.02), fabric_dd, false, 0.88)
			_add_box(root, Vector3(fx, 0.1, -d * 0.44), Vector3(0.04, 0.1, 0.02), fabric_dd, false, 0.88)
		# Brass nailheads along front rail
		for i in 7:
			var t := float(i) / 6.0
			_add_cylinder(root, Vector3(-w * 0.4 + t * w * 0.8, 0.2, d * 0.42), 0.012, 0.014, BRASS, false, 0.3, true)
		for sx in [-1.0, 1.0]:
			for sz in [-1.0, 1.0]:
				_add_cylinder(root, Vector3(sx * w * 0.4, 0.055, sz * d * 0.34), 0.03, 0.1, MAHOGANY, true)
				_add_cylinder(root, Vector3(sx * w * 0.4, 0.012, sz * d * 0.34), 0.04, 0.028, MAHOGANY_DARK, true)
	else:
		# Square chesterfield footstool (drawing-room hero) — soft mass, not a fridge brick
		_add_box(root, Vector3(0, 0.1, 0), Vector3(w * 0.92, 0.07, d * 0.9), MAHOGANY_DARK, true, 0.42)
		_add_box(root, Vector3(0, 0.15, 0), Vector3(w * 0.98, 0.035, d * 0.96), MAHOGANY, false, 0.45)
		# Main cushion + slightly inset top
		_add_box(root, Vector3(0, 0.28, 0), Vector3(w * 0.9, 0.18, d * 0.86), fabric, true, 0.9)
		_add_box(root, Vector3(0, 0.39, 0), Vector3(w * 0.78, 0.08, d * 0.72), fabric_d, false, 0.92)
		_add_box(root, Vector3(0, 0.45, 0), Vector3(w * 0.62, 0.05, d * 0.55), fabric_l, false, 0.93)
		# Rolled perimeter bolsters (side volume + soft silhouette)
		_add_cylinder_rotated(root, Vector3(0, 0.34, d * 0.38), 0.055, w * 0.82, fabric_l, Vector3(0, 0, PI * 0.5), 0.9)
		_add_cylinder_rotated(root, Vector3(0, 0.34, -d * 0.38), 0.055, w * 0.82, fabric_l, Vector3(0, 0, PI * 0.5), 0.9)
		_add_cylinder_rotated(root, Vector3(w * 0.4, 0.34, 0), 0.055, d * 0.72, fabric_l, Vector3(PI * 0.5, 0, 0), 0.9)
		_add_cylinder_rotated(root, Vector3(-w * 0.4, 0.34, 0), 0.055, d * 0.72, fabric_l, Vector3(PI * 0.5, 0, 0), 0.9)
		# Corner rolls (velvet cylinders, not foliage spheres)
		for sx in [-1.0, 1.0]:
			for sz in [-1.0, 1.0]:
				_add_cylinder(root, Vector3(sx * w * 0.36, 0.36, sz * d * 0.32), 0.055, 0.1, fabric, false, 0.9)
		# Diamond button tufts — large enough to read at room FOV
		for row in 3:
			var by := 0.48
			var odd := row % 2 == 1
			var cols: Array = [-0.12, 0.12] if odd else [-0.2, 0.0, 0.2]
			for bx_v in cols:
				var bz_v := (float(row) - 1.0) * d * 0.18
				_add_cylinder(root, Vector3(float(bx_v), by, bz_v), 0.02, 0.016, fabric_dd, false, 0.95)
		# Skirt fringe (thin vertical dangles)
		for i in 7:
			var fx := (float(i) / 6.0 - 0.5) * w * 0.82
			_add_box(root, Vector3(fx, 0.1, d * 0.42), Vector3(0.035, 0.09, 0.018), fabric_dd, false, 0.88)
			_add_box(root, Vector3(fx, 0.1, -d * 0.42), Vector3(0.035, 0.09, 0.018), fabric_dd, false, 0.88)
		for i in 5:
			var fz := (float(i) / 4.0 - 0.5) * d * 0.75
			_add_box(root, Vector3(w * 0.44, 0.1, fz), Vector3(0.018, 0.09, 0.035), fabric_dd, false, 0.88)
			_add_box(root, Vector3(-w * 0.44, 0.1, fz), Vector3(0.018, 0.09, 0.035), fabric_dd, false, 0.88)
		# Brass nailheads on mahogany rail
		for i in 6:
			var t := float(i) / 5.0
			_add_cylinder(root, Vector3(-w * 0.38 + t * w * 0.76, 0.18, d * 0.44), 0.011, 0.012, BRASS, false, 0.3, true)
			_add_cylinder(root, Vector3(-w * 0.38 + t * w * 0.76, 0.18, -d * 0.44), 0.011, 0.012, BRASS, false, 0.3, true)
		# Turned bun feet
		for sx in [-1.0, 1.0]:
			for sz in [-1.0, 1.0]:
				_add_cylinder(root, Vector3(sx * w * 0.34, 0.05, sz * d * 0.3), 0.034, 0.1, MAHOGANY, true)
				_add_cylinder(root, Vector3(sx * w * 0.34, 0.012, sz * d * 0.3), 0.044, 0.028, MAHOGANY_DARK, true)
	_add_contact_shadow(root, w * 0.55, d * 0.55)
	return root


static func _make_letter_stack(prop: Dictionary) -> Node3D:
	## Sealed letters / vellum packet — Selina drawing-room hero prop (novel MUST).
	var root := Node3D.new()
	root.name = "LetterStack"
	var seed0: int = int(prop.get("seed", 0))
	# Stack of folded letters with wax seals
	for i in 3 + seed0 % 2:
		var y := 0.02 + float(i) * 0.012
		var ox := float((i + seed0) % 3) * 0.01
		_add_box(root, Vector3(ox, y, 0), Vector3(0.18 - float(i) * 0.01, 0.008, 0.12), PAPER.darkened(0.04 * float(i)), false)
	# Top open letter with ink lines
	_add_box(root, Vector3(0.02, 0.055, 0.02), Vector3(0.16, 0.004, 0.11), PAPER.lightened(0.05), false)
	_add_box(root, Vector3(0.0, 0.06, 0.0), Vector3(0.1, 0.002, 0.008), INK, false, 0.95)
	_add_box(root, Vector3(0.02, 0.06, 0.02), Vector3(0.08, 0.002, 0.006), INK.lightened(0.2), false, 0.95)
	# Wax seal
	_add_cylinder(root, Vector3(0.05, 0.07, 0.03), 0.018, 0.008, Color(0.55, 0.12, 0.1), false, 0.6)
	# Ribbon / string
	_add_box(root, Vector3(-0.02, 0.04, 0), Vector3(0.02, 0.01, 0.14), Color(0.45, 0.18, 0.14), false, 0.7)
	return root


static func _make_tea_tray(prop: Dictionary) -> Node3D:
	## Loop 160 — tea at four (hero FOV): oval silver tray, round pot silhouette,
	## readable spout/handle, cups with open rims. Avoid pure-white block china.
	var root := Node3D.new()
	root.name = "TeaTray"
	var seed0: int = int(prop.get("seed", 0))
	var china: Color
	var china_d: Color
	var trim: Color
	var band: Color
	match seed0 % 3:
		0:  # cream + gilt (drawing-room) — g≤0.64 so china ≠ linen fabric
			china = Color(0.8, 0.64, 0.5)
			china_d = Color(0.66, 0.52, 0.4)
			trim = BRASS.darkened(0.08)
			band = Color(0.55, 0.4, 0.2)
		1:  # blue willow on ivory (morning)
			china = Color(0.76, 0.62, 0.58)
			china_d = Color(0.6, 0.5, 0.46)
			trim = Color(0.18, 0.3, 0.48)
			band = Color(0.24, 0.36, 0.52)
		_:  # soft rose
			china = Color(0.82, 0.62, 0.58)
			china_d = Color(0.68, 0.5, 0.46)
			trim = Color(0.48, 0.2, 0.22)
			band = Color(0.52, 0.28, 0.3)
	# Pewter/silver tray — oval via stacked cylinders (not white china plane)
	var silver := Color(0.58, 0.58, 0.62)
	var silver_d := Color(0.42, 0.42, 0.46)
	var silver_hi := Color(0.7, 0.7, 0.74)
	_add_cylinder(root, Vector3(0, 0.012, 0), 0.24, 0.014, silver_d, false, 0.28, true)
	_add_cylinder(root, Vector3(0, 0.02, 0), 0.22, 0.01, silver, false, 0.25, true)
	# Stretch oval with side pads
	_add_box(root, Vector3(0, 0.016, 0), Vector3(0.5, 0.012, 0.28), silver, false, 0.26)
	_add_box(root, Vector3(0, 0.024, 0), Vector3(0.46, 0.008, 0.24), silver_hi, false, 0.22)
	# Raised rim (darker lip so china sits in a dish)
	_add_cylinder(root, Vector3(0, 0.034, 0), 0.23, 0.012, silver_d, false, 0.3, true)
	_add_box(root, Vector3(0, 0.036, 0.14), Vector3(0.46, 0.016, 0.016), silver, false, 0.28)
	_add_box(root, Vector3(0, 0.036, -0.14), Vector3(0.46, 0.016, 0.016), silver, false, 0.28)
	_add_box(root, Vector3(0.22, 0.036, 0), Vector3(0.016, 0.016, 0.26), silver, false, 0.28)
	_add_box(root, Vector3(-0.22, 0.036, 0), Vector3(0.016, 0.016, 0.26), silver, false, 0.28)
	for sx in [-1.0, 1.0]:
		_add_box(root, Vector3(sx * 0.26, 0.04, 0), Vector3(0.03, 0.022, 0.08), silver_d, false, 0.28)
		_add_cylinder_rotated(root, Vector3(sx * 0.275, 0.05, 0), 0.014, 0.05, silver_hi, Vector3(0, 0, PI * 0.5), 0.25)
	# ── Teapot hero (loop 165: cylinders only — no foliage sphere_blob balloons) ──
	var tx := -0.09
	var tz := 0.01
	var by0 := 0.05
	# Foot ring
	_add_cylinder(root, Vector3(tx, by0 + 0.01, tz), 0.04, 0.012, china_d, false, 0.55)
	# Round belly via stacked radii (textured china, not untextured spheres)
	_add_cylinder(root, Vector3(tx, by0 + 0.045, tz), 0.072, 0.04, china, false, 0.55)
	_add_cylinder(root, Vector3(tx, by0 + 0.07, tz), 0.068, 0.04, china, false, 0.55)
	_add_cylinder(root, Vector3(tx, by0 + 0.095, tz), 0.055, 0.028, china_d, false, 0.55)
	# Decorative band
	_add_cylinder(root, Vector3(tx, by0 + 0.072, tz), 0.074, 0.01, band, false, 0.45)
	# Dome lid + knop
	_add_cylinder(root, Vector3(tx, by0 + 0.12, tz), 0.045, 0.028, china, false, 0.52)
	_add_cylinder(root, Vector3(tx, by0 + 0.138, tz), 0.032, 0.016, china_d, false, 0.52)
	_add_cylinder(root, Vector3(tx, by0 + 0.155, tz), 0.014, 0.016, trim, false, 0.32)
	_add_cylinder(root, Vector3(tx, by0 + 0.168, tz), 0.01, 0.01, trim.lightened(0.08), false, 0.3)
	# Curved spout
	_add_box(root, Vector3(tx + 0.055, by0 + 0.06, tz), Vector3(0.05, 0.024, 0.024), china_d, false, 0.55)
	_add_cylinder_rotated(root, Vector3(tx + 0.1, by0 + 0.075, tz), 0.014, 0.07, china.darkened(0.06), Vector3(0, 0, -0.55), 0.55)
	_add_cylinder(root, Vector3(tx + 0.13, by0 + 0.09, tz), 0.011, 0.018, china_d, false, 0.55)
	# C-handle
	_add_cylinder_rotated(root, Vector3(tx - 0.08, by0 + 0.07, tz), 0.012, 0.055, china_d, Vector3(0, 0, PI * 0.5), 0.55)
	_add_box(root, Vector3(tx - 0.09, by0 + 0.095, tz), Vector3(0.03, 0.014, 0.022), china.darkened(0.08), false, 0.55)
	_add_box(root, Vector3(tx - 0.09, by0 + 0.045, tz), Vector3(0.028, 0.012, 0.022), china.darkened(0.08), false, 0.55)
	# ── Two cups + saucers ──
	for i in 2:
		var cx := 0.08 + float(i) * 0.11
		var cz := 0.05 - float(i) * 0.09
		_add_cylinder(root, Vector3(cx, by0 + 0.008, cz), 0.045, 0.008, china_d, false, 0.55)
		_add_cylinder(root, Vector3(cx, by0 + 0.014, cz), 0.035, 0.006, china, false, 0.55)
		# Cup bowl (slightly flared rim)
		_add_cylinder(root, Vector3(cx, by0 + 0.035, cz), 0.024, 0.035, china, false, 0.55)
		_add_cylinder(root, Vector3(cx, by0 + 0.055, cz), 0.028, 0.008, band if i == 0 else trim, false, 0.42)
		_add_cylinder(root, Vector3(cx, by0 + 0.06, cz), 0.03, 0.006, china.lightened(0.04), false, 0.5)
		# Handle loop
		_add_box(root, Vector3(cx + 0.03, by0 + 0.038, cz), Vector3(0.014, 0.026, 0.012), china_d, false, 0.55)
		# Tea liquid disc inside cup
		_add_cylinder(root, Vector3(cx, by0 + 0.042, cz), 0.018, 0.004, Color(0.45, 0.28, 0.12), false, 0.7)
	# Cream jug
	var jx := 0.04
	var jz := -0.09
	_add_cylinder(root, Vector3(jx, by0 + 0.03, jz), 0.02, 0.045, china, false, 0.55)
	_add_cylinder(root, Vector3(jx, by0 + 0.055, jz), 0.022, 0.01, band, false, 0.45)
	_add_box(root, Vector3(jx + 0.025, by0 + 0.045, jz), Vector3(0.024, 0.014, 0.016), china_d, false, 0.55)
	_add_box(root, Vector3(jx - 0.02, by0 + 0.038, jz), Vector3(0.01, 0.028, 0.012), china_d, false, 0.55)
	# Sugar bowl + lid (cylinders only)
	var sx2 := -0.02
	var sz2 := -0.07
	_add_cylinder(root, Vector3(sx2, by0 + 0.028, sz2), 0.028, 0.032, china, false, 0.55)
	_add_cylinder(root, Vector3(sx2, by0 + 0.048, sz2), 0.03, 0.01, band, false, 0.45)
	_add_cylinder(root, Vector3(sx2, by0 + 0.058, sz2), 0.024, 0.016, china, false, 0.52)
	_add_cylinder(root, Vector3(sx2, by0 + 0.07, sz2), 0.01, 0.014, trim, false, 0.32)
	# Teaspoons
	_add_box(root, Vector3(0.15, by0 + 0.01, -0.02), Vector3(0.08, 0.005, 0.01), silver_hi, false, 0.22)
	_add_box(root, Vector3(0.19, by0 + 0.01, -0.035), Vector3(0.06, 0.004, 0.008), silver, false, 0.22)
	return root


static func _make_sofa(prop: Dictionary) -> Node3D:
	## Loop 162 — olive chesterfield mesh (drawing-room hero).
	## Dense diamond buttoning, velvet-mat bolsters only (no foliage sphere_blob),
	## carved mahogany arm ends + scrolled crest. Not a green fridge or balloon cushions.
	if prop.get("billboard", false) and prop.get("texture", "") != "":
		return _make_billboard_prop(prop)
	var root := Node3D.new()
	root.name = "Sofa"
	var width: float = float(prop.get("width", 2.35))
	var fabric: Color = prop.get("fabric", VELVET_GREEN)
	var fabric_d := fabric.darkened(0.1)
	var fabric_dd := fabric.darkened(0.22)
	var fabric_l := fabric.lightened(0.04)
	# Slim mahogany plinth (visible under skirt)
	_add_box(root, Vector3(0, 0.14, 0.02), Vector3(width * 0.98, 0.07, 0.86), MAHOGANY_DARK, true, 0.42)
	_add_box(root, Vector3(0, 0.2, 0.02), Vector3(width, 0.03, 0.9), MAHOGANY, false, 0.45)
	# Seat deck — one continuous buttoned pad (not three pale balloons)
	_add_box(root, Vector3(0, 0.34, 0.06), Vector3(width - 0.1, 0.16, 0.76), fabric, true, 0.9)
	_add_box(root, Vector3(0, 0.44, 0.08), Vector3(width - 0.18, 0.08, 0.66), fabric_d, false, 0.92)
	# Shallow cushion sections as low boxes + dense seat buttons
	for i in 3:
		var cx: float = (i - 1) * (width * 0.28)
		_add_box(root, Vector3(cx, 0.48, 0.1), Vector3(width * 0.25, 0.06, 0.6), fabric_d, false, 0.92)
		_add_box(root, Vector3(cx, 0.52, 0.1), Vector3(width * 0.22, 0.03, 0.52), fabric, false, 0.93)
		for j in 3:
			for k in 2:
				var bx := cx + (float(j) - 1.0) * 0.1
				var bz := 0.0 + float(k) * 0.16
				_add_cylinder(root, Vector3(bx, 0.55, bz), 0.014, 0.012, fabric_dd, false, 0.95)
	# Front seat bolster (horizontal velvet roll)
	_add_cylinder_rotated(root, Vector3(0, 0.4, 0.4), 0.065, width * 0.86, fabric_l, Vector3(0, 0, PI * 0.5), 0.9)
	# Back: continuous buttoned shell + crown scroll
	_add_box(root, Vector3(0, 0.85, -0.3), Vector3(width * 0.96, 0.72, 0.2), fabric, true, 0.9)
	_add_box(root, Vector3(0, 0.88, -0.18), Vector3(width * 0.88, 0.64, 0.1), fabric_d, false, 0.9)
	_add_box(root, Vector3(0, 0.92, -0.1), Vector3(width * 0.78, 0.5, 0.05), fabric_l, false, 0.92)
	# Dense diamond tufts (chesterfield read at room FOV)
	for row in 5:
		var by := 0.58 + float(row) * 0.12
		var odd := row % 2 == 1
		var n := 5 if odd else 6
		for i in n:
			var bx := (float(i) / float(maxi(n - 1, 1)) - 0.5) * width * 0.72
			_add_cylinder(root, Vector3(bx, by, -0.06), 0.015, 0.012, fabric_dd, false, 0.95)
	# Crown roll + carved mahogany crest (painted-art cue)
	_add_cylinder_rotated(root, Vector3(0, 1.18, -0.14), 0.075, width * 0.78, fabric, Vector3(0, 0, PI * 0.5), 0.88)
	_add_cylinder_rotated(root, Vector3(0, 1.22, -0.2), 0.048, width * 0.5, fabric_d, Vector3(0, 0, PI * 0.5), 0.88)
	_add_box(root, Vector3(0, 1.24, -0.28), Vector3(width * 0.42, 0.04, 0.08), MAHOGANY, false, 0.45)
	_add_box(root, Vector3(0, 1.28, -0.28), Vector3(width * 0.18, 0.035, 0.06), MAHOGANY_DARK, false, 0.42)
	# Scrolled arm ends (mahogany) + velvet rolls — no foliage spheres
	for sx in [-1.0, 1.0]:
		var ax: float = sx * (width * 0.5 - 0.12)
		_add_box(root, Vector3(ax, 0.55, 0.02), Vector3(0.2, 0.4, 0.76), fabric, true, 0.88)
		_add_cylinder(root, Vector3(ax, 0.7, 0.06), 0.1, 0.52, fabric_d, false, 0.9)
		_add_cylinder_rotated(root, Vector3(ax, 0.76, 0.02), 0.08, 0.68, fabric_l, Vector3(PI * 0.5, 0, 0), 0.88)
		# Outer vertical roll
		_add_cylinder(root, Vector3(ax + sx * 0.06, 0.72, 0.0), 0.07, 0.48, fabric, false, 0.88)
		# Mahogany scroll nose + post (reads carved wood like painted art)
		_add_cylinder(root, Vector3(ax + sx * 0.02, 0.55, 0.38), 0.055, 0.14, MAHOGANY, false, 0.42)
		_add_cylinder_rotated(root, Vector3(ax + sx * 0.02, 0.62, 0.42), 0.04, 0.12, MAHOGANY_DARK, Vector3(PI * 0.5, 0, 0), 0.42)
		_add_cylinder(root, Vector3(ax, 0.38, 0.3), 0.035, 0.18, MAHOGANY, false, 0.45)
		# Arm top buttons
		for k in 3:
			_add_cylinder(root, Vector3(ax, 0.82, -0.1 + float(k) * 0.14), 0.012, 0.01, fabric_dd, false, 0.95)
	# Skirt fringe (thin verticals)
	for i in 11:
		var fx := (float(i) / 10.0 - 0.5) * width * 0.9
		_add_box(root, Vector3(fx, 0.11, 0.4), Vector3(0.04, 0.09, 0.02), fabric_dd, false, 0.88)
	# Brass nailheads along front rail
	for i in 9:
		var t := float(i) / 8.0
		_add_cylinder(root, Vector3(-width * 0.42 + t * width * 0.84, 0.22, 0.42), 0.01, 0.012, BRASS, false, 0.3, true)
	# Turned bun feet
	for sx in [-1.0, 0.0, 1.0]:
		_add_cylinder(root, Vector3(sx * width * 0.38, 0.06, 0.28), 0.03, 0.11, MAHOGANY, true)
		_add_cylinder(root, Vector3(sx * width * 0.38, 0.012, 0.28), 0.04, 0.024, MAHOGANY_DARK, true)
		_add_cylinder(root, Vector3(sx * width * 0.38, 0.06, -0.24), 0.028, 0.11, MAHOGANY, true)
		_add_cylinder(root, Vector3(sx * width * 0.38, 0.012, -0.24), 0.038, 0.024, MAHOGANY_DARK, true)
	_add_contact_shadow(root, width * 0.48, 0.52)
	return root

static func _make_rug(prop: Dictionary) -> Node3D:
	## Loop 87/109: woven field texture + thin fringe/lip (no cardboard medallion blotch).
	var root := Node3D.new()
	root.name = "Rug"
	var size: Array = prop.get("size", [4.6, 3.4])
	var sw: float = float(size[0])
	var sd: float = float(size[1])
	var tex_path: String = prop.get("texture", "")
	var body := Node3D.new()
	var mesh := PlaneMesh.new()
	mesh.orientation = PlaneMesh.FACE_Y
	mesh.size = Vector2(sw, sd)
	var mi := MeshInstance3D.new()
	mi.mesh = mesh
	var mat := StandardMaterial3D.new()
	var has_tex := false
	var is_runner := maxf(sw, sd) / maxf(0.01, minf(sw, sd)) > 2.2
	if tex_path != "":
		var tex: Texture2D = _load_tex(tex_path)
		if tex:
			mat.albedo_texture = tex
			# Loop 109: map full woven plate once (medallion reads); runners tile along length only
			if is_runner:
				# ~2–3 cartouche repeats along long axis; single width
				var along: float = maxf(sw, sd)
				var tile_n: float = clampf(along / 3.2, 1.5, 3.5)
				if sd >= sw:
					mat.uv1_scale = Vector3(1.0, tile_n, 1.0)
				else:
					mat.uv1_scale = Vector3(tile_n, 1.0, 1.0)
			else:
				# Full medallion + multi-band border once across the plane
				mat.uv1_scale = Vector3(1.0, 1.0, 1.0)
			has_tex = true
	if not has_tex:
		# Fallback Persian-ish field (deep red) if texture missing
		mat.albedo_color = Color(0.55, 0.14, 0.12)
	mat.roughness = 0.95
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_PER_PIXEL
	mi.material_override = mat
	body.add_child(mi)
	body.position = Vector3(0, 0.035, 0)
	root.add_child(body)
	var border := Color(0.22, 0.1, 0.08)
	var gold := Color(0.55, 0.4, 0.2)
	var fringe := Color(0.42, 0.28, 0.16)
	if has_tex:
		# Loop 109: very thin lip only — woven border is in the plate; no cross-rails/medallion mesh
		var bw := 0.035
		_add_box(root, Vector3(0, 0.038, sd * 0.5 - bw * 0.5), Vector3(sw * 0.99, 0.012, bw), border.darkened(0.15), false, 0.92)
		_add_box(root, Vector3(0, 0.038, -sd * 0.5 + bw * 0.5), Vector3(sw * 0.99, 0.012, bw), border.darkened(0.15), false, 0.92)
		_add_box(root, Vector3(sw * 0.5 - bw * 0.5, 0.038, 0), Vector3(bw, 0.012, sd * 0.97), border.darkened(0.15), false, 0.92)
		_add_box(root, Vector3(-sw * 0.5 + bw * 0.5, 0.038, 0), Vector3(bw, 0.012, sd * 0.97), border.darkened(0.15), false, 0.92)
		# Short fringe teeth on short ends (reads as pile edge from standing height)
		var fringe_n := int(clampf(sw * 8.0, 8.0, 28.0))
		for fi in fringe_n:
			var fx := -sw * 0.45 + (sw * 0.9) * (float(fi) / float(maxi(fringe_n - 1, 1)))
			_add_box(root, Vector3(fx, 0.032, sd * 0.5 + 0.02), Vector3(0.04, 0.008, 0.05), fringe, false, 0.95)
			_add_box(root, Vector3(fx, 0.032, -sd * 0.5 - 0.02), Vector3(0.04, 0.008, 0.05), fringe, false, 0.95)
	else:
		var bw := 0.08
		_add_box(root, Vector3(0, 0.04, sd * 0.5 - bw * 0.5), Vector3(sw * 0.98, 0.02, bw), border, false, 0.9)
		_add_box(root, Vector3(0, 0.04, -sd * 0.5 + bw * 0.5), Vector3(sw * 0.98, 0.02, bw), border, false, 0.9)
		_add_box(root, Vector3(sw * 0.5 - bw * 0.5, 0.04, 0), Vector3(bw, 0.02, sd * 0.94), border, false, 0.9)
		_add_box(root, Vector3(-sw * 0.5 + bw * 0.5, 0.04, 0), Vector3(bw, 0.02, sd * 0.94), border, false, 0.9)
		_add_box(root, Vector3(0, 0.042, 0), Vector3(sw * 0.88, 0.01, 0.025), gold, false, 0.7)
		_add_box(root, Vector3(0, 0.042, 0), Vector3(0.025, 0.01, sd * 0.88), gold, false, 0.7)
		if sw > 2.5 and sd > 2.0:
			_add_cylinder(root, Vector3(0, 0.048, 0), minf(sw, sd) * 0.06, 0.01, gold.darkened(0.1), false, 0.75)
			_add_cylinder(root, Vector3(0, 0.05, 0), minf(sw, sd) * 0.035, 0.01, Color(0.45, 0.18, 0.12), false, 0.85)
	return root

static func _make_bookshelf(prop: Dictionary) -> Node3D:
	## Open shelves with leather/cloth spines — period library, not Minecraft cubes.
	## seed forks case wood, crown style, and book mix (uniqueness rule).
	var root := Node3D.new()
	root.name = "Bookshelf"
	var width: float = prop.get("width", 1.7)
	var height: float = prop.get("height", 2.5)
	var depth: float = prop.get("depth", 0.36)
	var seed0: int = int(prop.get("seed", 0))
	# Case wood: 0 oak · 1 mahogany · 2 darker oak (never all-identical)
	var case_col: Color
	var case_dark: Color
	match seed0 % 3:
		0:
			case_col = Color(0.48, 0.34, 0.18)
			case_dark = Color(0.36, 0.24, 0.12)
		1:
			case_col = Color(0.32, 0.16, 0.09)
			case_dark = Color(0.2, 0.1, 0.06)
		_:
			case_col = Color(0.4, 0.28, 0.14)
			case_dark = Color(0.28, 0.18, 0.1)
	# Back panel (lighter so it doesn't read as a black monolith)
	_add_box(root, Vector3(0, height * 0.5, -depth * 0.35), Vector3(width, height, 0.04), case_col, true, 0.55)
	# Sides with subtle pilaster
	_add_box(root, Vector3(-width * 0.5 + 0.03, height * 0.5, 0), Vector3(0.06, height, depth), case_dark, true, 0.52)
	_add_box(root, Vector3(width * 0.5 - 0.03, height * 0.5, 0), Vector3(0.06, height, depth), case_dark, true, 0.52)
	_add_box(root, Vector3(-width * 0.5 + 0.05, height * 0.55, depth * 0.35), Vector3(0.03, height * 0.7, 0.04), case_col.lightened(0.05), false, 0.5)
	_add_box(root, Vector3(width * 0.5 - 0.05, height * 0.55, depth * 0.35), Vector3(0.03, height * 0.7, 0.04), case_col.lightened(0.05), false, 0.5)
	# Crown (seed: plain vs stepped cornice)
	_add_box(root, Vector3(0, height - 0.05, 0.02), Vector3(width + 0.08, 0.1, depth + 0.08), case_col, false, 0.5)
	if seed0 % 2 == 0:
		_add_box(root, Vector3(0, height - 0.12, 0.04), Vector3(width + 0.02, 0.05, depth + 0.02), case_dark, false, 0.48)
	_add_box(root, Vector3(0, 0.06, 0.02), Vector3(width + 0.04, 0.12, depth + 0.04), case_dark, true, 0.5)
	# Plinth moulding
	_add_box(root, Vector3(0, 0.14, 0.04), Vector3(width + 0.02, 0.04, depth + 0.02), case_col.darkened(0.05), false, 0.5)
	# Loop 80: thin leather spines + gilt + bookends — not Minecraft cubes
	var shelf_n := 5
	for i in shelf_n:
		var y: float = 0.38 + i * (height - 0.55) / float(shelf_n - 1)
		_add_box(root, Vector3(0, y, 0.02), Vector3(width * 0.92, 0.035, depth * 0.9), case_col.lightened(0.04), false, 0.55)
		# Brass bookends at shelf ends
		if (i + seed0) % 2 == 0:
			_add_box(root, Vector3(-width * 0.38, y + 0.1, 0.06), Vector3(0.035, 0.16, 0.14), BRASS.darkened(0.1), false, 0.3)
			_add_box(root, Vector3(width * 0.38, y + 0.1, 0.06), Vector3(0.035, 0.16, 0.14), BRASS.darkened(0.12), false, 0.3)
		var x := -width * 0.36
		var bi := 0
		while x < width * 0.36:
			# Horizontal folio stack
			if (bi + i + seed0) % 13 == 0:
				for k in 3:
					var fcol := _book_color(i + bi + k + seed0 * 3)
					_add_box(
						root,
						Vector3(x + 0.07, y + 0.025 + float(k) * 0.022, depth * 0.04),
						Vector3(0.13, 0.018, depth * 0.48),
						fcol,
						false,
						0.68
					)
					# Edge gilt on folio
					_add_box(
						root,
						Vector3(x + 0.13, y + 0.025 + float(k) * 0.022, depth * 0.04),
						Vector3(0.008, 0.016, depth * 0.45),
						BRASS.lightened(0.1),
						false,
						0.35
					)
				x += 0.16
				bi += 1
				continue
			# Thin spines (period octavo / duodecimo scale)
			var bw: float = 0.028 + float((i + bi + seed0) % 7) * 0.012
			var bh: float = 0.14 + float((i * 3 + bi + seed0 * 2) % 7) * 0.028
			var bd: float = depth * (0.42 + float((bi + seed0) % 4) * 0.06)
			var bcol := _book_color(i + bi + seed0 * 7)
			var cx := x + bw * 0.5
			var cy := y + 0.018 + bh * 0.5
			# Slight pull-forward on some volumes
			var pull := 0.02 if (bi + seed0) % 9 == 0 else 0.0
			var cz := depth * 0.04 + pull
			_add_box(root, Vector3(cx, cy, cz), Vector3(bw * 0.94, bh, bd), bcol, false, 0.7)
			# Spine ridge (raised band down centre)
			_add_box(root, Vector3(cx, cy, cz + bd * 0.42), Vector3(bw * 0.22, bh * 0.92, 0.008), bcol.darkened(0.08), false, 0.65)
			# Headcap + footcap leather
			_add_box(root, Vector3(cx, y + 0.018 + bh - 0.012, cz + bd * 0.35), Vector3(bw * 0.9, 0.014, bd * 0.55), bcol.darkened(0.12), false, 0.6)
			_add_box(root, Vector3(cx, y + 0.028, cz + bd * 0.35), Vector3(bw * 0.9, 0.012, bd * 0.55), bcol.darkened(0.1), false, 0.6)
			# Gilt title bands (1–3 horizontal)
			var bands := 1 + (bi + i + seed0) % 3
			for g in bands:
				var gy := y + 0.018 + bh * (0.35 + float(g) * 0.18)
				_add_box(root, Vector3(cx, gy, cz + bd * 0.48), Vector3(bw * 0.78, 0.008, 0.01), BRASS, false, 0.32)
			# Occasional title plate
			if (bi + seed0) % 5 == 0:
				_add_box(root, Vector3(cx, cy + bh * 0.05, cz + bd * 0.5), Vector3(bw * 0.55, bh * 0.18, 0.01), BRASS.darkened(0.15), false, 0.35)
			# Occasional paper label
			if (bi + i) % 8 == 0:
				_add_box(root, Vector3(cx, cy - bh * 0.15, cz + bd * 0.5), Vector3(bw * 0.7, bh * 0.12, 0.008), PAPER.darkened(0.05), false, 0.85)
			x += bw + 0.004
			bi += 1
		# Gap filler: bust / globe / ink box on one shelf
		if i == (1 + seed0 % 3):
			if seed0 % 2 == 0:
				_add_cylinder(root, Vector3(width * 0.22, y + 0.1, 0.04), 0.04, 0.12, MARBLE, false, 0.55)
				_add_sphere_blob(root, Vector3(width * 0.22, y + 0.2, 0.04), 0.045, MARBLE.darkened(0.05))
			else:
				# Small terrestrial globe
				_add_sphere_blob(root, Vector3(-width * 0.2, y + 0.12, 0.05), 0.055, Color(0.35, 0.42, 0.5))
				_add_cylinder(root, Vector3(-width * 0.2, y + 0.04, 0.05), 0.03, 0.04, BRASS, false, 0.3, true)
	# Top board dressing (seed-unique)
	if seed0 % 2 == 0:
		_add_box(root, Vector3(-0.15, height + 0.02, 0.05), Vector3(0.18, 0.035, 0.12), _book_color(seed0), false, 0.7)
		_add_box(root, Vector3(-0.12, height + 0.055, 0.04), Vector3(0.14, 0.025, 0.1), _book_color(seed0 + 2), false, 0.7)
		_add_box(root, Vector3(0.2, height + 0.03, 0.05), Vector3(0.12, 0.04, 0.1), BRASS.darkened(0.2), false, 0.35)
	else:
		_add_cylinder(root, Vector3(0.1, height + 0.08, 0.04), 0.05, 0.12, CREAM.darkened(0.1), false, 0.7)
		_add_box(root, Vector3(-0.2, height + 0.025, 0.04), Vector3(0.16, 0.03, 0.11), _book_color(seed0 + 1), false, 0.7)
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
			var kind := (i * 3 + j + seed0) % 5
			if kind == 0:
				# Plate stack with rim
				_add_cylinder(root, Vector3(x, y + 0.035, 0.04), 0.09, 0.025, CREAM, false, 0.75)
				_add_cylinder(root, Vector3(x, y + 0.055, 0.04), 0.08, 0.02, CREAM.darkened(0.06), false, 0.75)
				_add_cylinder(root, Vector3(x, y + 0.07, 0.04), 0.07, 0.015, CREAM.lightened(0.04), false, 0.75)
			elif kind == 1:
				# Crock with lid
				_add_cylinder(root, Vector3(x, y + 0.1, 0.04), 0.07, 0.16, CLAY if (j + seed0) % 2 == 0 else CLAY.lightened(0.08), false, 0.8)
				_add_cylinder(root, Vector3(x, y + 0.19, 0.04), 0.06, 0.03, CLAY.darkened(0.1), false, 0.8)
			elif kind == 2:
				# Copper bowl: bottom + belly + flared rim + handle (loop 119)
				_add_cylinder(root, Vector3(x, y + 0.04, 0.04), 0.07, 0.02, COPPER.darkened(0.1), false, 0.35, true)
				_add_cylinder(root, Vector3(x, y + 0.09, 0.04), 0.09, 0.1, COPPER, false, 0.35, true)
				_add_cylinder(root, Vector3(x, y + 0.15, 0.04), 0.1, 0.02, COPPER.lightened(0.08), false, 0.32, true)
				_add_box(root, Vector3(x + 0.09, y + 0.09, 0.04), Vector3(0.05, 0.03, 0.03), COPPER, false, 0.35)
			elif kind == 3:
				# Jug
				_add_cylinder(root, Vector3(x, y + 0.08, 0.04), 0.055, 0.14, CREAM.darkened(0.08), false, 0.7)
				_add_cylinder(root, Vector3(x, y + 0.16, 0.04), 0.04, 0.04, CREAM.darkened(0.05), false, 0.75)
				_add_box(root, Vector3(x + 0.06, y + 0.1, 0.04), Vector3(0.04, 0.08, 0.03), CREAM.darkened(0.12), false, 0.7)
			else:
				# Nested bowls
				_add_cylinder(root, Vector3(x, y + 0.04, 0.04), 0.1, 0.035, CREAM.darkened(0.1), false, 0.7)
				_add_cylinder(root, Vector3(x, y + 0.07, 0.04), 0.07, 0.03, CREAM, false, 0.75)
	_add_contact_shadow(root, width * 0.5, depth * 0.6)
	return root


static func _make_tool_shelf(prop: Dictionary) -> Node3D:
	## Workshop shelf: timber, parts, tools — not books. seed forks mix.
	var root := Node3D.new()
	root.name = "ToolShelf"
	var width: float = float(prop.get("width", 1.3))
	var height: float = float(prop.get("height", 1.9))
	var depth: float = float(prop.get("depth", 0.34))
	var seed0: int = int(prop.get("seed", 2))
	_add_box(root, Vector3(0, height * 0.5, -depth * 0.35), Vector3(width, height, 0.04), OAK.darkened(0.12), true, 0.55)
	_add_box(root, Vector3(-width * 0.48, height * 0.5, 0), Vector3(0.05, height, depth), OAK.darkened(0.18), true, 0.55)
	_add_box(root, Vector3(width * 0.48, height * 0.5, 0), Vector3(0.05, height, depth), OAK.darkened(0.18), true, 0.55)
	_add_box(root, Vector3(0, 0.05, 0.01), Vector3(width + 0.04, 0.1, depth + 0.04), MAHOGANY_DARK, true, 0.5)
	# Peg rail under top shelf (distinct from library case)
	_add_box(root, Vector3(0, height - 0.2, 0.12), Vector3(width * 0.85, 0.03, 0.04), OAK, false, 0.55)
	for i in 4:
		var y: float = 0.32 + float(i) * ((height - 0.45) / 3.0)
		_add_box(root, Vector3(0, y, 0.02), Vector3(width * 0.9, 0.035, depth * 0.88), OAK, false, 0.55)
		var n := 2 + (i + seed0) % 2
		for j in n:
			var x := -width * 0.28 + float(j) * (width * 0.55 / float(maxi(n - 1, 1)))
			var kind := (i + j + seed0) % 4
			if kind == 0:
				_add_box(root, Vector3(x, y + 0.06, 0.04), Vector3(0.28, 0.06, 0.12), OAK.lightened(0.1), false, 0.6)
			elif kind == 1:
				# Rooke wrench language
				_add_box(root, Vector3(x, y + 0.1, 0.04), Vector3(0.22, 0.04, 0.04), IRON, false, 0.4)
				_add_box(root, Vector3(x + 0.1, y + 0.1, 0.04), Vector3(0.06, 0.08, 0.05), IRON.lightened(0.1), false, 0.4)
			elif kind == 2:
				_add_box(root, Vector3(x, y + 0.08, 0.04), Vector3(0.16, 0.1, 0.12), MAHOGANY, false, 0.5)
				_add_cylinder(root, Vector3(x, y + 0.14, 0.1), 0.02, 0.16, IRON, false, 0.4)
			else:
				_add_cylinder(root, Vector3(x, y + 0.1, 0.04), 0.06, 0.14, COPPER.darkened(0.1), false, 0.4, true)
	# Hanging tools on peg rail
	for i in 3 + seed0 % 2:
		var px := -width * 0.3 + float(i) * 0.2
		_add_cylinder(root, Vector3(px, height - 0.35, 0.14), 0.012, 0.28, IRON.darkened(0.05), false, 0.45)
		_add_box(root, Vector3(px, height - 0.5, 0.14), Vector3(0.06, 0.04, 0.03), IRON, false, 0.4)
	_add_contact_shadow(root, width * 0.5, depth * 0.6)
	return root

static func _make_side_table(prop: Dictionary) -> Node3D:
	## Occasional tables — base silhouette + top dressing fork by seed (uniqueness).
	## base style: 0 tripod · 1 square 4-leg · 2 demi-lune console.
	if prop.get("billboard", false) and prop.get("texture", "") != "":
		return _make_billboard_prop(prop)
	var root := Node3D.new()
	root.name = "SideTable"
	var seed0: int = int(prop.get("seed", 0))
	var base := seed0 % 3
	var dress := (seed0 / 3) % 4
	if base == 0:
		# Tripod pedestal (loop 117/143: short warm feet — long dark bars read as rug L-junk)
		_add_cylinder(root, Vector3(0, 0.64, 0), 0.3, 0.04, MAHOGANY, true)
		_add_cylinder(root, Vector3(0, 0.67, 0), 0.32, 0.025, MAHOGANY_DARK, false)
		_add_cylinder(root, Vector3(0, 0.61, 0), 0.28, 0.02, MAHOGANY.lightened(0.05), false)
		# Turned column (stacked diameters)
		_add_cylinder(root, Vector3(0, 0.52, 0), 0.09, 0.1, MAHOGANY, true)
		_add_cylinder(root, Vector3(0, 0.4, 0), 0.055, 0.16, MAHOGANY_DARK, true)
		_add_cylinder(root, Vector3(0, 0.28, 0), 0.07, 0.1, MAHOGANY, true)
		_add_cylinder(root, Vector3(0, 0.16, 0), 0.1, 0.08, MAHOGANY_DARK, true)
		# Compact carved feet under column — not long free bars on the rug
		_add_cylinder(root, Vector3(0, 0.06, 0), 0.12, 0.06, MAHOGANY, true, 0.48)
		for a in [0.0, 120.0, 240.0]:
			var rad := deg_to_rad(a)
			var fx := cos(rad) * 0.12
			var fz := sin(rad) * 0.12
			_add_box(root, Vector3(fx, 0.04, fz), Vector3(0.12, 0.035, 0.055), MAHOGANY, true, 0.48)
			_add_cylinder(root, Vector3(fx * 1.2, 0.025, fz * 1.2), 0.028, 0.035, MAHOGANY.lightened(0.05), true)
	elif base == 1:
		# Square top + apron drawer + four turned legs (loop 117)
		_add_box(root, Vector3(0, 0.64, 0), Vector3(0.55, 0.04, 0.55), MAHOGANY, true, 0.45)
		_add_box(root, Vector3(0, 0.67, 0), Vector3(0.58, 0.02, 0.58), MAHOGANY_DARK, false, 0.42)
		# Apron + false drawer
		_add_box(root, Vector3(0, 0.56, 0.24), Vector3(0.5, 0.1, 0.04), MAHOGANY, false, 0.48)
		_add_box(root, Vector3(0, 0.56, -0.24), Vector3(0.5, 0.1, 0.04), MAHOGANY, false, 0.48)
		_add_box(root, Vector3(0.24, 0.56, 0), Vector3(0.04, 0.1, 0.46), MAHOGANY, false, 0.48)
		_add_box(root, Vector3(-0.24, 0.56, 0), Vector3(0.04, 0.1, 0.46), MAHOGANY, false, 0.48)
		_add_box(root, Vector3(0, 0.56, 0.26), Vector3(0.28, 0.06, 0.02), MAHOGANY_DARK, false, 0.5)
		_add_cylinder(root, Vector3(0, 0.56, 0.28), 0.012, 0.02, BRASS, false, 0.3, true)
		for sx in [-1.0, 1.0]:
			for sz in [-1.0, 1.0]:
				_add_cylinder(root, Vector3(sx * 0.2, 0.4, sz * 0.2), 0.032, 0.24, MAHOGANY_DARK, true)
				_add_cylinder(root, Vector3(sx * 0.2, 0.22, sz * 0.2), 0.024, 0.18, MAHOGANY, true)
				_add_cylinder(root, Vector3(sx * 0.2, 0.08, sz * 0.2), 0.03, 0.12, MAHOGANY_DARK, true)
				_add_cylinder(root, Vector3(sx * 0.2, 0.02, sz * 0.2), 0.04, 0.04, MAHOGANY, true)
		_add_box(root, Vector3(0, 0.2, 0), Vector3(0.36, 0.025, 0.36), MAHOGANY, false, 0.5)
	else:
		# Demi-lune console (loop 117: thicker top edge + curved apron)
		_add_box(root, Vector3(0, 0.64, 0.05), Vector3(0.72, 0.045, 0.36), MAHOGANY, true, 0.45)
		_add_cylinder(root, Vector3(0, 0.64, 0.05), 0.34, 0.045, MAHOGANY, true)
		_add_cylinder(root, Vector3(0, 0.67, 0.05), 0.32, 0.02, MAHOGANY_DARK, false)
		_add_box(root, Vector3(0, 0.55, 0.12), Vector3(0.55, 0.08, 0.04), MAHOGANY, false, 0.48)
		_add_cylinder(root, Vector3(-0.22, 0.36, 0.1), 0.03, 0.5, MAHOGANY_DARK, true)
		_add_cylinder(root, Vector3(0.22, 0.36, 0.1), 0.03, 0.5, MAHOGANY_DARK, true)
		_add_cylinder(root, Vector3(0.0, 0.36, -0.06), 0.032, 0.5, MAHOGANY_DARK, true)
		_add_cylinder(root, Vector3(-0.22, 0.02, 0.1), 0.04, 0.04, MAHOGANY, true)
		_add_cylinder(root, Vector3(0.22, 0.02, 0.1), 0.04, 0.04, MAHOGANY, true)
		_add_cylinder(root, Vector3(0.0, 0.02, -0.06), 0.04, 0.04, MAHOGANY, true)
		_add_box(root, Vector3(0, 0.28, 0.06), Vector3(0.42, 0.03, 0.14), MAHOGANY, false, 0.48)
	# Loop 126/166 top dressing — thin leather folios (not Minecraft cubes)
	var top_y := 0.69
	if prop.get("bare", false):
		_add_contact_shadow(root, 0.34, 0.34)
		return root
	if dress == 0:
		# Loop 154 mini Argand + thin octavo (not fat book brick)
		_add_cylinder(root, Vector3(0, top_y + 0.015, 0), 0.045, 0.028, MAHOGANY_DARK, false, 0.5)
		_add_cylinder(root, Vector3(0, top_y + 0.05, 0), 0.04, 0.045, Color(0.48, 0.34, 0.16), false, 0.4, true)
		_add_cylinder(root, Vector3(0, top_y + 0.08, 0), 0.032, 0.018, BRASS.darkened(0.18), false, 0.32, true)
		_add_cylinder(root, Vector3(0, top_y + 0.2, 0), 0.028, 0.2, Color(0.95, 0.78, 0.42, 0.42), false, 0.12)
		_add_cylinder(root, Vector3(0, top_y + 0.2, 0), 0.018, 0.16, Color(1.0, 0.9, 0.58, 0.28), false, 0.1)
		_add_cylinder(root, Vector3(0, top_y + 0.12, 0), 0.014, 0.02, Color(1.0, 0.82, 0.4), false, 0.35)
		_add_table_folio(root, Vector3(0.12, top_y + 0.02, 0.04), seed0 + 2, 0.0)
		var lamp := OmniLight3D.new()
		lamp.light_color = Color(1.0, 0.85, 0.55)
		lamp.light_energy = 0.55
		lamp.omni_range = 2.6
		lamp.position = Vector3(0, top_y + 0.22, 0)
		root.add_child(lamp)
	elif dress == 1:
		# Stacked thin folios + cream crock (loop 166 — not colored cubes)
		_add_table_folio_stack(root, Vector3(-0.04, top_y + 0.01, 0.0), seed0, 3)
		_add_cylinder(root, Vector3(0.12, top_y + 0.05, 0.08), 0.038, 0.09, CREAM.darkened(0.1), false, 0.75)
		_add_cylinder(root, Vector3(0.12, top_y + 0.11, 0.08), 0.028, 0.025, CREAM.darkened(0.18), false, 0.75)
	elif dress == 2:
		# Loop 172: glazed earthenware pot (not white wedding-cake tiers).
		# Warm CLAY/stone body + blue band; dense low bloom crown.
		# Clay gate: r>0.65 g≥0.45 g<0.56 b<0.38 (terracotta before copper).
		var pot := Color(0.72, 0.5, 0.32)      # terracotta
		var pot_d := Color(0.58, 0.4, 0.24)
		var pot_l := Color(0.78, 0.56, 0.36)
		var glaze := Color(0.22, 0.32, 0.42)    # blue-grey band (not metal)
		# Foot + ONE wide belly (pot, not stacked cups)
		_add_cylinder(root, Vector3(0, top_y + 0.015, 0), 0.05, 0.022, pot_d, false, 0.78)
		_add_cylinder(root, Vector3(0, top_y + 0.08, 0), 0.085, 0.11, pot, false, 0.78)
		_add_cylinder(root, Vector3(0, top_y + 0.14, 0), 0.072, 0.04, pot_l, false, 0.78)
		# Decorative band
		_add_cylinder(root, Vector3(0, top_y + 0.1, 0), 0.088, 0.018, glaze, false, 0.55)
		# Short neck + rim
		_add_cylinder(root, Vector3(0, top_y + 0.175, 0), 0.048, 0.03, pot_d, false, 0.75)
		_add_cylinder(root, Vector3(0, top_y + 0.195, 0), 0.062, 0.018, pot_l, false, 0.75)
		# Soil
		_add_cylinder(root, Vector3(0, top_y + 0.2, 0), 0.04, 0.014, Color(0.16, 0.1, 0.06), false, 0.9)
		# Dense bloom crown (low mass)
		for bi in 5:
			var bang := float(bi) * TAU / 5.0 + 0.35
			var bx := cos(bang) * 0.028
			var bz := sin(bang) * 0.028
			_add_cylinder(root, Vector3(bx, top_y + 0.235, bz), 0.007, 0.05, Color(0.16, 0.3, 0.1), false, 0.85)
			var bloom := Color(0.58, 0.16, 0.18) if bi % 2 == 0 else Color(0.68, 0.42, 0.18)
			_add_cylinder(root, Vector3(bx * 1.15, top_y + 0.27, bz * 1.15), 0.022, 0.02, bloom, false, 0.78)
		_add_cylinder(root, Vector3(0, top_y + 0.275, 0), 0.02, 0.022, Color(0.52, 0.14, 0.16), false, 0.78)
	else:
		# Candlestick + letters (drawing-room identity)
		_add_cylinder(root, Vector3(-0.08, top_y + 0.02, 0.0), 0.05, 0.03, MAHOGANY_DARK, false, 0.5)
		_add_cylinder(root, Vector3(-0.08, top_y + 0.08, 0.0), 0.025, 0.08, MAHOGANY, false, 0.48)
		_add_cylinder(root, Vector3(-0.08, top_y + 0.13, 0.0), 0.04, 0.02, BRASS.darkened(0.2), false, 0.35, true)
		_add_cylinder(root, Vector3(-0.08, top_y + 0.26, 0.0), 0.018, 0.22, CANDLE, false, 0.6)
		_add_sphere_blob(root, Vector3(-0.08, top_y + 0.38, 0.0), 0.025, Color(1.0, 0.78, 0.35))
		_add_box(root, Vector3(0.08, top_y, 0.02), Vector3(0.16, 0.01, 0.11), PAPER, false)
		_add_box(root, Vector3(0.1, top_y + 0.012, 0.0), Vector3(0.14, 0.008, 0.1), PAPER.darkened(0.06), false)
		_add_box(root, Vector3(0.12, top_y + 0.01, -0.08), Vector3(0.08, 0.02, 0.04), MAHOGANY_DARK, false, 0.45)
		_add_cylinder(root, Vector3(0.12, top_y + 0.03, -0.08), 0.006, 0.1, INK, false, 0.5)
		var candle_l := OmniLight3D.new()
		candle_l.light_color = Color(1.0, 0.82, 0.5)
		candle_l.light_energy = 0.4
		candle_l.omni_range = 2.2
		candle_l.position = Vector3(-0.08, top_y + 0.36, 0.0)
		root.add_child(candle_l)
	_add_contact_shadow(root, 0.34, 0.34)
	return root

static func _make_hall_table(prop: Dictionary) -> Node3D:
	## Hall console — seed forks base (turned / square / demi) + still-life kit.
	## Loop 144: turned-profile legs (not fat pipe cylinders) + warmer pedestal.
	var root := Node3D.new()
	root.name = "HallTable"
	var seed0: int = int(prop.get("seed", 0))
	var base := seed0 % 3
	var dress := (seed0 / 3) % 4
	var top_y := 0.82
	if base == 0:
		# Classic turned-leg console — stacked diameters for lathe read
		_add_box(root, Vector3(0, top_y, 0), Vector3(1.4, 0.05, 0.5), MAHOGANY, true, 0.48)
		_add_box(root, Vector3(0, top_y - 0.04, 0), Vector3(1.35, 0.04, 0.46), MAHOGANY_DARK, false, 0.45)
		_add_box(root, Vector3(0, top_y - 0.12, 0), Vector3(1.28, 0.08, 0.42), MAHOGANY, false, 0.48)
		_add_box(root, Vector3(0, 0.4, 0), Vector3(1.15, 0.03, 0.4), MAHOGANY_DARK, false, 0.45)
		for sx in [-1.0, 1.0]:
			for sz in [-0.12, 0.12]:
				var lx: float = float(sx) * 0.52
				var lz: float = float(sz)
				_add_cylinder(root, Vector3(lx, 0.68, lz), 0.038, 0.08, MAHOGANY, true)
				_add_cylinder(root, Vector3(lx, 0.55, lz), 0.028, 0.18, MAHOGANY_DARK, true)
				_add_cylinder(root, Vector3(lx, 0.4, lz), 0.035, 0.1, MAHOGANY, true)
				_add_cylinder(root, Vector3(lx, 0.22, lz), 0.025, 0.22, MAHOGANY_DARK, true)
				_add_cylinder(root, Vector3(lx, 0.08, lz), 0.032, 0.08, MAHOGANY, true)
				_add_cylinder(root, Vector3(lx, 0.02, lz), 0.05, 0.04, MAHOGANY.lightened(0.04), true)
	elif base == 1:
		# Square pedestal console — warm mahogany panels (not ebony Minecraft blocks)
		_add_box(root, Vector3(0, top_y, 0), Vector3(1.35, 0.06, 0.48), MAHOGANY, true, 0.45)
		_add_box(root, Vector3(0, top_y + 0.03, 0), Vector3(1.28, 0.02, 0.42), MAHOGANY.lightened(0.05), false, 0.42)
		_add_box(root, Vector3(0, top_y - 0.1, 0), Vector3(1.2, 0.08, 0.4), MAHOGANY_DARK, false, 0.48)
		for sx in [-0.48, 0.48]:
			_add_box(root, Vector3(sx, 0.42, 0), Vector3(0.16, 0.72, 0.36), MAHOGANY_DARK, true, 0.48)
			_add_box(root, Vector3(sx, 0.42, 0.16), Vector3(0.12, 0.55, 0.04), MAHOGANY, false, 0.5)
			_add_box(root, Vector3(sx, 0.04, 0), Vector3(0.2, 0.08, 0.4), MAHOGANY, true, 0.48)
		_add_box(root, Vector3(0, 0.22, 0), Vector3(0.9, 0.04, 0.32), MAHOGANY, false, 0.48)
		_add_cylinder(root, Vector3(0, 0.42, 0), 0.03, 0.02, BRASS.darkened(0.2), false, 0.35, true)
	else:
		# Demi-lune against wall — turned legs with rings
		_add_box(root, Vector3(0, top_y, 0.06), Vector3(1.25, 0.05, 0.38), MAHOGANY, true, 0.48)
		_add_cylinder(root, Vector3(0, top_y, 0.06), 0.55, 0.05, MAHOGANY, true, 0.48)
		_add_box(root, Vector3(0, top_y - 0.1, 0.08), Vector3(1.05, 0.06, 0.28), MAHOGANY_DARK, false, 0.48)
		for leg in [Vector3(-0.4, 0.0, 0.1), Vector3(0.4, 0.0, 0.1), Vector3(0.0, 0.0, -0.05)]:
			_add_cylinder(root, Vector3(leg.x, 0.65, leg.z), 0.035, 0.08, MAHOGANY, true)
			_add_cylinder(root, Vector3(leg.x, 0.45, leg.z), 0.025, 0.28, MAHOGANY_DARK, true)
			_add_cylinder(root, Vector3(leg.x, 0.22, leg.z), 0.03, 0.12, MAHOGANY, true)
			_add_cylinder(root, Vector3(leg.x, 0.02, leg.z), 0.04, 0.04, MAHOGANY.lightened(0.04), true)
		_add_box(root, Vector3(0, 0.35, 0.08), Vector3(0.7, 0.03, 0.15), MAHOGANY, false, 0.48)
	var ty := top_y + 0.05
	# Loop 122 dressing — period candlesticks / miniature Argand (never gold coin stacks)
	if dress == 0:
		# Card tray + dual candlesticks + carriage clock
		_add_box(root, Vector3(-0.35, ty, 0.05), Vector3(0.36, 0.03, 0.22), MAHOGANY_DARK, false, 0.4)
		_add_box(root, Vector3(-0.35, ty + 0.03, 0.05), Vector3(0.28, 0.01, 0.16), PAPER, false)
		_add_box(root, Vector3(-0.32, ty + 0.045, 0.02), Vector3(0.2, 0.008, 0.11), PAPER.darkened(0.08), false)
		_add_box(root, Vector3(0.05, ty, 0.08), Vector3(0.14, 0.02, 0.09), CREAM.darkened(0.12), false, 0.9)
		# Pair of candlesticks: dark iron/mahogany base + cream taper + flame
		for sx in [-0.15, 0.42]:
			_add_cylinder(root, Vector3(sx, ty + 0.02, -0.05), 0.055, 0.04, MAHOGANY_DARK, false, 0.5)
			_add_cylinder(root, Vector3(sx, ty + 0.08, -0.05), 0.035, 0.08, MAHOGANY, false, 0.48)
			_add_cylinder(root, Vector3(sx, ty + 0.14, -0.05), 0.04, 0.03, BRASS.darkened(0.2), false, 0.35, true)
			_add_cylinder(root, Vector3(sx, ty + 0.26, -0.05), 0.018, 0.22, CANDLE, false, 0.6)
			_add_sphere_blob(root, Vector3(sx, ty + 0.4, -0.05), 0.025, Color(1.0, 0.78, 0.35))
		# Carriage clock (square face — not brass cylinder stack)
		_add_box(root, Vector3(0.12, ty + 0.08, -0.12), Vector3(0.1, 0.14, 0.06), BRASS.darkened(0.15), false, 0.35)
		_add_box(root, Vector3(0.12, ty + 0.08, -0.09), Vector3(0.07, 0.1, 0.02), Color(0.88, 0.86, 0.78), false, 0.5)
		_add_box(root, Vector3(0.12, ty + 0.16, -0.12), Vector3(0.08, 0.02, 0.05), BRASS.darkened(0.1), false, 0.35)
		var lamp0 := OmniLight3D.new()
		lamp0.light_color = Color(1.0, 0.85, 0.55)
		lamp0.light_energy = 0.55
		lamp0.omni_range = 3.0
		lamp0.position = Vector3(0.42, ty + 0.38, -0.05)
		root.add_child(lamp0)
	elif dress == 1:
		# Hat box + gloves + single brass candlestick with drip pan
		_add_cylinder(root, Vector3(-0.35, ty + 0.1, 0), 0.14, 0.18, Color(0.55, 0.28, 0.18), false, 0.75)
		_add_cylinder(root, Vector3(-0.35, ty + 0.2, 0), 0.15, 0.03, Color(0.48, 0.24, 0.14), false, 0.7)
		_add_box(root, Vector3(0.05, ty, 0.08), Vector3(0.18, 0.025, 0.12), CREAM.darkened(0.15), false, 0.9)
		_add_box(root, Vector3(0.07, ty + 0.02, 0.05), Vector3(0.12, 0.015, 0.08), CREAM.darkened(0.2), false, 0.9)
		# Candlestick: wide drip pan + short stem + cream taper
		_add_cylinder(root, Vector3(0.4, ty + 0.02, 0), 0.07, 0.03, BRASS.darkened(0.15), false, 0.35, true)
		_add_cylinder(root, Vector3(0.4, ty + 0.08, 0), 0.025, 0.1, BRASS.darkened(0.2), false, 0.35, true)
		_add_cylinder(root, Vector3(0.4, ty + 0.14, 0), 0.05, 0.025, BRASS.darkened(0.1), false, 0.32, true)
		_add_cylinder(root, Vector3(0.4, ty + 0.28, 0), 0.02, 0.24, CANDLE, false, 0.6)
		_add_sphere_blob(root, Vector3(0.4, ty + 0.42, 0), 0.028, Color(1.0, 0.78, 0.4))
		_add_box(root, Vector3(0.0, ty, -0.1), Vector3(0.22, 0.04, 0.14), MAHOGANY_DARK, false, 0.5)
		var lamp1 := OmniLight3D.new()
		lamp1.light_color = Color(1.0, 0.82, 0.5)
		lamp1.light_energy = 0.4
		lamp1.omni_range = 2.4
		lamp1.position = Vector3(0.4, ty + 0.4, 0)
		root.add_child(lamp1)
	elif dress == 2:
		# Flower vase + calling cards + ink tray
		_add_cylinder(root, Vector3(0.35, ty + 0.04, 0), 0.05, 0.04, CREAM.darkened(0.15), false, 0.7)
		_add_cylinder(root, Vector3(0.35, ty + 0.12, 0), 0.07, 0.14, CREAM.darkened(0.05), false, 0.7)
		_add_cylinder(root, Vector3(0.35, ty + 0.2, 0), 0.05, 0.04, CREAM, false, 0.7)
		_add_sphere_blob(root, Vector3(0.35, ty + 0.3, 0.02), 0.05, Color(0.65, 0.25, 0.28))
		_add_sphere_blob(root, Vector3(0.32, ty + 0.28, -0.03), 0.04, Color(0.75, 0.7, 0.35))
		_add_sphere_blob(root, Vector3(0.4, ty + 0.27, 0.0), 0.035, Color(0.5, 0.55, 0.3))
		_add_box(root, Vector3(-0.35, ty, 0.05), Vector3(0.3, 0.02, 0.18), PAPER, false)
		_add_box(root, Vector3(-0.32, ty + 0.015, 0.02), Vector3(0.22, 0.008, 0.12), PAPER.darkened(0.06), false)
		_add_box(root, Vector3(0.0, ty, -0.08), Vector3(0.16, 0.03, 0.1), MAHOGANY_DARK, false, 0.45)
		_add_cylinder(root, Vector3(0.02, ty + 0.05, -0.08), 0.015, 0.08, INK, false, 0.5)
	else:
		# Silver tray + correspondence + miniature Argand (wood base + amber glass)
		_add_box(root, Vector3(0.0, ty, 0.0), Vector3(0.55, 0.02, 0.32), Color(0.65, 0.65, 0.68), false, 0.35)
		_add_box(root, Vector3(0.0, ty + 0.015, 0.0), Vector3(0.5, 0.01, 0.28), Color(0.75, 0.75, 0.78), false, 0.32)
		_add_box(root, Vector3(-0.1, ty + 0.03, 0.02), Vector3(0.2, 0.01, 0.14), PAPER, false)
		_add_box(root, Vector3(-0.08, ty + 0.04, 0.0), Vector3(0.16, 0.008, 0.1), PAPER.darkened(0.05), false)
		# Loop 154 mini Argand on tray: thimble font + tall glass
		_add_cylinder(root, Vector3(0.18, ty + 0.02, -0.05), 0.038, 0.028, MAHOGANY_DARK, false, 0.5)
		_add_cylinder(root, Vector3(0.18, ty + 0.055, -0.05), 0.035, 0.04, Color(0.48, 0.34, 0.16), false, 0.4, true)
		_add_cylinder(root, Vector3(0.18, ty + 0.085, -0.05), 0.028, 0.016, BRASS.darkened(0.18), false, 0.32, true)
		_add_cylinder(root, Vector3(0.18, ty + 0.2, -0.05), 0.026, 0.18, Color(0.95, 0.78, 0.42, 0.42), false, 0.12)
		_add_cylinder(root, Vector3(0.18, ty + 0.2, -0.05), 0.016, 0.14, Color(1.0, 0.9, 0.58, 0.28), false, 0.1)
		_add_sphere_blob(root, Vector3(0.18, ty + 0.12, -0.05), 0.014, Color(1.0, 0.8, 0.38))
		_add_box(root, Vector3(0.35, ty + 0.02, 0.08), Vector3(0.12, 0.04, 0.08), Color(0.55, 0.12, 0.1), false)
		var lamp3 := OmniLight3D.new()
		lamp3.light_color = Color(1.0, 0.85, 0.55)
		lamp3.light_energy = 0.45
		lamp3.omni_range = 2.6
		lamp3.position = Vector3(0.18, ty + 0.22, -0.05)
		root.add_child(lamp3)
	_add_contact_shadow(root, 0.78, 0.38)
	return root

# ─── Kitchen identity ────────────────────────────────────────────────────────

static func _make_kitchen_range(_prop: Dictionary) -> Node3D:
	## Cast-iron Victorian kitchen range (loop 130): readable from doorway —
	## fielded oven doors, fender, firebox, bulbous hotplate vessels (no copper tower),
	## stepped flue crown, side boiler, brass furniture.
	var root := Node3D.new()
	root.name = "KitchenRange"
	var iron_mid := Color(0.38, 0.38, 0.4)
	var iron_body := Color(0.32, 0.32, 0.34)
	var iron_dark := Color(0.22, 0.22, 0.24)
	var iron_light := Color(0.48, 0.48, 0.5)
	var soot := Color(0.16, 0.15, 0.14)
	# Hearth plinth + ash lip + fender rail
	_add_box(root, Vector3(0, 0.07, 0.08), Vector3(2.4, 0.14, 1.05), STONE, true, 0.72)
	_add_box(root, Vector3(0, 0.12, 0.48), Vector3(1.2, 0.05, 0.32), STONE.darkened(0.15), false, 0.78)
	# Low iron fender (keeps fire reading as a hearth, not a hole)
	_add_box(root, Vector3(0, 0.18, 0.55), Vector3(0.9, 0.08, 0.06), iron_dark, false, 0.45)
	_add_box(root, Vector3(-0.42, 0.22, 0.5), Vector3(0.06, 0.16, 0.08), iron_mid, false, 0.45)
	_add_box(root, Vector3(0.42, 0.22, 0.5), Vector3(0.06, 0.16, 0.08), iron_mid, false, 0.45)
	_add_cylinder(root, Vector3(0, 0.28, 0.55), 0.02, 0.7, BRASS.darkened(0.15), false, 0.35)
	# Main body + slightly proud top band
	_add_box(root, Vector3(0, 0.68, 0), Vector3(2.2, 1.15, 0.9), iron_body, true, 0.55)
	_add_box(root, Vector3(0, 1.2, 0.02), Vector3(2.22, 0.08, 0.92), iron_mid, false, 0.5)
	# Side cheeks + rivets
	for sx in [-1.0, 1.0]:
		_add_box(root, Vector3(sx * 1.08, 0.68, 0.08), Vector3(0.1, 1.05, 0.72), iron_dark, false, 0.5)
		for ri in 6:
			var ry := 0.28 + float(ri) * 0.16
			_add_cylinder(root, Vector3(sx * 1.12, ry, 0.4), 0.015, 0.018, iron_light, false, 0.4)
	# Brass trim rails (period range identity)
	_add_box(root, Vector3(0, 1.22, 0.46), Vector3(2.22, 0.035, 0.04), BRASS, false, 0.32)
	_add_box(root, Vector3(0, 0.2, 0.46), Vector3(2.22, 0.03, 0.04), BRASS.darkened(0.12), false, 0.35)
	_add_box(root, Vector3(-1.08, 0.7, 0.46), Vector3(0.04, 1.05, 0.03), BRASS.darkened(0.1), false, 0.35)
	_add_box(root, Vector3(1.08, 0.7, 0.46), Vector3(0.04, 1.05, 0.03), BRASS.darkened(0.1), false, 0.35)
	# Twin oven doors — deeper fielded panels + hinges + D-handles
	for door_x in [-0.55, 0.55]:
		_add_box(root, Vector3(door_x, 0.58, 0.44), Vector3(0.78, 0.72, 0.08), iron_mid, false, 0.5)
		_add_box(root, Vector3(door_x, 0.58, 0.49), Vector3(0.58, 0.52, 0.025), iron_dark, false, 0.55)
		_add_box(root, Vector3(door_x, 0.58, 0.505), Vector3(0.42, 0.36, 0.02), iron_light, false, 0.5)
		# Cross stile in panel
		_add_box(root, Vector3(door_x, 0.58, 0.51), Vector3(0.42, 0.03, 0.015), iron_mid, false, 0.5)
		_add_box(root, Vector3(door_x, 0.58, 0.51), Vector3(0.03, 0.36, 0.015), iron_mid, false, 0.5)
		for hy in [0.85, 0.32]:
			_add_box(root, Vector3(door_x - 0.34, hy, 0.48), Vector3(0.07, 0.09, 0.045), BRASS, false, 0.3)
		# D-handle (posts + bar)
		_add_cylinder(root, Vector3(door_x + 0.18, 0.68, 0.54), 0.014, 0.05, BRASS, false, 0.28, true)
		_add_cylinder(root, Vector3(door_x + 0.18, 0.48, 0.54), 0.014, 0.05, BRASS, false, 0.28, true)
		_add_cylinder(root, Vector3(door_x + 0.18, 0.58, 0.56), 0.016, 0.22, BRASS.lightened(0.05), false, 0.28, true)
	# Upper warming-oven doors (smaller pair above fire)
	for wx in [-0.32, 0.32]:
		_add_box(root, Vector3(wx, 1.0, 0.44), Vector3(0.42, 0.22, 0.06), iron_mid, false, 0.5)
		_add_box(root, Vector3(wx, 1.0, 0.48), Vector3(0.3, 0.14, 0.02), iron_dark, false, 0.55)
		_add_cylinder(root, Vector3(wx, 1.0, 0.52), 0.012, 0.1, BRASS, false, 0.3, true)
	# Centre firebox
	_add_box(root, Vector3(0, 0.42, 0.4), Vector3(0.58, 0.48, 0.1), soot, false, 0.55)
	_add_box(root, Vector3(0, 0.22, 0.4), Vector3(0.52, 0.06, 0.2), Color(0.2, 0.16, 0.12), false, 0.85)
	# Grate + fire dogs
	for gi in 5:
		var gx := -0.18 + float(gi) * 0.09
		_add_box(root, Vector3(gx, 0.34, 0.44), Vector3(0.025, 0.26, 0.035), iron_dark, false, 0.45)
	_add_box(root, Vector3(-0.16, 0.28, 0.42), Vector3(0.06, 0.14, 0.1), iron_mid, false, 0.45)
	_add_box(root, Vector3(0.16, 0.28, 0.42), Vector3(0.06, 0.14, 0.1), iron_mid, false, 0.45)
	# Logs
	_add_box(root, Vector3(-0.06, 0.3, 0.36), Vector3(0.38, 0.07, 0.11), MAHOGANY_DARK, false, 0.7)
	_add_box(root, Vector3(0.08, 0.36, 0.37), Vector3(0.28, 0.06, 0.09), MAHOGANY, false, 0.7)
	# Multi-lobe fire (smaller spheres, less one big orange blob)
	for fi in 6:
		var t := float(fi) / 5.0
		var em := MeshInstance3D.new()
		var em_mesh := SphereMesh.new()
		em_mesh.radius = 0.07 - t * 0.025
		em_mesh.height = 0.1 + t * 0.06
		em.mesh = em_mesh
		var emat := StandardMaterial3D.new()
		var warm := Color(1.0, 0.35 + t * 0.45, 0.05 + t * 0.2)
		emat.albedo_color = warm
		emat.emission_enabled = true
		emat.emission = warm
		emat.emission_energy_multiplier = 2.6 - t * 0.35
		emat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		em.material_override = emat
		em.position = Vector3(sin(t * 4.0) * 0.08, 0.34 + t * 0.1, 0.46 + cos(t * 3.0) * 0.02)
		root.add_child(em)
	# Hotplate — four rings (not two giant discs)
	_add_box(root, Vector3(0, 1.28, 0), Vector3(2.22, 0.08, 0.9), iron_dark, true, 0.45)
	for ring_x in [-0.7, -0.22, 0.22, 0.7]:
		_add_cylinder(root, Vector3(ring_x, 1.34, 0.05), 0.16, 0.03, iron_mid, false, 0.4)
		_add_cylinder(root, Vector3(ring_x, 1.36, 0.05), 0.145, 0.015, BRASS.darkened(0.22), false, 0.35, true)
		_add_cylinder(root, Vector3(ring_x, 1.37, 0.05), 0.07, 0.02, iron_dark, false, 0.45)
	# Hotplate vessels: squat kettle + saucepan + iron skillet (NO tall copper tower)
	# Kettle (left) — bulbous
	_add_cylinder(root, Vector3(-0.7, 1.42, 0.05), 0.08, 0.04, COPPER.darkened(0.1), false, 0.32, true)
	_add_cylinder(root, Vector3(-0.7, 1.5, 0.05), 0.12, 0.12, COPPER, false, 0.32, true)
	_add_sphere_blob(root, Vector3(-0.7, 1.52, 0.05), 0.1, COPPER.lightened(0.04))
	_add_cylinder(root, Vector3(-0.7, 1.6, 0.05), 0.06, 0.04, COPPER.darkened(0.05), false, 0.32, true)
	_add_cylinder(root, Vector3(-0.7, 1.64, 0.05), 0.03, 0.03, BRASS, false, 0.28, true)
	_add_box(root, Vector3(-0.52, 1.5, 0.05), Vector3(0.12, 0.025, 0.03), COPPER.darkened(0.05), false, 0.32)
	_add_box(root, Vector3(-0.82, 1.52, 0.05), Vector3(0.04, 0.08, 0.03), COPPER, false, 0.32)
	# Saucepan (mid-left)
	_add_cylinder(root, Vector3(-0.2, 1.42, 0.08), 0.09, 0.1, COPPER.lightened(0.05), false, 0.32, true)
	_add_cylinder(root, Vector3(-0.2, 1.48, 0.08), 0.095, 0.02, COPPER.lightened(0.1), false, 0.3, true)
	_add_box(root, Vector3(-0.02, 1.44, 0.08), Vector3(0.14, 0.02, 0.03), COPPER, false, 0.32)
	# Iron skillet (mid-right)
	_add_cylinder(root, Vector3(0.25, 1.4, 0.05), 0.14, 0.04, iron_dark, false, 0.4)
	_add_cylinder(root, Vector3(0.25, 1.43, 0.05), 0.145, 0.02, iron_mid, false, 0.4)
	_add_box(root, Vector3(0.48, 1.41, 0.05), Vector3(0.2, 0.022, 0.035), iron_light, false, 0.4)
	# Small copper pot (right ring)
	_add_cylinder(root, Vector3(0.7, 1.42, 0.05), 0.07, 0.08, COPPER.darkened(0.06), false, 0.32, true)
	_add_cylinder(root, Vector3(0.7, 1.48, 0.05), 0.075, 0.02, COPPER.lightened(0.08), false, 0.3, true)
	_add_cylinder(root, Vector3(0.7, 1.5, 0.05), 0.025, 0.025, BRASS, false, 0.28, true)
	# Mantel shelf + still-life
	_add_box(root, Vector3(0, 1.52, 0.12), Vector3(2.35, 0.06, 0.58), iron_mid, false, 0.45)
	_add_box(root, Vector3(0, 1.56, 0.12), Vector3(2.32, 0.02, 0.54), BRASS.darkened(0.12), false, 0.32)
	# Mantel crock, tin, candle, spoon rest — not copper coil stacks
	_add_cylinder(root, Vector3(-0.75, 1.64, 0.12), 0.07, 0.14, CREAM.darkened(0.1), false, 0.8)
	_add_cylinder(root, Vector3(-0.75, 1.73, 0.12), 0.055, 0.03, CREAM.darkened(0.18), false, 0.8)
	_add_cylinder(root, Vector3(-0.4, 1.62, 0.15), 0.05, 0.1, Color(0.55, 0.52, 0.48), false, 0.45)
	_add_box(root, Vector3(-0.05, 1.6, 0.18), Vector3(0.2, 0.03, 0.1), MAHOGANY, false, 0.5)
	_add_cylinder(root, Vector3(0.25, 1.66, 0.15), 0.025, 0.14, CANDLE, false, 0.55)
	_add_sphere_blob(root, Vector3(0.25, 1.75, 0.15), 0.022, Color(1.0, 0.75, 0.35))
	_add_cylinder(root, Vector3(0.65, 1.64, 0.12), 0.08, 0.12, CLAY, false, 0.8)
	_add_cylinder(root, Vector3(0.65, 1.72, 0.12), 0.06, 0.03, CLAY.darkened(0.1), false, 0.8)
	# Side hot-water boiler cylinder (classic range silhouette)
	_add_cylinder(root, Vector3(1.05, 0.85, -0.05), 0.18, 0.9, iron_mid, true, 0.5)
	_add_cylinder(root, Vector3(1.05, 1.3, -0.05), 0.19, 0.06, BRASS.darkened(0.1), false, 0.32, true)
	_add_cylinder(root, Vector3(1.05, 0.45, -0.05), 0.19, 0.06, iron_dark, false, 0.5)
	_add_cylinder(root, Vector3(1.05, 1.0, 0.12), 0.03, 0.04, BRASS, false, 0.3, true)
	# Flue — stepped stack, not black slab
	_add_box(root, Vector3(0, 1.7, -0.1), Vector3(0.85, 0.12, 0.6), iron_mid, true, 0.48)
	_add_box(root, Vector3(0, 1.78, -0.1), Vector3(0.72, 0.06, 0.52), BRASS.darkened(0.1), false, 0.32)
	_add_box(root, Vector3(0, 2.15, -0.12), Vector3(0.52, 0.85, 0.42), iron_body, true, 0.5)
	for ri in 5:
		var ry := 1.85 + float(ri) * 0.14
		_add_box(root, Vector3(-0.24, ry, 0.08), Vector3(0.035, 0.035, 0.035), iron_light, false, 0.45)
		_add_box(root, Vector3(0.24, ry, 0.08), Vector3(0.035, 0.035, 0.035), iron_light, false, 0.45)
	# Smoke plate + damper pull
	_add_box(root, Vector3(0, 2.05, 0.1), Vector3(0.32, 0.45, 0.04), iron_dark, false, 0.5)
	_add_cylinder(root, Vector3(0, 2.0, 0.14), 0.02, 0.08, BRASS, false, 0.3, true)
	# Stepped crown
	_add_box(root, Vector3(0, 2.55, -0.12), Vector3(0.68, 0.08, 0.52), iron_mid.lightened(0.05), false, 0.48)
	_add_box(root, Vector3(0, 2.62, -0.12), Vector3(0.52, 0.06, 0.4), iron_dark, false, 0.5)
	_add_box(root, Vector3(0, 2.68, -0.12), Vector3(0.38, 0.05, 0.3), iron_mid, false, 0.48)
	# Short hanging rail under mantel (pans — not giant tower stack)
	_add_box(root, Vector3(0, 1.62, 0.38), Vector3(1.4, 0.03, 0.04), MAHOGANY_DARK, false, 0.5)
	_add_cylinder(root, Vector3(-0.4, 1.48, 0.4), 0.09, 0.05, COPPER, false, 0.32, true)
	_add_box(root, Vector3(-0.22, 1.48, 0.4), Vector3(0.14, 0.02, 0.03), COPPER.darkened(0.05), false, 0.32)
	_add_cylinder(root, Vector3(-0.4, 1.55, 0.38), 0.008, 0.12, IRON, false, 0.4)
	_add_cylinder(root, Vector3(0.35, 1.46, 0.4), 0.08, 0.08, COPPER.lightened(0.04), false, 0.32, true)
	_add_cylinder(root, Vector3(0.35, 1.52, 0.4), 0.03, 0.025, BRASS, false, 0.28, true)
	_add_cylinder(root, Vector3(0.35, 1.56, 0.38), 0.008, 0.1, IRON, false, 0.4)
	var fire := OmniLight3D.new()
	fire.light_color = Color(1.0, 0.5, 0.22)
	fire.light_energy = 1.95
	fire.omni_range = 6.4
	fire.position = Vector3(0, 0.48, 0.55)
	root.add_child(fire)
	_add_fire_sparks(root, Vector3(0, 0.38, 0.48), 10)
	_add_contact_shadow(root, 1.25, 0.58)
	return root

static func _make_dresser(prop: Dictionary) -> Node3D:
	## Welsh dresser / plate rack — kitchen identity; seed varies plate/crock mix.
	var root := Node3D.new()
	root.name = "Dresser"
	var seed0: int = int(prop.get("seed", 0))
	var w := 1.7
	# Kitchen oak (lighter service wood, not drawing-room mahogany)
	var oak_l := Color(0.52, 0.38, 0.2)
	var oak_d := Color(0.4, 0.28, 0.14)
	# Base cupboard
	_add_box(root, Vector3(0, 0.55, 0), Vector3(w, 1.05, 0.42), oak_l, true, 0.55)
	_add_box(root, Vector3(-0.35, 0.55, 0.2), Vector3(0.7, 0.85, 0.04), oak_d, false, 0.55)
	_add_box(root, Vector3(0.35, 0.55, 0.2), Vector3(0.7, 0.85, 0.04), oak_d, false, 0.55)
	_add_cylinder(root, Vector3(-0.35, 0.55, 0.24), 0.02, 0.08, BRASS, false, 0.3, true)
	_add_cylinder(root, Vector3(0.35, 0.55, 0.24), 0.02, 0.08, BRASS, false, 0.3, true)
	# Upper plate rack open shelves
	_add_box(root, Vector3(0, 1.55, -0.05), Vector3(w, 0.08, 0.36), OAK, true, 0.5)
	_add_box(root, Vector3(0, 2.0, -0.05), Vector3(w, 0.08, 0.36), OAK, true, 0.5)
	_add_box(root, Vector3(0, 2.4, -0.05), Vector3(w, 0.1, 0.38), OAK, true, 0.5)
	_add_box(root, Vector3(-w * 0.48, 1.75, -0.05), Vector3(0.06, 1.3, 0.36), OAK, true, 0.5)
	_add_box(root, Vector3(w * 0.48, 1.75, -0.05), Vector3(0.06, 1.3, 0.36), OAK, true, 0.5)
	_add_box(root, Vector3(0, 1.75, -0.2), Vector3(w * 0.95, 1.3, 0.04), OAK.darkened(0.15), false, 0.55)
	# Loop 87: plate stacks with rims + crocks/jugs (clear kitchen, never book spines)
	for i in 5:
		var px := -0.6 + i * 0.3
		var kind := (i + seed0) % 4
		if kind == 0:
			# Plate stack
			_add_cylinder(root, Vector3(px, 1.6, 0.04), 0.1, 0.025, CREAM, false, 0.75)
			_add_cylinder(root, Vector3(px, 1.625, 0.04), 0.09, 0.02, CREAM.darkened(0.06), false, 0.75)
			_add_cylinder(root, Vector3(px, 1.645, 0.04), 0.08, 0.018, CREAM.lightened(0.04), false, 0.75)
		elif kind == 1:
			# Crock with lid
			_add_cylinder(root, Vector3(px, 1.7, 0.04), 0.065, 0.16, CLAY if (i + seed0) % 2 == 0 else CLAY.lightened(0.08), false, 0.8)
			_add_cylinder(root, Vector3(px, 1.8, 0.04), 0.055, 0.035, CLAY.darkened(0.1), false, 0.8)
		elif kind == 2:
			# Copper bowl: bottom + belly + flared rim + handle (loop 119)
			_add_cylinder(root, Vector3(px, 1.62, 0.04), 0.065, 0.02, COPPER.darkened(0.1), false, 0.35, true)
			_add_cylinder(root, Vector3(px, 1.68, 0.04), 0.085, 0.1, COPPER, false, 0.35, true)
			_add_cylinder(root, Vector3(px, 1.74, 0.04), 0.095, 0.02, COPPER.lightened(0.08), false, 0.32, true)
			_add_box(root, Vector3(px + 0.09, 1.68, 0.04), Vector3(0.05, 0.035, 0.03), COPPER, false, 0.35)
		else:
			# Jug
			_add_cylinder(root, Vector3(px, 1.68, 0.04), 0.05, 0.14, CREAM.darkened(0.08), false, 0.75)
			_add_box(root, Vector3(px + 0.05, 1.7, 0.04), Vector3(0.035, 0.08, 0.03), CREAM.darkened(0.12), false, 0.75)
		# Mid shelf: plate / bowl row
		_add_cylinder(root, Vector3(px + 0.02, 2.06, 0.04), 0.085, 0.025, CREAM.darkened(0.04 * float((i + seed0) % 3)), false, 0.75)
		if (i + seed0) % 2 == 0:
			_add_cylinder(root, Vector3(px, 2.46, 0.02), 0.09, 0.022, CREAM.darkened(0.08), false, 0.75)
			_add_cylinder(root, Vector3(px, 2.48, 0.02), 0.08, 0.018, CREAM, false, 0.75)
		else:
			_add_cylinder(root, Vector3(px, 2.52, 0.02), 0.055, 0.12, CLAY.lightened(0.05), false, 0.8)
			_add_cylinder(root, Vector3(px, 2.6, 0.02), 0.04, 0.03, CLAY.darkened(0.08), false, 0.8)
	# Work-top: jars + bulbous copper (loop 119 vessels, not coil stacks)
	_add_cylinder(root, Vector3(0.5, 1.18, 0.08), 0.07, 0.18, CLAY if seed0 % 2 == 0 else CLAY.darkened(0.08), false, 0.8)
	_add_cylinder(root, Vector3(0.5, 1.28, 0.08), 0.05, 0.04, CLAY.darkened(0.1), false, 0.8)
	_add_cylinder(root, Vector3(0.65, 1.14, 0.02), 0.06, 0.14, CLAY.lightened(0.1), false, 0.8)
	# Copper stockpot: belly + rim + side handle
	var dcop := COPPER if seed0 % 2 == 0 else COPPER.darkened(0.1)
	_add_cylinder(root, Vector3(-0.5, 1.12, 0.08), 0.065, 0.04, dcop.darkened(0.08), false, 0.35, true)
	_add_cylinder(root, Vector3(-0.5, 1.18, 0.08), 0.09, 0.12, dcop, false, 0.35, true)
	_add_cylinder(root, Vector3(-0.5, 1.26, 0.08), 0.095, 0.025, dcop.lightened(0.08), false, 0.32, true)
	_add_box(root, Vector3(-0.38, 1.18, 0.08), Vector3(0.05, 0.06, 0.04), dcop, false, 0.35)
	# Copper skillet: shallow bowl + handle
	_add_cylinder(root, Vector3(-0.25, 1.12, 0.02), 0.07, 0.02, COPPER.darkened(0.1), false, 0.35, true)
	_add_cylinder(root, Vector3(-0.25, 1.15, 0.02), 0.085, 0.06, COPPER.darkened(0.05), false, 0.35, true)
	_add_cylinder(root, Vector3(-0.25, 1.19, 0.02), 0.09, 0.02, COPPER.lightened(0.06), false, 0.32, true)
	_add_box(root, Vector3(-0.1, 1.15, 0.02), Vector3(0.14, 0.02, 0.035), COPPER.darkened(0.05), false, 0.35)
	_add_box(root, Vector3(0.1, 1.1, 0.1), Vector3(0.2, 0.03, 0.14), CREAM.darkened(0.05), false, 0.85)
	_add_contact_shadow(root, 0.9, 0.3)
	return root

static func _make_sink(prop: Dictionary) -> Node3D:
	## Scullery butler sink — deep stoneware well + drain board + pump (loop 119).
	var root := Node3D.new()
	root.name = "Sink"
	var seed0: int = int(prop.get("seed", 0))
	var wood := OAK if seed0 % 2 == 0 else Color(0.48, 0.34, 0.2)
	var ware := Color(0.88, 0.86, 0.8)
	var ware_d := Color(0.72, 0.7, 0.64)
	var well := Color(0.38, 0.44, 0.48)
	# Cabinet body + plinth
	_add_box(root, Vector3(0, 0.42, 0), Vector3(1.15, 0.78, 0.58), wood, true, 0.5)
	_add_box(root, Vector3(0, 0.06, 0.02), Vector3(1.2, 0.1, 0.62), wood.darkened(0.1), true, 0.5)
	# Fielded double doors + brass knobs
	_add_box(root, Vector3(-0.26, 0.4, 0.28), Vector3(0.5, 0.68, 0.04), wood.darkened(0.06), false, 0.5)
	_add_box(root, Vector3(0.26, 0.4, 0.28), Vector3(0.5, 0.68, 0.04), wood.darkened(0.06), false, 0.5)
	_add_box(root, Vector3(-0.26, 0.4, 0.3), Vector3(0.38, 0.48, 0.012), wood.darkened(0.14), false, 0.55)
	_add_box(root, Vector3(0.26, 0.4, 0.3), Vector3(0.38, 0.48, 0.012), wood.darkened(0.14), false, 0.55)
	_add_cylinder(root, Vector3(-0.1, 0.4, 0.32), 0.018, 0.05, BRASS, false, 0.3, true)
	_add_cylinder(root, Vector3(0.1, 0.4, 0.32), 0.018, 0.05, BRASS, false, 0.3, true)
	# Deep butler basin: outer apron + raised rim walls + recessed wet well (not flat slab)
	_add_box(root, Vector3(0.12, 0.88, 0.02), Vector3(0.78, 0.12, 0.52), ware_d, false, 0.55)
	# Four rim walls
	_add_box(root, Vector3(0.12, 1.0, 0.24), Vector3(0.76, 0.12, 0.05), ware, false, 0.5)
	_add_box(root, Vector3(0.12, 1.0, -0.2), Vector3(0.76, 0.12, 0.05), ware, false, 0.5)
	_add_box(root, Vector3(-0.24, 1.0, 0.02), Vector3(0.05, 0.12, 0.48), ware, false, 0.5)
	_add_box(root, Vector3(0.48, 1.0, 0.02), Vector3(0.05, 0.12, 0.48), ware, false, 0.5)
	# Inner wet well (recessed, darker)
	_add_box(root, Vector3(0.12, 0.92, 0.02), Vector3(0.62, 0.06, 0.36), well, false, 0.35)
	# Drain hole
	_add_cylinder(root, Vector3(0.12, 0.95, 0.02), 0.04, 0.02, IRON.lightened(0.15), false, 0.4)
	# Drain board (sloped scrubbed wood) left of basin + groove ribs
	_add_box(root, Vector3(-0.42, 0.96, 0.02), Vector3(0.38, 0.05, 0.48), OAK.lightened(0.18), false, 0.65)
	for gi in 4:
		var gz := -0.16 + float(gi) * 0.1
		_add_box(root, Vector3(-0.42, 0.99, gz), Vector3(0.32, 0.01, 0.02), OAK.lightened(0.05), false, 0.6)
	# Backsplash tile strip with grout lines
	_add_box(root, Vector3(0, 1.2, -0.24), Vector3(1.12, 0.42, 0.04), CREAM.darkened(0.02), false, 0.75)
	for ti in 3:
		_add_box(root, Vector3(-0.35 + float(ti) * 0.35, 1.2, -0.22), Vector3(0.3, 0.36, 0.02), CREAM.lightened(0.04), false, 0.72)
	_add_box(root, Vector3(0, 1.05, -0.21), Vector3(1.08, 0.03, 0.02), Color(0.55, 0.58, 0.52), false, 0.7)
	# Hand pump + spout + handle (clearer silhouette)
	_add_cylinder(root, Vector3(0.35, 1.22, -0.1), 0.04, 0.38, BRASS.darkened(0.05), false, 0.3, true)
	_add_cylinder(root, Vector3(0.35, 1.42, -0.1), 0.055, 0.07, BRASS, false, 0.28, true)
	_add_box(root, Vector3(0.18, 1.38, 0.02), Vector3(0.32, 0.04, 0.04), BRASS, false, 0.3)
	_add_cylinder(root, Vector3(0.02, 1.32, 0.08), 0.025, 0.1, BRASS, false, 0.3, true)
	_add_box(root, Vector3(0.48, 1.28, -0.08), Vector3(0.05, 0.2, 0.05), BRASS.darkened(0.08), false, 0.3)
	_add_box(root, Vector3(0.58, 1.36, -0.08), Vector3(0.14, 0.035, 0.035), BRASS, false, 0.3)
	# Still-life fork (soap, cloth, crock / copper vessel)
	if seed0 % 2 == 0:
		_add_box(root, Vector3(-0.45, 1.02, 0.18), Vector3(0.12, 0.035, 0.08), CREAM, false, 0.85)
		_add_box(root, Vector3(-0.3, 1.0, 0.2), Vector3(0.18, 0.02, 0.12), Color(0.72, 0.76, 0.78), false, 0.7)
		_add_cylinder(root, Vector3(0.55, 1.08, 0.14), 0.05, 0.12, CREAM.darkened(0.1), false, 0.8)
		_add_cylinder(root, Vector3(0.55, 1.16, 0.14), 0.03, 0.04, CREAM.darkened(0.15), false, 0.8)
	else:
		# Mini copper bowl with rim (not plain cylinder)
		_add_cylinder(root, Vector3(-0.4, 1.02, 0.12), 0.05, 0.02, COPPER.darkened(0.1), false, 0.35, true)
		_add_cylinder(root, Vector3(-0.4, 1.06, 0.12), 0.065, 0.08, COPPER, false, 0.35, true)
		_add_cylinder(root, Vector3(-0.4, 1.11, 0.12), 0.07, 0.02, COPPER.lightened(0.08), false, 0.32, true)
		_add_box(root, Vector3(0.4, 1.0, 0.16), Vector3(0.16, 0.02, 0.1), CREAM.darkened(0.05), false, 0.85)
		_add_cylinder(root, Vector3(0.42, 1.05, 0.12), 0.04, 0.08, CLAY, false, 0.8)
		_add_box(root, Vector3(-0.15, 0.99, 0.22), Vector3(0.14, 0.015, 0.1), Color(0.65, 0.7, 0.72), false, 0.7)
	_add_contact_shadow(root, 0.62, 0.36)
	return root

static func _make_prep_table(prop: Dictionary) -> Node3D:
	## Scrubbed kitchen prep table — loop 145 still-life: boards/food/tools dominate
	## (not stacked barrel cylinders that read Minecraft from the doorway).
	var root := Node3D.new()
	root.name = "PrepTable"
	var width: float = float(prop.get("width", 1.8))
	var seed0: int = int(prop.get("seed", 0))
	var kit := seed0 % 4
	# Scrubbed pale work-top (board, not mahogany furniture)
	var top_col := Color(0.74, 0.64, 0.44) if kit != 2 else Color(0.7, 0.6, 0.42)
	_add_box(root, Vector3(0, 0.82, 0), Vector3(width, 0.06, 0.85), top_col, true, 0.72)
	_add_box(root, Vector3(0, 0.72, 0), Vector3(width - 0.1, 0.12, 0.78), Color(0.55, 0.42, 0.28), false, 0.55)
	_add_box(root, Vector3(0, 0.86, 0.42), Vector3(width * 0.98, 0.025, 0.03), top_col.darkened(0.08), false, 0.7)
	# Breadboard groove on top
	_add_box(root, Vector3(0, 0.855, -0.15), Vector3(width * 0.55, 0.008, 0.35), top_col.darkened(0.12), false, 0.75)
	for lx in [-width * 0.4, width * 0.4]:
		for lz in [-0.32, 0.32]:
			_add_box(root, Vector3(lx, 0.4, lz), Vector3(0.08, 0.78, 0.08), Color(0.38, 0.26, 0.14), true, 0.55)
	_add_box(root, Vector3(0, 0.18, 0), Vector3(width * 0.75, 0.04, 0.7), OAK.darkened(0.08), false, 0.55)
	# Lower shelf — boxes/trays first (not mystery copper towers)
	_add_box(root, Vector3(0, 0.28, 0), Vector3(width * 0.72, 0.03, 0.55), OAK.lightened(0.05), false, 0.6)
	_add_box(root, Vector3(-width * 0.18, 0.36, 0.05), Vector3(0.28, 0.14, 0.22), OAK.darkened(0.12), false, 0.6)
	_add_box(root, Vector3(-width * 0.18, 0.44, 0.05), Vector3(0.24, 0.02, 0.18), OAK.darkened(0.05), false, 0.58)
	_add_box(root, Vector3(width * 0.2, 0.34, -0.05), Vector3(0.26, 0.1, 0.2), Color(0.48, 0.36, 0.22), false, 0.7)
	_add_cylinder(root, Vector3(width * 0.22, 0.42, 0.12), 0.06, 0.1, CREAM.darkened(0.1), false, 0.85)
	match kit:
		0:
			# Loop 163: flour/dough day — cloth bag + oval loaf (no snowman sphere stack).
			# Loop 168: cloth flour sack (not stacked cup towers / snowman).
			# Crust MUST miss copper. Sack g≥0.7 so linen gate wins (g<0.7 was scrubbed wood).
			var sack := Color(0.85, 0.78, 0.62)      # linen (g≥0.7 skips scrubbed wood)
			var sack_d := Color(0.78, 0.7, 0.55)     # still linen-ish
			var sack_dd := Color(0.72, 0.66, 0.5)     # g≥0.65 linen edge
			var crust := Color(0.48, 0.32, 0.16)     # wood brown
			var crumb := Color(0.8, 0.7, 0.5)
			# ONE wide low body (bag sits on table) + slight lean for slump
			_add_cylinder(root, Vector3(-0.5, 0.94, 0.02), 0.14, 0.14, sack, false, 0.92)
			_add_cylinder(root, Vector3(-0.48, 0.96, 0.05), 0.12, 0.1, sack_d, false, 0.92)
			# Belly bulge (wider mid band only — not a second tower)
			_add_cylinder(root, Vector3(-0.5, 0.95, 0.02), 0.155, 0.05, sack_d, false, 0.9)
			# Flat closed top (cloth fold lid) — short, not a cup rim stack
			_add_box(root, Vector3(-0.5, 1.03, 0.02), Vector3(0.24, 0.035, 0.2), sack_d, false, 0.9)
			_add_box(root, Vector3(-0.46, 1.05, -0.02), Vector3(0.1, 0.025, 0.08), sack, false, 0.9)
			_add_box(root, Vector3(-0.56, 1.045, 0.06), Vector3(0.08, 0.02, 0.07), sack_dd, false, 0.9)
			# Small gathered ear + twine (short knob only)
			_add_cylinder(root, Vector3(-0.5, 1.07, 0.02), 0.04, 0.035, sack_dd, false, 0.9)
			_add_cylinder(root, Vector3(-0.5, 1.075, 0.02), 0.045, 0.01, Color(0.36, 0.28, 0.16), false, 0.8)
			# Stencil / flour brand on face
			_add_box(root, Vector3(-0.38, 0.96, 0.02), Vector3(0.01, 0.06, 0.08), sack_dd, false, 0.88)
			_add_box(root, Vector3(-0.375, 0.97, 0.02), Vector3(0.008, 0.035, 0.05), Color(0.4, 0.18, 0.12), false, 0.7)
			# Wide dough board + flour dust
			_add_box(root, Vector3(0.1, 0.875, -0.05), Vector3(0.72, 0.03, 0.42), OAK.lightened(0.18), false, 0.65)
			_add_box(root, Vector3(0.1, 0.89, -0.05), Vector3(0.7, 0.008, 0.4), OAK.lightened(0.1), false, 0.68)
			_add_box(root, Vector3(0.02, 0.882, 0.0), Vector3(0.48, 0.006, 0.3), CREAM.lightened(0.1), false, 0.95)
			_add_box(root, Vector3(0.15, 0.883, -0.08), Vector3(0.2, 0.005, 0.14), CREAM, false, 0.95)
			# Oval loaf — lower profile, one crust shell + crumb top (readable scores)
			_add_cylinder_rotated(root, Vector3(0.0, 0.915, -0.05), 0.05, 0.32, crust, Vector3(0, 0, PI * 0.5), 0.92)
			_add_cylinder_rotated(root, Vector3(0.0, 0.93, -0.05), 0.038, 0.26, crumb, Vector3(0, 0, PI * 0.5), 0.94)
			_add_cylinder_rotated(root, Vector3(-0.14, 0.915, -0.05), 0.042, 0.05, crust, Vector3(0, 0, PI * 0.5), 0.92)
			_add_cylinder_rotated(root, Vector3(0.14, 0.915, -0.05), 0.042, 0.05, crust, Vector3(0, 0, PI * 0.5), 0.92)
			_add_box(root, Vector3(0.0, 0.96, -0.05), Vector3(0.2, 0.005, 0.008), crust.darkened(0.12), false, 0.92)
			_add_box(root, Vector3(0.0, 0.96, -0.02), Vector3(0.16, 0.004, 0.006), crust.darkened(0.1), false, 0.92)
			# Flour scoop (period cue)
			_add_box(root, Vector3(-0.28, 0.9, 0.18), Vector3(0.1, 0.025, 0.06), OAK.lightened(0.05), false, 0.55)
			_add_cylinder_rotated(root, Vector3(-0.22, 0.9, 0.18), 0.012, 0.1, OAK.darkened(0.05), Vector3(0, 0, PI * 0.5), 0.55)
			# Carving knife on rest
			_add_box(root, Vector3(0.34, 0.895, 0.12), Vector3(0.28, 0.012, 0.04), OAK.darkened(0.05), false, 0.55)
			_add_box(root, Vector3(0.42, 0.905, 0.12), Vector3(0.2, 0.008, 0.018), IRON.lightened(0.15), false, 0.28)
			_add_box(root, Vector3(0.5, 0.905, 0.12), Vector3(0.04, 0.006, 0.01), IRON.lightened(0.05), false, 0.3)
			_add_cylinder_rotated(root, Vector3(0.28, 0.905, 0.12), 0.012, 0.08, Color(0.35, 0.22, 0.12), Vector3(0, 0, PI * 0.5), 0.55)
			# Shallow copper basin + folded tea towel
			_add_cylinder(root, Vector3(0.52, 0.9, -0.15), 0.11, 0.05, COPPER, false, 0.35, true)
			_add_cylinder(root, Vector3(0.52, 0.935, -0.15), 0.12, 0.018, COPPER.lightened(0.08), false, 0.32, true)
			_add_box(root, Vector3(0.5, 0.875, 0.14), Vector3(0.14, 0.012, 0.1), Color(0.62, 0.58, 0.48), false, 0.85)
			_add_box(root, Vector3(0.5, 0.885, 0.14), Vector3(0.1, 0.01, 0.08), Color(0.7, 0.66, 0.55), false, 0.88)
			# Cold apples (produce)
			_add_sphere_blob(root, Vector3(0.2, 0.9, 0.18), 0.038, Color(0.55, 0.18, 0.14))
			_add_sphere_blob(root, Vector3(0.28, 0.9, 0.14), 0.033, Color(0.48, 0.22, 0.12))
			_add_sphere_blob(root, Vector3(0.22, 0.91, 0.1), 0.03, Color(0.6, 0.2, 0.14))
			# Salt crock — moved clear of sack (was merging into cup stack)
			_add_cylinder(root, Vector3(0.32, 0.91, -0.22), 0.038, 0.07, CREAM.darkened(0.08), false, 0.85)
			_add_cylinder(root, Vector3(0.32, 0.955, -0.22), 0.03, 0.022, CREAM.darkened(0.14), false, 0.85)
		1:
			# Baking — pie board, pie dish, low mixing bowl, horizontal rolling pin, cutters
			_add_box(root, Vector3(-0.4, 0.875, 0.0), Vector3(0.55, 0.03, 0.38), OAK.lightened(0.18), false, 0.65)
			# Dough slab (soft, low — not a tall brick)
			_add_box(root, Vector3(-0.4, 0.895, 0.0), Vector3(0.28, 0.03, 0.14), CREAM.darkened(0.08), false, 0.88)
			_add_sphere_blob(root, Vector3(-0.4, 0.9, 0.0), 0.08, CREAM.darkened(0.1))
			# Pie dish (shallow glazed) + crust rim
			_add_cylinder(root, Vector3(0.1, 0.89, 0.1), 0.12, 0.04, Color(0.55, 0.22, 0.18), false, 0.7)
			_add_cylinder(root, Vector3(0.1, 0.92, 0.1), 0.11, 0.025, Color(0.62, 0.28, 0.2), false, 0.65)
			_add_cylinder(root, Vector3(0.1, 0.935, 0.1), 0.08, 0.02, Color(0.75, 0.55, 0.35), false, 0.8)
			# Rolling pin — true horizontal (axis along X) + handles
			_add_cylinder_rotated(root, Vector3(0.35, 0.9, -0.15), 0.028, 0.42, OAK.lightened(0.1), Vector3(0, 0, PI * 0.5), 0.6)
			_add_cylinder_rotated(root, Vector3(0.12, 0.9, -0.15), 0.018, 0.06, MAHOGANY, Vector3(0, 0, PI * 0.5), 0.55)
			_add_cylinder_rotated(root, Vector3(0.58, 0.9, -0.15), 0.018, 0.06, MAHOGANY, Vector3(0, 0, PI * 0.5), 0.55)
			# Wide mixing bowl (low) + butter pat
			_add_cylinder(root, Vector3(0.5, 0.92, 0.15), 0.13, 0.08, CLAY.lightened(0.05), false, 0.8)
			_add_cylinder(root, Vector3(0.5, 0.97, 0.15), 0.14, 0.02, CLAY, false, 0.75)
			_add_box(root, Vector3(-0.05, 0.875, 0.25), Vector3(0.14, 0.03, 0.1), CREAM.darkened(0.1), false, 0.85)
			_add_sphere_blob(root, Vector3(-0.05, 0.895, 0.25), 0.035, CREAM.lightened(0.05))
			# Cookie cutters as thin rings
			_add_cylinder(root, Vector3(0.25, 0.88, 0.22), 0.04, 0.012, IRON.lightened(0.15), false, 0.4)
			_add_cylinder(root, Vector3(0.35, 0.88, 0.25), 0.032, 0.01, IRON.lightened(0.1), false, 0.4)
			_add_box(root, Vector3(-0.55, 0.875, 0.2), Vector3(0.16, 0.012, 0.12), Color(0.7, 0.72, 0.68), false, 0.8)
		2:
			# Loop 159: market veg — oval wicker tray (not wooden crate), roots, chop block
			var wick := Color(0.52, 0.38, 0.2)
			var wick_d := Color(0.4, 0.28, 0.14)
			# Shallow oval basket: cylinder body + rim (reads woven tray, not box)
			_add_cylinder(root, Vector3(-0.38, 0.9, 0.0), 0.16, 0.08, wick, false, 0.72)
			_add_cylinder(root, Vector3(-0.38, 0.88, 0.0), 0.14, 0.03, wick_d, false, 0.75)
			_add_cylinder(root, Vector3(-0.38, 0.95, 0.0), 0.17, 0.025, wick_d, false, 0.7)
			# Flatten oval via thin side lips
			_add_box(root, Vector3(-0.38, 0.93, 0.12), Vector3(0.3, 0.04, 0.02), wick_d, false, 0.72)
			_add_box(root, Vector3(-0.38, 0.93, -0.12), Vector3(0.3, 0.04, 0.02), wick_d, false, 0.72)
			# Greens mound + roots / carrots
			_add_sphere_blob(root, Vector3(-0.38, 0.98, 0.0), 0.08, Color(0.26, 0.4, 0.16))
			_add_sphere_blob(root, Vector3(-0.32, 1.0, 0.06), 0.05, Color(0.3, 0.42, 0.18))
			_add_sphere_blob(root, Vector3(-0.42, 0.99, -0.04), 0.045, Color(0.22, 0.36, 0.14))
			_add_sphere_blob(root, Vector3(-0.34, 1.02, 0.04), 0.032, Color(0.85, 0.45, 0.15))
			_add_sphere_blob(root, Vector3(-0.44, 1.0, 0.0), 0.028, Color(0.9, 0.5, 0.18))
			_add_cylinder_rotated(root, Vector3(-0.28, 0.98, -0.04), 0.015, 0.1, Color(0.85, 0.55, 0.2), Vector3(0, 0, PI * 0.35), 0.7)
			_add_cylinder_rotated(root, Vector3(-0.48, 0.98, 0.05), 0.012, 0.08, Color(0.8, 0.5, 0.18), Vector3(0, 0, -PI * 0.3), 0.7)
			# Thick chop block + cleaver
			_add_box(root, Vector3(0.3, 0.9, -0.05), Vector3(0.42, 0.09, 0.3), OAK.lightened(0.08), false, 0.55)
			_add_box(root, Vector3(0.3, 0.86, -0.05), Vector3(0.46, 0.035, 0.33), OAK.darkened(0.05), false, 0.55)
			_add_box(root, Vector3(0.36, 0.96, 0.02), Vector3(0.2, 0.015, 0.04), IRON.lightened(0.08), false, 0.35)
			_add_cylinder_rotated(root, Vector3(0.22, 0.96, 0.02), 0.014, 0.07, Color(0.32, 0.2, 0.1), Vector3(0, 0, PI * 0.5), 0.6)
			# Salt crock + tea towel
			_add_cylinder(root, Vector3(0.52, 0.93, 0.16), 0.045, 0.09, CREAM.darkened(0.06), false, 0.85)
			_add_cylinder(root, Vector3(0.52, 0.99, 0.16), 0.036, 0.022, CREAM.darkened(0.12), false, 0.85)
			_add_box(root, Vector3(0.08, 0.875, 0.22), Vector3(0.18, 0.012, 0.12), Color(0.72, 0.74, 0.7), false, 0.8)
			_add_sphere_blob(root, Vector3(0.52, 0.9, -0.14), 0.038, Color(0.52, 0.16, 0.12))
		_:
			# Scullery prep — mortar, pestle, herb board, copper colander shallow, spoon, cloth
			_add_box(root, Vector3(-0.35, 0.875, 0.05), Vector3(0.48, 0.03, 0.32), OAK.lightened(0.15), false, 0.65)
			# Herb / leaf piles (flat greens, not cylinders)
			_add_box(root, Vector3(-0.4, 0.9, 0.05), Vector3(0.22, 0.03, 0.14), Color(0.28, 0.4, 0.18), false, 0.85)
			_add_box(root, Vector3(-0.28, 0.9, -0.05), Vector3(0.16, 0.025, 0.12), Color(0.32, 0.38, 0.16), false, 0.85)
			# Mortar (short thick) + pestle
			_add_cylinder(root, Vector3(0.15, 0.92, 0.05), 0.09, 0.1, STONE.lightened(0.1), false, 0.7)
			_add_cylinder(root, Vector3(0.15, 0.98, 0.05), 0.1, 0.03, STONE, false, 0.65)
			_add_cylinder(root, Vector3(0.22, 1.05, 0.08), 0.02, 0.16, OAK.darkened(0.05), false, 0.55)
			_add_sphere_blob(root, Vector3(0.22, 0.98, 0.08), 0.03, OAK)
			# Shallow copper colander (wide, low) + holes as dark dots
			_add_cylinder(root, Vector3(0.5, 0.9, -0.1), 0.12, 0.05, COPPER, false, 0.35, true)
			_add_cylinder(root, Vector3(0.5, 0.94, -0.1), 0.13, 0.02, COPPER.lightened(0.06), false, 0.32, true)
			for hi in 4:
				var hx := 0.45 + float(hi % 2) * 0.08
				var hz := -0.14 + float(hi / 2) * 0.08
				_add_cylinder(root, Vector3(hx, 0.92, hz), 0.012, 0.01, Color(0.15, 0.12, 0.1), false, 0.8)
			# Wooden spoon + iron ladle
			_add_box(root, Vector3(-0.1, 0.89, -0.2), Vector3(0.32, 0.015, 0.03), OAK.lightened(0.05), false, 0.55)
			_add_sphere_blob(root, Vector3(-0.26, 0.89, -0.2), 0.028, OAK)
			_add_box(root, Vector3(0.25, 0.89, 0.22), Vector3(0.28, 0.015, 0.025), IRON, false, 0.4)
			_add_cylinder(root, Vector3(0.08, 0.89, 0.22), 0.035, 0.025, COPPER.darkened(0.05), false, 0.35, true)
			# Cloth + small cream jar only
			_add_box(root, Vector3(0.5, 0.875, 0.2), Vector3(0.16, 0.015, 0.12), Color(0.68, 0.7, 0.66), false, 0.8)
			_add_cylinder(root, Vector3(-0.55, 0.92, 0.2), 0.045, 0.1, CREAM.darkened(0.1), false, 0.85)
			_add_cylinder(root, Vector3(-0.55, 0.98, 0.2), 0.035, 0.03, CREAM.darkened(0.16), false, 0.85)
	_add_contact_shadow(root, width * 0.5, 0.5)
	return root


static func _make_floor_path(prop: Dictionary) -> Node3D:
	## Walk path — surface: stone (conservatory), iron (workshop/gallery), wood (service).
	## Loop 89: iron plates are riveted diamond-tread with curbs — not flat black slabs.
	## Never stamp pale stone on a finished hall runner (hall uses rug alone).
	var root := Node3D.new()
	root.name = "FloorPath"
	var length: float = float(prop.get("length", 3.5))
	var width: float = float(prop.get("width", 0.9))
	var seed0: int = int(prop.get("seed", 0))
	var surface: String = str(prop.get("surface", "stone"))
	var n := int(clampf(length / 0.55, 3.0, 14.0))
	# Mid-grey iron that reads under filmic tonemap (pure dark metal → black void)
	var iron_mid := Color(0.34, 0.34, 0.36)
	var iron_light := Color(0.42, 0.42, 0.44)
	var iron_dark := Color(0.26, 0.26, 0.28)
	var iron_edge := Color(0.48, 0.46, 0.42)  # slight brass-worn lip
	if surface == "iron":
		# Continuous bed so gaps aren't void
		_add_box(root, Vector3(0, 0.01, 0), Vector3(width * 0.98, 0.014, length * 0.98), iron_dark, false, 0.55)
		# Side curbs (coach-house / experiment floor language)
		_add_box(root, Vector3(-width * 0.48, 0.035, 0), Vector3(0.06, 0.05, length * 0.96), iron_mid, false, 0.5)
		_add_box(root, Vector3(width * 0.48, 0.035, 0), Vector3(0.06, 0.05, length * 0.96), iron_mid, false, 0.5)
		# Brass corner finials at path ends
		for ez in [-1.0, 1.0]:
			for ex in [-1.0, 1.0]:
				_add_cylinder(
					root,
					Vector3(ex * width * 0.48, 0.06, ez * length * 0.46),
					0.03, 0.05, BRASS.darkened(0.15), false, 0.35, true
				)
	for i in n:
		var z := -length * 0.5 + 0.3 + float(i) * (length / float(n))
		var ox := 0.03 * float(((i + seed0) % 3) - 1)
		if surface == "iron":
			var pw := width * (0.82 + float(i % 2) * 0.05)
			var pd := 0.48
			var icol := iron_light if (i + seed0) % 2 == 0 else iron_mid
			# Raised plate body
			_add_box(root, Vector3(ox, 0.028, z), Vector3(pw, 0.028, pd), icol, false, 0.48)
			# Raised perimeter lip (reads as plate edge, not Minecraft block)
			_add_box(root, Vector3(ox, 0.044, z - pd * 0.42), Vector3(pw * 0.96, 0.012, 0.03), iron_edge, false, 0.45)
			_add_box(root, Vector3(ox, 0.044, z + pd * 0.42), Vector3(pw * 0.96, 0.012, 0.03), iron_edge, false, 0.45)
			_add_box(root, Vector3(ox - pw * 0.45, 0.044, z), Vector3(0.03, 0.012, pd * 0.88), iron_edge, false, 0.45)
			_add_box(root, Vector3(ox + pw * 0.45, 0.044, z), Vector3(0.03, 0.012, pd * 0.88), iron_edge, false, 0.45)
			# Diamond-tread ridges (seed forks orientation)
			if (i + seed0) % 2 == 0:
				for r in 3:
					var rx := ox - pw * 0.25 + float(r) * (pw * 0.25)
					_add_box(root, Vector3(rx, 0.042, z), Vector3(0.04, 0.01, pd * 0.7), iron_light.lightened(0.06), false, 0.5)
			else:
				for r2 in 2:
					var rz := z - pd * 0.18 + float(r2) * (pd * 0.36)
					_add_box(root, Vector3(ox, 0.042, rz), Vector3(pw * 0.7, 0.01, 0.035), iron_light.lightened(0.05), false, 0.5)
			# Four corner rivets + mid-edge bolts
			var riv := IRON.lightened(0.22)
			for cx in [-1.0, 1.0]:
				for cz in [-1.0, 1.0]:
					_add_cylinder(
						root,
						Vector3(ox + cx * pw * 0.38, 0.05, z + cz * pd * 0.35),
						0.018, 0.016, riv, false, 0.4
					)
			_add_cylinder(root, Vector3(ox, 0.05, z), 0.016, 0.014, BRASS.darkened(0.25), false, 0.35, true)
			# Dark seam gap between plates
			_add_box(root, Vector3(ox, 0.02, z + pd * 0.5), Vector3(pw * 0.9, 0.01, 0.04), iron_dark.darkened(0.1), false, 0.55)
			# Occasional copper wear scuff (experiment floor history)
			if (i + seed0) % 4 == 0:
				_add_box(
					root,
					Vector3(ox + pw * 0.15, 0.046, z - 0.05),
					Vector3(0.12, 0.008, 0.08),
					COPPER.darkened(0.2), false, 0.45
				)
		elif surface == "wood":
			var wcol := OAK.darkened(0.05) if (i + seed0) % 2 == 0 else OAK.darkened(0.12)
			_add_box(root, Vector3(ox, 0.02, z), Vector3(width * 0.9, 0.035, 0.52), wcol, false, 0.6)
			_add_box(root, Vector3(ox, 0.015, z + 0.22), Vector3(width * 0.85, 0.008, 0.02), OAK.darkened(0.18), false, 0.55)
		else:
			# Loop 170: stone flags — colors MUST hit TEX_STONE (r>0.45,g>0.42,b>0.36,|r−g|<0.1).
			# Prior greys hit iron/wood paths → metal plates + board look on conservatory path.
			var pw := width * (0.78 + float(i % 3) * 0.06)
			var pd := 0.48 + float((i + seed0) % 2) * 0.06
			var col: Color
			match (i + seed0) % 5:
				0:
					col = Color(0.55, 0.52, 0.46)
				1:
					col = Color(0.5, 0.48, 0.42)
				2:
					col = Color(0.58, 0.54, 0.48)
				3:
					col = Color(0.52, 0.5, 0.44)
				_:
					col = Color(0.54, 0.51, 0.45)
			var grit := Color(0.48, 0.46, 0.4)
			# Continuous gravel bed under each flag
			_add_box(root, Vector3(ox, 0.008, z), Vector3(pw * 1.12, 0.014, pd * 1.12), grit, false, 0.88)
			# Raised flag (slight height jitter) + dark lip
			var hy := 0.024 + float((i + seed0) % 3) * 0.005
			_add_box(root, Vector3(ox, hy, z), Vector3(pw, 0.04, pd), col, false, 0.78)
			_add_box(root, Vector3(ox, hy - 0.01, z), Vector3(pw * 1.05, 0.012, pd * 1.05), grit.darkened(0.08), false, 0.85)
			# Mortar seam between flags
			_add_box(root, Vector3(ox, 0.012, z + pd * 0.52), Vector3(pw * 0.95, 0.01, 0.04), grit.darkened(0.05), false, 0.88)
			# Wear groove (not brass rivet — that read as iron plate)
			if (i + seed0) % 3 == 0:
				_add_box(
					root,
					Vector3(ox + pw * 0.08, hy + 0.022, z - pd * 0.08),
					Vector3(pw * 0.4, 0.005, 0.018),
					col.darkened(0.12), false, 0.82
				)
			# Moss tufts (damp conservatory grit)
			if (i + seed0) % 3 != 1:
				_add_box(
					root,
					Vector3(ox + pw * 0.28, hy + 0.018, z - pd * 0.2),
					Vector3(0.09, 0.012, 0.06),
					Color(0.2, 0.36, 0.16), false, 0.92
				)
			if (i + seed0) % 2 == 0:
				_add_box(
					root,
					Vector3(ox - pw * 0.26, hy + 0.016, z + pd * 0.16),
					Vector3(0.07, 0.01, 0.05),
					Color(0.24, 0.38, 0.18), false, 0.92
				)
			# Pebble (stone-class color, not brass bolt)
			if (i + seed0) % 2 == 1:
				_add_cylinder(
					root,
					Vector3(ox + pw * 0.18, hy + 0.018, z + pd * 0.12),
					0.022, 0.018, Color(0.5, 0.48, 0.42), false, 0.8
				)
	# Continuous gravel bed full length + side curbs (loop 170)
	if surface == "stone":
		_add_box(root, Vector3(0, 0.006, 0), Vector3(width * 0.95, 0.01, length * 0.96), Color(0.48, 0.46, 0.4), false, 0.88)
		_add_box(root, Vector3(-width * 0.5, 0.014, 0), Vector3(0.14, 0.028, length * 0.96), Color(0.5, 0.48, 0.42), false, 0.82)
		_add_box(root, Vector3(width * 0.5, 0.014, 0), Vector3(0.14, 0.028, length * 0.96), Color(0.5, 0.48, 0.42), false, 0.82)
		for gi in 10:
			var gz := -length * 0.4 + float(gi) * (length * 0.8 / 9.0)
			_add_cylinder(root, Vector3(-width * 0.5, 0.028, gz), 0.028, 0.022, Color(0.52, 0.5, 0.44), false, 0.8)
			_add_cylinder(root, Vector3(width * 0.5, 0.028, gz), 0.026, 0.02, Color(0.5, 0.48, 0.42), false, 0.8)
	return root


static func _make_garden_bench(prop: Dictionary) -> Node3D:
	## Victorian conservatory / park bench (loop 99).
	## seed 0: cast-iron ends + oak horizontal slats (not Minecraft vertical bars).
	## seed 1: teak garden settle with open back rails + scrolled arms.
	var root := Node3D.new()
	root.name = "GardenBench"
	var seed0: int = int(prop.get("seed", 0))
	var w: float = float(prop.get("width", 1.35))
	var seat_y := 0.44
	var seat_d := 0.48
	if seed0 % 2 == 0:
		# Painted cast-iron (black-green) + weathered oak slats — park-bench language
		var iron_paint := Color(0.14, 0.16, 0.14)
		var iron_hi := Color(0.22, 0.24, 0.2)
		var oak_slat := Color(0.48, 0.34, 0.18)
		var oak_edge := Color(0.38, 0.24, 0.12)
		# Seat frame rails (front/back under slats)
		_add_box(root, Vector3(0, seat_y - 0.04, 0.16), Vector3(w * 0.92, 0.04, 0.05), iron_paint, true, 0.45)
		_add_box(root, Vector3(0, seat_y - 0.04, -0.16), Vector3(w * 0.92, 0.04, 0.05), iron_paint, true, 0.45)
		# Horizontal seat slats (gaps between — reads as real bench, not solid block)
		var n_seat := 5
		for i in n_seat:
			var t := float(i) / float(n_seat - 1)
			var z := -0.18 + t * 0.38
			_add_box(root, Vector3(0, seat_y, z), Vector3(w * 0.9, 0.035, 0.055), oak_slat, true, 0.62)
		# Front nosing strip
		_add_box(root, Vector3(0, seat_y + 0.01, 0.22), Vector3(w * 0.92, 0.04, 0.03), oak_edge, false, 0.55)
		# Back: iron frame + vertical balusters (loop 100: horizontal stack read as shelves from rear)
		_add_box(root, Vector3(0, 0.58, -0.22), Vector3(w * 0.94, 0.05, 0.04), iron_paint, true, 0.42)
		_add_box(root, Vector3(0, 0.98, -0.22), Vector3(w * 0.94, 0.06, 0.05), iron_hi, true, 0.4)
		# Crest rail curve suggestion (thicker centre)
		_add_box(root, Vector3(0, 1.05, -0.21), Vector3(w * 0.7, 0.05, 0.04), iron_paint, false, 0.4)
		_add_box(root, Vector3(0, 1.1, -0.2), Vector3(w * 0.28, 0.04, 0.035), iron_hi, false, 0.38)
		var n_bal := 7
		for i in n_bal:
			var t := float(i) / float(n_bal - 1)
			var bx: float = -w * 0.4 + t * w * 0.8
			_add_box(root, Vector3(bx, 0.78, -0.2), Vector3(0.035, 0.38, 0.03), iron_paint, false, 0.42)
			# Thin oak insert on baluster face (period wood-iron mix)
			if i % 2 == 0:
				_add_box(root, Vector3(bx, 0.78, -0.18), Vector3(0.02, 0.32, 0.02), oak_slat.darkened(0.08), false, 0.6)
		# Cast-iron end standards (scrolled silhouette via stacked shapes)
		for sx in [-1.0, 1.0]:
			var ex: float = sx * w * 0.48
			# Leg posts
			_add_box(root, Vector3(ex, 0.22, 0.14), Vector3(0.06, 0.42, 0.06), iron_paint, true, 0.4)
			_add_box(root, Vector3(ex, 0.22, -0.18), Vector3(0.06, 0.42, 0.06), iron_paint, true, 0.4)
			# Scroll feet
			_add_box(root, Vector3(ex, 0.03, 0.18), Vector3(0.08, 0.05, 0.14), iron_hi, true, 0.4)
			_add_box(root, Vector3(ex, 0.03, -0.22), Vector3(0.08, 0.05, 0.14), iron_hi, true, 0.4)
			_add_cylinder(root, Vector3(ex, 0.04, 0.26), 0.04, 0.04, iron_paint, false, 0.4, true)
			_add_cylinder(root, Vector3(ex, 0.04, -0.28), 0.04, 0.04, iron_paint, false, 0.4, true)
			# Side panel / arm upright with decorative voids suggested by rails
			_add_box(root, Vector3(ex, 0.72, -0.02), Vector3(0.05, 0.55, 0.06), iron_paint, true, 0.4)
			_add_box(root, Vector3(ex, 0.55, 0.0), Vector3(0.04, 0.06, 0.38), iron_hi, false, 0.4)
			# Armrest
			_add_box(root, Vector3(ex, 0.68, 0.02), Vector3(0.07, 0.05, 0.42), iron_paint, false, 0.38)
			_add_cylinder(root, Vector3(ex, 0.68, 0.22), 0.035, 0.06, iron_hi, false, 0.35, true)
			# Decorative medallion on end
			_add_cylinder(root, Vector3(ex + sx * 0.01, 0.82, -0.02), 0.05, 0.03, iron_hi, false, 0.35, true)
			_add_cylinder(root, Vector3(ex + sx * 0.01, 0.82, -0.02), 0.025, 0.035, BRASS.darkened(0.2), false, 0.35, true)
		# Centre stretcher under seat
		_add_box(root, Vector3(0, 0.18, 0.0), Vector3(w * 0.85, 0.035, 0.04), iron_paint, false, 0.45)
		_add_box(root, Vector3(0, 0.18, 0.0), Vector3(0.04, 0.035, 0.3), iron_paint, false, 0.45)
	else:
		# Teak garden settle (loop 135): open ladder-back + seat slats (not fridge slab)
		var teak := Color(0.42, 0.28, 0.14)
		var teak_d := Color(0.3, 0.18, 0.08)
		var teak_l := Color(0.52, 0.36, 0.18)
		var cushion := Color(0.55, 0.42, 0.28)
		# Seat: horizontal slats with gaps
		_add_box(root, Vector3(0, seat_y - 0.05, 0.0), Vector3(w * 0.94, 0.05, seat_d * 0.95), teak_d, true, 0.52)
		for i in 5:
			var t := float(i) / 4.0
			var z := -0.18 + t * 0.36
			_add_box(root, Vector3(0, seat_y, z), Vector3(w * 0.9, 0.04, 0.05), teak_l if i % 2 == 0 else teak, true, 0.58)
		_add_box(root, Vector3(0, seat_y + 0.04, 0.02), Vector3(w * 0.88, 0.035, seat_d * 0.75), cushion, false, 0.85)
		# Open ladder-back: rails only + thin spindles (air shows through)
		_add_box(root, Vector3(0, 0.58, -0.22), Vector3(w * 0.9, 0.05, 0.05), teak_d, true, 0.5)
		_add_box(root, Vector3(0, 0.85, -0.22), Vector3(w * 0.88, 0.04, 0.04), teak, false, 0.5)
		_add_box(root, Vector3(0, 1.1, -0.22), Vector3(w * 0.9, 0.06, 0.05), teak_l, true, 0.5)
		_add_box(root, Vector3(0, 1.16, -0.2), Vector3(w * 0.4, 0.04, 0.04), teak, false, 0.5)
		for i in 7:
			var t := float(i) / 6.0
			var bx: float = -w * 0.38 + t * w * 0.76
			_add_box(root, Vector3(bx, 0.85, -0.2), Vector3(0.035, 0.48, 0.03), teak_d if i % 2 == 0 else teak, false, 0.55)
		# Arms + open ends
		for sx in [-1.0, 1.0]:
			var ex: float = sx * w * 0.45
			_add_box(root, Vector3(ex, 0.85, -0.2), Vector3(0.08, 0.65, 0.08), teak_d, true, 0.5)
			_add_box(root, Vector3(ex, 0.62, 0.05), Vector3(0.09, 0.06, 0.42), teak_l, false, 0.5)
			_add_cylinder(root, Vector3(ex, 0.62, 0.24), 0.04, 0.05, teak, false, 0.5)
			_add_box(root, Vector3(ex, 0.22, 0.16), Vector3(0.07, 0.4, 0.07), teak_d, true, 0.52)
			_add_box(root, Vector3(ex, 0.22, -0.18), Vector3(0.07, 0.4, 0.07), teak_d, true, 0.52)
			_add_box(root, Vector3(ex, 0.03, 0.16), Vector3(0.09, 0.04, 0.1), teak, true, 0.52)
			_add_box(root, Vector3(ex, 0.03, -0.18), Vector3(0.09, 0.04, 0.1), teak, true, 0.52)
		_add_box(root, Vector3(0, 0.15, 0.0), Vector3(w * 0.8, 0.035, 0.04), teak_d, false, 0.55)
		_add_box(root, Vector3(0, 0.15, 0.0), Vector3(0.04, 0.035, 0.3), teak_d, false, 0.55)
	_add_contact_shadow(root, w * 0.5, 0.38)
	return root


static func _make_urn(prop: Dictionary) -> Node3D:
	## Loop 149: classical stone/terracotta urn — stone grit (not wood/copper barrel).
	## Sparse trailing ivy; no green knob crown.
	var root := Node3D.new()
	root.name = "Urn"
	var seed0: int = int(prop.get("seed", 0))
	var scale: float = float(prop.get("scale", 1.0))
	# Prefer cool stone greys; terracotta only when seed odd (now classifies as clay not copper)
	var body := Color(0.58, 0.55, 0.48) if seed0 % 2 == 0 else Color(0.72, 0.46, 0.28)
	var body_d := body.darkened(0.1)
	var body_l := body.lightened(0.06)
	# Square plinth + moulded foot
	_add_box(root, Vector3(0, 0.05 * scale, 0), Vector3(0.42 * scale, 0.08 * scale, 0.42 * scale), body_d, true, 0.78)
	_add_box(root, Vector3(0, 0.1 * scale, 0), Vector3(0.34 * scale, 0.04 * scale, 0.34 * scale), body, true, 0.75)
	_add_cylinder(root, Vector3(0, 0.16 * scale, 0), 0.16 * scale, 0.08 * scale, body_d, true, 0.78)
	# Classical amphora belly (wide mid, narrow neck)
	_add_cylinder(root, Vector3(0, 0.32 * scale, 0), 0.15 * scale, 0.18 * scale, body, true, 0.78)
	_add_cylinder(root, Vector3(0, 0.48 * scale, 0), 0.18 * scale, 0.16 * scale, body_l, true, 0.76)
	_add_cylinder(root, Vector3(0, 0.6 * scale, 0), 0.12 * scale, 0.1 * scale, body, true, 0.78)
	# Neck + everted rim
	_add_cylinder(root, Vector3(0, 0.7 * scale, 0), 0.09 * scale, 0.1 * scale, body_d, false, 0.78)
	_add_cylinder(root, Vector3(0, 0.78 * scale, 0), 0.14 * scale, 0.04 * scale, body_l, false, 0.72)
	_add_cylinder(root, Vector3(0, 0.81 * scale, 0), 0.11 * scale, 0.03 * scale, body_d, false, 0.75)
	# Two side handles (reads as urn, not barrel)
	for sx in [-1.0, 1.0]:
		_add_box(root, Vector3(sx * 0.17 * scale, 0.55 * scale, 0), Vector3(0.04 * scale, 0.16 * scale, 0.05 * scale), body_d, false, 0.75)
		_add_box(root, Vector3(sx * 0.2 * scale, 0.62 * scale, 0), Vector3(0.06 * scale, 0.04 * scale, 0.05 * scale), body, false, 0.75)
	# Sparse fluting (3 ribs, not weave bands)
	for fi in 3:
		var fang := float(fi) * TAU / 3.0 + 0.2
		_add_box(
			root,
			Vector3(cos(fang) * 0.16 * scale, 0.45 * scale, sin(fang) * 0.16 * scale),
			Vector3(0.02 * scale, 0.22 * scale, 0.02 * scale),
			body_d, false, 0.72
		)
	# Soil + sparse trailing ivy only (no upright green knobs)
	_add_cylinder(root, Vector3(0, 0.82 * scale, 0), 0.1 * scale, 0.03 * scale, Color(0.16, 0.11, 0.07), false, 0.92)
	var leaf_a := Color(0.2, 0.38, 0.14)
	var leaf_b := Color(0.14, 0.3, 0.1)
	var stem_c := Color(0.24, 0.2, 0.1)
	for i in 3:
		var ang := float(i) * TAU / 3.0 + float(seed0) * 0.35
		var lx: float = cos(ang) * 0.12 * scale
		var lz: float = sin(ang) * 0.12 * scale
		_add_cylinder(root, Vector3(lx, 0.65 * scale, lz), 0.007 * scale, 0.22 * scale, stem_c, false, 0.88)
		for j in 2:
			var jy: float = 0.72 * scale - float(j) * 0.08 * scale
			_add_box(
				root,
				Vector3(lx + cos(ang) * 0.025 * scale, jy, lz + sin(ang) * 0.025 * scale),
				Vector3(0.04 * scale, 0.01 * scale, 0.018 * scale),
				leaf_a if j % 2 == 0 else leaf_b, false, 0.92
			)
	_add_contact_shadow(root, 0.24 * scale, 0.24 * scale)
	return root


static func _make_watering_can(prop: Dictionary) -> Node3D:
	## Loop 171: Victorian copper Haws can — readable mid-FOV (not 5-prim stick).
	## Body + collar, long spout with rose, C-handle, top bail, seam bands.
	var root := Node3D.new()
	root.name = "WateringCan"
	var s: float = float(prop.get("scale", 1.0))
	var seed0: int = int(prop.get("seed", 0))
	# Stay in copper gate (g≈0.42). Prefer base COPPER — lightened can wash toward brass.
	var cop := COPPER if seed0 % 2 == 0 else Color(0.68, 0.4, 0.2)
	var cop_l := Color(0.78, 0.46, 0.24)  # bright copper highlight, still g<0.48
	var cop_d := Color(0.58, 0.34, 0.16)
	# Foot ring + squat stacked body (metal-tex copper — not untextured plastic)
	_add_cylinder(root, Vector3(0, 0.02 * s, 0), 0.1 * s, 0.035 * s, cop_d, true, 0.38, true)
	_add_cylinder(root, Vector3(0, 0.1 * s, 0), 0.12 * s, 0.13 * s, cop, true, 0.34, true)
	_add_cylinder(root, Vector3(0, 0.2 * s, 0), 0.11 * s, 0.09 * s, cop_l, true, 0.32, true)
	# Shoulder seam + everted rim collar
	_add_cylinder(root, Vector3(0, 0.15 * s, 0), 0.125 * s, 0.018 * s, cop_d, false, 0.35, true)
	_add_cylinder(root, Vector3(0, 0.26 * s, 0), 0.105 * s, 0.03 * s, cop_l, false, 0.32, true)
	_add_cylinder(root, Vector3(0, 0.28 * s, 0), 0.09 * s, 0.02 * s, cop_d, false, 0.34, true)
	# Interior dark (open mouth)
	_add_cylinder(root, Vector3(0, 0.275 * s, 0), 0.07 * s, 0.018 * s, Color(0.22, 0.14, 0.08), false, 0.9)
	# Long spout (thick horizontal pipe + droop tip + rose) — must read mid-FOV
	_add_box(root, Vector3(0.12 * s, 0.19 * s, 0), Vector3(0.1 * s, 0.055 * s, 0.055 * s), cop, false, 0.34)
	# Cylinder default Y-up → rotate Z so axis runs along +X
	_add_cylinder_rotated(root, Vector3(0.24 * s, 0.17 * s, 0), 0.035 * s, 0.22 * s, cop, Vector3(0, 0, PI * 0.5), 0.34)
	_add_cylinder_rotated(root, Vector3(0.38 * s, 0.13 * s, 0), 0.028 * s, 0.1 * s, cop_d, Vector3(0, 0, PI * 0.58), 0.34)
	# Rose (perforated spray head) — large disc so silhouette is not a stick
	_add_cylinder(root, Vector3(0.45 * s, 0.1 * s, 0), 0.055 * s, 0.024 * s, cop_l, false, 0.32, true)
	_add_cylinder(root, Vector3(0.45 * s, 0.085 * s, 0), 0.048 * s, 0.014 * s, cop_d, false, 0.38, true)
	for di in 6:
		var dang := float(di) * TAU / 6.0
		_add_cylinder(
			root,
			Vector3(0.45 * s + cos(dang) * 0.022 * s, 0.078 * s, sin(dang) * 0.022 * s),
			0.007 * s, 0.008 * s, Color(0.2, 0.12, 0.07), false, 0.9
		)
	# Side C-handle (rear of body) — upright posts + grip
	_add_box(root, Vector3(-0.1 * s, 0.14 * s, 0), Vector3(0.03 * s, 0.05 * s, 0.04 * s), cop_d, false, 0.34)
	_add_box(root, Vector3(-0.16 * s, 0.2 * s, 0), Vector3(0.03 * s, 0.14 * s, 0.035 * s), cop, false, 0.34)
	_add_box(root, Vector3(-0.12 * s, 0.28 * s, 0), Vector3(0.08 * s, 0.03 * s, 0.035 * s), cop_l, false, 0.32)
	_add_box(root, Vector3(-0.08 * s, 0.26 * s, 0), Vector3(0.03 * s, 0.05 * s, 0.03 * s), cop_d, false, 0.34)
	# Top bail arch (two posts + crossbar) — reads over mouth at mid FOV
	_add_cylinder(root, Vector3(-0.04 * s, 0.36 * s, 0), 0.012 * s, 0.12 * s, cop_d, false, 0.35, true)
	_add_cylinder(root, Vector3(0.04 * s, 0.36 * s, 0), 0.012 * s, 0.12 * s, cop_d, false, 0.35, true)
	_add_box(root, Vector3(0, 0.42 * s, 0), Vector3(0.1 * s, 0.02 * s, 0.025 * s), cop, false, 0.32)
	_add_cylinder(root, Vector3(0, 0.43 * s, 0), 0.02 * s, 0.025 * s, cop_l, false, 0.3, true)
	# Vertical seam rivets (identity, not iron plate — copper class only)
	for ri in 3:
		var ry := (0.08 + float(ri) * 0.07) * s
		_add_cylinder(root, Vector3(0.0, ry, 0.11 * s), 0.01 * s, 0.012 * s, cop_l, false, 0.3, true)
	_add_contact_shadow(root, 0.2 * s, 0.14 * s)
	return root


static func _make_wall_sconce(prop: Dictionary) -> Node3D:
	## Brass wall light — seed forks arm / gas-jet / candle plate (uniqueness).
	var root := Node3D.new()
	root.name = "WallSconce"
	var y: float = float(prop.get("height", 2.1))
	var ppos: Array = prop.get("pos", [0, 0, 0])
	var seed0: int = int(prop.get("seed", int(absf(
		y * 10.0 + float(prop.get("yaw", 0.0)) + float(ppos[0]) * 3.0 + float(ppos[2]) * 5.0
	))))
	var style := seed0 % 3
	_add_box(root, Vector3(0, y, 0), Vector3(0.08, 0.14, 0.05), BRASS.darkened(0.05 * float(style)), false, 0.3)
	if style == 0:
		# Straight arm + frosted amber cup (loop 127: not pale stick)
		_add_box(root, Vector3(0, y, 0.1), Vector3(0.04, 0.04, 0.16), BRASS, false, 0.3)
		_add_cylinder(root, Vector3(0, y - 0.02, 0.2), 0.06, 0.04, BRASS.darkened(0.1), false, 0.3, true)
		_add_tapered_cylinder(root, Vector3(0, y - 0.08, 0.2), 0.025, 0.065, 0.12, Color(0.88, 0.78, 0.55), 0.4)
		_add_sphere_blob(root, Vector3(0, y - 0.05, 0.2), 0.03, Color(1.0, 0.82, 0.4))
	elif style == 1:
		# Curved arm + glass globe
		_add_box(root, Vector3(0.04, y - 0.02, 0.08), Vector3(0.12, 0.035, 0.035), BRASS, false, 0.3)
		_add_box(root, Vector3(0.1, y - 0.08, 0.14), Vector3(0.035, 0.12, 0.035), BRASS.darkened(0.05), false, 0.3)
		_add_sphere_blob(root, Vector3(0.1, y - 0.16, 0.18), 0.07, Color(0.9, 0.82, 0.6))
		_add_sphere_blob(root, Vector3(0.1, y - 0.16, 0.18), 0.04, Color(1.0, 0.85, 0.45))
	else:
		# Candle plate sconce with drip pan
		_add_box(root, Vector3(0, y - 0.02, 0.1), Vector3(0.035, 0.035, 0.14), BRASS, false, 0.3)
		_add_cylinder(root, Vector3(0, y - 0.08, 0.18), 0.08, 0.025, BRASS.darkened(0.1), false, 0.3, true)
		_add_cylinder(root, Vector3(0, y + 0.02, 0.18), 0.02, 0.16, CANDLE, false, 0.55)
		_add_sphere_blob(root, Vector3(0, y + 0.12, 0.18), 0.028, Color(1.0, 0.78, 0.35))

	var lamp := OmniLight3D.new()
	lamp.light_color = Color(1.0, 0.85, 0.55)
	lamp.light_energy = 0.5 + float(style) * 0.06
	lamp.omni_range = 3.2 + float(style) * 0.3
	lamp.position = Vector3(0.0 if style != 1 else 0.08, y - 0.06, 0.18)
	root.add_child(lamp)
	return root


static func _make_oil_lamp(prop: Dictionary) -> Node3D:
	## Loop 154 Argand: pencil stem + thimble font + tall glass hero.
	## Close FOV must not read as stacked metal barrels (loop 149 residual).
	var root := Node3D.new()
	root.name = "OilLamp"
	var h: float = float(prop.get("height", 1.0))
	var ppos: Array = prop.get("pos", [0, 0, 0])
	var seed0: int = int(prop.get("seed", int(absf(h * 17.0 + float(ppos[0]) * 7.0 + float(ppos[2]) * 11.0))))
	var style := seed0 % 3
	# Stem ends lower so glass occupies more of total height
	var stem_top: float = clampf(h * 0.26, 0.18, 0.30)
	var wood_d := MAHOGANY_DARK
	var wood := MAHOGANY
	var iron_mid := Color(0.34, 0.34, 0.36)
	if style == 0:
		# Disc foot + pencil stem (not fat pedestal)
		_add_cylinder(root, Vector3(0, 0.018, 0), 0.07, 0.032, wood_d, true, 0.55)
		_add_cylinder(root, Vector3(0, 0.04, 0), 0.045, 0.02, wood, true, 0.52)
		_add_cylinder(root, Vector3(0, stem_top * 0.48, 0), 0.012, stem_top * 0.7, wood, true, 0.5)
		_add_cylinder(root, Vector3(0, stem_top * 0.78, 0), 0.02, 0.018, BRASS.darkened(0.15), false, 0.35, true)
	elif style == 1:
		# Slim tripod (feet hug the floor, not a wide platform)
		_add_cylinder(root, Vector3(0, 0.022, 0), 0.04, 0.028, wood_d, true, 0.5)
		for a in [0.0, 120.0, 240.0]:
			var rad := deg_to_rad(a)
			_add_box(root, Vector3(cos(rad) * 0.07, 0.015, sin(rad) * 0.07), Vector3(0.09, 0.016, 0.022), wood, true, 0.5)
			_add_cylinder(root, Vector3(cos(rad) * 0.1, 0.012, sin(rad) * 0.1), 0.014, 0.02, wood_d.lightened(0.08), true, 0.52)
		_add_cylinder(root, Vector3(0, stem_top * 0.48, 0), 0.012, stem_top * 0.7, wood, true, 0.5)
		_add_cylinder(root, Vector3(0, stem_top * 0.78, 0), 0.02, 0.018, BRASS.darkened(0.12), false, 0.35, true)
	else:
		# Small square plinth + thin brass riser
		_add_box(root, Vector3(0, 0.018, 0), Vector3(0.11, 0.032, 0.11), wood_d, true, 0.52)
		_add_box(root, Vector3(0, 0.04, 0), Vector3(0.07, 0.02, 0.07), wood, true, 0.5)
		_add_cylinder(root, Vector3(0, stem_top * 0.48, 0), 0.011, stem_top * 0.65, BRASS.darkened(0.18), true, 0.35, true)
		_add_cylinder(root, Vector3(0, stem_top * 0.78, 0), 0.02, 0.018, BRASS.darkened(0.12), false, 0.32, true)
	# Thimble oil font — tiny cup under burner (not barrel drum)
	var font_c := Color(0.46, 0.32, 0.15)
	var fy: float = stem_top + 0.008
	_add_cylinder(root, Vector3(0, fy, 0), 0.038, 0.018, font_c.darkened(0.12), false, 0.42, true)
	_add_cylinder(root, Vector3(0, fy + 0.028, 0), 0.048, 0.04, font_c, false, 0.4, true)
	_add_cylinder(root, Vector3(0, fy + 0.052, 0), 0.04, 0.014, font_c.lightened(0.06), false, 0.38, true)
	# Small side filler knob (reads as hardware, not bulk)
	_add_sphere_blob(root, Vector3(0.042, fy + 0.03, 0), 0.012, font_c.darkened(0.05))
	# Brass burner collar
	_add_cylinder(root, Vector3(0, fy + 0.065, 0), 0.036, 0.016, BRASS.darkened(0.1), false, 0.3, true)
	_add_cylinder(root, Vector3(0, fy + 0.078, 0), 0.028, 0.012, BRASS.darkened(0.18), false, 0.32, true)
	# Tall thin amber chimney — alpha glass so _mat_for never classifies as brass
	# (opaque amber was metallic brass → solid gold barrel at mid FOV).
	var glass := Color(0.95, 0.78, 0.42, 0.42)
	var glass_hi := Color(1.0, 0.9, 0.58, 0.28)
	var glass_h: float = clampf(h * 0.38, 0.28, 0.42)
	var cy: float = fy + 0.08 + glass_h * 0.5
	_add_cylinder(root, Vector3(0, cy, 0), 0.032, glass_h, glass, false, 0.12)
	_add_cylinder(root, Vector3(0, cy + glass_h * 0.02, 0), 0.022, glass_h * 0.85, glass_hi, false, 0.1)
	# Slight top flare (chimney lip) — still translucent
	_add_cylinder(root, Vector3(0, cy + glass_h * 0.48, 0), 0.038, 0.018, Color(0.98, 0.88, 0.55, 0.5), false, 0.12)
	var glass_em := MeshInstance3D.new()
	var gem := CylinderMesh.new()
	gem.top_radius = 0.016
	gem.bottom_radius = 0.018
	gem.height = glass_h * 0.55
	glass_em.mesh = gem
	var gmat := StandardMaterial3D.new()
	gmat.albedo_color = Color(1.0, 0.86, 0.5, 0.55)
	gmat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	gmat.emission_enabled = true
	gmat.emission = Color(1.0, 0.76, 0.38)
	gmat.emission_energy_multiplier = 1.15
	gmat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	glass_em.material_override = gmat
	glass_em.position = Vector3(0, cy, 0)
	root.add_child(glass_em)
	# Two hairline cage rods only (not iron barrel bars)
	for i in 2:
		var ang := float(i) * PI + 0.35
		_add_box(
			root,
			Vector3(cos(ang) * 0.034, cy, sin(ang) * 0.034),
			Vector3(0.005, glass_h * 0.7, 0.005),
			iron_mid, false, 0.45
		)
	_add_cylinder(root, Vector3(0, cy + glass_h * 0.42, 0), 0.026, 0.012, iron_mid.lightened(0.08), false, 0.4)
	_add_sphere_blob(root, Vector3(0, fy + 0.1, 0), 0.016, Color(1.0, 0.86, 0.45))
	var light := OmniLight3D.new()
	light.light_color = Color(1.0, 0.86, 0.58)
	light.light_energy = 0.62 + float(style) * 0.05
	light.omni_range = 3.3 + float(style) * 0.15
	light.position = Vector3(0, cy, 0)
	root.add_child(light)
	_add_contact_shadow(root, 0.08, 0.08)
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
			# Plate stack with rims
			_add_cylinder(root, Vector3(x, y + 0.06, 0.04), 0.08 + float(i % 2) * 0.012, 0.02, CREAM if (i + seed0) % 2 == 0 else CREAM.darkened(0.08), false, 0.7)
			_add_cylinder(root, Vector3(x, y + 0.08, 0.04), 0.07, 0.018, CREAM.darkened(0.05), false, 0.7)
		elif kind == 1:
			# Loop 119: copper bowl with bottom + flared rim + handle (not tall coil)
			var ccol := COPPER if i % 2 == 0 else COPPER.darkened(0.1)
			var cr: float = 0.06 + float((i + seed0) % 3) * 0.012
			_add_cylinder(root, Vector3(x, y + 0.04, 0.04), cr * 0.75, 0.015, ccol.darkened(0.1), false, 0.35, true)
			_add_cylinder(root, Vector3(x, y + 0.08, 0.04), cr, 0.07, ccol, false, 0.35, true)
			_add_cylinder(root, Vector3(x, y + 0.12, 0.04), cr + 0.015, 0.018, ccol.lightened(0.08), false, 0.32, true)
			_add_box(root, Vector3(x + cr * 0.85, y + 0.08, 0.04), Vector3(0.05, 0.03, 0.03), ccol, false, 0.35)
		elif kind == 2:
			# Crock with lid
			_add_cylinder(root, Vector3(x, y + 0.09, 0.04), 0.055, 0.12, CLAY if (i + seed0) % 2 == 0 else CLAY.lightened(0.1), false, 0.75)
			_add_cylinder(root, Vector3(x, y + 0.16, 0.04), 0.045, 0.03, CLAY.darkened(0.1), false, 0.75)
		else:
			# Cream bowl / jug mix
			if (i + seed0) % 2 == 0:
				_add_cylinder(root, Vector3(x, y + 0.06, 0.04), 0.07, 0.04, Color(0.72, 0.68, 0.6), false, 0.65)
				_add_cylinder(root, Vector3(x, y + 0.09, 0.04), 0.075, 0.015, Color(0.78, 0.74, 0.66), false, 0.65)
			else:
				_add_cylinder(root, Vector3(x, y + 0.08, 0.04), 0.045, 0.1, CREAM.darkened(0.1), false, 0.7)
				_add_box(root, Vector3(x + 0.05, y + 0.09, 0.04), Vector3(0.035, 0.06, 0.025), CREAM.darkened(0.15), false, 0.7)
	return root


static func _make_pot_rack(prop: Dictionary) -> Node3D:
	## Wall copper pan rail — wide pans + ladles (loop 119: readable vessels, not coils).
	var root := Node3D.new()
	root.name = "PotRack"
	var seed0: int = int(prop.get("seed", 0))
	_add_box(root, Vector3(0, 2.2, 0), Vector3(2.05, 0.08, 0.12), MAHOGANY_DARK, true, 0.5)
	_add_box(root, Vector3(-0.95, 1.75, 0), Vector3(0.07, 0.95, 0.07), MAHOGANY, true, 0.5)
	_add_box(root, Vector3(0.95, 1.75, 0), Vector3(0.07, 0.95, 0.07), MAHOGANY, true, 0.5)
	# Cross brace
	_add_box(root, Vector3(0, 1.85, 0), Vector3(1.85, 0.04, 0.05), MAHOGANY_DARK, false, 0.5)
	# 5 hangers: wide pans + ladle/spoon mix (hang lower so silhouette reads)
	for i in 5:
		var x := -0.7 + i * 0.35
		# Hook from rail
		_add_cylinder(root, Vector3(x, 2.1, 0.06), 0.012, 0.18, IRON, false, 0.4)
		_add_box(root, Vector3(x, 1.98, 0.1), Vector3(0.04, 0.025, 0.05), IRON.lightened(0.1), false, 0.4)
		var pr: float = 0.11 + float((i * 3 + seed0) % 5) * 0.022
		var pcols: Array[Color] = [
			COPPER,
			COPPER.darkened(0.12),
			COPPER.lightened(0.08),
			Color(0.55, 0.32, 0.18),
			BRASS.darkened(0.1),
		]
		var pcol: Color = pcols[(i + seed0) % 5]
		var shape := (i + seed0) % 4
		if shape == 0:
			# Wide skillet: solid bottom + short wall + long handle
			_add_cylinder(root, Vector3(x, 1.72, 0.12), pr * 0.9, 0.022, pcol.darkened(0.12), false, 0.35, true)
			_add_cylinder(root, Vector3(x, 1.76, 0.12), pr, 0.06, pcol, false, 0.35, true)
			_add_cylinder(root, Vector3(x, 1.8, 0.12), pr + 0.02, 0.02, pcol.lightened(0.1), false, 0.32, true)
			_add_box(root, Vector3(x + pr * 0.95, 1.76, 0.12), Vector3(0.16, 0.025, 0.04), pcol.darkened(0.05), false, 0.35)
		elif shape == 1:
			# Deep saute: bottom + taller wall + helper loop
			_add_cylinder(root, Vector3(x, 1.7, 0.12), pr * 0.85, 0.02, pcol.darkened(0.1), false, 0.35, true)
			_add_cylinder(root, Vector3(x, 1.76, 0.12), pr * 1.05, 0.1, pcol, false, 0.35, true)
			_add_cylinder(root, Vector3(x, 1.82, 0.12), pr * 1.1, 0.02, pcol.lightened(0.08), false, 0.32, true)
			_add_box(root, Vector3(x + pr * 0.95, 1.76, 0.12), Vector3(0.12, 0.03, 0.04), pcol, false, 0.35)
			_add_box(root, Vector3(x - pr * 0.9, 1.78, 0.12), Vector3(0.05, 0.035, 0.04), pcol, false, 0.35)
		elif shape == 2:
			# Covered pot: belly + lid knob
			_add_cylinder(root, Vector3(x, 1.68, 0.12), pr * 0.65, 0.02, pcol.darkened(0.12), false, 0.35, true)
			_add_cylinder(root, Vector3(x, 1.76, 0.12), pr * 0.85, 0.14, pcol.darkened(0.05), false, 0.35, true)
			_add_cylinder(root, Vector3(x, 1.84, 0.12), pr * 0.9, 0.025, pcol.lightened(0.08), false, 0.32, true)
			_add_cylinder(root, Vector3(x, 1.88, 0.12), 0.04, 0.04, BRASS, false, 0.3, true)
			_add_box(root, Vector3(x + pr * 0.75, 1.76, 0.12), Vector3(0.05, 0.06, 0.04), pcol, false, 0.35)
		else:
			# Ladle with bowl + wood handle end
			_add_cylinder(root, Vector3(x, 1.82, 0.1), 0.012, 0.38, IRON.lightened(0.08), false, 0.4)
			_add_cylinder(root, Vector3(x, 1.58, 0.14), 0.06, 0.02, pcol.darkened(0.1), false, 0.35, true)
			_add_cylinder(root, Vector3(x, 1.62, 0.14), 0.07, 0.06, pcol, false, 0.35, true)
			_add_box(root, Vector3(x, 2.0, 0.08), Vector3(0.035, 0.05, 0.06), OAK, false, 0.55)
	return root

static func _make_copper_pot(prop: Dictionary) -> Node3D:
	## Loop 118: bulbous copper vessels with rims/handles (not flat coil stacks).
	var root := Node3D.new()
	root.name = "CopperPot"
	var scale: float = prop.get("scale", 1.0)
	var seed0: int = int(prop.get("seed", 0))
	var style := seed0 % 5
	var col := COPPER if style % 2 == 0 else COPPER.darkened(0.08)
	if style == 0:
		# Classic kettle — belly + shoulder + bail
		_add_cylinder(root, Vector3(0, 0.06 * scale, 0), 0.11 * scale, 0.08 * scale, col.darkened(0.06), true, 0.35, true)
		_add_cylinder(root, Vector3(0, 0.14 * scale, 0), 0.15 * scale, 0.12 * scale, col, true, 0.35, true)
		_add_cylinder(root, Vector3(0, 0.22 * scale, 0), 0.13 * scale, 0.08 * scale, col.lightened(0.05), true, 0.32, true)
		_add_cylinder(root, Vector3(0, 0.28 * scale, 0), 0.14 * scale, 0.03 * scale, col.lightened(0.1), false, 0.3, true)
		_add_cylinder(root, Vector3(0, 0.3 * scale, 0), 0.09 * scale, 0.025 * scale, Color(0.18, 0.1, 0.06), false)
		_add_box(root, Vector3(0.15 * scale, 0.2 * scale, 0), Vector3(0.03 * scale, 0.12 * scale, 0.03 * scale), col, false, 0.35)
		_add_box(root, Vector3(-0.15 * scale, 0.2 * scale, 0), Vector3(0.03 * scale, 0.12 * scale, 0.03 * scale), col, false, 0.35)
		_add_box(root, Vector3(0, 0.32 * scale, 0), Vector3(0.32 * scale, 0.02 * scale, 0.025 * scale), BRASS.darkened(0.1), false, 0.3)
		_add_box(root, Vector3(0.14 * scale, 0.16 * scale, 0), Vector3(0.08 * scale, 0.04 * scale, 0.06 * scale), col.darkened(0.05), false, 0.35)
	elif style == 1:
		# Wide skillet — deep rim + long handle + helper loop
		_add_cylinder(root, Vector3(0, 0.05 * scale, 0), 0.16 * scale, 0.06 * scale, col.darkened(0.05), true, 0.35, true)
		_add_cylinder(root, Vector3(0, 0.1 * scale, 0), 0.19 * scale, 0.08 * scale, col.lightened(0.05), true, 0.35, true)
		_add_cylinder(root, Vector3(0, 0.15 * scale, 0), 0.2 * scale, 0.03 * scale, col, false, 0.3, true)
		_add_box(root, Vector3(0.24 * scale, 0.11 * scale, 0), Vector3(0.22 * scale, 0.028 * scale, 0.05 * scale), col, false, 0.35)
		_add_cylinder(root, Vector3(0.36 * scale, 0.11 * scale, 0), 0.025 * scale, 0.04 * scale, col.darkened(0.08), false, 0.35, true)
		_add_box(root, Vector3(-0.18 * scale, 0.12 * scale, 0), Vector3(0.06 * scale, 0.04 * scale, 0.05 * scale), col, false, 0.35)
	elif style == 2:
		# Tall stockpot with lid + side handles
		_add_cylinder(root, Vector3(0, 0.08 * scale, 0), 0.11 * scale, 0.1 * scale, col.darkened(0.08), true, 0.35, true)
		_add_cylinder(root, Vector3(0, 0.2 * scale, 0), 0.13 * scale, 0.18 * scale, col.darkened(0.05), true, 0.35, true)
		_add_cylinder(root, Vector3(0, 0.32 * scale, 0), 0.12 * scale, 0.08 * scale, col, true, 0.32, true)
		_add_cylinder(root, Vector3(0, 0.38 * scale, 0), 0.135 * scale, 0.03 * scale, col.lightened(0.08), false, 0.3, true)
		_add_cylinder(root, Vector3(0, 0.42 * scale, 0), 0.05 * scale, 0.04 * scale, BRASS, false, 0.3, true)
		_add_box(root, Vector3(0.14 * scale, 0.24 * scale, 0), Vector3(0.04 * scale, 0.1 * scale, 0.08 * scale), col, false, 0.35)
		_add_box(root, Vector3(-0.14 * scale, 0.24 * scale, 0), Vector3(0.04 * scale, 0.1 * scale, 0.08 * scale), col, false, 0.35)
	elif style == 3:
		# Water jug / ewer — bulb body + neck + spout + handle
		_add_cylinder(root, Vector3(0, 0.08 * scale, 0), 0.08 * scale, 0.08 * scale, col.darkened(0.05), true, 0.35, true)
		_add_cylinder(root, Vector3(0, 0.16 * scale, 0), 0.12 * scale, 0.12 * scale, col.lightened(0.04), true, 0.35, true)
		_add_cylinder(root, Vector3(0, 0.26 * scale, 0), 0.07 * scale, 0.1 * scale, col, true, 0.32, true)
		_add_cylinder(root, Vector3(0, 0.32 * scale, 0), 0.06 * scale, 0.04 * scale, col.lightened(0.06), false, 0.32, true)
		_add_box(root, Vector3(0.12 * scale, 0.24 * scale, 0), Vector3(0.12 * scale, 0.035 * scale, 0.05 * scale), col, false, 0.35)
		_add_box(root, Vector3(-0.1 * scale, 0.2 * scale, 0), Vector3(0.04 * scale, 0.14 * scale, 0.03 * scale), col.darkened(0.05), false, 0.35)
		_add_box(root, Vector3(-0.08 * scale, 0.3 * scale, 0), Vector3(0.1 * scale, 0.025 * scale, 0.03 * scale), col.darkened(0.05), false, 0.35)
	else:
		# Coal scuttle / bucket — tapered + hoop + bail
		_add_cylinder(root, Vector3(0, 0.08 * scale, 0), 0.12 * scale, 0.1 * scale, col.darkened(0.12), true, 0.4, true)
		_add_cylinder(root, Vector3(0, 0.18 * scale, 0), 0.16 * scale, 0.14 * scale, col.darkened(0.1), true, 0.4, true)
		_add_cylinder(root, Vector3(0, 0.26 * scale, 0), 0.17 * scale, 0.03 * scale, IRON.lightened(0.1), false, 0.45)
		_add_box(root, Vector3(0, 0.34 * scale, 0), Vector3(0.025 * scale, 0.14 * scale, 0.3 * scale), IRON, false, 0.4)
		_add_box(root, Vector3(0.1 * scale, 0.14 * scale, 0.1 * scale), Vector3(0.06 * scale, 0.04 * scale, 0.06 * scale), Color(0.12, 0.1, 0.1), false, 0.8)
	_add_contact_shadow(root, 0.2 * scale, 0.2 * scale)
	return root


static func _make_copper_scrap(prop: Dictionary) -> Node3D:
	## Rooke scrap heap — loop 120/140: wire spool / plate stack / tube bundle.
	## Bright copper read at distance (not black Minecraft floor junk).
	var root := Node3D.new()
	root.name = "CopperScrap"
	var s: float = float(prop.get("scale", 1.0))
	var seed0: int = int(prop.get("seed", 0))
	var style := seed0 % 3
	var cu := COPPER.lightened(0.08)
	var cu_d := COPPER.darkened(0.04)
	var cu_hi := COPPER.lightened(0.16)
	var iron_mid := Color(0.38, 0.38, 0.4)  # mid grey iron, not near-black
	# Low wood tray / board under scrap
	_add_box(root, Vector3(0, 0.03 * s, 0), Vector3(0.58 * s, 0.05 * s, 0.42 * s), OAK.darkened(0.08), true, 0.65)
	_add_box(root, Vector3(0, 0.055 * s, 0), Vector3(0.52 * s, 0.015 * s, 0.36 * s), OAK.lightened(0.08), false, 0.6)
	if style == 0:
		# Wire spool on wood arbor: flange discs + wound barrel + loose end
		_add_cylinder(root, Vector3(-0.06 * s, 0.14 * s, 0.0), 0.14 * s, 0.025 * s, OAK.darkened(0.05), false, 0.55)
		_add_cylinder(root, Vector3(-0.06 * s, 0.28 * s, 0.0), 0.14 * s, 0.025 * s, OAK.darkened(0.05), false, 0.55)
		_add_cylinder(root, Vector3(-0.06 * s, 0.21 * s, 0.0), 0.09 * s, 0.12 * s, cu_d, false, 0.32, true)
		for wi in 6:
			var wa := float(wi) * TAU / 6.0
			_add_box(root, Vector3(-0.06 * s + cos(wa) * 0.09 * s, 0.21 * s, sin(wa) * 0.09 * s),
				Vector3(0.02 * s, 0.1 * s, 0.03 * s), cu_hi, false, 0.3)
		_add_cylinder(root, Vector3(-0.06 * s, 0.21 * s, 0.0), 0.02 * s, 0.2 * s, iron_mid, false, 0.45)
		_add_box(root, Vector3(0.1 * s, 0.21 * s, 0.0), Vector3(0.08 * s, 0.025 * s, 0.025 * s), iron_mid, false, 0.45)
		_add_box(root, Vector3(0.14 * s, 0.28 * s, 0.0), Vector3(0.025 * s, 0.12 * s, 0.025 * s), iron_mid.lightened(0.08), false, 0.45)
		# Loose copper plate + tube (not dark blob)
		_add_box(root, Vector3(0.16 * s, 0.09 * s, -0.08 * s), Vector3(0.16 * s, 0.02 * s, 0.12 * s), cu_hi, false, 0.3)
		_add_cylinder(root, Vector3(0.18 * s, 0.1 * s, 0.1 * s), 0.015 * s, 0.22 * s, cu, false, 0.32, true)
		_add_box(root, Vector3(0.05 * s, 0.08 * s, 0.14 * s), Vector3(0.06 * s, 0.04 * s, 0.05 * s), cu_d, false, 0.32)
	elif style == 1:
		# Flattened plate stack with edge lip + bent tube + iron clamp
		for i in 4:
			var py := (0.07 + float(i) * 0.028) * s
			var pw := (0.3 - float(i) * 0.02) * s
			_add_box(root, Vector3(-0.06 * s, py, 0.0), Vector3(pw, 0.018 * s, 0.24 * s), cu.darkened(float(i) * 0.03), false, 0.3)
			_add_box(root, Vector3(-0.06 * s + pw * 0.45, py, 0.0), Vector3(0.015 * s, 0.03 * s, 0.22 * s), cu_hi, false, 0.28)
		_add_cylinder(root, Vector3(0.18 * s, 0.14 * s, 0.06 * s), 0.022 * s, 0.32 * s, cu_hi, false, 0.3, true)
		_add_box(root, Vector3(0.18 * s, 0.14 * s, 0.18 * s), Vector3(0.04 * s, 0.04 * s, 0.08 * s), cu_d, false, 0.3)
		_add_cylinder(root, Vector3(0.1 * s, 0.12 * s, -0.12 * s), 0.018 * s, 0.2 * s, BRASS.lightened(0.05), false, 0.28, true)
		_add_box(root, Vector3(0.0, 0.16 * s, 0.12 * s), Vector3(0.14 * s, 0.04 * s, 0.08 * s), iron_mid.lightened(0.05), false, 0.42)
	else:
		# Angled tube bundle + strap + offcut (no dark sphere nugget)
		for i in 5:
			var ox := (-0.14 + float(i) * 0.07) * s
			var oz := (-0.06 + float(i % 3) * 0.04) * s
			_add_cylinder(root, Vector3(ox, 0.1 * s, oz), 0.018 * s, 0.36 * s, cu.darkened(float(i % 3) * 0.03), false, 0.3, true)
		_add_cylinder(root, Vector3(0.05 * s, 0.16 * s, 0.02 * s), 0.02 * s, 0.28 * s, cu_hi, false, 0.3, true)
		_add_box(root, Vector3(0.0, 0.2 * s, 0.0), Vector3(0.38 * s, 0.03 * s, 0.06 * s), iron_mid, false, 0.42)
		_add_box(root, Vector3(0.0, 0.2 * s, 0.0), Vector3(0.06 * s, 0.03 * s, 0.28 * s), iron_mid.lightened(0.06), false, 0.42)
		_add_box(root, Vector3(0.16 * s, 0.09 * s, 0.12 * s), Vector3(0.1 * s, 0.035 * s, 0.08 * s), cu_d, false, 0.3)
		_add_box(root, Vector3(-0.16 * s, 0.09 * s, 0.12 * s), Vector3(0.1 * s, 0.04 * s, 0.08 * s), BRASS.lightened(0.04), false, 0.28)
	_add_contact_shadow(root, 0.32 * s, 0.24 * s)
	return root


# ─── Workshop ────────────────────────────────────────────────────────────────

static func _make_workbench(prop: Dictionary) -> Node3D:
	## Scrubbed oak top + solid collision + seed-forked tool clutter (not clones).
	var root := Node3D.new()
	root.name = "Workbench"
	var width: float = prop.get("width", 2.8)
	var seed0: int = int(prop.get("seed", int(width * 10.0)))
	# Apron + thick top (solid = player cannot walk through)
	_add_box(root, Vector3(0, 0.86, 0), Vector3(width, 0.09, 0.95), OAK.lightened(0.08), true, 0.55)
	_add_box(root, Vector3(0, 0.8, 0), Vector3(width - 0.04, 0.05, 0.9), OAK, false, 0.5)
	# Edge banding (detail)
	_add_box(root, Vector3(0, 0.91, 0.46), Vector3(width * 0.98, 0.03, 0.04), OAK.darkened(0.08), false, 0.5)
	for lx in [-width * 0.38, width * 0.38]:
		_add_box(root, Vector3(lx, 0.4, 0), Vector3(0.12, 0.8, 0.85), MAHOGANY, true, 0.5)
		# Leg foot
		_add_box(root, Vector3(lx, 0.04, 0), Vector3(0.16, 0.08, 0.9), MAHOGANY_DARK, true, 0.5)
	_add_box(root, Vector3(0, 0.38, 0), Vector3(width * 0.72, 0.08, 0.78), MAHOGANY_DARK, true, 0.5)
	# Drawers with brass pulls
	_add_box(root, Vector3(-width * 0.2, 0.35, 0.35), Vector3(width * 0.28, 0.22, 0.12), MAHOGANY, false, 0.48)
	_add_box(root, Vector3(width * 0.2, 0.35, 0.35), Vector3(width * 0.28, 0.22, 0.12), MAHOGANY, false, 0.48)
	_add_cylinder(root, Vector3(-width * 0.2, 0.35, 0.42), 0.02, 0.06, BRASS, false, 0.3, true)
	_add_cylinder(root, Vector3(width * 0.2, 0.35, 0.42), 0.02, 0.06, BRASS, false, 0.3, true)
	# Seed-unique top dressing (loop 146: files/clamps/timber — Rooke bench micro)
	var iron_mid := Color(0.36, 0.36, 0.38)
	var iron_d := Color(0.28, 0.28, 0.3)
	var dress := seed0 % 3
	if dress == 0:
		# Measuring plate + steel rule + calipers + oil can + file + scrap timber
		_add_box(root, Vector3(-0.45, 0.93, 0.12), Vector3(0.32, 0.035, 0.22), BRASS.darkened(0.08), false, 0.3)
		_add_box(root, Vector3(0.05, 0.935, 0.28), Vector3(0.7, 0.02, 0.05), iron_mid, false, 0.42)  # steel rule
		# Tick marks on rule
		for ti in 6:
			_add_box(root, Vector3(-0.25 + float(ti) * 0.1, 0.945, 0.3), Vector3(0.01, 0.015, 0.03), iron_d, false, 0.4)
		# Calipers (L-jaw)
		_add_box(root, Vector3(-0.15, 0.95, 0.15), Vector3(0.06, 0.03, 0.2), iron_mid.lightened(0.08), false, 0.42)
		_add_box(root, Vector3(-0.05, 0.95, 0.05), Vector3(0.18, 0.03, 0.05), iron_mid, false, 0.42)
		# Flat file + rasp (lying — not coin towers)
		_add_box(root, Vector3(0.35, 0.94, 0.05), Vector3(0.42, 0.025, 0.06), iron_mid, false, 0.4)
		_add_box(root, Vector3(0.5, 0.95, 0.05), Vector3(0.08, 0.035, 0.05), Color(0.4, 0.26, 0.14), false, 0.55)
		_add_box(root, Vector3(0.25, 0.94, -0.2), Vector3(0.38, 0.022, 0.05), iron_d, false, 0.4)
		_add_box(root, Vector3(0.4, 0.95, -0.2), Vector3(0.07, 0.03, 0.045), Color(0.38, 0.24, 0.12), false, 0.55)
		# Oil can: belly + spout
		_add_cylinder(root, Vector3(0.75, 0.95, 0.15), 0.045, 0.035, BRASS.darkened(0.1), false, 0.32, true)
		_add_cylinder(root, Vector3(0.75, 1.0, 0.15), 0.065, 0.09, BRASS, false, 0.3, true)
		_add_box(root, Vector3(0.85, 1.02, 0.15), Vector3(0.09, 0.022, 0.025), BRASS.darkened(0.05), false, 0.3)
		# Scrap timber offcuts
		_add_box(root, Vector3(-0.7, 0.94, -0.15), Vector3(0.35, 0.04, 0.08), OAK.lightened(0.05), false, 0.58)
		_add_box(root, Vector3(-0.55, 0.96, -0.22), Vector3(0.2, 0.035, 0.06), OAK.darkened(0.08), false, 0.55)
		_add_box(root, Vector3(0.1, 0.93, -0.25), Vector3(0.25, 0.02, 0.16), PAPER, false)
		# Small copper dish (rim bowl, not stack)
		_add_cylinder(root, Vector3(-0.75, 0.95, 0.2), 0.055, 0.025, COPPER.darkened(0.08), false, 0.32, true)
		_add_cylinder(root, Vector3(-0.75, 0.98, 0.2), 0.07, 0.05, COPPER, false, 0.32, true)
	elif dress == 1:
		# Plans + Rooke wrench + G-clamp + lying copper tube + chalk + mallet
		_add_box(root, Vector3(0.25, 0.92, -0.12), Vector3(0.5, 0.025, 0.34), PAPER, false)
		_add_box(root, Vector3(0.3, 0.94, -0.1), Vector3(0.35, 0.01, 0.24), PAPER.darkened(0.08), false)
		_add_box(root, Vector3(0.28, 0.95, -0.06), Vector3(0.2, 0.008, 0.14), PAPER.darkened(0.12), false)
		# Open-end wrench (Rooke)
		_add_box(root, Vector3(-0.55, 0.94, 0.12), Vector3(0.55, 0.03, 0.07), iron_mid, false, 0.42)
		_add_box(root, Vector3(-0.25, 0.95, 0.18), Vector3(0.1, 0.05, 0.14), iron_mid.lightened(0.08), false, 0.42)
		_add_box(root, Vector3(-0.22, 0.95, 0.22), Vector3(0.05, 0.04, 0.08), iron_d, false, 0.4)  # open jaw
		# G-clamp
		_add_box(root, Vector3(0.65, 0.98, 0.05), Vector3(0.06, 0.14, 0.12), iron_mid, false, 0.42)
		_add_box(root, Vector3(0.65, 0.93, 0.12), Vector3(0.14, 0.04, 0.05), iron_mid.lightened(0.05), false, 0.42)
		_add_box(root, Vector3(0.65, 1.05, 0.12), Vector3(0.14, 0.035, 0.05), iron_mid, false, 0.42)
		_add_cylinder(root, Vector3(0.72, 0.99, 0.12), 0.015, 0.12, iron_d, false, 0.4)
		_add_cylinder(root, Vector3(0.72, 1.08, 0.12), 0.03, 0.025, BRASS.darkened(0.1), false, 0.32, true)
		# Lying copper tube stock (not upright coins)
		_add_cylinder(root, Vector3(0.55, 0.96, 0.25), 0.022, 0.32, COPPER, false, 0.32, true)
		_add_cylinder(root, Vector3(0.4, 0.96, 0.3), 0.018, 0.22, COPPER.darkened(0.06), false, 0.32, true)
		# Timber offcut stack (flat boards)
		_add_box(root, Vector3(-0.7, 0.94, -0.2), Vector3(0.28, 0.03, 0.16), OAK.lightened(0.08), false, 0.58)
		_add_box(root, Vector3(-0.68, 0.97, -0.18), Vector3(0.24, 0.025, 0.14), OAK.darkened(0.05), false, 0.55)
		_add_box(root, Vector3(-0.66, 1.0, -0.16), Vector3(0.2, 0.02, 0.12), OAK, false, 0.55)
		# Chalk stub + mallet
		_add_cylinder(root, Vector3(-0.35, 0.95, -0.25), 0.018, 0.08, CREAM, false)
		_add_cylinder(root, Vector3(0.05, 0.97, 0.22), 0.04, 0.12, Color(0.38, 0.24, 0.12), false, 0.55)
		_add_box(root, Vector3(0.05, 0.94, 0.32), Vector3(0.1, 0.06, 0.08), iron_mid, false, 0.42)
	else:
		# Bench vice + wood block + G-clamp + file + scrap plate + rule
		_add_box(root, Vector3(0.7, 0.98, -0.12), Vector3(0.24, 0.14, 0.18), iron_mid, false, 0.42)
		_add_box(root, Vector3(0.7, 1.08, -0.05), Vector3(0.12, 0.08, 0.1), iron_d, false, 0.4)
		_add_cylinder(root, Vector3(0.7, 1.12, 0.05), 0.02, 0.1, BRASS, false, 0.3, true)
		_add_box(root, Vector3(0.7, 1.14, 0.1), Vector3(0.08, 0.04, 0.04), iron_mid.lightened(0.08), false, 0.4)
		# Work block
		_add_box(root, Vector3(-0.5, 0.95, 0.05), Vector3(0.32, 0.06, 0.22), Color(0.28, 0.18, 0.1), false, 0.58)
		# File on block
		_add_box(root, Vector3(-0.45, 1.0, 0.08), Vector3(0.28, 0.02, 0.045), iron_mid, false, 0.4)
		_add_box(root, Vector3(-0.32, 1.01, 0.08), Vector3(0.06, 0.03, 0.04), Color(0.4, 0.26, 0.14), false, 0.55)
		# Small G-clamp
		_add_box(root, Vector3(0.15, 0.98, 0.2), Vector3(0.05, 0.12, 0.1), iron_mid, false, 0.42)
		_add_box(root, Vector3(0.15, 0.93, 0.26), Vector3(0.12, 0.03, 0.04), iron_mid, false, 0.42)
		_add_box(root, Vector3(0.15, 1.05, 0.26), Vector3(0.12, 0.03, 0.04), iron_d, false, 0.4)
		_add_cylinder(root, Vector3(0.2, 0.99, 0.26), 0.012, 0.1, iron_mid.lightened(0.05), false, 0.4)
		# Scrap copper plate (flat) + steel rule
		_add_box(root, Vector3(-0.15, 0.93, -0.22), Vector3(0.28, 0.02, 0.18), COPPER.darkened(0.05), false, 0.32)
		_add_box(root, Vector3(0.35, 0.935, -0.25), Vector3(0.5, 0.018, 0.04), iron_mid, false, 0.42)
		# Timber scrap
		_add_box(root, Vector3(-0.75, 0.94, 0.18), Vector3(0.18, 0.05, 0.12), OAK.lightened(0.05), false, 0.55)
		_add_box(root, Vector3(-0.7, 0.97, 0.22), Vector3(0.12, 0.03, 0.08), OAK.darkened(0.1), false, 0.55)
		# Pencil / chalk
		_add_cylinder(root, Vector3(0.4, 0.94, 0.15), 0.01, 0.14, Color(0.75, 0.55, 0.25), false)
	_add_contact_shadow(root, width * 0.5, 0.55)
	return root

static func _make_tool_rack(prop: Dictionary) -> Node3D:
	## Wall rack — loop 120: readable tool heads (not stick bars).
	var root := Node3D.new()
	root.name = "ToolRack"
	var seed0: int = int(prop.get("seed", 0))
	var wood_h := Color(0.32, 0.2, 0.1)
	var wood_l := Color(0.42, 0.28, 0.14)
	# Frame + peg rails
	_add_box(root, Vector3(0, 1.35, 0), Vector3(1.55, 0.1, 0.12), MAHOGANY_DARK, true, 0.5)
	_add_box(root, Vector3(0, 0.55, 0), Vector3(1.55, 0.08, 0.12), MAHOGANY_DARK, true, 0.5)
	_add_box(root, Vector3(-0.72, 0.95, 0), Vector3(0.08, 0.9, 0.1), MAHOGANY, true, 0.5)
	_add_box(root, Vector3(0.72, 0.95, 0), Vector3(0.08, 0.9, 0.1), MAHOGANY, true, 0.5)
	# Back board so tools read against dark oak
	_add_box(root, Vector3(0, 0.95, -0.04), Vector3(1.4, 0.85, 0.03), OAK.darkened(0.15), false, 0.55)
	# 6 pegs, each tool kind unique by (seed + slot)
	for i in 6:
		var x := -0.55 + float(i) * 0.22
		_add_cylinder(root, Vector3(x, 1.28, 0.1), 0.018, 0.12, wood_l, false, 0.55)
		var kind := (i + seed0 * 3) % 6
		match kind:
			0:  # claw hammer — thick handle + peen + claw fork
				_add_cylinder(root, Vector3(x, 0.95, 0.12), 0.028, 0.52, wood_h, false, 0.55)
				_add_box(root, Vector3(x, 0.68, 0.16), Vector3(0.22, 0.1, 0.09), IRON, false, 0.35)
				_add_box(root, Vector3(x + 0.12, 0.68, 0.16), Vector3(0.08, 0.08, 0.07), IRON.lightened(0.08), false, 0.35)
				# Claw
				_add_box(root, Vector3(x - 0.12, 0.66, 0.16), Vector3(0.08, 0.05, 0.06), IRON.darkened(0.05), false, 0.35)
				_add_box(root, Vector3(x - 0.16, 0.62, 0.16), Vector3(0.04, 0.08, 0.05), IRON, false, 0.35)
				_add_box(root, Vector3(x - 0.16, 0.7, 0.16), Vector3(0.04, 0.08, 0.05), IRON, false, 0.35)
			1:  # Rooke open-end wrench — wide jaw
				_add_box(root, Vector3(x, 0.95, 0.12), Vector3(0.04, 0.5, 0.04), IRON.darkened(0.08), false, 0.4)
				_add_box(root, Vector3(x, 0.68, 0.16), Vector3(0.2, 0.08, 0.08), IRON, false, 0.35)
				# Open jaw fork
				_add_box(root, Vector3(x + 0.12, 0.72, 0.18), Vector3(0.06, 0.1, 0.05), IRON.lightened(0.1), false, 0.35)
				_add_box(root, Vector3(x + 0.12, 0.64, 0.18), Vector3(0.06, 0.1, 0.05), IRON.lightened(0.1), false, 0.35)
				_add_box(root, Vector3(x + 0.16, 0.68, 0.18), Vector3(0.04, 0.05, 0.05), IRON, false, 0.35)
			2:  # blacksmith tongs — crossed arms + tips
				_add_box(root, Vector3(x - 0.035, 0.95, 0.12), Vector3(0.028, 0.55, 0.028), IRON, false, 0.4)
				_add_box(root, Vector3(x + 0.035, 0.95, 0.12), Vector3(0.028, 0.55, 0.028), IRON, false, 0.4)
				_add_box(root, Vector3(x, 1.15, 0.12), Vector3(0.12, 0.04, 0.04), IRON.darkened(0.05), false, 0.4)
				_add_box(root, Vector3(x - 0.05, 0.65, 0.16), Vector3(0.06, 0.04, 0.08), IRON.lightened(0.08), false, 0.35)
				_add_box(root, Vector3(x + 0.05, 0.65, 0.16), Vector3(0.06, 0.04, 0.08), IRON.lightened(0.08), false, 0.35)
			3:  # wood plane — body + tote + iron blade
				_add_box(root, Vector3(x, 0.85, 0.14), Vector3(0.12, 0.1, 0.32), wood_l.lightened(0.08), false, 0.55)
				_add_box(root, Vector3(x, 0.95, 0.05), Vector3(0.08, 0.1, 0.06), wood_h, false, 0.55)
				_add_box(root, Vector3(x, 0.82, 0.26), Vector3(0.1, 0.04, 0.08), IRON, false, 0.4)
				_add_box(root, Vector3(x, 0.88, 0.14), Vector3(0.06, 0.03, 0.12), BRASS.darkened(0.15), false, 0.35)
			4:  # half-round file — wood grip + tapered blade with teeth ticks
				_add_cylinder(root, Vector3(x, 1.05, 0.12), 0.03, 0.18, wood_h, false, 0.55)
				_add_box(root, Vector3(x, 0.78, 0.12), Vector3(0.045, 0.42, 0.04), IRON.lightened(0.12), false, 0.4)
				for ti in 4:
					_add_box(root, Vector3(x + 0.025, 0.65 + float(ti) * 0.08, 0.12), Vector3(0.01, 0.02, 0.035), IRON, false, 0.4)
			_:  # copper-headed mallet — turned handle + fat copper head
				_add_cylinder(root, Vector3(x, 0.98, 0.12), 0.03, 0.42, wood_l, false, 0.55)
				_add_cylinder(root, Vector3(x, 0.72, 0.16), 0.09, 0.14, COPPER, false, 0.35, true)
				_add_cylinder(root, Vector3(x, 0.72, 0.16), 0.1, 0.04, COPPER.darkened(0.1), false, 0.35, true)
	# Lower pegs: shorter seed-unique set
	for i in 3:
		var x2 := -0.35 + float(i) * 0.35
		var kind2 := (i + seed0 + 2) % 4
		_add_cylinder(root, Vector3(x2, 0.58, 0.1), 0.014, 0.1, wood_l, false, 0.55)
		if kind2 == 0:
			# Small hatchet
			_add_box(root, Vector3(x2, 0.38, 0.12), Vector3(0.035, 0.3, 0.035), wood_h, false, 0.55)
			_add_box(root, Vector3(x2, 0.24, 0.16), Vector3(0.14, 0.08, 0.06), IRON, false, 0.4)
			_add_box(root, Vector3(x2 + 0.08, 0.24, 0.16), Vector3(0.06, 0.1, 0.04), IRON.lightened(0.08), false, 0.4)
		elif kind2 == 1:
			# Turn-key / driver
			_add_cylinder(root, Vector3(x2, 0.4, 0.14), 0.02, 0.32, BRASS.darkened(0.1), false, 0.35, true)
			_add_box(root, Vector3(x2, 0.55, 0.14), Vector3(0.1, 0.03, 0.03), BRASS, false, 0.3)
		elif kind2 == 2:
			# Cold chisel
			_add_box(root, Vector3(x2, 0.4, 0.14), Vector3(0.05, 0.28, 0.05), IRON, false, 0.4)
			_add_box(root, Vector3(x2, 0.24, 0.14), Vector3(0.06, 0.04, 0.04), IRON.lightened(0.15), false, 0.4)
		else:
			# Small copper boss / punch
			_add_cylinder(root, Vector3(x2, 0.4, 0.14), 0.025, 0.28, IRON.darkened(0.05), false, 0.4)
			_add_cylinder(root, Vector3(x2, 0.28, 0.14), 0.05, 0.08, COPPER, false, 0.35, true)
	# Bits / stock on rail shelf
	if seed0 % 2 == 0:
		_add_box(root, Vector3(-0.35, 0.62, 0.1), Vector3(0.1, 0.04, 0.08), COPPER.darkened(0.05), false, 0.35)
		_add_cylinder(root, Vector3(-0.18, 0.64, 0.1), 0.03, 0.08, BRASS, false, 0.3, true)
		_add_box(root, Vector3(0.0, 0.62, 0.1), Vector3(0.12, 0.03, 0.06), IRON.lightened(0.1), false, 0.4)
	else:
		_add_box(root, Vector3(0.15, 0.62, 0.1), Vector3(0.22, 0.05, 0.12), OAK.lightened(0.1), false, 0.55)
		_add_cylinder(root, Vector3(0.4, 0.64, 0.1), 0.028, 0.08, COPPER, false, 0.35, true)
		_add_box(root, Vector3(0.5, 0.62, 0.1), Vector3(0.08, 0.04, 0.06), BRASS.darkened(0.1), false, 0.3)
	return root

static func _make_wicker_basket(prop: Dictionary) -> Node3D:
	## Loop 171: garden trug — oval weave, arched end handles, readable mid-FOV.
	## Not a packing drum or brown Minecraft brick. fill: apples|linen|veg|""
	var root := Node3D.new()
	root.name = "WickerBasket"
	var s: float = float(prop.get("scale", 1.0))
	var seed0: int = int(prop.get("seed", 0))
	var fill: String = str(prop.get("fill", ""))
	if fill == "" and seed0 % 3 == 0:
		fill = "apples"
	elif fill == "" and seed0 % 3 == 1:
		fill = "linen"
	# Willow: warm brown, not copper (g too high for metal) and not scrubbed oak
	var wick := Color(0.62, 0.48, 0.3) if seed0 % 2 == 0 else Color(0.55, 0.42, 0.26)
	var wick_d := wick.darkened(0.16)
	var wick_l := wick.lightened(0.12)
	# Wider low trug (loop 171: slightly taller walls for mid-FOV silhouette)
	var rx: float = 0.26 * s
	var rz: float = 0.17 * s
	var h: float = 0.18 * s
	# Flattened oval body (box core + rounded ends) — solid so walk-into collides
	_add_box(root, Vector3(0, h * 0.42, 0), Vector3(rx * 1.7, h * 0.82, rz * 1.55), wick, true, 0.78)
	_add_cylinder(root, Vector3(rx * 0.58, h * 0.42, 0), rz * 0.78, h * 0.82, wick, true, 0.78)
	_add_cylinder(root, Vector3(-rx * 0.58, h * 0.42, 0), rz * 0.78, h * 0.82, wick, true, 0.78)
	# Raised foot rail + dark interior soil bed
	_add_box(root, Vector3(0, 0.018 * s, 0), Vector3(rx * 1.75, 0.03 * s, rz * 1.6), wick_d, true, 0.72)
	_add_box(root, Vector3(0, h * 0.5, 0), Vector3(rx * 1.35, 0.025 * s, rz * 1.2), Color(0.2, 0.14, 0.08), false, 0.9)
	# Horizontal weave bands (alternating light/dark)
	for bi in 4:
		var by := 0.035 * s + float(bi) * (h * 0.22)
		_add_box(root, Vector3(0, by, 0), Vector3(rx * 1.78, 0.016 * s, rz * 1.62), wick_d if bi % 2 == 0 else wick_l, false, 0.74)
	# Vertical ribs on long sides + ends
	for vi in 6:
		var t := (float(vi) / 5.0 - 0.5) * rx * 1.5
		_add_box(root, Vector3(t, h * 0.42, rz * 0.74), Vector3(0.016 * s, h * 0.72, 0.016 * s), wick_d, false, 0.72)
		_add_box(root, Vector3(t, h * 0.42, -rz * 0.74), Vector3(0.016 * s, h * 0.72, 0.016 * s), wick_d, false, 0.72)
	for ei in 3:
		var ez := (float(ei) / 2.0 - 0.5) * rz * 1.1
		_add_box(root, Vector3(rx * 0.82, h * 0.42, ez), Vector3(0.016 * s, h * 0.7, 0.016 * s), wick_d, false, 0.72)
		_add_box(root, Vector3(-rx * 0.82, h * 0.42, ez), Vector3(0.016 * s, h * 0.7, 0.016 * s), wick_d, false, 0.72)
	# Thick rim
	_add_box(root, Vector3(0, h * 0.88, 0), Vector3(rx * 1.82, 0.03 * s, rz * 1.68), wick_l, false, 0.7)
	_add_box(root, Vector3(0, h * 0.92, 0), Vector3(rx * 1.7, 0.018 * s, rz * 1.55), wick_d, false, 0.72)
	# Arched end handles (trug signature — rise above rim, not end nubs)
	for sx in [-1.0, 1.0]:
		var hx: float = sx * rx * 0.9
		_add_box(root, Vector3(hx, h * 0.95, 0), Vector3(0.045 * s, 0.08 * s, 0.07 * s), wick, false, 0.68)
		_add_box(root, Vector3(hx, h * 1.12, 0), Vector3(0.04 * s, 0.12 * s, 0.05 * s), wick_d, false, 0.68)
		_add_box(root, Vector3(hx, h * 1.22, 0), Vector3(0.055 * s, 0.035 * s, 0.08 * s), wick_l, false, 0.65)
	# Cross grip bar (optional seed) — long trug carry
	if seed0 % 2 == 0:
		_add_box(root, Vector3(0, h * 1.18, 0), Vector3(rx * 1.65, 0.022 * s, 0.028 * s), wick_d, false, 0.68)
	# Fill (no foliage sphere blobs that read as plant scrap)
	if fill == "apples":
		for ai in 6:
			var ax := cos(float(ai) * 1.15) * rx * 0.42
			var az := sin(float(ai) * 1.15) * rz * 0.38
			var acol := Color(0.55, 0.18, 0.12) if ai % 2 == 0 else Color(0.48, 0.22, 0.1)
			# Small squat cylinders (apple mass without foliage path)
			_add_cylinder(root, Vector3(ax, h * 0.72, az), 0.038 * s, 0.045 * s, acol, false, 0.85)
			_add_cylinder(root, Vector3(ax, h * 0.78, az), 0.03 * s, 0.02 * s, acol.lightened(0.08), false, 0.85)
	elif fill == "linen":
		# Folded cloth stack — cream g high enough for linen, not scrubbed wood
		_add_box(root, Vector3(0, h * 0.68, 0), Vector3(rx * 1.25, 0.055 * s, rz * 1.15), Color(0.84, 0.8, 0.7), false, 0.9)
		_add_box(root, Vector3(0.02 * s, h * 0.78, 0.015 * s), Vector3(rx * 1.05, 0.04 * s, rz * 0.95), Color(0.8, 0.76, 0.66), false, 0.9)
		_add_box(root, Vector3(-0.015 * s, h * 0.86, -0.01 * s), Vector3(rx * 0.9, 0.03 * s, rz * 0.8), Color(0.78, 0.74, 0.64), false, 0.9)
	elif fill == "veg":
		# Conservatory trug: soil cake + root veg + leaf fronds (thin boxes, not green brick)
		_add_box(root, Vector3(0, h * 0.58, 0), Vector3(rx * 1.2, 0.04 * s, rz * 1.05), Color(0.28, 0.2, 0.1), false, 0.9)
		# Carrots / roots (orange cylinders, miss copper via higher g)
		for ci in 4:
			var cx := (float(ci) / 3.0 - 0.5) * rx * 0.9
			_add_cylinder(root, Vector3(cx, h * 0.7, rz * 0.15), 0.018 * s, 0.09 * s, Color(0.78, 0.42, 0.18), false, 0.8)
			_add_box(root, Vector3(cx, h * 0.78, rz * 0.15), Vector3(0.04 * s, 0.02 * s, 0.03 * s), Color(0.22, 0.4, 0.14), false, 0.9)
		# Leaf fronds (flat, horizontal — not upright plant scrap)
		_add_box(root, Vector3(0.05 * s, h * 0.76, -rz * 0.2), Vector3(0.12 * s, 0.012 * s, 0.08 * s), Color(0.24, 0.42, 0.16), false, 0.9)
		_add_box(root, Vector3(-0.08 * s, h * 0.74, -rz * 0.1), Vector3(0.1 * s, 0.01 * s, 0.07 * s), Color(0.2, 0.38, 0.14), false, 0.9)
		# Turnip / potato mass
		_add_cylinder(root, Vector3(rx * 0.25, h * 0.68, -rz * 0.15), 0.035 * s, 0.04 * s, Color(0.72, 0.62, 0.4), false, 0.85)
	_add_contact_shadow(root, rx * 1.25, rz * 1.25)
	return root


static func _make_crate(prop: Dictionary) -> Node3D:
	## Packing crates: closed / open-lid / stenciled / rope-handled by seed.
	var root := Node3D.new()
	root.name = "Crate"
	var s: float = prop.get("scale", 1.0)
	var seed0: int = int(prop.get("seed", 0))
	var wood := Color(0.62, 0.48, 0.28) if seed0 % 2 == 0 else Color(0.55, 0.42, 0.24)
	if seed0 % 5 == 4:
		wood = Color(0.48, 0.36, 0.22)  # darker shipping pine
	var h: float = 0.38 + float(seed0 % 3) * 0.04
	var open_lid := seed0 % 4 == 1
	_add_box(root, Vector3(0, h * 0.5 * s, 0), Vector3(0.55 * s, h * s, 0.45 * s), wood, true, 0.7)
	# Loop 117: plank lines so crate reads as boarded (not solid cube)
	for pi in 3:
		var py := (0.15 + float(pi) * 0.12) * h * s
		_add_box(root, Vector3(0, py, 0.225 * s), Vector3(0.52 * s, 0.012 * s, 0.012 * s), wood.darkened(0.12), false, 0.6)
		_add_box(root, Vector3(0, py, -0.225 * s), Vector3(0.52 * s, 0.012 * s, 0.012 * s), wood.darkened(0.12), false, 0.6)
	if open_lid:
		# Lid hinged ajar — shows packing straw
		_add_box(root, Vector3(0.0, h * s + 0.04 * s, -0.18 * s), Vector3(0.52 * s, 0.04 * s, 0.42 * s), wood.darkened(0.08), false, 0.65)
		_add_box(root, Vector3(0.0, h * s - 0.02 * s, 0.0), Vector3(0.4 * s, 0.04 * s, 0.3 * s), Color(0.7, 0.62, 0.35), false, 0.85)
	else:
		_add_box(root, Vector3(0, h * s, 0), Vector3(0.52 * s, 0.04 * s, 0.42 * s), wood.darkened(0.1), false, 0.65)
	# Batten straps
	if seed0 % 2 == 0:
		_add_box(root, Vector3(0, h * 0.5 * s, 0.22 * s), Vector3(0.52 * s, 0.06 * s, 0.03 * s), wood.darkened(0.15), false, 0.55)
		_add_box(root, Vector3(0, h * 0.5 * s, -0.22 * s), Vector3(0.52 * s, 0.06 * s, 0.03 * s), wood.darkened(0.15), false, 0.55)
	else:
		_add_box(root, Vector3(0.22 * s, h * 0.5 * s, 0), Vector3(0.03 * s, 0.06 * s, 0.42 * s), wood.darkened(0.15), false, 0.55)
		_add_box(root, Vector3(-0.22 * s, h * 0.5 * s, 0), Vector3(0.03 * s, 0.06 * s, 0.42 * s), wood.darkened(0.15), false, 0.55)
	# Iron hasp / rope handles / stencil plate by seed
	match seed0 % 4:
		0:
			_add_box(root, Vector3(0, h * 0.55 * s, 0.24 * s), Vector3(0.08 * s, 0.04 * s, 0.02 * s), IRON, false, 0.4)
		1:
			_add_cylinder(root, Vector3(0.28 * s, h * 0.55 * s, 0), 0.02 * s, 0.12 * s, Color(0.45, 0.35, 0.2), false, 0.7)
			_add_cylinder(root, Vector3(-0.28 * s, h * 0.55 * s, 0), 0.02 * s, 0.12 * s, Color(0.45, 0.35, 0.2), false, 0.7)
		2:
			# Stencil plate "SULPHUR / PARTS"
			_add_box(root, Vector3(0, h * 0.55 * s, 0.23 * s), Vector3(0.22 * s, 0.1 * s, 0.015 * s), PAPER.darkened(0.15), false, 0.75)
			_add_box(root, Vector3(0, h * 0.58 * s, 0.24 * s), Vector3(0.16 * s, 0.02 * s, 0.01 * s), INK.lightened(0.3), false, 0.9)
		_:
			_add_box(root, Vector3(0, h * 0.35 * s, 0.23 * s), Vector3(0.5 * s, 0.03 * s, 0.02 * s), IRON.darkened(0.1), false, 0.4)
			_add_box(root, Vector3(0, h * 0.65 * s, 0.23 * s), Vector3(0.5 * s, 0.03 * s, 0.02 * s), IRON.darkened(0.1), false, 0.4)
	_add_contact_shadow(root, 0.3 * s, 0.25 * s)
	return root

static func _make_stool(prop: Dictionary) -> Node3D:
	## Loop 127: thicker seats, piping, turned legs — not flat green discs.
	## seed: 0 tripod oak · 1 four-leg square · 2 padded drum
	var root := Node3D.new()
	root.name = "Stool"
	var seed0: int = int(prop.get("seed", 0))
	var style := seed0 % 3
	if style == 0:
		# Round seat with thick rim + under-disc
		_add_cylinder(root, Vector3(0, 0.48, 0), 0.21, 0.06, OAK, true, 0.52)
		_add_cylinder(root, Vector3(0, 0.52, 0), 0.19, 0.035, OAK.lightened(0.06), false, 0.55)
		_add_cylinder(root, Vector3(0, 0.54, 0), 0.2, 0.02, OAK.darkened(0.08), false, 0.5)
		_add_cylinder(root, Vector3(0, 0.44, 0), 0.22, 0.025, MAHOGANY_DARK, false, 0.48)
		for a in [0.0, 120.0, 240.0]:
			var rad := deg_to_rad(a)
			var lx := cos(rad) * 0.15
			var lz := sin(rad) * 0.15
			_add_cylinder(root, Vector3(lx, 0.34, lz), 0.034, 0.2, MAHOGANY_DARK, true)
			_add_cylinder(root, Vector3(lx, 0.2, lz), 0.025, 0.14, MAHOGANY, true)
			_add_cylinder(root, Vector3(lx, 0.08, lz), 0.03, 0.12, MAHOGANY_DARK, true)
			_add_cylinder(root, Vector3(lx, 0.02, lz), 0.042, 0.04, MAHOGANY, true)
		_add_cylinder(root, Vector3(0, 0.16, 0), 0.17, 0.028, MAHOGANY_DARK, false, 0.5)
		_add_cylinder(root, Vector3(0, 0.16, 0), 0.13, 0.02, MAHOGANY, false, 0.52)
	elif style == 1:
		# Square boarded seat + apron + four turned legs + H-stretcher
		_add_box(root, Vector3(0, 0.5, 0), Vector3(0.4, 0.05, 0.4), Color(0.42, 0.3, 0.16), true, 0.52)
		_add_box(root, Vector3(0, 0.54, 0), Vector3(0.38, 0.025, 0.38), OAK.lightened(0.05), false, 0.55)
		_add_box(root, Vector3(0, 0.46, 0.18), Vector3(0.36, 0.05, 0.035), MAHOGANY, false, 0.48)
		_add_box(root, Vector3(0, 0.46, -0.18), Vector3(0.36, 0.05, 0.035), MAHOGANY, false, 0.48)
		_add_box(root, Vector3(0.18, 0.46, 0), Vector3(0.035, 0.05, 0.34), MAHOGANY, false, 0.48)
		_add_box(root, Vector3(-0.18, 0.46, 0), Vector3(0.035, 0.05, 0.34), MAHOGANY, false, 0.48)
		for sx in [-1.0, 1.0]:
			for sz in [-1.0, 1.0]:
				_add_cylinder(root, Vector3(sx * 0.15, 0.34, sz * 0.15), 0.032, 0.2, MAHOGANY_DARK, true)
				_add_cylinder(root, Vector3(sx * 0.15, 0.18, sz * 0.15), 0.024, 0.16, MAHOGANY, true)
				_add_cylinder(root, Vector3(sx * 0.15, 0.06, sz * 0.15), 0.03, 0.1, MAHOGANY_DARK, true)
				_add_cylinder(root, Vector3(sx * 0.15, 0.02, sz * 0.15), 0.04, 0.035, MAHOGANY, true)
		_add_box(root, Vector3(0, 0.14, 0), Vector3(0.28, 0.028, 0.028), MAHOGANY_DARK, false, 0.5)
		_add_box(root, Vector3(-0.14, 0.14, 0), Vector3(0.028, 0.028, 0.26), MAHOGANY_DARK, false, 0.5)
		_add_box(root, Vector3(0.14, 0.14, 0), Vector3(0.028, 0.028, 0.26), MAHOGANY_DARK, false, 0.5)
	else:
		# Upholstered drum (loop 138): clear wood seat rim so it doesn't read as a cactus
		var fab := VELVET_GREEN.darkened(0.08) if seed0 % 2 == 0 else VELVET_RED.darkened(0.12)
		var fab_d := fab.darkened(0.14)
		# Wood plinth + visible oak seat rail (furniture language)
		_add_cylinder(root, Vector3(0, 0.36, 0), 0.22, 0.08, MAHOGANY_DARK, true, 0.45)
		_add_cylinder(root, Vector3(0, 0.42, 0), 0.215, 0.04, MAHOGANY, false, 0.48)
		_add_cylinder(root, Vector3(0, 0.46, 0), 0.2, 0.03, OAK.darkened(0.05), false, 0.52)
		# Padded top — flatter, wider, not tall green cylinder
		_add_cylinder(root, Vector3(0, 0.52, 0), 0.195, 0.1, fab, true, 0.9)
		_add_cylinder(root, Vector3(0, 0.58, 0), 0.18, 0.04, fab_d, false, 0.92)
		# Wood nailhead ring at top edge
		_add_cylinder(root, Vector3(0, 0.55, 0), 0.2, 0.015, MAHOGANY_DARK, false, 0.4)
		for ti in 6:
			var ta := float(ti) * TAU / 6.0
			_add_cylinder(root, Vector3(cos(ta) * 0.08, 0.6, sin(ta) * 0.08), 0.012, 0.012, fab.darkened(0.25), false, 0.95)
		# Turned legs
		for a in [0.0, 90.0, 180.0, 270.0]:
			var rad := deg_to_rad(a)
			var lx := cos(rad) * 0.13
			var lz := sin(rad) * 0.13
			_add_cylinder(root, Vector3(lx, 0.26, lz), 0.03, 0.16, MAHOGANY_DARK, true)
			_add_cylinder(root, Vector3(lx, 0.12, lz), 0.024, 0.14, MAHOGANY, true)
			_add_cylinder(root, Vector3(lx, 0.02, lz), 0.034, 0.04, MAHOGANY, true)
		_add_cylinder(root, Vector3(0, 0.12, 0), 0.14, 0.022, MAHOGANY_DARK, false, 0.5)
	_add_contact_shadow(root, 0.26, 0.26)
	return root

# ─── Gallery / aetheric ──────────────────────────────────────────────────────

static func _make_machine(prop: Dictionary) -> Node3D:
	## Secondary gallery apparatus — loop 131: THREE distinct instrument silhouettes
	## by seed (coil frame / harmonic fork / Leyden stack). Never mini-clones of the
	## main aetheric engine, never solid gold coin towers.
	var root := Node3D.new()
	root.name = "Machine"
	var height: float = float(prop.get("height", 2.6))
	var seed0: int = int(prop.get("seed", int(height * 10.0)))
	var style := seed0 % 3
	var iron_mid := Color(0.34, 0.34, 0.36)
	var iron_dark := Color(0.24, 0.24, 0.26)
	var oak_d := Color(0.26, 0.16, 0.09)
	var oak := Color(0.4, 0.26, 0.14)
	var glass_c := Color(0.35, 0.55, 0.58)
	var glass_hi := Color(0.45, 0.68, 0.72)
	var top_y: float = 1.6
	match style:
		0:
			# Open oak frame + spaced copper coils + dome (secondary coil apparatus)
			var col_h: float = maxf(height * 0.68, 1.35)
			_add_box(root, Vector3(0, 0.1, 0), Vector3(1.15, 0.2, 1.05), iron_mid, true, 0.45)
			_add_box(root, Vector3(0, 0.24, 0), Vector3(0.98, 0.1, 0.88), oak_d, true, 0.5)
			_add_box(root, Vector3(0, 0.3, 0), Vector3(0.82, 0.04, 0.74), COPPER.darkened(0.15), false, 0.35)
			var col_mid: float = 0.4 + col_h * 0.45
			_add_cylinder(root, Vector3(0, col_mid, 0), 0.06, col_h * 0.85, BRASS.darkened(0.05), true, 0.3, true)
			for sx in [-1.0, 1.0]:
				for sz in [-1.0, 1.0]:
					_add_box(root, Vector3(sx * 0.34, col_mid, sz * 0.34), Vector3(0.065, col_h * 0.8, 0.065), oak_d, true, 0.5)
					_add_cylinder(root, Vector3(sx * 0.34, 0.4 + col_h * 0.85, sz * 0.34), 0.045, 0.045, BRASS, false, 0.28, true)
			_add_box(root, Vector3(0, 0.4 + col_h * 0.82, 0), Vector3(0.78, 0.06, 0.78), oak, false, 0.5)
			_add_box(root, Vector3(0, 0.4 + col_h * 0.86, 0), Vector3(0.66, 0.03, 0.66), BRASS.darkened(0.1), false, 0.3)
			for i in 4:
				var y: float = 0.52 + float(i) * (col_h * 0.18)
				var r: float = 0.4 - float(i) * 0.04
				var copper_col: Color = COPPER if i % 2 == 0 else COPPER.darkened(0.1)
				_add_cylinder(root, Vector3(0, y, 0), r, 0.055, copper_col, false, 0.32, true)
				_add_cylinder(root, Vector3(0, y + 0.02, 0), r * 0.86, 0.02, copper_col.lightened(0.1), false, 0.3, true)
				_add_cylinder(root, Vector3(0, y, 0), r * 0.5, 0.045, oak_d.darkened(0.1), false, 0.55)
				var wind := 1.0 if i % 2 == 0 else -1.0
				for s in 10:
					var ang: float = float(s) * (TAU / 10.0) * wind
					_add_box(root, Vector3(cos(ang) * r * 0.96, y, sin(ang) * r * 0.96),
						Vector3(0.04, 0.03, 0.06), copper_col.lightened(0.05), false, 0.28)
				var side := 1.0 if i % 2 == 0 else -1.0
				_add_box(root, Vector3(side * r * 0.95, y, 0), Vector3(0.055, 0.07, 0.07), BRASS, false, 0.28)
			top_y = 0.42 + col_h * 0.9
			_add_cylinder(root, Vector3(0, top_y, 0), 0.2, 0.05, BRASS.lightened(0.05), false, 0.3, true)
			_add_cylinder(root, Vector3(0, top_y + 0.1, 0), 0.14, 0.14, glass_c, false, 0.35)
			_add_cylinder(root, Vector3(0, top_y + 0.18, 0), 0.1, 0.08, glass_hi, false, 0.32)
			for ri in 5:
				var ra := float(ri) * TAU / 5.0
				_add_box(root, Vector3(cos(ra) * 0.13, top_y + 0.12, sin(ra) * 0.13), Vector3(0.016, 0.14, 0.016), BRASS, false, 0.28)
			# Gauge bank + copper riser
			_add_box(root, Vector3(0.55, 0.55, 0.1), Vector3(0.28, 0.42, 0.3), oak_d, true, 0.48)
			for gi in 3:
				_add_cylinder(root, Vector3(0.55, 0.62 + float(gi) * 0.12, 0.22), 0.055, 0.025, BRASS, false, 0.28, true)
				_add_cylinder(root, Vector3(0.55, 0.63 + float(gi) * 0.12, 0.24), 0.04, 0.01, Color(0.85, 0.88, 0.8), false, 0.5)
			_add_cylinder(root, Vector3(-0.5, 0.85, 0.0), 0.035, 0.7, COPPER, false, 0.32, true)
			_add_cylinder(root, Vector3(-0.5, 1.25, 0.15), 0.045, 0.04, BRASS, false, 0.3, true)
		1:
			# Harmonic resonator — loop 132: SOLID bulk (not empty shelf tower).
			# Wide iron cheeks + dense copper diaphragms + central mast fill.
			_add_box(root, Vector3(0, 0.12, 0), Vector3(1.25, 0.24, 1.0), iron_dark, true, 0.45)
			_add_box(root, Vector3(0, 0.28, 0), Vector3(1.1, 0.1, 0.88), iron_mid, true, 0.45)
			_add_box(root, Vector3(0, 0.35, 0), Vector3(0.95, 0.04, 0.75), BRASS.darkened(0.12), false, 0.32)
			# Thick side cheeks (solid walls — kill hollow shelf read)
			for sx in [-1.0, 1.0]:
				_add_box(root, Vector3(sx * 0.38, 1.0, 0), Vector3(0.16, 1.4, 0.55), iron_mid, true, 0.42)
				_add_box(root, Vector3(sx * 0.38, 1.0, 0.08), Vector3(0.1, 1.3, 0.35), iron_dark, false, 0.45)
				_add_cylinder(root, Vector3(sx * 0.38, 1.72, 0), 0.09, 0.08, BRASS, false, 0.28, true)
				# Brass edge rails on cheeks
				_add_box(root, Vector3(sx * 0.46, 1.0, 0.25), Vector3(0.03, 1.25, 0.04), BRASS.darkened(0.1), false, 0.3)
			# Back panel (closes the silhouette from any angle)
			_add_box(root, Vector3(0, 1.0, -0.28), Vector3(0.85, 1.35, 0.08), oak_d, true, 0.5)
			_add_box(root, Vector3(0, 1.0, -0.24), Vector3(0.7, 1.2, 0.04), iron_dark, false, 0.48)
			# Central mast + stacked copper diaphragms (thick bands, no air-shelf look)
			_add_cylinder(root, Vector3(0, 1.0, 0.05), 0.08, 1.35, BRASS.darkened(0.05), true, 0.28, true)
			for i in 5:
				var y: float = 0.55 + float(i) * 0.22
				var r: float = 0.34 - float(i) * 0.025
				var copper_col: Color = COPPER if i % 2 == 0 else COPPER.darkened(0.1)
				_add_cylinder(root, Vector3(0, y, 0.05), r, 0.1, copper_col, false, 0.3, true)
				_add_cylinder(root, Vector3(0, y + 0.03, 0.05), r * 0.88, 0.035, copper_col.lightened(0.08), false, 0.28, true)
				# Fill between coil and cheeks so no empty shelf voids
				_add_box(root, Vector3(0, y, 0.05), Vector3(r * 1.5, 0.06, 0.2), copper_col.darkened(0.05), false, 0.35)
			# Cross braces (instrument, not furniture shelves)
			_add_box(root, Vector3(0, 0.7, 0.15), Vector3(0.75, 0.06, 0.1), iron_mid, false, 0.42)
			_add_box(root, Vector3(0, 1.35, 0.15), Vector3(0.75, 0.05, 0.1), iron_mid, false, 0.42)
			# Side instrument cabinets
			_add_box(root, Vector3(0.55, 0.65, 0.15), Vector3(0.3, 0.55, 0.42), oak_d, true, 0.5)
			for gi in 3:
				_add_cylinder(root, Vector3(0.55, 0.55 + float(gi) * 0.14, 0.32), 0.055, 0.025, BRASS, false, 0.28, true)
				_add_cylinder(root, Vector3(0.55, 0.56 + float(gi) * 0.14, 0.34), 0.04, 0.01, Color(0.85, 0.88, 0.8), false, 0.5)
			_add_box(root, Vector3(-0.55, 0.6, 0.1), Vector3(0.28, 0.45, 0.35), iron_dark, true, 0.45)
			_add_cylinder(root, Vector3(-0.55, 0.9, 0.2), 0.04, 0.55, COPPER, false, 0.32, true)
			_add_cylinder(root, Vector3(-0.55, 1.2, 0.28), 0.05, 0.04, BRASS, false, 0.3, true)
			# Top bridge + glass chamber
			_add_box(root, Vector3(0, 1.72, 0), Vector3(0.85, 0.08, 0.5), iron_mid, false, 0.42)
			_add_box(root, Vector3(0, 1.78, 0), Vector3(0.7, 0.04, 0.4), BRASS.darkened(0.08), false, 0.3)
			_add_cylinder(root, Vector3(0, 1.92, 0.05), 0.14, 0.16, glass_c, false, 0.32)
			_add_cylinder(root, Vector3(0, 2.02, 0.05), 0.1, 0.08, glass_hi, false, 0.3)
			for ri in 4:
				var ra := float(ri) * TAU / 4.0
				_add_box(root, Vector3(cos(ra) * 0.12, 1.95, sin(ra) * 0.12 + 0.05), Vector3(0.015, 0.14, 0.015), BRASS, false, 0.28)
			top_y = 1.95
			var fork_core := MeshInstance3D.new()
			var fcm := SphereMesh.new()
			fcm.radius = 0.07
			fcm.height = 0.14
			fork_core.mesh = fcm
			var fcmat := StandardMaterial3D.new()
			fcmat.albedo_color = Color(0.5, 0.88, 1.0)
			fcmat.emission_enabled = true
			fcmat.emission = Color(0.4, 0.8, 1.0)
			fcmat.emission_energy_multiplier = 2.4
			fcmat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
			fork_core.material_override = fcmat
			fork_core.position = Vector3(0, 1.95, 0.05)
			root.add_child(fork_core)
		_:
			# Leyden / glass-stack apparatus (vertical jar battery look)
			_add_box(root, Vector3(0, 0.1, 0), Vector3(1.05, 0.2, 1.0), oak_d, true, 0.5)
			_add_box(root, Vector3(0, 0.24, 0), Vector3(0.92, 0.1, 0.88), oak, true, 0.5)
			_add_box(root, Vector3(0, 0.3, 0), Vector3(0.78, 0.04, 0.74), iron_mid, false, 0.45)
			# Three glass jars with copper foil bands
			for i in 3:
				var jx := -0.28 + float(i) * 0.28
				var jh := 0.85 + float(i % 2) * 0.15
				_add_cylinder(root, Vector3(jx, 0.35 + jh * 0.5, 0.05), 0.12, jh, glass_c, false, 0.35)
				_add_cylinder(root, Vector3(jx, 0.55, 0.05), 0.125, 0.08, COPPER, false, 0.3, true)
				_add_cylinder(root, Vector3(jx, 0.85, 0.05), 0.125, 0.06, COPPER.darkened(0.08), false, 0.3, true)
				_add_cylinder(root, Vector3(jx, 0.35 + jh, 0.05), 0.08, 0.04, BRASS, false, 0.28, true)
				_add_cylinder(root, Vector3(jx, 0.4 + jh, 0.05), 0.02, 0.12, BRASS.darkened(0.05), false, 0.28, true)
			# Central mast with stacked copper discs (air gaps) + sphere terminal
			_add_cylinder(root, Vector3(0, 1.0, -0.25), 0.04, 1.2, BRASS, true, 0.28, true)
			for i in 5:
				var y: float = 0.55 + float(i) * 0.18
				var r: float = 0.22 - float(i) * 0.02
				_add_cylinder(root, Vector3(0, y, -0.25), r, 0.04, COPPER if i % 2 == 0 else COPPER.darkened(0.1), false, 0.3, true)
			_add_sphere_blob(root, Vector3(0, 1.7, -0.25), 0.1, BRASS.lightened(0.05))
			# Connecting rods between jars and mast
			_add_box(root, Vector3(0, 1.15, -0.08), Vector3(0.55, 0.03, 0.03), BRASS.darkened(0.1), false, 0.3)
			_add_box(root, Vector3(0, 0.9, 0.0), Vector3(0.6, 0.025, 0.025), COPPER, false, 0.32)
			# Side control panel
			_add_box(root, Vector3(0.45, 0.55, 0.25), Vector3(0.25, 0.4, 0.28), iron_dark, true, 0.45)
			_add_cylinder(root, Vector3(0.45, 0.7, 0.38), 0.06, 0.03, BRASS, false, 0.28, true)
			_add_cylinder(root, Vector3(0.45, 0.85, 0.38), 0.05, 0.025, BRASS.darkened(0.1), false, 0.28, true)
			top_y = 1.65
			# Subtle cyan glow at terminal
			var leyden_g := MeshInstance3D.new()
			var lsm := SphereMesh.new()
			lsm.radius = 0.05
			lsm.height = 0.1
			leyden_g.mesh = lsm
			var lmat := StandardMaterial3D.new()
			lmat.albedo_color = Color(0.55, 0.9, 1.0)
			lmat.emission_enabled = true
			lmat.emission = Color(0.4, 0.85, 1.0)
			lmat.emission_energy_multiplier = 1.8
			lmat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
			leyden_g.material_override = lmat
			leyden_g.position = Vector3(0, 1.72, -0.25)
			root.add_child(leyden_g)
	# Shared: emissive core accent for styles that need one on dome (style 0)
	if style == 0:
		var core := MeshInstance3D.new()
		var cm := CylinderMesh.new()
		cm.top_radius = 0.04
		cm.bottom_radius = 0.04
		cm.height = 0.12
		core.mesh = cm
		var cmat := StandardMaterial3D.new()
		cmat.albedo_color = Color(0.45, 0.85, 0.95)
		cmat.emission_enabled = true
		cmat.emission = Color(0.35, 0.75, 0.95)
		cmat.emission_energy_multiplier = 2.8
		cmat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		core.material_override = cmat
		core.position = Vector3(0, top_y + 0.12, 0)
		root.add_child(core)
		var glow_s := MeshInstance3D.new()
		var gsm := SphereMesh.new()
		gsm.radius = 0.05
		gsm.height = 0.1
		glow_s.mesh = gsm
		var gsmat := StandardMaterial3D.new()
		gsmat.albedo_color = Color(0.5, 0.9, 1.0)
		gsmat.emission_enabled = true
		gsmat.emission = Color(0.4, 0.85, 1.0)
		gsmat.emission_energy_multiplier = 2.0
		gsmat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		glow_s.material_override = gsmat
		glow_s.position = Vector3(0, top_y + 0.16, 0)
		root.add_child(glow_s)
	# Front valve wheel (all styles — control language)
	_add_cylinder(root, Vector3(0.0, 0.52, 0.48), 0.1, 0.03, BRASS, false, 0.28, true)
	_add_box(root, Vector3(0.0, 0.52, 0.48), Vector3(0.18, 0.02, 0.02), BRASS.lightened(0.05), false, 0.28)
	_add_box(root, Vector3(0.0, 0.52, 0.48), Vector3(0.02, 0.02, 0.18), BRASS.lightened(0.05), false, 0.28)
	var glow := OmniLight3D.new()
	glow.light_color = Color(0.55, 0.82, 0.95)
	glow.light_energy = 0.85
	glow.omni_range = 3.8
	glow.position = Vector3(0, top_y * 0.7, 0.1)
	root.add_child(glow)
	_add_contact_shadow(root, 0.58, 0.52)
	return root

static func _make_aetheric_machine(prop: Dictionary) -> Node3D:
	## Novel-true Aetheric Engine — loop 131: height-scaled coil stack, denser windings,
	## stronger dome glow, plaque base. Mid-grey iron posts (not black under tonemap).
	var root := Node3D.new()
	root.name = "AethericMachine"
	var height: float = float(prop.get("height", 2.95))
	var oak := Color(0.42, 0.28, 0.14)
	var oak_d := Color(0.26, 0.16, 0.09)
	var iron_frame := Color(0.34, 0.34, 0.36)
	var iron_dark := Color(0.26, 0.26, 0.28)
	# Square oak base with copper inlay plate + brass edge + name plaque
	# Loop 148: darker pedestal metals so from-north views don't specular-bloom
	_add_box(root, Vector3(0, 0.1, 0), Vector3(1.7, 0.2, 1.7), oak_d, true, 0.5)
	_add_box(root, Vector3(0, 0.24, 0), Vector3(1.52, 0.1, 1.52), oak, true, 0.52)
	_add_box(root, Vector3(0, 0.32, 0), Vector3(1.36, 0.06, 1.36), COPPER.darkened(0.22), false, 0.5)
	_add_box(root, Vector3(0, 0.35, 0), Vector3(1.42, 0.02, 1.42), BRASS.darkened(0.22), false, 0.45)
	# Front brass plaque strip
	_add_box(root, Vector3(0, 0.28, 0.78), Vector3(0.55, 0.08, 0.04), BRASS.darkened(0.08), false, 0.3)
	_add_box(root, Vector3(0, 0.28, 0.8), Vector3(0.42, 0.05, 0.02), BRASS.lightened(0.05), false, 0.28)
	# Corner iron footings + brass bolts
	for sx in [-1.0, 1.0]:
		for sz in [-1.0, 1.0]:
			_add_box(root, Vector3(sx * 0.74, 0.06, sz * 0.74), Vector3(0.18, 0.12, 0.18), iron_dark, true, 0.45)
			_add_cylinder(root, Vector3(sx * 0.74, 0.14, sz * 0.74), 0.032, 0.03, BRASS, false, 0.3, true)
	# Frame posts — iron clad with brass caps + mid collars
	for sx in [-1.0, 1.0]:
		for sz in [-1.0, 1.0]:
			_add_box(root, Vector3(sx * 0.52, height * 0.45, sz * 0.52), Vector3(0.11, height * 0.78, 0.11), iron_frame, true, 0.45)
			_add_box(root, Vector3(sx * 0.52, height * 0.45, sz * 0.52), Vector3(0.065, height * 0.72, 0.065), oak_d, false, 0.5)
			_add_cylinder(root, Vector3(sx * 0.52, height * 0.86, sz * 0.52), 0.075, 0.06, BRASS, false, 0.28, true)
			_add_cylinder(root, Vector3(sx * 0.52, height * 0.5, sz * 0.52), 0.07, 0.04, BRASS.darkened(0.1), false, 0.3, true)
			_add_cylinder(root, Vector3(sx * 0.52, height * 0.28, sz * 0.52), 0.065, 0.035, BRASS.darkened(0.15), false, 0.3, true)
	# Top ring beams (brass-capped oak)
	_add_box(root, Vector3(0, height * 0.9, 0), Vector3(1.25, 0.08, 1.25), oak_d, false, 0.48)
	_add_box(root, Vector3(0, height * 0.94, 0), Vector3(1.15, 0.04, 1.15), BRASS.darkened(0.1), false, 0.3)
	_add_box(root, Vector3(0, height * 0.97, 0), Vector3(1.0, 0.03, 1.0), BRASS.lightened(0.05), false, 0.28)
	# FIVE copper coils — Y scaled to height so stack fills the frame
	var coil_fracs := [0.18, 0.32, 0.46, 0.58, 0.68]
	var coil_rs := [0.74, 0.6, 0.48, 0.38, 0.28]
	var coil_hs := [0.12, 0.11, 0.1, 0.095, 0.085]
	for i in 5:
		var y: float = height * coil_fracs[i]
		var r: float = coil_rs[i]
		var ch: float = coil_hs[i]
		var copper_col: Color = COPPER if i % 2 == 0 else COPPER.darkened(0.1)
		_add_cylinder(root, Vector3(0, y, 0), r, ch, copper_col, false, 0.3, true)
		_add_cylinder(root, Vector3(0, y + ch * 0.35, 0), r * 0.9, ch * 0.22, copper_col.lightened(0.08), false, 0.28, true)
		# Inner dark void so coils read as bands
		_add_cylinder(root, Vector3(0, y, 0), r * 0.55, ch * 0.7, oak_d.darkened(0.05), false, 0.55)
		var wind := 1.0 if i % 2 == 0 else -1.0
		for s in 14:
			var ang: float = float(s) * (TAU / 14.0) * wind
			var bx: float = cos(ang) * r * 0.94
			var bz: float = sin(ang) * r * 0.94
			var by: float = y + (float(s) / 14.0 - 0.5) * ch * 0.9 * wind
			var bar_c: Color = copper_col.lightened(0.06) if s % 2 == 0 else copper_col.darkened(0.04)
			_add_box(root, Vector3(bx, by, bz), Vector3(0.05, 0.032, 0.085), bar_c, false, 0.28)
		var side := 1.0 if i % 2 == 0 else -1.0
		_add_box(root, Vector3(side * r * 0.97, y, 0), Vector3(0.08, ch + 0.04, 0.11), BRASS, false, 0.28)
	# Central spine + collars
	_add_cylinder(root, Vector3(0, height * 0.48, 0), 0.085, height * 0.65, BRASS, true, 0.28, true)
	_add_cylinder(root, Vector3(0, height * 0.55, 0), 0.14, 0.05, BRASS.darkened(0.05), false, 0.28, true)
	_add_cylinder(root, Vector3(0, height * 0.78, 0), 0.22, 0.08, BRASS.lightened(0.08), false, 0.28, true)
	# Loop 104: solid teal scientific dome + brass cage (not tall pale alpha tube)
	var glass_c := Color(0.32, 0.52, 0.55)
	var glass_hi := Color(0.42, 0.65, 0.7)
	var dome_y: float = height * 0.82
	_add_cylinder(root, Vector3(0, dome_y - 0.08, 0), 0.26, 0.14, glass_c, false, 0.32)
	_add_cylinder(root, Vector3(0, dome_y + 0.02, 0), 0.2, 0.12, glass_hi, false, 0.3)
	# Dome cap sphere (reads as glass chamber, not chimney)
	var dome := MeshInstance3D.new()
	var dm := SphereMesh.new()
	dm.radius = 0.18
	dm.height = 0.28
	dome.mesh = dm
	var dmat := StandardMaterial3D.new()
	dmat.albedo_color = Color(0.38, 0.6, 0.65)
	dmat.emission_enabled = true
	dmat.emission = Color(0.2, 0.45, 0.6)
	dmat.emission_energy_multiplier = 0.45
	dmat.roughness = 0.35
	dmat.metallic = 0.05
	dome.material_override = dmat
	dome.position = Vector3(0, dome_y + 0.12, 0)
	root.add_child(dome)
	# Brass cage ribs + top gallery
	for ri in 6:
		var ra := float(ri) * TAU / 6.0
		_add_box(root, Vector3(cos(ra) * 0.24, dome_y, sin(ra) * 0.24), Vector3(0.025, 0.28, 0.025), BRASS, false, 0.28)
	_add_cylinder(root, Vector3(0, dome_y - 0.14, 0), 0.28, 0.04, BRASS.darkened(0.05), false, 0.28, true)
	_add_cylinder(root, Vector3(0, dome_y + 0.18, 0), 0.12, 0.035, BRASS, false, 0.28, true)
	# Compact emissive aether core (loop 148: softer — no from-north white-out)
	var core := MeshInstance3D.new()
	var cm := CylinderMesh.new()
	cm.top_radius = 0.06
	cm.bottom_radius = 0.06
	cm.height = 0.14
	core.mesh = cm
	var cmat := StandardMaterial3D.new()
	cmat.albedo_color = Color(0.45, 0.8, 0.95)
	cmat.emission_enabled = true
	cmat.emission = Color(0.35, 0.7, 0.9)
	cmat.emission_energy_multiplier = 1.4
	cmat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	core.material_override = cmat
	core.position = Vector3(0, dome_y, 0)
	root.add_child(core)
	var glow := MeshInstance3D.new()
	var sm := SphereMesh.new()
	sm.radius = 0.08
	sm.height = 0.16
	glow.mesh = sm
	var smat := StandardMaterial3D.new()
	smat.albedo_color = Color(0.5, 0.85, 0.95)
	smat.emission_enabled = true
	smat.emission = Color(0.35, 0.75, 0.9)
	smat.emission_energy_multiplier = 1.1
	smat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	glow.material_override = smat
	glow.position = Vector3(0, dome_y + 0.05, 0)
	root.add_child(glow)
	# Cable runs (copper) down posts
	for sx in [-1.0, 1.0]:
		_add_cylinder(root, Vector3(sx * 0.55, 1.0, 0.35), 0.02, 1.4, COPPER.darkened(0.15), false, 0.35, true)
		_add_box(root, Vector3(sx * 0.55, 0.35, 0.2), Vector3(0.06, 0.06, 0.35), COPPER.darkened(0.1), false, 0.35)
		_add_cylinder(root, Vector3(sx * 0.55, 0.55, 0.35), 0.035, 0.04, BRASS, false, 0.3, true)
	# South hand-bracket (Rooke adjusts)
	_add_box(root, Vector3(0.0, 1.05, 0.82), Vector3(0.48, 0.14, 0.24), BRASS, true, 0.28)
	_add_box(root, Vector3(0.0, 0.78, 0.92), Vector3(0.1, 0.6, 0.1), BRASS.darkened(0.12), true, 0.3)
	_add_box(root, Vector3(0.0, 1.25, 0.96), Vector3(0.3, 0.08, 0.16), COPPER, false, 0.3)
	_add_cylinder(root, Vector3(0.0, 1.4, 0.98), 0.08, 0.14, COPPER.lightened(0.05), false, 0.3, true)
	_add_cylinder(root, Vector3(0.2, 1.05, 0.98), 0.1, 0.05, BRASS.lightened(0.1), false, 0.28, true)
	# Gauge bank (left) + valve wheel (right)
	_add_box(root, Vector3(-0.95, 0.85, 0.15), Vector3(0.28, 0.55, 0.35), oak_d, true, 0.5)
	for gi in 3:
		var gy := 0.65 + float(gi) * 0.18
		_add_cylinder(root, Vector3(-0.95, gy, 0.32), 0.06, 0.03, BRASS, false, 0.28, true)
		_add_cylinder(root, Vector3(-0.95, gy, 0.34), 0.045, 0.01, Color(0.85, 0.88, 0.8), false, 0.5)
	_add_box(root, Vector3(0.95, 0.7, 0.0), Vector3(0.3, 0.1, 0.38), oak, true, 0.5)
	_add_cylinder(root, Vector3(0.95, 0.95, 0.0), 0.12, 0.04, BRASS, false, 0.28, true)
	_add_box(root, Vector3(0.95, 0.95, 0.0), Vector3(0.22, 0.03, 0.03), BRASS.lightened(0.05), false, 0.28)
	_add_box(root, Vector3(0.95, 0.95, 0.0), Vector3(0.03, 0.03, 0.22), BRASS.lightened(0.05), false, 0.28)
	# Floor ring rail + brass studs
	_add_cylinder(root, Vector3(0, 0.38, 0), 0.85, 0.04, iron_frame, false, 0.45)
	for si in 8:
		var sang := float(si) * (TAU / 8.0)
		_add_cylinder(root, Vector3(cos(sang) * 0.82, 0.42, sin(sang) * 0.82), 0.025, 0.03, BRASS, false, 0.3, true)
	# Lights — loop 148: lower energy so pedestal/coils don't filmic-bloom white
	var warm := OmniLight3D.new()
	warm.light_color = Color(1.0, 0.8, 0.5)
	warm.light_energy = 0.42
	warm.omni_range = 4.0
	warm.position = Vector3(0.35, 1.2, 0.45)
	root.add_child(warm)
	var cool := OmniLight3D.new()
	cool.light_color = Color(0.55, 0.85, 1.0)
	cool.light_energy = 0.48
	cool.omni_range = 3.2
	cool.position = Vector3(0, height * 0.78, 0)
	root.add_child(cool)
	_add_contact_shadow(root, 0.95, 0.95)
	return root

static func _make_chalk_board(prop: Dictionary) -> Node3D:
	## Workshop / gallery slate — loop 122: bold high-contrast chalk plates (room-length read).
	var root := Node3D.new()
	root.name = "ChalkBoard"
	var seed0: int = int(prop.get("seed", 0))
	var w := 1.35 + float(seed0 % 3) * 0.08
	var h := 0.95 + float(seed0 % 2) * 0.08
	_add_box(root, Vector3(0, 1.2, 0), Vector3(w, h, 0.06), MAHOGANY_DARK, true, 0.45)
	# Frame lip (top/bottom + sides)
	_add_box(root, Vector3(0, 1.2 + h * 0.48, 0.02), Vector3(w - 0.04, 0.03, 0.04), MAHOGANY, false, 0.48)
	_add_box(root, Vector3(0, 1.2 - h * 0.48, 0.02), Vector3(w - 0.04, 0.03, 0.04), MAHOGANY, false, 0.48)
	_add_box(root, Vector3(-w * 0.48, 1.2, 0.02), Vector3(0.03, h - 0.06, 0.04), MAHOGANY, false, 0.48)
	_add_box(root, Vector3(w * 0.48, 1.2, 0.02), Vector3(0.03, h - 0.06, 0.04), MAHOGANY, false, 0.48)
	# Dark slate recess behind plate
	_add_box(root, Vector3(0, 1.2, 0.02), Vector3(w - 0.1, h - 0.1, 0.015), Color(0.08, 0.09, 0.08), false, 0.95)
	# Full-face chalk plate — loop 139: 4 unique dense plates (no clone equations/engine)
	var plate_paths := [
		"res://assets/rooms/textures/chalk/chalk_equations.jpg",
		"res://assets/rooms/textures/chalk/chalk_engine.jpg",
		"res://assets/rooms/textures/chalk/chalk_ledger.jpg",
		"res://assets/rooms/textures/chalk/chalk_wave.jpg",
	]
	var plate_path: String = plate_paths[seed0 % 4]
	var slate := MeshInstance3D.new()
	var slate_mesh := BoxMesh.new()
	slate_mesh.size = Vector3(w - 0.14, h - 0.14, 0.02)
	slate.mesh = slate_mesh
	var slate_mat := StandardMaterial3D.new()
	var plate_tex: Texture2D = _load_tex(plate_path)
	if plate_tex:
		slate_mat.albedo_texture = plate_tex
		slate_mat.uv1_scale = Vector3(1.0, 1.0, 1.0)
		# Loop 139: denser unique plates + strong room-length read
		slate_mat.albedo_color = Color(1.25, 1.25, 1.18)
		slate_mat.emission_enabled = true
		slate_mat.emission_texture = plate_tex
		slate_mat.emission = Color(0.82, 0.82, 0.76)
		slate_mat.emission_energy_multiplier = 0.62
		slate_mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	else:
		slate_mat.albedo_color = CHALK
		slate_mat.shading_mode = BaseMaterial3D.SHADING_MODE_PER_PIXEL
	slate_mat.roughness = 0.95
	slate.material_override = slate_mat
	slate.position = Vector3(0, 1.2, 0.04)
	root.add_child(slate)
	# Chalk rail + sticks
	_add_box(root, Vector3(0, 0.7, 0.05), Vector3(w - 0.1, 0.05, 0.1), MAHOGANY, false, 0.5)
	_add_cylinder(root, Vector3(-0.3, 0.76, 0.06), 0.012, 0.08, CREAM, false)
	_add_cylinder(root, Vector3(-0.15, 0.76, 0.05), 0.012, 0.07, CREAM.darkened(0.1), false)
	if seed0 % 2 == 0:
		_add_cylinder(root, Vector3(0.2, 0.76, 0.06), 0.012, 0.09, Color(0.85, 0.85, 0.8), false)
		_add_box(root, Vector3(0.4, 0.76, 0.05), Vector3(0.08, 0.02, 0.04), Color(0.55, 0.12, 0.1), false, 0.7)
	else:
		_add_cylinder(root, Vector3(0.15, 0.76, 0.06), 0.012, 0.08, Color(0.9, 0.88, 0.8), false)
		_add_cylinder(root, Vector3(0.3, 0.76, 0.05), 0.01, 0.06, CREAM, false)
	return root

# ─── Conservatory / hall ─────────────────────────────────────────────────────

static func _make_plant(prop: Dictionary) -> Node3D:
	## Painted plant card (loop 74 assets) + mesh frond bulk for side volume.
	## Card includes pot → no mesh_pot (avoids double terracotta).
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
			# FIXED_Y billboard faces camera; mesh fronds give side mass (no cross card pot)
			bp["face_camera"] = true
			bp["cross_planes"] = false
			var sc: float = float(prop.get("scale", 1.0))
			var ph: float = float(bp.get("height", 1.1 * sc))
			var pw: float = float(bp.get("width", 0.9 * sc))
			# Loop 169: floor plants below ~0.6h read as green scrap mid-FOV
			ph = clampf(ph, 0.68, 1.55)
			pw = clampf(pw, 0.55, 1.2)
			bp["height"] = ph
			bp["width"] = pw
			# Light sink — new assets are pot-to-crown, less empty padding
			bp["sink"] = clampf(0.06 + (1.2 - ph) * 0.04, 0.04, 0.18)
			bp["mesh_pot"] = false
			bp["col_size"] = [pw * 0.5, ph * 0.75, pw * 0.5]
			var root_plant := _make_billboard_prop(bp)
			_add_contact_shadow(root_plant, pw * 0.42, pw * 0.35)
			# Loop 74: denser mesh frond bulk ABOVE pot (~0.35*h) for walk-around sides
			_add_plant_mesh_fronds(root_plant, pw, ph, tex_path.find("fern") >= 0, int(prop.get("seed", 0)))
			return root_plant
	# Fallback full mesh plant — loop 140: fronds only, no sphere crown (cactus)
	var root := Node3D.new()
	root.name = "Plant"
	var scale: float = prop.get("scale", 1.0)
	var tall: bool = prop.get("tall", false)
	var leaf_a := Color(0.26, 0.46, 0.2)
	var leaf_b := Color(0.18, 0.36, 0.14)
	var leaf_c := Color(0.32, 0.5, 0.24)
	var stem_col := Color(0.2, 0.3, 0.12)
	_add_cylinder(root, Vector3(0, 0.18 * scale, 0), 0.2 * scale, 0.34 * scale, CLAY, true, 0.88)
	_add_cylinder(root, Vector3(0, 0.35 * scale, 0), 0.24 * scale, 0.05 * scale, CLAY.lightened(0.1), false, 0.88)
	_add_cylinder(root, Vector3(0, 0.37 * scale, 0), 0.17 * scale, 0.04 * scale, Color(0.16, 0.1, 0.06), false, 0.9)
	var stem_h := 0.42 * scale if tall else 0.22 * scale
	_add_cylinder(root, Vector3(0, 0.4 * scale + stem_h * 0.5, 0), 0.025 * scale, stem_h, stem_col, false, 0.9)
	var crown_y := 0.42 * scale + stem_h
	var n_f := 8 if tall else 6
	for i in n_f:
		var ang := float(i) * TAU / float(n_f)
		var bl := (0.28 if tall else 0.2) * scale
		var tip := Vector3(cos(ang) * bl * 0.55, crown_y + 0.08 * scale, sin(ang) * bl * 0.55)
		_add_box(root, tip, Vector3(bl, 0.02 * scale, 0.04 * scale), leaf_a if i % 2 == 0 else leaf_b, false, 0.92)
		_add_box(
			root,
			Vector3(cos(ang) * bl * 0.3, crown_y + 0.02 * scale, sin(ang) * bl * 0.3),
			Vector3(0.03 * scale, bl * 0.7, 0.025 * scale),
			leaf_c if i % 2 == 0 else leaf_a,
			false,
			0.9
		)
	_add_contact_shadow(root, 0.22 * scale, 0.22 * scale)
	return root


static func _add_plant_mesh_fronds(root: Node3D, pw: float, ph: float, is_fern: bool, seed0: int) -> void:
	## Loop 140: frond-only side volume — NO sphere crowns (cactus/mushroom read).
	## Flat ribbon leaves + thin stems for walk-around mass without ball tops.
	var pot_top := ph * 0.30
	var crown := ph * 0.78
	var leaf_a := Color(0.22, 0.42, 0.16)
	var leaf_b := Color(0.16, 0.36, 0.12)
	var leaf_c := Color(0.28, 0.48, 0.2)
	var stem_c := Color(0.28, 0.24, 0.12)
	var n_stems := 8 if is_fern else 7
	for i in n_stems:
		var ang := float(i) * (TAU / float(n_stems)) + float(seed0) * 0.41
		var r := pw * (0.06 + float(i % 3) * 0.02)
		var sx: float = cos(ang) * r
		var sz: float = sin(ang) * r
		var sh: float = (crown - pot_top) * (0.48 + float((i + seed0) % 4) * 0.1)
		_add_cylinder(root, Vector3(sx, pot_top + sh * 0.5, sz), 0.008 * pw + 0.005, sh, stem_c, false, 0.88)
		var tip_y: float = pot_top + sh
		if is_fern:
			# Arching pinnae: long thin horizontal leaflets stepped down the rachis
			for j in 5:
				var t := float(j) / 4.0
				var fang := ang + (float(j % 2) * 2.0 - 1.0) * (0.55 + t * 0.25)
				var fl := pw * (0.16 + (1.0 - t) * 0.08)
				var fy := tip_y - t * sh * 0.55
				_add_box(
					root,
					Vector3(sx + cos(fang) * fl * 0.42, fy, sz + sin(fang) * fl * 0.42),
					Vector3(fl, 0.012 * ph, 0.028 * pw),
					leaf_a if j % 2 == 0 else leaf_b,
					false,
					0.92
				)
				# Second leaflet opposite side of rachis
				var fang2 := fang + PI * 0.92
				_add_box(
					root,
					Vector3(sx + cos(fang2) * fl * 0.35, fy - 0.008 * ph, sz + sin(fang2) * fl * 0.35),
					Vector3(fl * 0.85, 0.01 * ph, 0.022 * pw),
					leaf_c if j % 2 == 0 else leaf_a,
					false,
					0.92
				)
		else:
			# Palm: drooping fronds (loop 141 — horizontal fans, not upright cactus sticks)
			for j in 5:
				var pang := ang + float(j - 2.0) * 0.28
				var bl := pw * (0.22 + float(j % 3) * 0.05)
				var drop := 0.02 * ph + float(j) * 0.018 * ph
				# Long leaflet mostly horizontal/splayed
				_add_box(
					root,
					Vector3(sx + cos(pang) * bl * 0.55, tip_y - drop, sz + sin(pang) * bl * 0.55),
					Vector3(bl * 0.95, 0.014 * ph, 0.03 * pw),
					leaf_c if j % 2 == 0 else leaf_a,
					false,
					0.9
				)
				# Slight mid-rib under leaf for thickness
				_add_box(
					root,
					Vector3(sx + cos(pang) * bl * 0.35, tip_y - drop - 0.01 * ph, sz + sin(pang) * bl * 0.35),
					Vector3(bl * 0.5, 0.01 * ph, 0.018 * pw),
					leaf_b,
					false,
					0.92
				)
	# Mid ring of thin blades (side volume, still leaf-shaped)
	for k in 10:
		var kang := float(k) * TAU / 10.0 + 0.15 + float(seed0 % 5) * 0.05
		var kr: float = pw * (0.16 + float(k % 3) * 0.035)
		var ky: float = pot_top + (crown - pot_top) * (0.3 + float(k % 4) * 0.12)
		var blade_len: float = pw * (0.12 + float(k % 2) * 0.04)
		_add_box(
			root,
			Vector3(cos(kang) * kr, ky, sin(kang) * kr),
			Vector3(blade_len, 0.014 * ph, 0.028 * pw),
			leaf_b if k % 2 == 0 else leaf_a,
			false,
			0.92
		)
	# Upper fan of flat leaflets (replaces sphere canopy — no cactus balls)
	for k in 6:
		var kang := float(k) * TAU / 6.0 + 0.4
		var kr: float = pw * 0.1
		var ky: float = crown * 0.88
		_add_box(
			root,
			Vector3(cos(kang) * kr, ky, sin(kang) * kr),
			Vector3(pw * 0.14, 0.012 * ph, 0.03 * pw),
			leaf_c if k % 2 == 0 else leaf_a,
			false,
			0.9
		)


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

static func _make_coat_stand(prop: Dictionary) -> Node3D:
	## Turned hall tree — seed forks coats / hats (uniqueness).
	var root := Node3D.new()
	root.name = "CoatStand"
	var seed0: int = int(prop.get("seed", 0))
	var wood := MAHOGANY if seed0 % 2 == 0 else MAHOGANY_DARK
	_add_cylinder(root, Vector3(0, 0.95, 0), 0.045, 1.85, wood, true, 0.45)
	_add_cylinder(root, Vector3(0, 0.35, 0), 0.07, 0.25, wood.darkened(0.1), true, 0.45)
	_add_cylinder(root, Vector3(0, 0.05, 0), 0.28, 0.08, wood, true, 0.45)
	for y in [0.55, 0.85, 1.25, 1.55]:
		_add_cylinder(root, Vector3(0, y, 0), 0.06, 0.04, wood.darkened(0.08), false, 0.4)
	for a in [0.0, 72.0, 144.0, 216.0, 288.0]:
		var rad := deg_to_rad(a + float(seed0) * 8.0)
		_add_box(root, Vector3(cos(rad) * 0.16, 1.62, sin(rad) * 0.16), Vector3(0.16, 0.025, 0.025), BRASS, false, 0.3)
		_add_cylinder(root, Vector3(cos(rad) * 0.22, 1.62, sin(rad) * 0.22), 0.02, 0.04, BRASS, false, 0.28, true)
	# Coat colours / count by seed
	var coat_a := Color(0.18, 0.14, 0.12) if seed0 % 3 != 1 else Color(0.12, 0.16, 0.22)
	var coat_b := Color(0.22, 0.12, 0.1) if seed0 % 3 != 2 else Color(0.28, 0.22, 0.14)
	_add_box(root, Vector3(0.14, 1.15, 0.06), Vector3(0.22, 0.85, 0.1), coat_a, false, 0.88)
	if seed0 % 2 == 0:
		_add_box(root, Vector3(-0.1, 1.05, -0.08), Vector3(0.18, 0.55, 0.08), coat_b, false, 0.88)
	# Hat: top hat vs bowler vs none
	if seed0 % 3 == 0:
		_add_cylinder(root, Vector3(0.05, 1.85, 0.05), 0.1, 0.04, Color(0.08, 0.08, 0.09), false, 0.7)
		_add_cylinder(root, Vector3(0.05, 1.95, 0.05), 0.07, 0.16, Color(0.1, 0.1, 0.11), false, 0.7)
	elif seed0 % 3 == 1:
		_add_cylinder(root, Vector3(-0.05, 1.88, -0.05), 0.09, 0.05, Color(0.12, 0.1, 0.08), false, 0.7)
		_add_cylinder(root, Vector3(-0.05, 1.95, -0.05), 0.07, 0.08, Color(0.14, 0.11, 0.09), false, 0.7)
	# Scarf drape / cane (seed-forked detail so stands read from doorway)
	if seed0 % 2 == 0:
		_add_box(root, Vector3(0.08, 1.35, -0.1), Vector3(0.12, 0.45, 0.04), Color(0.35, 0.12, 0.12), false, 0.85)
		_add_box(root, Vector3(0.1, 1.12, -0.12), Vector3(0.1, 0.08, 0.05), Color(0.4, 0.15, 0.14), false, 0.85)
	else:
		_add_cylinder(root, Vector3(-0.18, 0.85, 0.05), 0.015, 1.4, Color(0.22, 0.14, 0.08), false, 0.55)
		_add_sphere_blob(root, Vector3(-0.18, 1.55, 0.05), 0.03, Color(0.18, 0.12, 0.08))
	_add_contact_shadow(root, 0.32, 0.32)
	return root

static func _make_umbrella_stand(prop: Dictionary) -> Node3D:
	## Stick stand — seed forks ceramic / wood body + stick count.
	var root := Node3D.new()
	root.name = "UmbrellaStand"
	var seed0: int = int(prop.get("seed", 0))
	if seed0 % 2 == 0:
		_add_cylinder(root, Vector3(0, 0.32, 0), 0.15, 0.6, MAHOGANY_DARK, true, 0.45)
		_add_cylinder(root, Vector3(0, 0.62, 0), 0.17, 0.04, BRASS, false, 0.3, true)
		_add_cylinder(root, Vector3(0, 0.05, 0), 0.18, 0.06, MAHOGANY, true, 0.45)
	else:
		# Ceramic pot stand
		_add_cylinder(root, Vector3(0, 0.3, 0), 0.16, 0.55, CREAM.darkened(0.12), true, 0.75)
		_add_cylinder(root, Vector3(0, 0.58, 0), 0.18, 0.04, CREAM.darkened(0.05), false, 0.7)
		_add_cylinder(root, Vector3(0, 0.05, 0), 0.17, 0.05, CLAY, true, 0.8)
		_add_box(root, Vector3(0, 0.35, 0.16), Vector3(0.12, 0.08, 0.02), Color(0.45, 0.2, 0.15), false, 0.7)
	var n := 3 + seed0 % 2
	for i in n:
		var ang := float(i) * 0.9 + float(seed0) * 0.2
		var ox := cos(ang) * 0.05
		var oz := sin(ang) * 0.04
		var h := 0.5 + float((i + seed0) % 3) * 0.08
		var col := Color(0.2, 0.12, 0.08) if i % 2 == 0 else Color(0.12, 0.1, 0.1)
		_add_cylinder(root, Vector3(ox, 0.55 + h * 0.5, oz), 0.015 + float(i) * 0.002, h, col, false, 0.55)
	_add_box(root, Vector3(0.05, 1.28, 0.02), Vector3(0.1, 0.03, 0.03), Color(0.2, 0.12, 0.08), false, 0.55)
	_add_contact_shadow(root, 0.2, 0.2)
	return root

# ─── Features ────────────────────────────────────────────────────────────────

static func _make_chandelier(_prop: Dictionary) -> Node3D:
	## Loop 123 Victorian gasolier: brass rose + bowl + true tapered frosted shades
	## (not stacked white tube lamps).
	var root := Node3D.new()
	root.name = "Chandelier"
	var hang: float = float(_prop.get("hang", 2.95))
	var glass := Color(0.82, 0.72, 0.48)  # frosted amber, not pure white
	var glass_hi := Color(0.92, 0.84, 0.58)
	var iron_mid := Color(0.3, 0.3, 0.32)
	# Ceiling rose (plaster disc) + brass drop
	_add_cylinder(root, Vector3(0, hang + 0.32, 0), 0.18, 0.05, Color(0.88, 0.84, 0.76), false, 0.75)
	_add_cylinder(root, Vector3(0, hang + 0.28, 0), 0.1, 0.04, BRASS.darkened(0.08), false, 0.3, true)
	_add_cylinder(root, Vector3(0, hang + 0.12, 0), 0.02, 0.28, BRASS.darkened(0.05), false, 0.28, true)
	# Central font / reservoir (brass-heavy mass, not glass stack)
	_add_cylinder(root, Vector3(0, hang - 0.02, 0), 0.12, 0.06, BRASS.darkened(0.1), false, 0.3, true)
	_add_cylinder(root, Vector3(0, hang - 0.1, 0), 0.18, 0.1, BRASS, false, 0.28, true)
	_add_cylinder(root, Vector3(0, hang - 0.18, 0), 0.14, 0.05, BRASS.darkened(0.08), false, 0.3, true)
	_add_cylinder(root, Vector3(0, hang - 0.22, 0), 0.08, 0.04, BRASS.lightened(0.05), false, 0.28, true)
	# Six arms + inverted frosted cone shades
	for i in 6:
		var a := float(i) * 60.0
		var rad := deg_to_rad(a)
		var ax: float = cos(rad) * 0.38
		var az: float = sin(rad) * 0.38
		# Curved brass arm (outer segment lower)
		_add_box(root, Vector3(ax * 0.3, hang - 0.05, az * 0.3), Vector3(0.2, 0.035, 0.035), BRASS, false, 0.3)
		_add_box(root, Vector3(ax * 0.65, hang - 0.1, az * 0.65), Vector3(0.18, 0.03, 0.03), BRASS.darkened(0.06), false, 0.3)
		# Gas jet cup
		_add_cylinder(root, Vector3(ax, hang - 0.14, az), 0.045, 0.05, BRASS, false, 0.28, true)
		_add_cylinder(root, Vector3(ax, hang - 0.18, az), 0.06, 0.025, BRASS.darkened(0.1), false, 0.3, true)
		# True inverted cone shade (wide bottom, narrow top) via tapered mesh
		_add_tapered_cylinder(root, Vector3(ax, hang - 0.28, az), 0.035, 0.1, 0.16, glass, 0.42)
		_add_tapered_cylinder(root, Vector3(ax, hang - 0.26, az), 0.025, 0.07, 0.1, glass_hi, 0.4)
		# Dark iron gallery ring under shade
		_add_cylinder(root, Vector3(ax, hang - 0.36, az), 0.095, 0.02, iron_mid, false, 0.45)
		# Warm flame
		_add_sphere_blob(root, Vector3(ax, hang - 0.22, az), 0.028, Color(1.0, 0.78, 0.35))
	# Crystal drops under central bowl
	for j in 5:
		var ja := float(j) * 72.0 + 15.0
		var jr := deg_to_rad(ja)
		_add_box(root, Vector3(cos(jr) * 0.1, hang - 0.28, sin(jr) * 0.1), Vector3(0.018, 0.1, 0.018), Color(0.78, 0.8, 0.82), false, 0.35)
	var light := OmniLight3D.new()
	light.light_color = Color(1.0, 0.86, 0.58)
	light.light_energy = 1.15
	light.omni_range = 7.5
	light.position = Vector3(0, hang - 0.22, 0)
	root.add_child(light)
	return root


static func _add_tapered_cylinder(
	parent: Node3D,
	pos: Vector3,
	top_r: float,
	bot_r: float,
	height: float,
	color: Color,
	roughness: float = 0.5,
) -> void:
	## Cone / inverted-cone glass or metal (top_radius != bottom_radius).
	var mi := MeshInstance3D.new()
	var mesh := CylinderMesh.new()
	mesh.top_radius = top_r
	mesh.bottom_radius = bot_r
	mesh.height = height
	mesh.radial_segments = 12
	mi.mesh = mesh
	var mat := StandardMaterial3D.new()
	mat.albedo_color = color
	mat.roughness = roughness
	mat.metallic = 0.05 if color.v > 0.7 else 0.35
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_PER_PIXEL
	if color.a < 0.98:
		mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	mi.material_override = mat
	mi.position = pos
	parent.add_child(mi)


static func _make_fireplace(prop: Dictionary) -> Node3D:
	## Marble surround + firebox + seed mantel kit + fender/tools/overmantel (loop 144).
	var root := Node3D.new()
	root.name = "Fireplace"
	var seed0: int = int(prop.get("seed", 0))
	var grate_iron := Color(0.36, 0.36, 0.38)
	var iron_tool := Color(0.28, 0.28, 0.3)
	# Outer surround body + fielded lintel moulding stack
	_add_box(root, Vector3(0, 0.72, -0.05), Vector3(1.75, 1.45, 0.42), MARBLE, true, 0.35)
	_add_box(root, Vector3(0, 1.28, 0.1), Vector3(1.55, 0.06, 0.14), MARBLE.darkened(0.04), false, 0.32)
	_add_box(root, Vector3(0, 1.35, 0.1), Vector3(1.6, 0.08, 0.16), MARBLE.darkened(0.06), false, 0.32)
	# Inner dark firebox recess + arched lintel lip
	_add_box(root, Vector3(0, 0.55, 0.12), Vector3(0.95, 0.85, 0.28), Color(0.06, 0.05, 0.05), false, 0.9)
	_add_box(root, Vector3(0, 0.95, 0.2), Vector3(0.88, 0.06, 0.1), Color(0.1, 0.09, 0.09), false, 0.7)
	# Mantel shelf — deeper edge read from room
	_add_box(root, Vector3(0, 1.45, 0.02), Vector3(1.95, 0.1, 0.55), MARBLE, true, 0.3)
	_add_box(root, Vector3(0, 1.5, 0.05), Vector3(1.85, 0.03, 0.48), MARBLE.lightened(0.05), false, 0.3)
	_add_box(root, Vector3(0, 1.42, 0.22), Vector3(1.9, 0.04, 0.08), MARBLE.darkened(0.05), false, 0.32)
	# Loop 144: chimney-glass overmantel — silvered plate (period looking-glass above fire)
	_add_box(root, Vector3(0, 1.95, 0.0), Vector3(1.05, 0.85, 0.08), BRASS.darkened(0.08), false, 0.32)
	_add_box(root, Vector3(0, 1.95, 0.04), Vector3(0.92, 0.72, 0.04), BRASS.darkened(0.18), false, 0.35)
	_add_box(root, Vector3(0, 1.95, 0.055), Vector3(0.82, 0.62, 0.02), Color(0.14, 0.12, 0.1), false, 0.55)
	var om_plate := MeshInstance3D.new()
	var om_mesh := QuadMesh.new()
	om_mesh.size = Vector2(0.76, 0.56)
	om_plate.mesh = om_mesh
	var om_mat := StandardMaterial3D.new()
	var om_tex := _load_tex("res://assets/rooms/textures/victorian/mirror_plate.jpg")
	if om_tex:
		om_mat.albedo_texture = om_tex
		om_mat.albedo_color = Color(1.2, 1.18, 1.14)
		om_mat.emission_enabled = true
		om_mat.emission_texture = om_tex
		om_mat.emission = Color(0.55, 0.52, 0.48)
		om_mat.emission_energy_multiplier = 0.35
	else:
		om_mat.albedo_color = Color(0.65, 0.68, 0.66)
	om_mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	om_mat.cull_mode = BaseMaterial3D.CULL_DISABLED
	om_plate.material_override = om_mat
	om_plate.position = Vector3(0, 1.95, 0.07)
	root.add_child(om_plate)
	_add_unshaded_plate(root, Vector3(-0.18, 2.08, 0.075), Vector3(0.01, 0.16, 0.004), Color(0.88, 0.9, 0.92))
	_add_box(root, Vector3(0, 2.42, 0.02), Vector3(0.28, 0.1, 0.05), BRASS.lightened(0.05), false, 0.3)
	_add_cylinder(root, Vector3(0, 2.5, 0.03), 0.035, 0.04, BRASS, false, 0.28, true)
	# Loop 126/144 mantel ornaments — taller readable candlesticks / urns / clock
	match seed0 % 3:
		0:
			# Twin candlesticks + carriage clock
			for sx in [-0.58, 0.58]:
				_add_cylinder(root, Vector3(sx, 1.54, 0.08), 0.055, 0.035, MAHOGANY_DARK, false, 0.5)
				_add_cylinder(root, Vector3(sx, 1.62, 0.08), 0.03, 0.12, MAHOGANY, false, 0.48)
				_add_cylinder(root, Vector3(sx, 1.7, 0.08), 0.045, 0.025, BRASS.darkened(0.15), false, 0.35, true)
				_add_cylinder(root, Vector3(sx, 1.88, 0.08), 0.02, 0.28, CANDLE, false, 0.6)
				_add_sphere_blob(root, Vector3(sx, 2.04, 0.08), 0.03, Color(1.0, 0.75, 0.35))
			_add_box(root, Vector3(0, 1.6, 0.1), Vector3(0.22, 0.18, 0.12), Color(0.12, 0.1, 0.1), false, 0.4)
			_add_box(root, Vector3(0, 1.72, 0.12), Vector3(0.14, 0.12, 0.06), Color(0.88, 0.85, 0.78), false, 0.45)
			_add_box(root, Vector3(0, 1.8, 0.1), Vector3(0.18, 0.03, 0.1), BRASS.darkened(0.12), false, 0.35)
		1:
			# Twin urns + centre candlesticks with bases
			for sxu in [-0.55, 0.55]:
				_add_cylinder(root, Vector3(sxu, 1.56, 0.08), 0.055, 0.045, CREAM.darkened(0.15), false, 0.7)
				_add_cylinder(root, Vector3(sxu, 1.68, 0.08), 0.08, 0.2, CREAM.darkened(0.08), false, 0.7)
				_add_cylinder(root, Vector3(sxu, 1.8, 0.08), 0.05, 0.04, CREAM, false, 0.7)
			for sx2 in [-0.15, 0.15]:
				_add_cylinder(root, Vector3(sx2, 1.54, 0.1), 0.04, 0.03, MAHOGANY_DARK, false, 0.5)
				_add_cylinder(root, Vector3(sx2, 1.66, 0.1), 0.022, 0.2, CANDLE, false, 0.55)
				_add_sphere_blob(root, Vector3(sx2, 1.8, 0.1), 0.025, Color(1.0, 0.75, 0.35))
		_:
			# Carriage clock + small vases
			_add_box(root, Vector3(0.0, 1.62, 0.08), Vector3(0.2, 0.28, 0.12), BRASS.darkened(0.1), false, 0.32)
			_add_box(root, Vector3(0.0, 1.68, 0.12), Vector3(0.14, 0.14, 0.03), Color(0.9, 0.88, 0.8), false, 0.5)
			_add_box(root, Vector3(0.0, 1.8, 0.08), Vector3(0.16, 0.03, 0.1), BRASS.darkened(0.05), false, 0.32)
			_add_cylinder(root, Vector3(-0.52, 1.58, 0.08), 0.055, 0.18, Color(0.35, 0.2, 0.15), false, 0.7)
			_add_cylinder(root, Vector3(0.52, 1.58, 0.08), 0.055, 0.18, Color(0.35, 0.2, 0.15), false, 0.7)
	# Columns / pilasters with capital + plinth
	_add_box(root, Vector3(-0.72, 0.7, 0.12), Vector3(0.16, 1.25, 0.22), MARBLE, false, 0.32)
	_add_box(root, Vector3(0.72, 0.7, 0.12), Vector3(0.16, 1.25, 0.22), MARBLE, false, 0.32)
	_add_box(root, Vector3(-0.72, 1.3, 0.14), Vector3(0.22, 0.1, 0.26), MARBLE.darkened(0.04), false, 0.32)
	_add_box(root, Vector3(0.72, 1.3, 0.14), Vector3(0.22, 0.1, 0.26), MARBLE.darkened(0.04), false, 0.32)
	_add_box(root, Vector3(-0.72, 0.12, 0.14), Vector3(0.22, 0.12, 0.26), MARBLE.darkened(0.06), false, 0.35)
	_add_box(root, Vector3(0.72, 0.12, 0.14), Vector3(0.22, 0.12, 0.26), MARBLE.darkened(0.06), false, 0.35)
	# Hearth slab + ash lip
	_add_box(root, Vector3(0, 0.04, 0.35), Vector3(1.55, 0.08, 0.58), STONE, true, 0.55)
	_add_box(root, Vector3(0, 0.08, 0.38), Vector3(1.25, 0.03, 0.42), STONE.darkened(0.1), false, 0.6)
	# Loop 144: iron fender rail (hearth reads as hearth, not open hole)
	_add_box(root, Vector3(0, 0.16, 0.58), Vector3(1.35, 0.04, 0.05), grate_iron, false, 0.42)
	_add_box(root, Vector3(0, 0.28, 0.58), Vector3(1.3, 0.025, 0.035), grate_iron.lightened(0.08), false, 0.42)
	for fx in [-0.62, -0.2, 0.2, 0.62]:
		_add_cylinder(root, Vector3(fx, 0.22, 0.58), 0.018, 0.14, grate_iron.darkened(0.05), false, 0.45)
	_add_cylinder(root, Vector3(-0.68, 0.14, 0.58), 0.04, 0.08, grate_iron, false, 0.42)
	_add_cylinder(root, Vector3(0.68, 0.14, 0.58), 0.04, 0.08, grate_iron, false, 0.42)
	# Andirons (mid-grey iron so not pure black under filmic)
	for sx in [-1.0, 1.0]:
		_add_box(root, Vector3(sx * 0.3, 0.16, 0.3), Vector3(0.07, 0.22, 0.2), grate_iron, false, 0.45)
		_add_box(root, Vector3(sx * 0.3, 0.28, 0.22), Vector3(0.05, 0.08, 0.08), grate_iron.lightened(0.1), false, 0.45)
		_add_cylinder(root, Vector3(sx * 0.3, 0.1, 0.42), 0.03, 0.08, grate_iron.darkened(0.05), false, 0.45)
		_add_cylinder(root, Vector3(sx * 0.3, 0.32, 0.22), 0.02, 0.03, BRASS.darkened(0.2), false, 0.35, true)
	# Grate bars
	for i in 5:
		var gx := -0.32 + float(i) * 0.16
		_add_box(root, Vector3(gx, 0.2, 0.22), Vector3(0.025, 0.22, 0.04), grate_iron.darkened(0.08), false, 0.45)
	# Logs
	_add_box(root, Vector3(-0.12, 0.24, 0.2), Vector3(0.55, 0.1, 0.16), MAHOGANY_DARK, false, 0.7)
	_add_box(root, Vector3(0.15, 0.3, 0.22), Vector3(0.45, 0.09, 0.14), MAHOGANY, false, 0.7)
	_add_box(root, Vector3(0.0, 0.36, 0.18), Vector3(0.35, 0.08, 0.12), Color(0.25, 0.12, 0.06), false, 0.8)
	# Ash bed
	_add_box(root, Vector3(0, 0.14, 0.25), Vector3(0.7, 0.04, 0.28), Color(0.22, 0.18, 0.14), false, 0.85)
	# Loop 144: fire-tool stand + poker / shovel / tongs (right of hearth)
	_add_cylinder(root, Vector3(0.78, 0.08, 0.42), 0.08, 0.04, iron_tool, false, 0.5)
	_add_cylinder(root, Vector3(0.78, 0.35, 0.42), 0.018, 0.55, iron_tool.lightened(0.08), false, 0.48)
	_add_cylinder(root, Vector3(0.78, 0.65, 0.42), 0.1, 0.03, iron_tool, false, 0.5)
	# Poker
	_add_cylinder(root, Vector3(0.72, 0.42, 0.48), 0.01, 0.7, iron_tool.darkened(0.05), false, 0.45)
	_add_box(root, Vector3(0.72, 0.08, 0.48), Vector3(0.03, 0.04, 0.06), iron_tool, false, 0.45)
	_add_cylinder(root, Vector3(0.72, 0.78, 0.48), 0.022, 0.04, BRASS.darkened(0.15), false, 0.35, true)
	# Shovel
	_add_cylinder(root, Vector3(0.84, 0.4, 0.38), 0.01, 0.62, iron_tool.darkened(0.05), false, 0.45)
	_add_box(root, Vector3(0.84, 0.1, 0.38), Vector3(0.1, 0.02, 0.08), iron_tool, false, 0.45)
	_add_box(root, Vector3(0.84, 0.12, 0.34), Vector3(0.08, 0.04, 0.02), iron_tool.lightened(0.05), false, 0.45)
	_add_cylinder(root, Vector3(0.84, 0.72, 0.38), 0.02, 0.035, BRASS.darkened(0.15), false, 0.35, true)
	# Tongs (paired thin bars)
	_add_box(root, Vector3(0.78, 0.4, 0.5), Vector3(0.012, 0.55, 0.012), iron_tool, false, 0.45)
	_add_box(root, Vector3(0.82, 0.4, 0.5), Vector3(0.012, 0.55, 0.012), iron_tool, false, 0.45)
	_add_box(root, Vector3(0.8, 0.12, 0.5), Vector3(0.06, 0.02, 0.04), iron_tool.darkened(0.05), false, 0.45)
	# Coal scuttle (left of hearth)
	_add_cylinder(root, Vector3(-0.82, 0.18, 0.4), 0.14, 0.28, Color(0.22, 0.2, 0.18), false, 0.55)
	_add_cylinder(root, Vector3(-0.82, 0.34, 0.4), 0.15, 0.04, Color(0.28, 0.26, 0.24), false, 0.5)
	_add_box(root, Vector3(-0.82, 0.22, 0.52), Vector3(0.04, 0.12, 0.08), iron_tool, false, 0.48)
	_add_box(root, Vector3(-0.7, 0.12, 0.4), Vector3(0.12, 0.06, 0.1), Color(0.18, 0.14, 0.1), false, 0.75)
	# Loop 107: organic flame (spheres + tapered cylinders) — not flat yellow slabs
	var base_em := MeshInstance3D.new()
	var base_m := SphereMesh.new()
	base_m.radius = 0.22
	base_m.height = 0.18
	base_em.mesh = base_m
	var base_mat := StandardMaterial3D.new()
	base_mat.albedo_color = Color(1.0, 0.32, 0.06)
	base_mat.emission_enabled = true
	base_mat.emission = Color(1.0, 0.28, 0.04)
	base_mat.emission_energy_multiplier = 3.4
	base_mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	base_em.material_override = base_mat
	base_em.position = Vector3(0, 0.3, 0.3)
	root.add_child(base_em)
	# Flame tongues — tapered cylinders leaning outward
	for fi in 6:
		var em := MeshInstance3D.new()
		var em_mesh := CylinderMesh.new()
		var t := float(fi) / 5.0
		em_mesh.bottom_radius = 0.08 - t * 0.04
		em_mesh.top_radius = 0.02
		em_mesh.height = 0.22 + t * 0.2
		em.mesh = em_mesh
		var emat := StandardMaterial3D.new()
		var warm := Color(1.0, 0.4 + t * 0.45, 0.1 + t * 0.2)
		emat.albedo_color = warm
		emat.emission_enabled = true
		emat.emission = warm
		emat.emission_energy_multiplier = 3.6 - t * 0.5
		emat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		em.material_override = emat
		var ang := float(fi) * 0.9
		em.position = Vector3(cos(ang) * 0.1, 0.38 + t * 0.12, 0.28 + sin(ang) * 0.04)
		root.add_child(em)
	# Tip glow spheres
	for ti in 3:
		var tip := MeshInstance3D.new()
		var tm := SphereMesh.new()
		tm.radius = 0.045 - float(ti) * 0.008
		tm.height = tm.radius * 2.0
		tip.mesh = tm
		var tmat := StandardMaterial3D.new()
		tmat.albedo_color = Color(1.0, 0.85, 0.35)
		tmat.emission_enabled = true
		tmat.emission = Color(1.0, 0.8, 0.3)
		tmat.emission_energy_multiplier = 3.0
		tmat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		tip.material_override = tmat
		tip.position = Vector3(float(ti - 1) * 0.07, 0.55 + float(ti) * 0.04, 0.3)
		root.add_child(tip)
	# Coal embers (small spheres)
	for ei in 5:
		var ember := MeshInstance3D.new()
		var ems := SphereMesh.new()
		ems.radius = 0.03
		ems.height = 0.05
		ember.mesh = ems
		var emat2 := StandardMaterial3D.new()
		emat2.albedo_color = Color(1.0, 0.22, 0.04)
		emat2.emission_enabled = true
		emat2.emission = Color(1.0, 0.18, 0.0)
		emat2.emission_energy_multiplier = 2.6
		emat2.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		ember.material_override = emat2
		ember.position = Vector3(-0.22 + float(ei) * 0.11, 0.2, 0.28)
		root.add_child(ember)
	var fire := OmniLight3D.new()
	fire.light_color = Color(1.0, 0.55, 0.25)
	fire.light_energy = 1.95
	fire.omni_range = 6.8
	fire.position = Vector3(0, 0.55, 0.45)
	root.add_child(fire)
	# Loop 132: rising ember sparks
	_add_fire_sparks(root, Vector3(0, 0.35, 0.32), 14)
	_add_contact_shadow(root, 1.05, 0.65)
	return root

static func _add_fire_sparks(parent: Node3D, at: Vector3, amount: int = 12) -> void:
	## Lightweight rising ember particles for hearth/range (loop 132).
	var parts := GPUParticles3D.new()
	parts.amount = amount
	parts.lifetime = 1.4
	parts.explosiveness = 0.05
	parts.randomness = 0.65
	parts.position = at
	parts.visibility_aabb = AABB(Vector3(-0.5, -0.1, -0.4), Vector3(1.0, 1.6, 0.8))
	var mesh := SphereMesh.new()
	mesh.radius = 0.012
	mesh.height = 0.024
	mesh.radial_segments = 6
	mesh.rings = 3
	var mat := StandardMaterial3D.new()
	mat.albedo_color = Color(1.0, 0.55, 0.15)
	mat.emission_enabled = true
	mat.emission = Color(1.0, 0.45, 0.1)
	mat.emission_energy_multiplier = 2.8
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	mesh.material = mat
	parts.draw_pass_1 = mesh
	var proc := ParticleProcessMaterial.new()
	proc.direction = Vector3(0, 1, 0)
	proc.spread = 28.0
	proc.initial_velocity_min = 0.25
	proc.initial_velocity_max = 0.75
	proc.gravity = Vector3(0, 0.15, 0)
	proc.damping_min = 0.4
	proc.damping_max = 1.0
	proc.scale_min = 0.4
	proc.scale_max = 1.2
	proc.color = Color(1.0, 0.6, 0.2, 0.9)
	parts.process_material = proc
	parts.emitting = true
	parent.add_child(parts)

static func _make_dust_motes(prop: Dictionary) -> Node3D:
	## Soft floating dust in sunbeams (loop 136) — low-count, unshaded pale motes.
	var root := Node3D.new()
	root.name = "DustMotes"
	var amount: int = int(prop.get("amount", 28))
	var parts := GPUParticles3D.new()
	parts.amount = amount
	parts.lifetime = 8.0
	parts.preprocess = 4.0
	parts.explosiveness = 0.0
	parts.randomness = 0.9
	parts.visibility_aabb = AABB(Vector3(-3, 0, -3), Vector3(6, 4, 6))
	var mesh := SphereMesh.new()
	mesh.radius = 0.008
	mesh.height = 0.016
	mesh.radial_segments = 4
	mesh.rings = 2
	var mat := StandardMaterial3D.new()
	mat.albedo_color = Color(0.95, 0.92, 0.82, 0.55)
	mat.emission_enabled = true
	mat.emission = Color(0.9, 0.88, 0.78)
	mat.emission_energy_multiplier = 0.35
	mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	mesh.material = mat
	parts.draw_pass_1 = mesh
	var proc := ParticleProcessMaterial.new()
	proc.emission_shape = ParticleProcessMaterial.EMISSION_SHAPE_BOX
	proc.emission_box_extents = Vector3(2.2, 1.2, 2.2)
	proc.direction = Vector3(0.1, 0.2, 0.05)
	proc.spread = 180.0
	proc.initial_velocity_min = 0.02
	proc.initial_velocity_max = 0.08
	proc.gravity = Vector3(0, 0.02, 0)
	proc.damping_min = 0.1
	proc.damping_max = 0.4
	proc.scale_min = 0.3
	proc.scale_max = 1.1
	proc.color = Color(1.0, 0.97, 0.9, 0.45)
	parts.process_material = proc
	parts.emitting = true
	parts.position = Vector3(0, 1.4, 0)
	root.add_child(parts)
	return root

static func _make_window(feat: Dictionary) -> Node3D:
	## Sash-style window with OUTSIDE view through a hollow aperture.
	## CRITICAL: never fill the aperture with a solid box — that reads as black/void.
	## View plate sits in the opening (unshaded garden/yard/sky). Never room photos.
	var root := Node3D.new()
	root.name = "Window"
	var pos: Array = feat.get("pos", [0, 0, 0])
	root.position = Vector3(pos[0], pos[1], pos[2])
	root.rotation_degrees.y = feat.get("yaw", 0.0)
	var w: float = feat.get("width", 1.1)
	var h: float = feat.get("height", 1.85)
	var seed0: int = int(feat.get("seed", int(absf(pos[0] * 10.0 + pos[2] * 3.0))))
	var frame_d := 0.12
	var stile := 0.07
	# Hollow frame: four stiles/rails only (open aperture for exterior plate)
	_add_box(root, Vector3(-w * 0.5, h * 0.5, 0), Vector3(stile, h, frame_d), MAHOGANY, true, 0.38)
	_add_box(root, Vector3(w * 0.5, h * 0.5, 0), Vector3(stile, h, frame_d), MAHOGANY, true, 0.38)
	_add_box(root, Vector3(0, h - stile * 0.5, 0), Vector3(w, stile, frame_d), MAHOGANY, true, 0.38)
	_add_box(root, Vector3(0, stile * 0.5, 0), Vector3(w, stile, frame_d), MAHOGANY, true, 0.38)
	# Architrave + deep sill (period sash)
	_add_box(root, Vector3(0, h + 0.04, 0.02), Vector3(w + 0.18, 0.08, 0.16), MAHOGANY_DARK, false, 0.4)
	_add_box(root, Vector3(0, 0.02, 0.1), Vector3(w + 0.22, 0.07, 0.24), MAHOGANY, false, 0.42)
	# Mullion cross (thin — must not hide exterior)
	_add_box(root, Vector3(0, h * 0.5, 0.03), Vector3(0.045, h - stile * 2.0, 0.04), MAHOGANY_DARK, false, 0.4)
	_add_box(root, Vector3(0, h * 0.5, 0.03), Vector3(w - stile * 2.0, 0.045, 0.04), MAHOGANY_DARK, false, 0.4)
	# Exterior view plate in the open aperture (both faces, unshaded so never void-black)
	var view_path: String = str(feat.get("view", ""))
	if view_path == "" or view_path.find("richmond_") >= 0 or view_path.find("wallpaper_") >= 0:
		view_path = VIEW_EXTERIORS[seed0 % VIEW_EXTERIORS.size()]
	var view_mi := MeshInstance3D.new()
	var vm := QuadMesh.new()
	vm.size = Vector2(w - stile * 1.6, h - stile * 1.6)
	view_mi.mesh = vm
	var vmat := StandardMaterial3D.new()
	var vtex := _load_tex(view_path)
	if vtex:
		vmat.albedo_texture = vtex
		vmat.albedo_color = Color(1.05, 1.05, 1.0)  # slight lift so green/sky read
	else:
		# Procedural sky+lawn fallback if texture missing
		vmat.albedo_color = Color(0.42, 0.62, 0.38)
	vmat.roughness = 1.0
	vmat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	vmat.cull_mode = BaseMaterial3D.CULL_DISABLED
	view_mi.material_override = vmat
	# Loop 83: view plate on room side of wall (+Z) so facade never occludes to black
	# Loop 91: do not paint sky/lawn bands over the painted exterior plate
	view_mi.position = Vector3(0, h * 0.5, 0.02)
	root.add_child(view_mi)
	# Very thin cool glass (alpha low) — never solid black
	var gmat := StandardMaterial3D.new()
	gmat.albedo_color = Color(0.82, 0.92, 0.98, 0.1)
	gmat.metallic = 0.05
	gmat.roughness = 0.05
	gmat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	gmat.cull_mode = BaseMaterial3D.CULL_DISABLED
	for ox in [-1.0, 1.0]:
		for oy in [0.72, 0.28]:
			var pane := MeshInstance3D.new()
			var pm := BoxMesh.new()
			pm.size = Vector3((w - stile * 2.2) * 0.42, (h - stile * 2.2) * 0.42, 0.008)
			pane.mesh = pm
			pane.material_override = gmat
			pane.position = Vector3(ox * w * 0.2, h * oy, 0.06)
			root.add_child(pane)
	# Soft outdoor fill (daylight through sash)
	var fill := OmniLight3D.new()
	fill.light_color = Color(0.85, 0.92, 1.0)
	fill.light_energy = 0.65
	fill.omni_range = 4.2
	fill.position = Vector3(0, h * 0.55, 0.45)
	root.add_child(fill)
	# Loop 106: period drapery (drawing/morning/gallery) — soft panels, not modern blinds
	if bool(feat.get("curtains", false)):
		var drape: Color = feat.get("curtain_color", Color(0.38, 0.28, 0.22))
		var drape_d := drape.darkened(0.12)
		var drape_l := drape.lightened(0.08)
		# Pelmet / cornice box
		_add_box(root, Vector3(0, h + 0.02, 0.14), Vector3(w + 0.28, 0.1, 0.12), MAHOGANY_DARK, false, 0.45)
		_add_box(root, Vector3(0, h - 0.02, 0.16), Vector3(w + 0.22, 0.04, 0.08), drape_d, false, 0.85)
		# Side panels (parted, revealing view)
		for sx in [-1.0, 1.0]:
			var px: float = sx * (w * 0.38)
			_add_box(root, Vector3(px, h * 0.48, 0.12), Vector3(w * 0.22, h * 0.88, 0.06), drape, false, 0.88)
			# Soft fold ridges
			_add_box(root, Vector3(px + sx * 0.04, h * 0.48, 0.14), Vector3(0.03, h * 0.82, 0.04), drape_d, false, 0.9)
			_add_box(root, Vector3(px - sx * 0.05, h * 0.45, 0.14), Vector3(0.025, h * 0.75, 0.035), drape_l, false, 0.9)
			# Tie-back / rope
			_add_cylinder(root, Vector3(px, h * 0.35, 0.18), 0.02, 0.08, BRASS.darkened(0.15), false, 0.4, true)
			_add_box(root, Vector3(px + sx * 0.06, h * 0.35, 0.16), Vector3(0.1, 0.025, 0.03), drape_d, false, 0.85)
		# Pool / puddle of fabric on sill
		_add_box(root, Vector3(-w * 0.35, 0.08, 0.14), Vector3(0.18, 0.06, 0.1), drape_d, false, 0.88)
		_add_box(root, Vector3(w * 0.35, 0.08, 0.14), Vector3(0.18, 0.06, 0.1), drape_d, false, 0.88)
	return root

static func _make_glass_wall(feat: Dictionary) -> Node3D:
	## Conservatory iron-framed glass. Loop 91/140: painted garden plate is the exterior
	## (never black void). View plate is unshaded+emission; glass does NOT depth-write.
	var root := Node3D.new()
	root.name = "GlassWall"
	var pos: Array = feat.get("pos", [0, 0, 0])
	root.position = Vector3(pos[0], pos[1], pos[2])
	root.rotation_degrees.y = feat.get("yaw", 0.0)
	var w: float = feat.get("width", 2.5)
	var h: float = feat.get("height", 3.2)
	var seed0: int = int(feat.get("seed", int(absf(float(pos[0]) * 5.0 + float(pos[2]) * 3.0))))
	# --- Garden exterior plate (unshaded + emission) — must never read as void black ---
	var view_path: String = str(feat.get("view", VIEW_EXTERIORS[seed0 % VIEW_EXTERIORS.size()]))
	if view_path == "" or view_path.find("night") >= 0:
		view_path = "res://assets/rooms/textures/views/view_garden.jpg"
	var view_mi := MeshInstance3D.new()
	var vm := QuadMesh.new()
	vm.size = Vector2(w - 0.08, h - 0.08)
	view_mi.mesh = vm
	var vmat := StandardMaterial3D.new()
	var vtex := _load_tex(view_path)
	if vtex:
		vmat.albedo_texture = vtex
		vmat.albedo_color = Color(1.12, 1.14, 1.08)
		vmat.emission_enabled = true
		vmat.emission_texture = vtex
		vmat.emission = Color(0.55, 0.58, 0.5)
		vmat.emission_energy_multiplier = 0.35
	else:
		vmat.albedo_color = Color(0.48, 0.65, 0.42)
		vmat.emission_enabled = true
		vmat.emission = Color(0.35, 0.48, 0.3)
		vmat.emission_energy_multiplier = 0.4
	vmat.roughness = 1.0
	vmat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	vmat.cull_mode = BaseMaterial3D.CULL_DISABLED
	vmat.depth_draw_mode = BaseMaterial3D.DEPTH_DRAW_OPAQUE_ONLY
	vmat.render_priority = 1
	view_mi.material_override = vmat
	# Plate on room side of wall (+Z) so facade never occludes to black
	view_mi.position = Vector3(0, h * 0.5, 0.02)
	root.add_child(view_mi)
	# Subtle sill ledge only
	_add_box(root, Vector3(0, 0.06, 0.08), Vector3(w - 0.1, 0.08, 0.12), STONE.darkened(0.05), false, 0.7)
	# Brass glazing bar caps
	for sx in [-1.0, 1.0]:
		for sy in [0.08, h - 0.08]:
			_add_box(root, Vector3(sx * (w * 0.5 - 0.05), sy, 0.14), Vector3(0.08, 0.06, 0.06), BRASS.darkened(0.1), false, 0.35)
	# Perimeter iron (mid-grey)
	var bar := 0.07
	var frame_iron := Color(0.34, 0.34, 0.36)
	_add_box(root, Vector3(0, bar * 0.5, 0.1), Vector3(w, bar, 0.09), frame_iron, true, 0.45)
	_add_box(root, Vector3(0, h - bar * 0.5, 0.1), Vector3(w, bar, 0.09), frame_iron, true, 0.45)
	_add_box(root, Vector3(-w * 0.5 + bar * 0.5, h * 0.5, 0.1), Vector3(bar, h, 0.09), frame_iron, true, 0.45)
	_add_box(root, Vector3(w * 0.5 - bar * 0.5, h * 0.5, 0.1), Vector3(bar, h, 0.09), frame_iron, true, 0.45)
	# Mullion grid
	for i in 4:
		var fx2 := -w * 0.35 + float(i) * (w * 0.23)
		_add_box(root, Vector3(fx2, h * 0.5, 0.11), Vector3(0.035, h - 0.14, 0.04), frame_iron.lightened(0.08), false, 0.45)
	for j in 3:
		var fy := h * 0.22 * float(j + 1)
		_add_box(root, Vector3(0, fy, 0.11), Vector3(w - 0.14, 0.035, 0.04), frame_iron.lightened(0.08), false, 0.45)
	# Very light glass tint — NO depth write (loop 140: DEPTH_DRAW_ALWAYS could black out plates)
	var glass := MeshInstance3D.new()
	var gm := BoxMesh.new()
	gm.size = Vector3(w - 0.14, h - 0.14, 0.01)
	glass.mesh = gm
	var gmat := StandardMaterial3D.new()
	gmat.albedo_color = Color(0.78, 0.88, 0.92, 0.08)
	gmat.metallic = 0.05
	gmat.roughness = 0.06
	gmat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	gmat.cull_mode = BaseMaterial3D.CULL_DISABLED
	gmat.depth_draw_mode = BaseMaterial3D.DEPTH_DRAW_DISABLED
	glass.material_override = gmat
	glass.position = Vector3(0, h * 0.5, 0.12)
	root.add_child(glass)
	var fill := OmniLight3D.new()
	fill.light_color = Color(0.82, 0.94, 0.98)
	fill.light_energy = 0.75
	fill.omni_range = 5.5
	fill.position = Vector3(0, h * 0.55, 0.6)
	root.add_child(fill)
	return root

static func _make_door_frame(feat: Dictionary) -> Node3D:
	## Mid-Victorian 4-panel door + architrave + brass furniture (c.1850s).
	## seed forks wood tone (reception mahogany vs service oak) for uniqueness.
	## Root sits on floor at doorway center (ignores feature y so doors don't float).
	var root := Node3D.new()
	root.name = "DoorFrame"
	var pos: Array = feat.get("pos", [0, 0, 0])
	root.position = Vector3(float(pos[0]), 0.0, float(pos[2]))
	root.rotation_degrees.y = feat.get("yaw", 0.0)
	var w: float = feat.get("width", 1.5)
	var h: float = feat.get("height", 2.35)
	var seed0: int = int(feat.get("seed", int(absf(float(pos[0]) * 7.0 + float(pos[2]) * 3.0))))
	var depth := 0.18
	# Wood tone by seed — not every door the same brown slab
	var door_wood: Color
	var door_frame_col: Color
	var panel_field: Color
	var case_col: Color
	match seed0 % 3:
		0:  # polished mahogany (drawing / gallery)
			door_wood = Color(0.42, 0.28, 0.16)
			door_frame_col = Color(0.34, 0.22, 0.12)
			panel_field = Color(0.36, 0.24, 0.14)
			case_col = MAHOGANY
		1:  # darker ebony-mahogany (hall)
			door_wood = Color(0.28, 0.16, 0.1)
			door_frame_col = Color(0.2, 0.12, 0.07)
			panel_field = Color(0.24, 0.14, 0.09)
			case_col = MAHOGANY_DARK
		_:  # oak service (kitchen / workshop)
			door_wood = Color(0.5, 0.36, 0.2)
			door_frame_col = Color(0.4, 0.28, 0.15)
			panel_field = Color(0.45, 0.32, 0.18)
			case_col = OAK
	# Outer architrave (doorcase)
	_add_box(root, Vector3(-w * 0.5 - 0.06, h * 0.5, 0), Vector3(0.14, h + 0.08, depth + 0.06), door_frame_col, true, 0.4)
	_add_box(root, Vector3(w * 0.5 + 0.06, h * 0.5, 0), Vector3(0.14, h + 0.08, depth + 0.06), door_frame_col, true, 0.4)
	_add_box(root, Vector3(0, h + 0.05, 0), Vector3(w + 0.34, 0.14, depth + 0.08), case_col, true, 0.4)
	# Inner stop mould
	_add_box(root, Vector3(-w * 0.5 + 0.02, h * 0.5, 0.06), Vector3(0.04, h - 0.05, 0.04), case_col, false, 0.45)
	_add_box(root, Vector3(w * 0.5 - 0.02, h * 0.5, 0.06), Vector3(0.04, h - 0.05, 0.04), case_col, false, 0.45)
	# Threshold / saddle (loop 98: dark kick so oak doors don't "float" on bright stone)
	_add_box(root, Vector3(0, 0.025, 0.02), Vector3(w + 0.18, 0.05, depth + 0.24), STONE.darkened(0.1), true, 0.7)
	_add_box(root, Vector3(0, 0.055, 0.02), Vector3(w + 0.12, 0.04, depth + 0.14), door_frame_col, false, 0.45)
	# Continuous dark kick under leaf (closes light gap under pale oak doors)
	_add_box(root, Vector3(0, 0.04, 0.05), Vector3(w - 0.06, 0.08, 0.1), door_wood.darkened(0.12), true, 0.45)
	# Loop 167: warm under-leaf glow (next room light leak — not closet void)
	var glow := MeshInstance3D.new()
	glow.name = "DoorLightLeak"
	var gmesh := BoxMesh.new()
	gmesh.size = Vector3(w * 0.7, 0.016, 0.04)
	glow.mesh = gmesh
	var gmat := StandardMaterial3D.new()
	gmat.albedo_color = Color(1.0, 0.78, 0.45, 0.8)
	gmat.emission_enabled = true
	gmat.emission = Color(1.0, 0.72, 0.35)
	gmat.emission_energy_multiplier = 1.2
	gmat.roughness = 0.6
	glow.material_override = gmat
	glow.position = Vector3(0, 0.03, 0.08)
	root.add_child(glow)
	# Overdoor cornice (formal entrance read)
	_add_box(root, Vector3(0, h + 0.12, 0.02), Vector3(w + 0.28, 0.08, depth + 0.1), case_col, false, 0.42)
	_add_box(root, Vector3(0, h + 0.18, 0.04), Vector3(w * 0.4, 0.05, 0.08), BRASS.darkened(0.2), false, 0.32)
	# Jamb feet — ground the case into the threshold
	_add_box(root, Vector3(-w * 0.5 - 0.06, 0.04, 0), Vector3(0.18, 0.12, depth + 0.1), door_frame_col, true, 0.4)
	_add_box(root, Vector3(w * 0.5 + 0.06, 0.04, 0), Vector3(0.18, 0.12, depth + 0.1), door_frame_col, true, 0.4)
	# --- Door leaf CLOSED (E teleports; do not leave walk-into-void gap) ---
	# Leaf bottom at y≈0.04 so it meets the dark kick / saddle
	var leaf_w := w - 0.1
	var leaf_h := h - 0.05
	var leaf := Node3D.new()
	leaf.name = "DoorLeaf"
	leaf.position = Vector3(-w * 0.5 + 0.05, 0.04, 0.04)
	leaf.rotation_degrees.y = 0.0  # closed — room change is interact/teleport only
	root.add_child(leaf)
	# solid=true so player cannot walk through the closed leaf into void
	_add_box(leaf, Vector3(leaf_w * 0.5, leaf_h * 0.5, 0), Vector3(leaf_w, leaf_h, 0.048), door_wood, true, 0.42)
	# Bottom kick rail on leaf itself
	_add_box(leaf, Vector3(leaf_w * 0.5, 0.04, 0.02), Vector3(leaf_w * 0.98, 0.08, 0.04), door_frame_col, false, 0.42)
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
	# Loop 125: brass mortice set — plate + round knob + keyhole escutcheon (reads at distance)
	var knob_x := leaf_w - 0.16
	var knob_y := mid_rail_y + 0.1
	_add_box(leaf, Vector3(knob_x, knob_y - 0.02, 0.04), Vector3(0.1, 0.18, 0.02), BRASS.darkened(0.18), false, 0.3)
	_add_box(leaf, Vector3(knob_x, knob_y - 0.02, 0.05), Vector3(0.08, 0.14, 0.012), BRASS.darkened(0.08), false, 0.28)
	_add_cylinder(leaf, Vector3(knob_x, knob_y, 0.06), 0.05, 0.02, BRASS, false, 0.28, true)
	_add_cylinder(leaf, Vector3(knob_x, knob_y, 0.09), 0.04, 0.06, BRASS.lightened(0.08), false, 0.25, true)
	_add_cylinder(leaf, Vector3(knob_x, knob_y, 0.13), 0.025, 0.03, BRASS.darkened(0.1), false, 0.28, true)
	# Keyhole plate below knob
	_add_box(leaf, Vector3(knob_x, knob_y - 0.12, 0.055), Vector3(0.055, 0.1, 0.018), BRASS, false, 0.28)
	_add_box(leaf, Vector3(knob_x, knob_y - 0.12, 0.065), Vector3(0.02, 0.05, 0.01), Color(0.12, 0.1, 0.08), false, 0.6)
	# Three butt hinges on hinge stile
	for hy in [0.28, leaf_h * 0.5, leaf_h - 0.32]:
		_add_box(leaf, Vector3(0.035, hy, 0.045), Vector3(0.06, 0.18, 0.04), BRASS.darkened(0.05), false, 0.32)
		_add_box(leaf, Vector3(0.035, hy, 0.06), Vector3(0.03, 0.12, 0.02), BRASS.lightened(0.05), false, 0.3)
	return root

static func _make_mirror(feat: Dictionary) -> Node3D:
	## Victorian looking-glass (loop 133): full painterly silvered plate (hall reflection),
	## ornate gilt frame only — NO dark silhouette blocks over the plate.
	var root := Node3D.new()
	root.name = "Mirror"
	var pos: Array = feat.get("pos", [0, 0, 0])
	root.position = Vector3(pos[0], pos[1], pos[2])
	root.rotation_degrees.y = feat.get("yaw", 0.0)
	var w: float = float(feat.get("width", 1.05))
	var h: float = float(feat.get("height", 1.45))
	# Ornate gilt frame + dark liner
	_add_box(root, Vector3(0, 0, 0.04), Vector3(w + 0.14, h + 0.14, 0.1), BRASS, true, 0.32)
	_add_box(root, Vector3(0, 0, 0.07), Vector3(w + 0.06, h + 0.06, 0.05), BRASS.darkened(0.12), false, 0.35)
	_add_box(root, Vector3(0, 0, 0.085), Vector3(w - 0.06, h - 0.06, 0.03), Color(0.16, 0.1, 0.07), false, 0.55)
	# Inner gold bead around aperture
	_add_box(root, Vector3(0, 0, 0.095), Vector3(w - 0.1, h - 0.1, 0.012), BRASS.lightened(0.08), false, 0.3)
	# Crest + corner bosses
	_add_box(root, Vector3(0, h * 0.5 + 0.09, 0.06), Vector3(0.32, 0.15, 0.055), BRASS.lightened(0.1), false, 0.3)
	_add_box(root, Vector3(0, h * 0.5 + 0.16, 0.06), Vector3(0.14, 0.08, 0.04), BRASS, false, 0.3)
	_add_cylinder(root, Vector3(0, h * 0.5 + 0.2, 0.07), 0.04, 0.03, BRASS.lightened(0.12), false, 0.28, true)
	for sx in [-1.0, 1.0]:
		for sy in [-1.0, 1.0]:
			_add_box(root, Vector3(sx * (w * 0.5), sy * (h * 0.5), 0.07), Vector3(0.1, 0.1, 0.045), BRASS.lightened(0.05), false, 0.3)
	# Silvered plate — loop 141: cleaner asset + stronger room-length silver read
	var glass := MeshInstance3D.new()
	var gm := QuadMesh.new()
	gm.size = Vector2(w - 0.16, h - 0.16)
	glass.mesh = gm
	var gmat := StandardMaterial3D.new()
	var plate_tex := _load_tex("res://assets/rooms/textures/victorian/mirror_plate.jpg")
	if plate_tex:
		gmat.albedo_texture = plate_tex
		gmat.albedo_color = Color(1.28, 1.26, 1.22)
		gmat.emission_enabled = true
		gmat.emission_texture = plate_tex
		gmat.emission = Color(0.72, 0.7, 0.65)
		gmat.emission_energy_multiplier = 0.48
	else:
		gmat.albedo_color = Color(0.72, 0.74, 0.72)
		gmat.emission_enabled = true
		gmat.emission = Color(0.45, 0.48, 0.45)
		gmat.emission_energy_multiplier = 0.35
	gmat.roughness = 0.22
	gmat.metallic = 0.75
	gmat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	gmat.cull_mode = BaseMaterial3D.CULL_DISABLED
	glass.material_override = gmat
	glass.position = Vector3(0, 0, 0.108)
	root.add_child(glass)
	# Soft specular catch — short silver glints only
	_add_unshaded_plate(root, Vector3(-w * 0.2, h * 0.2, 0.112), Vector3(0.012, h * 0.16, 0.002), Color(0.88, 0.9, 0.92))
	_add_unshaded_plate(root, Vector3(w * 0.18, -h * 0.12, 0.112), Vector3(0.01, h * 0.1, 0.002), Color(0.8, 0.82, 0.84))
	var catch_l := OmniLight3D.new()
	catch_l.light_color = Color(0.95, 0.98, 1.0)
	catch_l.light_energy = 0.55
	catch_l.omni_range = 2.2
	catch_l.position = Vector3(0.1, 0.12, 0.45)
	root.add_child(catch_l)
	return root


static func _add_unshaded_plate(parent: Node3D, pos: Vector3, size: Vector3, color: Color) -> void:
	## Flat unshaded panel for mirror reflection paint (bypasses wood/metal auto-tex).
	var mi := MeshInstance3D.new()
	var mesh := BoxMesh.new()
	mesh.size = size
	mi.mesh = mesh
	var mat := StandardMaterial3D.new()
	mat.albedo_color = color
	mat.roughness = 1.0
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	mat.cull_mode = BaseMaterial3D.CULL_DISABLED
	mi.material_override = mat
	mi.position = pos
	parent.add_child(mi)

static func _make_painting(feat: Dictionary) -> Node3D:
	## Gilt/wood-frame oil: landscape / still life / botanical / portrait —
	## NEVER a room photo (reads as windows or nonsense mirrors).
	## Frame style forks by seed: ornate gilt · mahogany · ebony · dark gilt.
	var root := Node3D.new()
	root.name = "Painting"
	var pos: Array = feat.get("pos", [0, 0, 0])
	root.position = Vector3(pos[0], pos[1], pos[2])
	root.rotation_degrees.y = feat.get("yaw", 0.0)
	var w: float = feat.get("width", 0.85)
	var h: float = feat.get("height", 1.05)
	var seed0: int = int(feat.get("seed", int(absf(pos[0] * 7.0 + pos[2] * 5.0 + w * 11.0))))
	var kind: String = str(feat.get("art", "auto"))
	var frame_style: int = int(feat.get("frame", seed0 % 4))
	var outer: Color
	var mid: Color
	var liner: Color
	var corner_c: Color
	var rough_o: float = 0.32
	match frame_style:
		0:  # Ornate gilt salon
			outer = BRASS
			mid = BRASS.lightened(0.1)
			liner = BRASS.darkened(0.18)
			corner_c = BRASS.lightened(0.14)
			rough_o = 0.28
		1:  # Mahogany with gilt liner (library / morning)
			outer = MAHOGANY
			mid = MAHOGANY.lightened(0.08)
			liner = BRASS.darkened(0.1)
			corner_c = BRASS
			rough_o = 0.55
		2:  # Ebony austere (gallery / hall)
			outer = Color(0.08, 0.07, 0.07)
			mid = Color(0.12, 0.1, 0.09)
			liner = Color(0.22, 0.16, 0.1)
			corner_c = BRASS.darkened(0.2)
			rough_o = 0.45
		_:  # Dark gilt with deep liner (kitchen / workshop)
			outer = BRASS.darkened(0.22)
			mid = BRASS.darkened(0.1)
			liner = Color(0.14, 0.08, 0.05)
			corner_c = BRASS.lightened(0.05)
			rough_o = 0.35
	# Outer moulding + stepped liner (NO solid plate over canvas — was blacking out oils)
	_add_box(root, Vector3(0, 0, 0), Vector3(w + 0.12, h + 0.12, 0.08), outer, true, rough_o)
	_add_box(root, Vector3(0, 0, 0.018), Vector3(w + 0.05, h + 0.05, 0.05), mid, false, rough_o * 0.95)
	# Hollow liner: four thin rails around the canvas aperture (not a full dark plate)
	var rail: float = 0.06
	var aper_w: float = w - 0.16
	var aper_h: float = h - 0.16
	_add_box(root, Vector3(0, aper_h * 0.5 + rail * 0.35, 0.03), Vector3(aper_w + rail * 1.2, rail, 0.035), liner, false, 0.4)
	_add_box(root, Vector3(0, -(aper_h * 0.5 + rail * 0.35), 0.03), Vector3(aper_w + rail * 1.2, rail, 0.035), liner, false, 0.4)
	_add_box(root, Vector3(aper_w * 0.5 + rail * 0.35, 0, 0.03), Vector3(rail, aper_h, 0.035), liner, false, 0.4)
	_add_box(root, Vector3(-(aper_w * 0.5 + rail * 0.35), 0, 0.03), Vector3(rail, aper_h, 0.035), liner, false, 0.4)
	# Backing board behind canvas (slightly larger, pushed back so canvas wins depth)
	_add_box(root, Vector3(0, 0, -0.01), Vector3(aper_w + 0.02, aper_h + 0.02, 0.02), Color(0.12, 0.08, 0.05), false, 0.7)
	# Corner ornaments (gilt styles only get full blocks; ebony gets slim pips)
	var csz: float = 0.08 if frame_style != 2 else 0.045
	for sx in [-1.0, 1.0]:
		for sy in [-1.0, 1.0]:
			_add_box(root, Vector3(sx * (w * 0.5 + 0.02), sy * (h * 0.5 + 0.02), 0.03),
				Vector3(csz, csz, 0.05), corner_c, false, 0.28)
	# Picture-rail hook / crest (skip on austere ebony)
	if frame_style != 2:
		_add_box(root, Vector3(0, h * 0.5 + 0.1, 0.02), Vector3(0.12, 0.08, 0.04), liner, false, 0.32)
		_add_cylinder(root, Vector3(0, h * 0.5 + 0.16, 0.03), 0.025, 0.03, corner_c, false, 0.3, true)
	# Ornate gilt: mid-side rosettes
	if frame_style == 0:
		_add_cylinder(root, Vector3(-(w * 0.5 + 0.01), 0, 0.04), 0.03, 0.025, corner_c, false, 0.28, true)
		_add_cylinder(root, Vector3(w * 0.5 + 0.01, 0, 0.04), 0.03, 0.025, corner_c, false, 0.28, true)
	var canvas := MeshInstance3D.new()
	var cm := QuadMesh.new()
	cm.size = Vector2(aper_w, aper_h)
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
		if kind == "still_life":
			tex_path = ART_STILL_LIFES[seed0 % ART_STILL_LIFES.size()]
		elif kind == "botanical":
			tex_path = ART_BOTANICALS[seed0 % ART_BOTANICALS.size()]
		elif kind == "portrait":
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
			# default / landscape / auto / ruin / seascape → outdoor oil pool
			tex_path = ART_LANDSCAPES[seed0 % ART_LANDSCAPES.size()]
	var tex := _load_tex(tex_path)
	if tex == null:
		tex = _load_tex(ART_LANDSCAPES[0])
	if tex:
		cmat.albedo_texture = tex
		# Warm varnish wash so oils read aged, not pure photo
		cmat.albedo_color = Color(1.0, 0.97, 0.9)
	else:
		cmat.albedo_color = Color(0.4, 0.55, 0.65)
	cmat.roughness = 0.78
	cmat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	cmat.cull_mode = BaseMaterial3D.CULL_DISABLED
	canvas.material_override = cmat
	# Sit clearly in front of frame rails / backing
	canvas.position = Vector3(0, 0, 0.055)
	root.add_child(canvas)
	# Subtle picture light so canvas never dies in shadow
	var pic_l := OmniLight3D.new()
	pic_l.light_color = Color(1.0, 0.92, 0.75)
	pic_l.light_energy = 0.22
	pic_l.omni_range = 1.5
	pic_l.position = Vector3(0.0, h * 0.12, 0.5)
	root.add_child(pic_l)
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
	# Plants: low scissor keeps stem links; furniture cards higher (loop 147: less fringe scrap)
	var is_plant_card := tex_path.find("plant_") >= 0
	mat.alpha_scissor_threshold = 0.28 if is_plant_card else 0.58
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
		# Second card at 90° — volume from every walk-around angle (plants + side chairs)
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
	# Loop 70/136: mesh bulk for furniture (also with cross_planes so edge-on isn't empty)
	var bulk_kind: String = str(prop.get("mesh_bulk", ""))
	if bulk_kind == "" and solid and not face_camera and not cross_planes:
		var base := tex_path.get_file()
		if base == "desk.png":
			bulk_kind = "sofa"
		elif base == "sofa.png":
			bulk_kind = "desk"
		elif base == "chair.png":
			bulk_kind = "wing"
		elif base == "armchair.png":
			bulk_kind = "chair"
	if bulk_kind != "" and bulk_kind != "none":
		# Loop 143: when cross_planes carry silhouette, seat-only bulk (no legs → rug L-junk)
		_add_billboard_mesh_bulk(root, bulk_kind, width, height, cross_planes)

	if solid:
		# Prefer explicit col_size [w,h,d] for furniture cards so player cannot walk through
		var body := StaticBody3D.new()
		body.name = "Collider"
		var col := CollisionShape3D.new()
		var shape := BoxShape3D.new()
		var csz: Variant = prop.get("col_size", null)
		if csz is Array and csz.size() >= 3:
			shape.size = Vector3(float(csz[0]), float(csz[1]), float(csz[2]))
			col.position = Vector3(0, float(csz[1]) * 0.5, 0)
		else:
			var depth_col: float = width * 0.45 if cross_planes else 0.55
			shape.size = Vector3(width * 0.72, height * 0.8, depth_col)
			col.position = Vector3(0, maxf(y_off * 0.9, 0.4), 0)
		col.shape = shape
		body.add_child(col)
		root.add_child(body)

	_add_contact_shadow(root, width * 0.4, 0.32)
	return root


static func _add_billboard_mesh_bulk(root: Node3D, bulk: String, width: float, height: float, cross_planes: bool = false) -> void:
	## Low-poly solid volume *behind* the painted card (card faces +Z at z≈0).
	## Keep all bulk z-max ≤ -0.04 so front hero art is never covered.
	## Loop 143: with cross_planes, never add free-standing legs/stretchers (read as rug junk).
	match bulk:
		"sofa":
			# Loop 144: low dark bulk only — no green slab peeks above chesterfield crest
			var sw: float = clampf(width * 0.68, 1.3, 1.9)
			var seat_g := Color(0.22, 0.26, 0.16)  # near-shadow olive, not bright green
			_add_box(root, Vector3(0, 0.2, -0.34), Vector3(sw, 0.12, 0.28), MAHOGANY_DARK, false, 0.42)
			_add_box(root, Vector3(0, 0.36, -0.32), Vector3(sw * 0.85, 0.14, 0.24), seat_g, false, 0.88)
			# Back mass stays low + deep (y top ≈ 0.72 — under painted crest)
			_add_box(root, Vector3(0, 0.58, -0.44), Vector3(sw * 0.82, 0.28, 0.12), seat_g.darkened(0.08), false, 0.9)
			for sx in [-1.0, 1.0]:
				_add_box(root, Vector3(sx * (sw * 0.36), 0.42, -0.34),
					Vector3(0.12, 0.18, 0.22), seat_g.darkened(0.05), false, 0.88)
				if not cross_planes:
					_add_cylinder(root, Vector3(sx * (sw * 0.34), 0.08, -0.2), 0.03, 0.12, MAHOGANY, false)
					_add_cylinder(root, Vector3(sx * (sw * 0.34), 0.08, -0.4), 0.028, 0.12, MAHOGANY, false)
		"desk":
			# Loop 138: pedestals tucked behind card
			var dw: float = clampf(width * 0.75, 1.0, 1.45)
			_add_box(root, Vector3(0, 0.78, -0.28), Vector3(dw, 0.05, 0.32), MAHOGANY, false, 0.45)
			_add_box(root, Vector3(0, 0.81, -0.28), Vector3(dw * 0.88, 0.012, 0.28), Color(0.1, 0.16, 0.1), false, 0.72)
			_add_box(root, Vector3(-0.38, 0.38, -0.28), Vector3(0.32, 0.7, 0.3), MAHOGANY_DARK, false, 0.42)
			_add_box(root, Vector3(0.38, 0.38, -0.28), Vector3(0.32, 0.7, 0.3), MAHOGANY_DARK, false, 0.42)
			_add_box(root, Vector3(0, 0.95, -0.4), Vector3(dw * 0.85, 0.22, 0.05), MAHOGANY, false, 0.45)
		"wing", "wing_green":
			# Loop 147/153: cross_planes → seat pad + short feet (no tall legs/stretchers)
			var ww: float = clampf(width * 0.42, 0.42, 0.58)
			var fab: Color = Color(0.38, 0.44, 0.34) if bulk == "wing_green" else Color(0.4, 0.14, 0.14)
			if cross_planes:
				_add_box(root, Vector3(0, 0.42, -0.28), Vector3(ww * 0.85, 0.08, 0.2), MAHOGANY_DARK, false, 0.45)
				_add_box(root, Vector3(0, 0.5, -0.26), Vector3(ww * 0.72, 0.1, 0.16), fab, false, 0.9)
				# Short stub feet under pad only — not free bars on the rug
				for sx in [-1.0, 1.0]:
					for sz in [-1.0, 1.0]:
						_add_cylinder(
							root,
							Vector3(sx * ww * 0.22, 0.12, -0.22 + sz * 0.04),
							0.022, 0.2, MAHOGANY, false
						)
						_add_cylinder(
							root,
							Vector3(sx * ww * 0.22, 0.02, -0.22 + sz * 0.04),
							0.03, 0.04, MAHOGANY.lightened(0.04), false
						)
			else:
				# Loop 156: fuller wing bulk when no cross_planes (side volume without card ghost)
				_add_box(root, Vector3(0, 0.38, -0.32), Vector3(ww * 0.95, 0.1, 0.28), MAHOGANY_DARK, false, 0.45)
				_add_box(root, Vector3(0, 0.5, -0.28), Vector3(ww * 0.82, 0.14, 0.26), fab, false, 0.9)
				_add_box(root, Vector3(0, 0.78, -0.42), Vector3(ww * 0.72, 0.5, 0.14), fab.darkened(0.08), false, 0.9)
				_add_box(root, Vector3(0, 0.95, -0.38), Vector3(ww * 0.55, 0.18, 0.12), fab.darkened(0.12), false, 0.9)
				for sx in [-1.0, 1.0]:
					# Wings / arms
					_add_box(root, Vector3(sx * ww * 0.38, 0.62, -0.28), Vector3(0.1, 0.36, 0.22), fab.darkened(0.05), false, 0.88)
					_add_cylinder(root, Vector3(sx * ww * 0.28, 0.12, -0.18), 0.026, 0.18, MAHOGANY, false)
					_add_cylinder(root, Vector3(sx * ww * 0.28, 0.12, -0.38), 0.024, 0.18, MAHOGANY.darkened(0.05), false)
		"chair":
			# Loop 153: cross_planes → seat cushion + short stub feet (edge-on volume).
			# No stretchers / long free legs (those read as gallery rug L-junk).
			var cw: float = clampf(width * 0.48, 0.36, 0.52)
			if cross_planes:
				_add_box(root, Vector3(0, 0.44, -0.22), Vector3(cw * 0.95, 0.04, 0.2), MAHOGANY, false, 0.48)
				_add_box(root, Vector3(0, 0.5, -0.2), Vector3(cw * 0.88, 0.09, 0.18), VELVET_GREEN, false, 0.9)
				_add_box(root, Vector3(0, 0.56, -0.2), Vector3(cw * 0.82, 0.025, 0.16), VELVET_GREEN.lightened(0.06), false, 0.88)
				# Four vertical feet under seat (no horizontal stretchers → rug L-junk)
				for sx in [-1.0, 1.0]:
					for sz in [-1.0, 1.0]:
						_add_cylinder(
							root,
							Vector3(sx * cw * 0.28, 0.22, -0.2 + sz * 0.04),
							0.015, 0.4, MAHOGANY, false
						)
						_add_cylinder(
							root,
							Vector3(sx * cw * 0.28, 0.02, -0.2 + sz * 0.04),
							0.022, 0.035, MAHOGANY.lightened(0.05), false
						)
			else:
				_add_box(root, Vector3(0, 0.46, -0.32), Vector3(cw, 0.05, 0.22), MAHOGANY, false, 0.48)
				_add_box(root, Vector3(0, 0.52, -0.3), Vector3(cw * 0.88, 0.09, 0.18), VELVET_GREEN, false, 0.9)
				for sx in [-1.0, 1.0]:
					_add_cylinder(root, Vector3(sx * cw * 0.28, 0.2, -0.24), 0.018, 0.32, MAHOGANY, false)
					_add_cylinder(root, Vector3(sx * cw * 0.28, 0.2, -0.36), 0.016, 0.32, MAHOGANY.darkened(0.06), false)
				_add_box(root, Vector3(0, 0.12, -0.28), Vector3(cw * 0.6, 0.025, 0.025), MAHOGANY, false, 0.5)
		_:
			_add_box(root, Vector3(0, height * 0.35, -0.22),
				Vector3(width * 0.7, height * 0.55, 0.28), MAHOGANY_DARK, false, 0.5)


# ─── Materials / primitives ──────────────────────────────────────────────────

static func _book_color(seed: int) -> Color:
	## Leather / cloth bindings — muted 1850s library, never Minecraft green.
	var hues := [
		Color(0.38, 0.14, 0.10),  # oxblood
		Color(0.16, 0.20, 0.30),  # navy
		Color(0.34, 0.22, 0.12),  # tan leather
		Color(0.48, 0.12, 0.10),  # crimson
		Color(0.22, 0.18, 0.14),  # dark brown
		Color(0.28, 0.24, 0.18),  # buff
		Color(0.14, 0.16, 0.14),  # near-black green-brown
		Color(0.40, 0.30, 0.18),  # mustard cloth
		Color(0.20, 0.22, 0.28),  # slate cloth
		Color(0.42, 0.28, 0.16),  # calf tan
		Color(0.30, 0.10, 0.12),  # burgundy
		Color(0.18, 0.14, 0.10),  # black morocco
	]
	return hues[seed % hues.size()]


static func _add_table_folio(root: Node3D, pos: Vector3, seed0: int, yaw_deg: float = 0.0) -> void:
	## Single thin leather folio on a table — spine + gilt edge (not a cube).
	var col := _book_color(seed0)
	var node := Node3D.new()
	node.position = pos
	node.rotation_degrees.y = yaw_deg
	root.add_child(node)
	# Lying flat: height is book thickness
	_add_box(node, Vector3(0, 0.012, 0), Vector3(0.12, 0.022, 0.16), col, false, 0.68)
	# Gilt page edge
	_add_box(node, Vector3(0.055, 0.012, 0), Vector3(0.008, 0.018, 0.14), BRASS.lightened(0.05), false, 0.35)
	# Spine band
	_add_box(node, Vector3(-0.055, 0.012, 0), Vector3(0.012, 0.02, 0.15), col.darkened(0.12), false, 0.65)


static func _add_table_folio_stack(root: Node3D, pos: Vector3, seed0: int, count: int = 3) -> void:
	## Stacked thin folios with slight offsets — conservatory/library table dress.
	var n := clampi(count, 2, 4)
	for i in n:
		var ox := float((i + seed0) % 3) * 0.012 - 0.012
		var oz := float((i * 2 + seed0) % 3) * 0.01 - 0.01
		var yaw := float((i + seed0) % 5) * 4.0 - 8.0
		_add_table_folio(
			root,
			pos + Vector3(ox, float(i) * 0.024, oz),
			seed0 + i * 3,
			yaw
		)

static func _load_tex(path: String) -> Texture2D:
	if path == "":
		return null
	if _tex_cache.has(path):
		return _tex_cache[path]
	var tex: Texture2D = null
	if ResourceLoader.exists(path):
		var r = load(path)
		if r is Texture2D:
			tex = r
	if tex == null:
		var abs_path := ProjectSettings.globalize_path(path)
		if FileAccess.file_exists(abs_path):
			var img := Image.new()
			if img.load(abs_path) == OK:
				tex = ImageTexture.create_from_image(img)
	if tex:
		_tex_cache[path] = tex
	return tex

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
	## Loop 149: CLAY/terracotta must not match copper or scrubbed wood (urns → barrel look).
	var mat := StandardMaterial3D.new()
	mat.roughness = roughness
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_PER_PIXEL
	var tex_path := ""
	var metallic := 0.0
	var wood_tint := 0.32
	# Terracotta / clay FIRST — g≥0.45 (CLAY 0.48). COPPER const g=0.42 stays metal.
	if (
		color.r > 0.65 and color.g >= 0.45 and color.g < 0.56 and color.b < 0.38
		and color.r > color.g + 0.18 and color.r - color.b > 0.28
	):
		tex_path = TEX_STONE
		metallic = 0.0
		mat.roughness = maxf(roughness, 0.82)
		wood_tint = 0.55
	# Copper metal (g typically <0.45 — COPPER const 0.42)
	elif color.r > 0.55 and color.g > 0.25 and color.g < 0.48 and color.b < 0.32 and color.r > color.g + 0.12:
		tex_path = TEX_COPPER
		metallic = 0.75
		mat.roughness = minf(roughness, 0.4)
	# Brass / gold
	elif color.r > 0.55 and color.g > 0.4 and color.b < 0.4 and color.r >= color.g and color.r - color.g < 0.22:
		tex_path = TEX_BRASS
		metallic = 0.7
		mat.roughness = minf(roughness, 0.4)
	# Iron / dark metal — TRUE greys only (r≈g≈b). Warm dark mahogany must not
	# match: MAHOGANY / MAHOGANY_DARK were classified as iron → black metal desks.
	# Exclude plant greens (LEAF_DARK) via low green-dominance.
	elif (
		color.r < 0.40 and color.g < 0.40 and color.b < 0.42 and color.v < 0.42
		and absf(color.r - color.g) < 0.05
		and absf(color.g - color.b) < 0.06
		and absf(color.r - color.b) < 0.08
		and color.g <= color.r + 0.03
	):
		tex_path = TEX_IRON
		# Lower metallic: without env probes high metal reads as pure black
		metallic = 0.42
		mat.roughness = minf(roughness, 0.58)
	# Loop 157: fabrics BEFORE wood — VELVET_RED (0.55,0.12,0.16) was matching
	# mahogany wood path (r>g>b brown gate) and read as solid timber wing.
	# Red velvet / oxblood (true fabric reds; MAHOGANY 0.30 stays below r threshold)
	elif color.r > 0.32 and color.g < 0.24 and color.b < 0.24 and color.r > color.g + 0.18:
		tex_path = TEX_VELVET_RED
	# Green velvet — sage + deep (NOT bright plant leaf greens)
	elif (
		color.g > color.r + 0.01
		and color.g > color.b * 0.85
		and color.g > 0.18
		and color.g < 0.46
		and absf(color.r - color.b) < 0.14
		and color.r < 0.4
	):
		if color.g < 0.3:
			tex_path = TEX_VELVET_GREEN_DEEP
		else:
			tex_path = TEX_VELVET_GREEN
	# Mahogany / wood browns / oak — after fabric so wing cloth ≠ timber
	# Exclude terracotta (caught above) and stone greys.
	elif (
		color.r > 0.12 and color.r >= color.g * 0.85 and color.r > color.b
		and color.g < 0.42 and color.g > 0.08
		and color.r < 0.72
	):
		tex_path = _wood_path_for_color(color, size)
		# Larger furniture: coarser UV; small boards: finer grain
		wood_tint = 0.38 if size.x * size.z < 0.4 else 0.26
	# Light scrubbed oak / pale wood (prep tops) — exclude orange clay (r−g large)
	elif (
		color.r > 0.55 and color.g > 0.4 and color.b > 0.2 and color.r < 0.85 and color.g < 0.7
		and color.r - color.g < 0.2
	):
		tex_path = TEX_WOOD_SCRUBBED if color.v > 0.55 else TEX_WOOD_PINE
		wood_tint = 0.42
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


static func _add_cylinder_rotated(
	parent: Node3D,
	pos: Vector3,
	radius: float,
	height: float,
	color: Color,
	euler: Vector3,
	roughness: float = 0.75,
) -> void:
	## Decorative cylinder with euler rotation (for bolsters / horizontal rolls). No collision.
	var body := Node3D.new()
	var mesh := CylinderMesh.new()
	mesh.top_radius = radius
	mesh.bottom_radius = radius
	mesh.height = height
	var mi := MeshInstance3D.new()
	mi.mesh = mesh
	mi.material_override = _mat_for(color, roughness, Vector3(radius * 2.0, height, radius * 2.0))
	body.add_child(mi)
	body.position = pos
	body.rotation = euler
	parent.add_child(body)
