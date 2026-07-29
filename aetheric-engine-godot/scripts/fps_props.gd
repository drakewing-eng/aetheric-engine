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
	# Still life on writing surface
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
	## seed forks splat style + fabric so chairs aren't clones.
	if prop.get("billboard", false) and prop.get("texture", "") != "":
		return _make_billboard_prop(prop)
	var root := Node3D.new()
	root.name = "Chair"
	var seed0: int = int(prop.get("seed", 0))
	var fabric: Color = prop.get("fabric", VELVET_GREEN if seed0 % 2 == 0 else VELVET_RED.darkened(0.15))
	# Seat box + cushion (solid = walk-block)
	_add_box(root, Vector3(0, 0.44, 0.02), Vector3(0.52, 0.07, 0.5), MAHOGANY, true, 0.48)
	_add_box(root, Vector3(0, 0.5, 0.02), Vector3(0.48, 0.07, 0.46), fabric, true, 0.9)
	_add_box(root, Vector3(0, 0.55, 0.02), Vector3(0.44, 0.035, 0.42), fabric.darkened(0.1), false, 0.92)
	# Piping / welt edge (detail)
	_add_box(root, Vector3(0, 0.53, 0.25), Vector3(0.46, 0.015, 0.02), fabric.darkened(0.2), false, 0.9)
	# Nailhead band
	for i in 6:
		var nx := -0.2 + i * 0.08
		_add_cylinder(root, Vector3(nx, 0.47, 0.26), 0.01, 0.015, BRASS, false, 0.3, true)
	# Back frame OPEN (loop 98: no solid mahogany slab from behind)
	# Side uprights + top crest + lower rail only; splat fills the void
	for sx in [-1.0, 1.0]:
		_add_box(root, Vector3(sx * 0.23, 0.9, -0.2), Vector3(0.055, 0.78, 0.06), MAHOGANY, true, 0.48)
	# Top crest rail
	_add_box(root, Vector3(0, 1.28, -0.19), Vector3(0.48, 0.1, 0.07), MAHOGANY, false, 0.45)
	_add_box(root, Vector3(0, 1.34, -0.18), Vector3(0.36, 0.05, 0.05), MAHOGANY.lightened(0.05), false, 0.45)
	# Lower back rail at seat
	_add_box(root, Vector3(0, 0.58, -0.2), Vector3(0.42, 0.06, 0.05), MAHOGANY_DARK, false, 0.48)
	# Mid cross rail
	_add_box(root, Vector3(0, 0.95, -0.2), Vector3(0.4, 0.04, 0.04), MAHOGANY, false, 0.5)
	# Splat style by seed (fills open back — readable from both sides)
	if seed0 % 3 == 0:
		# Triple vertical splat
		_add_box(root, Vector3(0, 0.95, -0.18), Vector3(0.1, 0.55, 0.04), MAHOGANY_DARK, false, 0.5)
		_add_box(root, Vector3(-0.12, 0.95, -0.18), Vector3(0.04, 0.5, 0.035), MAHOGANY, false, 0.5)
		_add_box(root, Vector3(0.12, 0.95, -0.18), Vector3(0.04, 0.5, 0.035), MAHOGANY, false, 0.5)
	elif seed0 % 3 == 1:
		# Balloon back padded (open frame around fabric oval)
		_add_box(root, Vector3(0, 1.0, -0.17), Vector3(0.38, 0.5, 0.05), fabric, false, 0.88)
		_add_box(root, Vector3(0, 1.18, -0.16), Vector3(0.32, 0.12, 0.04), fabric.darkened(0.1), false, 0.9)
		for bi in 3:
			_add_cylinder(root, Vector3((float(bi) - 1.0) * 0.1, 1.05, -0.14), 0.015, 0.02, fabric.darkened(0.2), false, 0.9)
	else:
		# Lyre-ish central splat
		_add_box(root, Vector3(0, 0.95, -0.18), Vector3(0.08, 0.55, 0.04), MAHOGANY_DARK, false, 0.5)
		_add_box(root, Vector3(0, 1.12, -0.17), Vector3(0.28, 0.07, 0.035), MAHOGANY, false, 0.5)
		_add_box(root, Vector3(-0.1, 0.85, -0.18), Vector3(0.04, 0.35, 0.03), MAHOGANY, false, 0.5)
		_add_box(root, Vector3(0.1, 0.85, -0.18), Vector3(0.04, 0.35, 0.03), MAHOGANY, false, 0.5)
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
	## Wing chair (loop 103): open side silhouette — seat rail + arm gap + rolled wing,
	## not a solid green wall from extreme side.
	if prop.get("billboard", false) and prop.get("texture", "") != "":
		return _make_billboard_prop(prop)
	var root := Node3D.new()
	root.name = "Armchair"
	var fabric: Color = prop.get("fabric", VELVET_RED)
	var fabric_d := fabric.darkened(0.1)
	var fabric_dd := fabric.darkened(0.18)
	# Wood seat rail (visible from side under cushions)
	_add_box(root, Vector3(0, 0.3, 0.06), Vector3(0.92, 0.1, 0.86), MAHOGANY_DARK, true, 0.42)
	_add_box(root, Vector3(0, 0.36, 0.06), Vector3(0.94, 0.04, 0.88), MAHOGANY, false, 0.45)
	# Plush seat cushions (sit above rail — gap under arm reads open)
	_add_box(root, Vector3(0, 0.46, 0.1), Vector3(0.82, 0.14, 0.72), fabric, true, 0.9)
	_add_box(root, Vector3(0, 0.55, 0.12), Vector3(0.72, 0.07, 0.62), fabric_d, false, 0.92)
	# Button tufts on seat
	for bx in [-0.18, 0.0, 0.18]:
		for bz in [-0.08, 0.1]:
			_add_cylinder(root, Vector3(bx, 0.59, bz), 0.016, 0.018, fabric_dd, false, 0.95)
	# High back (narrow depth so side isn't a slab)
	_add_box(root, Vector3(0, 0.95, -0.32), Vector3(0.78, 0.9, 0.12), fabric, true, 0.9)
	_add_box(root, Vector3(0, 1.35, -0.3), Vector3(0.7, 0.12, 0.1), fabric_d, false, 0.9)
	# Thin wood crest bead
	_add_box(root, Vector3(0, 1.44, -0.28), Vector3(0.62, 0.035, 0.06), MAHOGANY, false, 0.45)
	# Button tufts on back
	for by in [0.85, 1.05, 1.22]:
		for bx in [-0.16, 0.0, 0.16]:
			_add_cylinder(root, Vector3(bx, by, -0.24), 0.014, 0.016, fabric_dd, false, 0.95)
	# Side uprights (wood posts — break fabric wall from side)
	for sx in [-1.0, 1.0]:
		_add_box(root, Vector3(sx * 0.4, 0.85, -0.3), Vector3(0.06, 0.9, 0.08), MAHOGANY_DARK, true, 0.45)
	# Wings — C-curve rolls only at upper rear (not full-height side slabs)
	for sx in [-1.0, 1.0]:
		# Main wing panel (rear-biased, leaves front side open)
		_add_box(root, Vector3(sx * 0.4, 1.15, -0.18), Vector3(0.12, 0.5, 0.28), fabric, true, 0.88)
		_add_cylinder(root, Vector3(sx * 0.44, 1.2, -0.05), 0.07, 0.4, fabric_d, false, 0.88)
		_add_cylinder(root, Vector3(sx * 0.42, 1.35, -0.12), 0.06, 0.22, fabric, false, 0.9)
		# Piping
		_add_box(root, Vector3(sx * 0.48, 1.18, -0.1), Vector3(0.02, 0.4, 0.22), fabric_dd, false, 0.9)
	# Arms — mid-height only with open under-arm void (key side read)
	for sx in [-1.0, 1.0]:
		# Arm pad
		_add_box(root, Vector3(sx * 0.4, 0.68, 0.08), Vector3(0.14, 0.1, 0.55), fabric, true, 0.88)
		_add_cylinder(root, Vector3(sx * 0.4, 0.72, 0.12), 0.07, 0.45, fabric_d, false, 0.88)
		# Front scroll + wood support post (void under arm behind post)
		_add_cylinder(root, Vector3(sx * 0.38, 0.52, 0.32), 0.055, 0.14, MAHOGANY, false, 0.45)
		_add_box(root, Vector3(sx * 0.4, 0.48, 0.28), Vector3(0.05, 0.28, 0.05), MAHOGANY_DARK, true, 0.45)
		# Rear arm root into wing
		_add_box(root, Vector3(sx * 0.4, 0.7, -0.15), Vector3(0.1, 0.12, 0.18), fabric_d, false, 0.88)
	# Legs + feet
	for sx in [-1.0, 1.0]:
		_add_cylinder(root, Vector3(sx * 0.34, 0.14, 0.3), 0.04, 0.26, MAHOGANY_DARK, true)
		_add_cylinder(root, Vector3(sx * 0.34, 0.02, 0.3), 0.055, 0.04, MAHOGANY, true)
		_add_cylinder(root, Vector3(sx * 0.32, 0.14, -0.28), 0.038, 0.26, MAHOGANY_DARK, true)
		_add_cylinder(root, Vector3(sx * 0.32, 0.02, -0.28), 0.05, 0.04, MAHOGANY, true)
	# Front skirt only (sides open so legs/void read)
	_add_box(root, Vector3(0, 0.22, 0.35), Vector3(0.75, 0.06, 0.06), MAHOGANY_DARK, false, 0.42)
	_add_box(root, Vector3(0, 0.22, -0.28), Vector3(0.7, 0.05, 0.05), MAHOGANY_DARK, false, 0.42)
	_add_contact_shadow(root, 0.68, 0.62)
	return root

static func _make_ottoman(prop: Dictionary) -> Node3D:
	## Low tufted footstool — sits in front of sofa, never under it.
	## seed: 0 square tufted · 1 round drum · 2 long bench with fringe (uniqueness).
	var root := Node3D.new()
	root.name = "Ottoman"
	var fabric: Color = prop.get("fabric", VELVET_GREEN.darkened(0.08))
	var seed0: int = int(prop.get("seed", 0))
	var style := seed0 % 3
	var w: float = float(prop.get("width", 0.72 if style != 2 else 1.05))
	var d: float = float(prop.get("depth", 0.5 if style != 1 else 0.72))
	if style == 1:
		# Round drum ottoman
		_add_cylinder(root, Vector3(0, 0.12, 0), w * 0.42, 0.1, MAHOGANY_DARK, true, 0.42)
		_add_cylinder(root, Vector3(0, 0.28, 0), w * 0.4, 0.22, fabric, true, 0.9)
		_add_cylinder(root, Vector3(0, 0.42, 0), w * 0.36, 0.06, fabric.darkened(0.1), false, 0.92)
		for i in 6:
			var ang := float(i) * TAU / 6.0
			_add_cylinder(root, Vector3(cos(ang) * w * 0.18, 0.44, sin(ang) * w * 0.18), 0.014, 0.02, fabric.darkened(0.22), false, 0.95)
		for i in 4:
			var ang2 := float(i) * TAU / 4.0 + 0.4
			_add_cylinder(root, Vector3(cos(ang2) * w * 0.28, 0.05, sin(ang2) * w * 0.28), 0.03, 0.1, MAHOGANY, true)
	else:
		# Square / long bench: mahogany base + padded top + fringe
		_add_box(root, Vector3(0, 0.14, 0), Vector3(w, 0.1, d), MAHOGANY_DARK, true, 0.42)
		_add_box(root, Vector3(0, 0.26, 0), Vector3(w * 0.96, 0.16, d * 0.96), fabric, true, 0.9)
		_add_box(root, Vector3(0, 0.36, 0), Vector3(w * 0.88, 0.06, d * 0.88), fabric.darkened(0.1), false, 0.92)
		# Tufts denser on long style
		var cols := 3 if style == 0 else 5
		for i in cols:
			for j in 2:
				var bx := (float(i) / float(maxi(cols - 1, 1)) - 0.5) * w * 0.7
				var bz := (float(j) - 0.5) * d * 0.35
				_add_cylinder(root, Vector3(bx, 0.4, bz), 0.015, 0.02, fabric.darkened(0.22), false, 0.95)
		# Nailhead edge
		for i in 8:
			var t := float(i) / 7.0
			_add_cylinder(root, Vector3(-w * 0.42 + t * w * 0.84, 0.2, d * 0.42), 0.01, 0.012, BRASS, false, 0.3, true)
		# Fringe / skirt
		_add_box(root, Vector3(0, 0.1, 0), Vector3(w * 0.94, 0.06, d * 0.94), fabric.darkened(0.18), false, 0.88)
		for sx in [-1.0, 1.0]:
			for sz in [-1.0, 1.0]:
				_add_cylinder(root, Vector3(sx * w * 0.38, 0.05, sz * d * 0.35), 0.032, 0.1, MAHOGANY, true)
				_add_cylinder(root, Vector3(sx * w * 0.38, 0.01, sz * d * 0.35), 0.04, 0.03, MAHOGANY_DARK, true)
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
	## Tea at four — silvered tray, period china (loop 103: cream ivory only,
	## never pure white plastic blockware).
	var root := Node3D.new()
	root.name = "TeaTray"
	var seed0: int = int(prop.get("seed", 0))
	var china: Color
	var trim: Color
	var pattern: Color
	match seed0 % 3:
		0:  # cream + gilt
			china = Color(0.86, 0.8, 0.68)
			trim = BRASS.darkened(0.08)
			pattern = Color(0.62, 0.48, 0.28)
		1:  # blue willow on ivory
			china = Color(0.84, 0.82, 0.74)
			trim = Color(0.22, 0.34, 0.52)
			pattern = Color(0.28, 0.4, 0.58)
		_:  # soft rose band
			china = Color(0.88, 0.8, 0.74)
			trim = Color(0.5, 0.22, 0.22)
			pattern = Color(0.58, 0.32, 0.32)
	# Oval silver tray with rim
	_add_box(root, Vector3(0, 0.015, 0), Vector3(0.5, 0.016, 0.34), BRASS.darkened(0.22), false, 0.28)
	_add_box(root, Vector3(0, 0.026, 0), Vector3(0.46, 0.01, 0.3), BRASS.darkened(0.05), false, 0.25)
	_add_box(root, Vector3(0, 0.032, 0), Vector3(0.42, 0.006, 0.26), Color(0.55, 0.52, 0.46), false, 0.4)
	# Handles
	_add_box(root, Vector3(-0.25, 0.038, 0), Vector3(0.04, 0.03, 0.1), BRASS.darkened(0.1), false, 0.28)
	_add_box(root, Vector3(0.25, 0.038, 0), Vector3(0.04, 0.03, 0.1), BRASS.darkened(0.1), false, 0.28)
	# Teapot — bulbous body, clear lid knop, spout, handle
	_add_cylinder(root, Vector3(-0.08, 0.1, 0.02), 0.07, 0.11, china, false, 0.6)
	_add_cylinder(root, Vector3(-0.08, 0.1, 0.02), 0.072, 0.025, pattern, false, 0.5)
	_add_cylinder(root, Vector3(-0.08, 0.16, 0.02), 0.055, 0.03, china.darkened(0.05), false, 0.58)
	_add_cylinder(root, Vector3(-0.08, 0.185, 0.02), 0.022, 0.03, trim, false, 0.4)
	_add_box(root, Vector3(0.02, 0.1, 0.02), Vector3(0.1, 0.022, 0.028), china.darkened(0.08), false, 0.58)
	_add_box(root, Vector3(-0.16, 0.11, 0.02), Vector3(0.028, 0.07, 0.035), china.darkened(0.1), false, 0.58)
	_add_cylinder(root, Vector3(-0.08, 0.13, 0.02), 0.073, 0.01, trim, false, 0.4)
	# Cups + saucers
	for i in 2:
		var cx := 0.1 + float(i) * 0.1
		var cz := 0.04 - float(i) * 0.07
		_add_cylinder(root, Vector3(cx, 0.042, cz), 0.042, 0.01, china.darkened(0.06), false, 0.58)
		_add_cylinder(root, Vector3(cx, 0.065, cz), 0.028, 0.04, china, false, 0.58)
		_add_cylinder(root, Vector3(cx, 0.08, cz), 0.03, 0.008, trim, false, 0.4)
		_add_box(root, Vector3(cx + 0.028, 0.065, cz), Vector3(0.018, 0.028, 0.014), china.darkened(0.08), false, 0.58)
	# Cream jug
	_add_cylinder(root, Vector3(0.02, 0.07, -0.08), 0.024, 0.05, china, false, 0.58)
	_add_cylinder(root, Vector3(0.02, 0.085, -0.08), 0.026, 0.008, pattern, false, 0.48)
	_add_box(root, Vector3(0.05, 0.08, -0.08), Vector3(0.03, 0.02, 0.02), china.darkened(0.06), false, 0.55)
	# Sugar bowl + lid
	_add_cylinder(root, Vector3(-0.02, 0.07, -0.05), 0.032, 0.04, china, false, 0.55)
	_add_cylinder(root, Vector3(-0.02, 0.095, -0.05), 0.02, 0.02, trim, false, 0.4)
	# Spoon rest
	_add_box(root, Vector3(0.14, 0.04, -0.02), Vector3(0.08, 0.008, 0.02), BRASS.darkened(0.1), false, 0.3)
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
	# Back with button grid (loop 99: fabric crown — no mahogany blotch like loop 97 armchair)
	_add_box(root, Vector3(0, 0.85, -0.3), Vector3(width, 0.78, 0.18), fabric, true, 0.9)
	_add_box(root, Vector3(0, 1.22, -0.28), Vector3(width - 0.12, 0.14, 0.14), fabric.darkened(0.05), false, 0.9)
	_add_box(root, Vector3(0, 1.3, -0.26), Vector3(width - 0.2, 0.04, 0.08), MAHOGANY, false, 0.45)
	for i in 5:
		for j in 3:
			var bx := (i - 2) * (width * 0.16)
			var by := 0.7 + j * 0.18
			_add_cylinder(root, Vector3(bx, by, -0.2), 0.018, 0.02, fabric.darkened(0.25), false, 0.95)
	# Rolled arms — side bulk + roll so side view isn't a flat green wall
	for sx in [-1.0, 1.0]:
		var ax: float = sx * (width * 0.5 - 0.12)
		_add_box(root, Vector3(ax, 0.6, 0.06), Vector3(0.22, 0.48, 0.86), fabric, true, 0.88)
		_add_cylinder(root, Vector3(ax, 0.82, 0.2), 0.11, 0.35, fabric.darkened(0.05), false, 0.9)
		# Outer roll contour (reads volume from side)
		_add_cylinder(root, Vector3(ax + sx * 0.08, 0.72, 0.05), 0.09, 0.55, fabric.darkened(0.08), false, 0.88)
		_add_box(root, Vector3(ax + sx * 0.06, 0.95, -0.05), Vector3(0.1, 0.35, 0.5), fabric.darkened(0.04), false, 0.9)
		_add_cylinder(root, Vector3(ax, 0.55, 0.38), 0.07, 0.14, MAHOGANY, false, 0.45)
	# Turned legs
	for x in range(-2, 3):
		var lx := x * (width * 0.2)
		_add_cylinder(root, Vector3(lx, 0.08, 0.32), 0.035, 0.14, MAHOGANY, true)
		_add_cylinder(root, Vector3(lx, 0.08, -0.28), 0.035, 0.14, MAHOGANY, true)
		_add_cylinder(root, Vector3(lx, 0.02, 0.32), 0.045, 0.03, MAHOGANY_DARK, true)
	_add_contact_shadow(root, width * 0.5, 0.55)
	return root

static func _make_rug(prop: Dictionary) -> Node3D:
	## Loop 87: textured field + raised border/fringe so rugs read as woven carpets.
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
	if tex_path != "":
		var tex: Texture2D = _load_tex(tex_path)
		if tex:
			mat.albedo_texture = tex
			mat.uv1_scale = Vector3(sw * 0.35, sd * 0.35, 1.0)
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
	# Raised border (darker) + corner medallion for volume
	var border := Color(0.22, 0.1, 0.08)
	var gold := Color(0.55, 0.4, 0.2)
	var bw := 0.08
	_add_box(root, Vector3(0, 0.04, sd * 0.5 - bw * 0.5), Vector3(sw * 0.98, 0.02, bw), border, false, 0.9)
	_add_box(root, Vector3(0, 0.04, -sd * 0.5 + bw * 0.5), Vector3(sw * 0.98, 0.02, bw), border, false, 0.9)
	_add_box(root, Vector3(sw * 0.5 - bw * 0.5, 0.04, 0), Vector3(bw, 0.02, sd * 0.94), border, false, 0.9)
	_add_box(root, Vector3(-sw * 0.5 + bw * 0.5, 0.04, 0), Vector3(bw, 0.02, sd * 0.94), border, false, 0.9)
	# Inner gold rail (loop 105: thin only — large solid medallion read as cardboard blotch)
	_add_box(root, Vector3(0, 0.042, 0), Vector3(sw * 0.88, 0.01, 0.025), gold, false, 0.7)
	_add_box(root, Vector3(0, 0.042, 0), Vector3(0.025, 0.01, sd * 0.88), gold, false, 0.7)
	# Small centre rosette only when no field texture (texture already has medallion)
	if not has_tex and sw > 2.5 and sd > 2.0:
		_add_cylinder(root, Vector3(0, 0.048, 0), minf(sw, sd) * 0.06, 0.01, gold.darkened(0.1), false, 0.75)
		_add_cylinder(root, Vector3(0, 0.05, 0), minf(sw, sd) * 0.035, 0.01, Color(0.45, 0.18, 0.12), false, 0.85)
	elif has_tex and sw > 2.5 and sd > 2.0:
		# Subtle raised ring only (lets woven field show)
		_add_cylinder(root, Vector3(0, 0.042, 0), minf(sw, sd) * 0.12, 0.008, gold.darkened(0.2), false, 0.8)
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
				# Copper bowl
				_add_cylinder(root, Vector3(x, y + 0.08, 0.04), 0.085, 0.1, COPPER, false, 0.35, true)
				_add_cylinder(root, Vector3(x, y + 0.14, 0.04), 0.09, 0.02, COPPER.lightened(0.08), false, 0.35, true)
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
		# Tripod pedestal
		_add_cylinder(root, Vector3(0, 0.62, 0), 0.3, 0.04, MAHOGANY, true)
		_add_cylinder(root, Vector3(0, 0.65, 0), 0.31, 0.02, MAHOGANY_DARK, false)
		_add_cylinder(root, Vector3(0, 0.48, 0), 0.08, 0.12, MAHOGANY, true)
		_add_cylinder(root, Vector3(0, 0.32, 0), 0.045, 0.28, MAHOGANY_DARK, true)
		_add_cylinder(root, Vector3(0, 0.14, 0), 0.1, 0.08, MAHOGANY, true)
		for a in [0.0, 120.0, 240.0]:
			var rad := deg_to_rad(a)
			_add_box(root, Vector3(cos(rad) * 0.16, 0.04, sin(rad) * 0.16), Vector3(0.22, 0.04, 0.06), MAHOGANY_DARK, true, 0.45)
	elif base == 1:
		# Square top + four turned legs
		_add_box(root, Vector3(0, 0.64, 0), Vector3(0.55, 0.04, 0.55), MAHOGANY, true, 0.45)
		_add_box(root, Vector3(0, 0.67, 0), Vector3(0.58, 0.02, 0.58), MAHOGANY_DARK, false, 0.42)
		for sx in [-1.0, 1.0]:
			for sz in [-1.0, 1.0]:
				_add_cylinder(root, Vector3(sx * 0.2, 0.32, sz * 0.2), 0.03, 0.6, MAHOGANY_DARK, true)
				_add_cylinder(root, Vector3(sx * 0.2, 0.02, sz * 0.2), 0.04, 0.04, MAHOGANY, true)
		_add_box(root, Vector3(0, 0.28, 0), Vector3(0.38, 0.03, 0.38), MAHOGANY, false, 0.5)
	else:
		# Demi-lune (half-round) console
		_add_box(root, Vector3(0, 0.64, 0.05), Vector3(0.7, 0.04, 0.35), MAHOGANY, true, 0.45)
		_add_cylinder(root, Vector3(0, 0.64, 0.05), 0.32, 0.04, MAHOGANY, true)
		_add_cylinder(root, Vector3(-0.22, 0.32, 0.08), 0.028, 0.6, MAHOGANY_DARK, true)
		_add_cylinder(root, Vector3(0.22, 0.32, 0.08), 0.028, 0.6, MAHOGANY_DARK, true)
		_add_cylinder(root, Vector3(0.0, 0.32, -0.05), 0.03, 0.6, MAHOGANY_DARK, true)
		_add_box(root, Vector3(0, 0.3, 0.05), Vector3(0.4, 0.025, 0.12), MAHOGANY, false, 0.48)
	# Top dressing — skip when bare (tea tray / hero still-life placed separately)
	var top_y := 0.69
	if prop.get("bare", false):
		_add_contact_shadow(root, 0.34, 0.34)
		return root
	if dress == 0:
		# Mini Argand on table (loop 102: short caged chimney, not white stick)
		_add_cylinder(root, Vector3(0, top_y, 0), 0.08, 0.05, BRASS, false, 0.28, true)
		_add_cylinder(root, Vector3(0, top_y + 0.08, 0), 0.07, 0.08, BRASS.darkened(0.05), false, 0.28, true)
		_add_cylinder(root, Vector3(0, top_y + 0.14, 0), 0.05, 0.03, BRASS, false, 0.28, true)
		var glass_t := Color(0.72, 0.58, 0.32)
		_add_cylinder(root, Vector3(0, top_y + 0.22, 0), 0.038, 0.12, glass_t, false, 0.4)
		for ri in 3:
			var ra := float(ri) * TAU / 3.0
			_add_box(root, Vector3(cos(ra) * 0.04, top_y + 0.22, sin(ra) * 0.04), Vector3(0.01, 0.11, 0.01), BRASS, false, 0.3)
		_add_cylinder(root, Vector3(0, top_y + 0.29, 0), 0.032, 0.025, BRASS, false, 0.28, true)
		_add_sphere_blob(root, Vector3(0, top_y + 0.2, 0), 0.022, Color(1.0, 0.8, 0.4))
		_add_box(root, Vector3(0.12, top_y - 0.01, 0.08), Vector3(0.12, 0.14, 0.09), _book_color(2 + seed0), false)
		var lamp := OmniLight3D.new()
		lamp.light_color = Color(1.0, 0.85, 0.55)
		lamp.light_energy = 0.55
		lamp.omni_range = 2.6
		lamp.position = Vector3(0, top_y + 0.22, 0)
		root.add_child(lamp)
	elif dress == 1:
		_add_box(root, Vector3(-0.05, top_y + 0.01, 0.02), Vector3(0.14, 0.05, 0.18), _book_color(seed0), false)
		_add_box(root, Vector3(0.02, top_y + 0.06, 0.0), Vector3(0.12, 0.04, 0.16), _book_color(seed0 + 3), false)
		_add_box(root, Vector3(0.08, top_y + 0.11, -0.02), Vector3(0.1, 0.035, 0.14), _book_color(seed0 + 5), false)
		_add_cylinder(root, Vector3(0.12, top_y + 0.03, 0.1), 0.04, 0.12, CREAM.darkened(0.1), false, 0.75)
	elif dress == 2:
		# Porcelain vase + restrained bloom (not Minecraft fruit blobs)
		_add_cylinder(root, Vector3(0, top_y + 0.04, 0), 0.055, 0.1, CREAM.darkened(0.05), false, 0.7)
		_add_cylinder(root, Vector3(0, top_y + 0.12, 0), 0.04, 0.08, CREAM, false, 0.7)
		_add_cylinder(root, Vector3(0, top_y + 0.18, 0), 0.05, 0.03, CREAM.darkened(0.08), false, 0.7)
		_add_cylinder(root, Vector3(0.01, top_y + 0.26, 0.01), 0.012, 0.12, Color(0.22, 0.35, 0.16), false, 0.8)
		_add_sphere_blob(root, Vector3(0.03, top_y + 0.32, 0.02), 0.028, Color(0.62, 0.22, 0.22))
		_add_sphere_blob(root, Vector3(-0.02, top_y + 0.3, -0.01), 0.022, Color(0.72, 0.55, 0.28))
		_add_sphere_blob(root, Vector3(0.0, top_y + 0.34, -0.02), 0.02, Color(0.55, 0.2, 0.25))
	else:
		# Letters + pen tray (drawing-room identity)
		_add_box(root, Vector3(-0.04, top_y, 0.02), Vector3(0.16, 0.01, 0.11), PAPER, false)
		_add_box(root, Vector3(0.0, top_y + 0.012, 0.0), Vector3(0.14, 0.008, 0.1), PAPER.darkened(0.06), false)
		_add_cylinder(root, Vector3(0.06, top_y + 0.02, 0.04), 0.015, 0.006, Color(0.55, 0.12, 0.1), false, 0.6)
		_add_box(root, Vector3(0.12, top_y + 0.01, -0.05), Vector3(0.1, 0.02, 0.04), MAHOGANY_DARK, false, 0.45)
		_add_cylinder(root, Vector3(0.12, top_y + 0.03, -0.05), 0.006, 0.1, INK, false, 0.5)
	_add_contact_shadow(root, 0.34, 0.34)
	return root

static func _make_hall_table(prop: Dictionary) -> Node3D:
	## Hall console — seed forks base (turned / square / demi) + still-life kit.
	var root := Node3D.new()
	root.name = "HallTable"
	var seed0: int = int(prop.get("seed", 0))
	var base := seed0 % 3
	var dress := (seed0 / 3) % 4
	var top_y := 0.82
	if base == 0:
		# Classic turned-leg console
		_add_box(root, Vector3(0, top_y, 0), Vector3(1.4, 0.05, 0.5), MAHOGANY, true, 0.48)
		_add_box(root, Vector3(0, top_y - 0.04, 0), Vector3(1.35, 0.04, 0.46), MAHOGANY_DARK, false, 0.45)
		_add_box(root, Vector3(0, 0.4, 0), Vector3(1.15, 0.03, 0.4), MAHOGANY_DARK, false, 0.45)
		for sx in [-1.0, 1.0]:
			for sz in [-0.12, 0.12]:
				_add_cylinder(root, Vector3(sx * 0.52, 0.4, sz), 0.045, 0.78, MAHOGANY_DARK, true)
				_add_cylinder(root, Vector3(sx * 0.52, 0.02, sz), 0.06, 0.04, MAHOGANY, true)
	elif base == 1:
		# Square pedestal console (heavier, ebony feet)
		_add_box(root, Vector3(0, top_y, 0), Vector3(1.35, 0.06, 0.48), MAHOGANY_DARK, true, 0.45)
		_add_box(root, Vector3(0, top_y + 0.03, 0), Vector3(1.28, 0.02, 0.42), MAHOGANY, false, 0.42)
		for sx in [-0.48, 0.48]:
			_add_box(root, Vector3(sx, 0.4, 0), Vector3(0.14, 0.76, 0.38), Color(0.14, 0.1, 0.08), true, 0.5)
			_add_box(root, Vector3(sx, 0.04, 0), Vector3(0.18, 0.08, 0.42), MAHOGANY_DARK, true, 0.48)
		_add_box(root, Vector3(0, 0.22, 0), Vector3(0.9, 0.04, 0.32), MAHOGANY, false, 0.48)
	else:
		# Demi-lune against wall
		_add_box(root, Vector3(0, top_y, 0.06), Vector3(1.25, 0.05, 0.38), MAHOGANY, true, 0.48)
		_add_cylinder(root, Vector3(0, top_y, 0.06), 0.55, 0.05, MAHOGANY, true, 0.48)
		_add_cylinder(root, Vector3(-0.4, 0.4, 0.1), 0.04, 0.78, MAHOGANY_DARK, true)
		_add_cylinder(root, Vector3(0.4, 0.4, 0.1), 0.04, 0.78, MAHOGANY_DARK, true)
		_add_cylinder(root, Vector3(0.0, 0.4, -0.05), 0.045, 0.78, MAHOGANY_DARK, true)
		_add_box(root, Vector3(0, 0.35, 0.08), Vector3(0.7, 0.03, 0.15), MAHOGANY, false, 0.48)
	var ty := top_y + 0.05
	# Dressing kits — never clone the same still-life
	if dress == 0:
		# Calling cards + Argand lamp + clock
		_add_box(root, Vector3(-0.35, ty, 0.05), Vector3(0.36, 0.03, 0.22), MAHOGANY_DARK, false, 0.4)
		_add_box(root, Vector3(-0.35, ty + 0.03, 0.05), Vector3(0.28, 0.01, 0.16), PAPER, false)
		_add_box(root, Vector3(-0.32, ty + 0.045, 0.02), Vector3(0.2, 0.008, 0.11), PAPER.darkened(0.08), false)
		_add_box(root, Vector3(0.05, ty, 0.08), Vector3(0.14, 0.02, 0.09), CREAM.darkened(0.12), false, 0.9)
		_add_cylinder(root, Vector3(0.4, ty + 0.02, -0.05), 0.07, 0.05, BRASS, false, 0.3, true)
		_add_cylinder(root, Vector3(0.4, ty + 0.12, -0.05), 0.028, 0.16, BRASS.darkened(0.05), false, 0.3, true)
		_add_cylinder(root, Vector3(0.4, ty + 0.28, -0.05), 0.04, 0.2, Color(0.88, 0.9, 0.85), false, 0.4)
		_add_sphere_blob(root, Vector3(0.4, ty + 0.2, -0.05), 0.025, Color(1.0, 0.8, 0.4))
		_add_cylinder(root, Vector3(-0.05, ty + 0.1, -0.1), 0.05, 0.14, BRASS, false, 0.3, true)
		_add_box(root, Vector3(-0.05, ty + 0.2, -0.1), Vector3(0.08, 0.08, 0.04), Color(0.85, 0.82, 0.75), false, 0.5)
		var lamp0 := OmniLight3D.new()
		lamp0.light_color = Color(1.0, 0.85, 0.55)
		lamp0.light_energy = 0.6
		lamp0.omni_range = 3.2
		lamp0.position = Vector3(0.4, ty + 0.32, -0.05)
		root.add_child(lamp0)
	elif dress == 1:
		# Hat box + gloves + candlestick (no freestanding lamp clone)
		_add_cylinder(root, Vector3(-0.35, ty + 0.1, 0), 0.14, 0.18, Color(0.55, 0.28, 0.18), false, 0.75)
		_add_cylinder(root, Vector3(-0.35, ty + 0.2, 0), 0.15, 0.03, Color(0.48, 0.24, 0.14), false, 0.7)
		_add_box(root, Vector3(0.1, ty, 0.08), Vector3(0.18, 0.025, 0.12), CREAM.darkened(0.15), false, 0.9)
		_add_box(root, Vector3(0.12, ty + 0.02, 0.05), Vector3(0.12, 0.015, 0.08), CREAM.darkened(0.2), false, 0.9)
		_add_cylinder(root, Vector3(0.4, ty + 0.02, 0), 0.06, 0.04, BRASS, false, 0.3, true)
		_add_cylinder(root, Vector3(0.4, ty + 0.14, 0), 0.02, 0.2, CANDLE, false, 0.55)
		_add_sphere_blob(root, Vector3(0.4, ty + 0.28, 0), 0.03, Color(1.0, 0.78, 0.4))
		_add_box(root, Vector3(0.0, ty, -0.1), Vector3(0.22, 0.04, 0.14), MAHOGANY_DARK, false, 0.5)
		var lamp1 := OmniLight3D.new()
		lamp1.light_color = Color(1.0, 0.82, 0.5)
		lamp1.light_energy = 0.4
		lamp1.omni_range = 2.4
		lamp1.position = Vector3(0.4, ty + 0.32, 0)
		root.add_child(lamp1)
	elif dress == 2:
		# Flower vase + calling cards + ink tray
		_add_cylinder(root, Vector3(0.35, ty + 0.1, 0), 0.06, 0.18, CREAM.darkened(0.05), false, 0.7)
		_add_sphere_blob(root, Vector3(0.35, ty + 0.28, 0.02), 0.05, Color(0.65, 0.25, 0.28))
		_add_sphere_blob(root, Vector3(0.32, ty + 0.26, -0.03), 0.04, Color(0.75, 0.7, 0.35))
		_add_sphere_blob(root, Vector3(0.4, ty + 0.25, 0.0), 0.035, Color(0.5, 0.55, 0.3))
		_add_box(root, Vector3(-0.35, ty, 0.05), Vector3(0.3, 0.02, 0.18), PAPER, false)
		_add_box(root, Vector3(-0.32, ty + 0.015, 0.02), Vector3(0.22, 0.008, 0.12), PAPER.darkened(0.06), false)
		_add_box(root, Vector3(0.0, ty, -0.08), Vector3(0.16, 0.03, 0.1), MAHOGANY_DARK, false, 0.45)
		_add_cylinder(root, Vector3(0.02, ty + 0.05, -0.08), 0.015, 0.08, INK, false, 0.5)
	else:
		# Silver tray + correspondence + small oil font
		_add_box(root, Vector3(0.0, ty, 0.0), Vector3(0.55, 0.02, 0.32), BRASS.darkened(0.15), false, 0.3)
		_add_box(root, Vector3(0.0, ty + 0.015, 0.0), Vector3(0.5, 0.01, 0.28), BRASS.lightened(0.05), false, 0.28)
		_add_box(root, Vector3(-0.1, ty + 0.03, 0.02), Vector3(0.2, 0.01, 0.14), PAPER, false)
		_add_box(root, Vector3(-0.08, ty + 0.04, 0.0), Vector3(0.16, 0.008, 0.1), PAPER.darkened(0.05), false)
		_add_cylinder(root, Vector3(0.15, ty + 0.06, -0.05), 0.04, 0.08, BRASS, false, 0.3, true)
		_add_cylinder(root, Vector3(0.15, ty + 0.16, -0.05), 0.025, 0.12, Color(0.9, 0.92, 0.86), false, 0.4)
		_add_sphere_blob(root, Vector3(0.15, ty + 0.12, -0.05), 0.02, Color(1.0, 0.8, 0.4))
		_add_box(root, Vector3(0.35, ty + 0.02, 0.08), Vector3(0.12, 0.04, 0.08), Color(0.55, 0.12, 0.1), false)
		var lamp3 := OmniLight3D.new()
		lamp3.light_color = Color(1.0, 0.85, 0.55)
		lamp3.light_energy = 0.45
		lamp3.omni_range = 2.6
		lamp3.position = Vector3(0.15, ty + 0.2, -0.05)
		root.add_child(lamp3)
	_add_contact_shadow(root, 0.78, 0.38)
	return root

# ─── Kitchen identity ────────────────────────────────────────────────────────

static func _make_kitchen_range(_prop: Dictionary) -> Node3D:
	## Cast-iron Victorian kitchen range — loop 90: mid-grey iron + brass trim + emissive fire
	## so it reads as a working range, not a black monolith from the doorway.
	var root := Node3D.new()
	root.name = "KitchenRange"
	# Mid-grey iron that survives filmic tonemap (pure IRON → black mass)
	var iron_mid := Color(0.36, 0.36, 0.38)
	var iron_body := Color(0.30, 0.30, 0.32)
	var iron_dark := Color(0.24, 0.24, 0.26)
	var iron_light := Color(0.44, 0.44, 0.46)
	# Plinth / hearth base (stone + ash lip)
	_add_box(root, Vector3(0, 0.08, 0.05), Vector3(2.35, 0.16, 1.0), STONE, true, 0.7)
	_add_box(root, Vector3(0, 0.14, 0.42), Vector3(1.1, 0.04, 0.28), STONE.darkened(0.12), false, 0.75)
	# Main iron body
	_add_box(root, Vector3(0, 0.65, 0), Vector3(2.15, 1.1, 0.85), iron_body, true, 0.55)
	# Side panels + rivet strips
	_add_box(root, Vector3(-1.05, 0.65, 0.1), Vector3(0.08, 1.0, 0.7), iron_dark, false, 0.5)
	_add_box(root, Vector3(1.05, 0.65, 0.1), Vector3(0.08, 1.0, 0.7), iron_dark, false, 0.5)
	for side in [-1.0, 1.0]:
		for ri in 5:
			var ry := 0.28 + float(ri) * 0.18
			_add_cylinder(root, Vector3(side * 1.08, ry, 0.38), 0.016, 0.02, iron_light, false, 0.4)
	# Brass corner beading / trim rails (period range identity)
	_add_box(root, Vector3(0, 1.18, 0.44), Vector3(2.18, 0.03, 0.04), BRASS, false, 0.35)
	_add_box(root, Vector3(0, 0.18, 0.44), Vector3(2.18, 0.03, 0.04), BRASS.darkened(0.1), false, 0.35)
	_add_box(root, Vector3(-1.05, 0.65, 0.44), Vector3(0.04, 1.0, 0.03), BRASS.darkened(0.08), false, 0.35)
	_add_box(root, Vector3(1.05, 0.65, 0.44), Vector3(0.04, 1.0, 0.03), BRASS.darkened(0.08), false, 0.35)
	# Twin oven doors — fielded panels + hinges + brass bar handles
	for door_x in [-0.52, 0.52]:
		_add_box(root, Vector3(door_x, 0.52, 0.42), Vector3(0.72, 0.58, 0.07), iron_mid, false, 0.5)
		# Fielded recess
		_add_box(root, Vector3(door_x, 0.52, 0.47), Vector3(0.52, 0.4, 0.02), iron_dark, false, 0.55)
		# Inner raised panel
		_add_box(root, Vector3(door_x, 0.52, 0.485), Vector3(0.38, 0.28, 0.015), iron_light, false, 0.52)
		# Hinges
		_add_box(root, Vector3(door_x - 0.3, 0.72, 0.46), Vector3(0.06, 0.08, 0.04), BRASS, false, 0.32)
		_add_box(root, Vector3(door_x - 0.3, 0.32, 0.46), Vector3(0.06, 0.08, 0.04), BRASS, false, 0.32)
		# Horizontal brass handle bar
		_add_cylinder(root, Vector3(door_x + 0.12, 0.52, 0.52), 0.018, 0.28, BRASS, false, 0.3, true)
		_add_cylinder(root, Vector3(door_x + 0.12, 0.62, 0.52), 0.012, 0.04, BRASS.darkened(0.1), false, 0.3, true)
		_add_cylinder(root, Vector3(door_x + 0.12, 0.42, 0.52), 0.012, 0.04, BRASS.darkened(0.1), false, 0.3, true)
	# Centre firebox opening — grate + layered emissive flame (like fireplace loop 86)
	_add_box(root, Vector3(0, 0.38, 0.4), Vector3(0.62, 0.42, 0.08), iron_dark, false, 0.5)
	# Ash bed
	_add_box(root, Vector3(0, 0.2, 0.38), Vector3(0.55, 0.05, 0.22), Color(0.22, 0.18, 0.14), false, 0.85)
	# Grate bars
	for gi in 4:
		var gx := -0.2 + float(gi) * 0.13
		_add_box(root, Vector3(gx, 0.32, 0.42), Vector3(0.03, 0.22, 0.04), iron_dark.darkened(0.05), false, 0.45)
	# Logs
	_add_box(root, Vector3(-0.08, 0.28, 0.35), Vector3(0.4, 0.08, 0.12), MAHOGANY_DARK, false, 0.7)
	_add_box(root, Vector3(0.1, 0.34, 0.36), Vector3(0.32, 0.07, 0.1), MAHOGANY, false, 0.7)
	# Emissive flame layers
	for fi in 3:
		var em := MeshInstance3D.new()
		var em_mesh := BoxMesh.new()
		em_mesh.size = Vector3(0.4 - float(fi) * 0.08, 0.16 + float(fi) * 0.08, 0.035)
		em.mesh = em_mesh
		var emat := StandardMaterial3D.new()
		var warm := Color(1.0, 0.48 - float(fi) * 0.08, 0.1 + float(fi) * 0.06)
		emat.albedo_color = warm
		emat.emission_enabled = true
		emat.emission = warm
		emat.emission_energy_multiplier = 2.6 - float(fi) * 0.35
		emat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		em.material_override = emat
		em.position = Vector3(float(fi - 1) * 0.05, 0.36 + float(fi) * 0.07, 0.46 + float(fi) * 0.015)
		root.add_child(em)
	# Hotplate top with rings + brass ring rims
	_add_box(root, Vector3(0, 1.22, 0), Vector3(2.2, 0.09, 0.88), iron_dark, true, 0.45)
	for ring_x in [-0.55, 0.55]:
		_add_cylinder(root, Vector3(ring_x, 1.3, 0.05), 0.24, 0.04, iron_mid, false, 0.4)
		_add_cylinder(root, Vector3(ring_x, 1.33, 0.05), 0.22, 0.02, BRASS.darkened(0.2), false, 0.35, true)
		_add_cylinder(root, Vector3(ring_x, 1.34, 0.05), 0.12, 0.03, iron_dark, false, 0.45)
	# Mantel shelf + still-life
	_add_box(root, Vector3(0, 1.45, 0.15), Vector3(2.3, 0.06, 0.55), iron_mid, false, 0.45)
	_add_box(root, Vector3(0, 1.48, 0.15), Vector3(2.28, 0.02, 0.52), BRASS.darkened(0.15), false, 0.35)
	_add_cylinder(root, Vector3(-0.7, 1.58, 0.15), 0.09, 0.18, COPPER, false, 0.35, true)
	_add_cylinder(root, Vector3(0.55, 1.55, 0.15), 0.07, 0.14, CREAM.darkened(0.12), false, 0.8)
	_add_box(root, Vector3(0.1, 1.52, 0.2), Vector3(0.22, 0.04, 0.12), MAHOGANY, false, 0.5)
	_add_cylinder(root, Vector3(-0.25, 1.58, 0.18), 0.03, 0.16, CANDLE, false, 0.55)
	# Chimney flue + brass collar + crown (loop 97: not a black monolith)
	_add_box(root, Vector3(0, 1.95, -0.12), Vector3(0.55, 1.2, 0.45), iron_mid, true, 0.5)
	# Rivet strips up flue
	for ri in 4:
		var ry := 1.55 + float(ri) * 0.25
		_add_box(root, Vector3(-0.28, ry, 0.1), Vector3(0.04, 0.04, 0.04), iron_light, false, 0.45)
		_add_box(root, Vector3(0.28, ry, 0.1), Vector3(0.04, 0.04, 0.04), iron_light, false, 0.45)
	_add_box(root, Vector3(0, 1.55, -0.05), Vector3(0.7, 0.1, 0.58), BRASS.darkened(0.1), false, 0.35)
	_add_box(root, Vector3(0, 1.62, -0.05), Vector3(0.62, 0.04, 0.5), BRASS, false, 0.32)
	# Crown moulding
	_add_box(root, Vector3(0, 2.55, -0.12), Vector3(0.75, 0.08, 0.58), iron_mid.lightened(0.06), false, 0.5)
	_add_box(root, Vector3(0, 2.62, -0.12), Vector3(0.55, 0.06, 0.42), iron_dark, false, 0.5)
	# Smoke plate detail
	_add_box(root, Vector3(0, 2.1, 0.12), Vector3(0.35, 0.5, 0.04), iron_dark, false, 0.5)
	# Hanging pan rail above range
	_add_box(root, Vector3(0, 1.75, 0.35), Vector3(1.6, 0.04, 0.05), MAHOGANY_DARK, false, 0.5)
	_add_cylinder(root, Vector3(-0.4, 1.55, 0.38), 0.1, 0.08, COPPER, false, 0.35, true)
	_add_cylinder(root, Vector3(0.35, 1.52, 0.38), 0.09, 0.07, COPPER.lightened(0.05), false, 0.35, true)
	var fire := OmniLight3D.new()
	fire.light_color = Color(1.0, 0.52, 0.2)
	fire.light_energy = 1.85
	fire.omni_range = 6.2
	fire.position = Vector3(0, 0.5, 0.55)
	root.add_child(fire)
	# Copper kettle on hotplate
	_add_cylinder(root, Vector3(-0.55, 1.45, 0.05), 0.13, 0.22, COPPER, false, 0.35, true)
	_add_cylinder(root, Vector3(-0.55, 1.58, 0.05), 0.05, 0.1, COPPER, false, 0.35, true)
	_add_box(root, Vector3(-0.35, 1.48, 0.05), Vector3(0.18, 0.03, 0.03), COPPER, false, 0.35)
	# Iron skillet with brass handle
	_add_cylinder(root, Vector3(0.55, 1.36, 0.05), 0.16, 0.05, iron_dark, false, 0.4)
	_add_box(root, Vector3(0.78, 1.36, 0.05), Vector3(0.22, 0.025, 0.04), BRASS.darkened(0.15), false, 0.35)
	_add_contact_shadow(root, 1.2, 0.55)
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
			# Copper bowl
			_add_cylinder(root, Vector3(px, 1.66, 0.04), 0.08, 0.1, COPPER, false, 0.35, true)
			_add_cylinder(root, Vector3(px, 1.72, 0.04), 0.09, 0.02, COPPER.lightened(0.08), false, 0.32, true)
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
	# Work-top: jars + copper (base cupboard top)
	_add_cylinder(root, Vector3(0.5, 1.18, 0.08), 0.07, 0.18, CLAY if seed0 % 2 == 0 else CLAY.darkened(0.08), false, 0.8)
	_add_cylinder(root, Vector3(0.5, 1.28, 0.08), 0.05, 0.04, CLAY.darkened(0.1), false, 0.8)
	_add_cylinder(root, Vector3(0.65, 1.14, 0.02), 0.06, 0.14, CLAY.lightened(0.1), false, 0.8)
	_add_cylinder(root, Vector3(-0.5, 1.16, 0.08), 0.08, 0.16, COPPER if seed0 % 2 == 0 else COPPER.darkened(0.1), false, 0.35, true)
	_add_cylinder(root, Vector3(-0.28, 1.14, 0.02), 0.06, 0.12, COPPER.darkened(0.08), false, 0.35, true)
	_add_box(root, Vector3(0.1, 1.1, 0.1), Vector3(0.2, 0.03, 0.14), CREAM.darkened(0.05), false, 0.85)
	_add_contact_shadow(root, 0.9, 0.3)
	return root

static func _make_sink(prop: Dictionary) -> Node3D:
	## Scullery sink — oak base, stoneware basin, pump, drain board (loop 80 identity).
	var root := Node3D.new()
	root.name = "Sink"
	var seed0: int = int(prop.get("seed", 0))
	var wood := OAK if seed0 % 2 == 0 else Color(0.48, 0.34, 0.2)
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
	# Stoneware basin with raised rim + wet well
	_add_box(root, Vector3(0, 0.9, 0.02), Vector3(1.12, 0.1, 0.55), STONE.lightened(0.08), false, 0.55)
	_add_box(root, Vector3(0, 0.96, 0.02), Vector3(0.95, 0.05, 0.42), STONE, false, 0.45)
	_add_box(root, Vector3(0, 0.93, 0.02), Vector3(0.72, 0.08, 0.28), Color(0.32, 0.38, 0.42), false, 0.3)
	# Drain board (sloped scrubbed wood) beside basin
	_add_box(root, Vector3(-0.55, 0.94, 0.05), Vector3(0.28, 0.04, 0.4), OAK.lightened(0.15), false, 0.65)
	_add_box(root, Vector3(-0.55, 0.97, 0.05), Vector3(0.24, 0.015, 0.12), OAK.lightened(0.05), false, 0.6)
	_add_box(root, Vector3(-0.55, 0.97, -0.08), Vector3(0.24, 0.015, 0.12), OAK.lightened(0.05), false, 0.6)
	# Backsplash tile strip
	_add_box(root, Vector3(0, 1.15, -0.22), Vector3(1.1, 0.35, 0.04), CREAM.darkened(0.05), false, 0.75)
	_add_box(root, Vector3(0, 1.05, -0.2), Vector3(1.05, 0.04, 0.02), Color(0.55, 0.58, 0.52), false, 0.7)
	# Hand pump + spout + handle
	_add_cylinder(root, Vector3(0.28, 1.18, -0.08), 0.035, 0.4, BRASS.darkened(0.05), false, 0.3, true)
	_add_cylinder(root, Vector3(0.28, 1.4, -0.08), 0.05, 0.06, BRASS, false, 0.28, true)
	_add_box(root, Vector3(0.1, 1.35, 0.02), Vector3(0.38, 0.035, 0.035), BRASS, false, 0.3)
	_add_cylinder(root, Vector3(-0.08, 1.3, 0.08), 0.022, 0.1, BRASS, false, 0.3, true)
	_add_box(root, Vector3(0.4, 1.25, -0.05), Vector3(0.04, 0.18, 0.04), BRASS.darkened(0.08), false, 0.3)
	_add_box(root, Vector3(0.48, 1.32, -0.05), Vector3(0.12, 0.03, 0.03), BRASS, false, 0.3)
	# Still-life fork (soap, cloth, crock / copper)
	if seed0 % 2 == 0:
		_add_box(root, Vector3(-0.35, 0.99, 0.15), Vector3(0.12, 0.035, 0.08), CREAM, false, 0.85)
		_add_box(root, Vector3(-0.2, 0.97, 0.18), Vector3(0.18, 0.02, 0.12), Color(0.72, 0.76, 0.78), false, 0.7)
		_add_cylinder(root, Vector3(0.4, 1.02, 0.12), 0.05, 0.12, CREAM.darkened(0.1), false, 0.8)
		_add_cylinder(root, Vector3(0.42, 1.1, 0.12), 0.03, 0.04, CREAM.darkened(0.15), false, 0.8)
	else:
		_add_cylinder(root, Vector3(-0.32, 1.02, 0.1), 0.055, 0.14, COPPER, false, 0.35, true)
		_add_box(root, Vector3(0.32, 0.98, 0.14), Vector3(0.16, 0.02, 0.1), CREAM.darkened(0.05), false, 0.85)
		_add_cylinder(root, Vector3(0.35, 1.02, 0.1), 0.04, 0.08, CLAY, false, 0.8)
		_add_box(root, Vector3(-0.1, 0.97, 0.2), Vector3(0.14, 0.015, 0.1), Color(0.65, 0.7, 0.72), false, 0.7)
	_add_contact_shadow(root, 0.62, 0.36)
	return root

static func _make_prep_table(prop: Dictionary) -> Node3D:
	## Scrubbed kitchen prep table — loop 84 still-life kits (not bare cylinders).
	var root := Node3D.new()
	root.name = "PrepTable"
	var width: float = prop.get("width", 1.8)
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
	# Lower shelf storage
	_add_box(root, Vector3(0, 0.28, 0), Vector3(width * 0.72, 0.03, 0.55), OAK.lightened(0.05), false, 0.6)
	if kit % 2 == 0:
		_add_cylinder(root, Vector3(-width * 0.22, 0.4, 0.1), 0.08, 0.16, CLAY, false, 0.8)
		_add_cylinder(root, Vector3(width * 0.18, 0.38, -0.05), 0.09, 0.12, COPPER.darkened(0.1), false, 0.35, true)
	else:
		_add_box(root, Vector3(-width * 0.15, 0.36, 0.05), Vector3(0.22, 0.12, 0.16), OAK.darkened(0.1), false, 0.6)
		_add_cylinder(root, Vector3(width * 0.2, 0.38, -0.08), 0.07, 0.14, CREAM.darkened(0.12), false, 0.85)
	match kit:
		0:
			# Loop 100: flour sack (cylinder body + cinched neck) + banded stoneware
			var sack := Color(0.7, 0.6, 0.42)
			var sack_d := Color(0.52, 0.42, 0.28)
			# Soft sack body (stacked cylinders read as cloth, not a crate)
			_add_cylinder(root, Vector3(-0.48, 0.96, 0.08), 0.11, 0.22, sack, false, 0.9)
			_add_cylinder(root, Vector3(-0.48, 1.08, 0.08), 0.09, 0.08, sack_d, false, 0.9)
			_add_cylinder(root, Vector3(-0.48, 1.14, 0.08), 0.05, 0.06, sack_d.darkened(0.08), false, 0.88)
			# Twine + fold wrinkles
			_add_cylinder(root, Vector3(-0.48, 1.08, 0.08), 0.095, 0.02, Color(0.38, 0.3, 0.18), false, 0.8)
			_add_box(root, Vector3(-0.4, 0.98, 0.08), Vector3(0.04, 0.16, 0.12), sack.darkened(0.06), false, 0.9)
			# Stoneware crock (banded)
			var ware := Color(0.72, 0.62, 0.48)
			_add_cylinder(root, Vector3(-0.15, 0.96, 0.18), 0.09, 0.18, ware, false, 0.82)
			_add_cylinder(root, Vector3(-0.15, 0.92, 0.18), 0.095, 0.03, Color(0.32, 0.24, 0.16), false, 0.7)
			_add_cylinder(root, Vector3(-0.15, 1.0, 0.18), 0.095, 0.025, Color(0.32, 0.24, 0.16), false, 0.7)
			_add_cylinder(root, Vector3(-0.15, 1.07, 0.18), 0.08, 0.035, ware.darkened(0.1), false, 0.82)
			# Flour dust smear
			_add_box(root, Vector3(-0.05, 0.865, 0.05), Vector3(0.35, 0.008, 0.25), CREAM.lightened(0.05), false, 0.95)
			# Dough board + loaf
			_add_box(root, Vector3(0.25, 0.875, -0.1), Vector3(0.38, 0.03, 0.28), OAK.lightened(0.15), false, 0.65)
			_add_box(root, Vector3(0.22, 0.9, -0.08), Vector3(0.22, 0.05, 0.14), CREAM.darkened(0.15), false, 0.85)
			# Knife on rest
			_add_box(root, Vector3(0.55, 0.875, 0.15), Vector3(0.28, 0.015, 0.06), OAK, false, 0.55)
			_add_box(root, Vector3(0.62, 0.885, 0.15), Vector3(0.2, 0.012, 0.03), IRON.lightened(0.1), false, 0.35)
			_add_box(root, Vector3(0.48, 0.885, 0.15), Vector3(0.06, 0.02, 0.035), Color(0.35, 0.22, 0.12), false, 0.6)
			# Copper basin + rag
			_add_cylinder(root, Vector3(0.05, 0.92, 0.22), 0.11, 0.1, COPPER, false, 0.35, true)
			_add_cylinder(root, Vector3(0.05, 0.98, 0.22), 0.12, 0.02, COPPER.lightened(0.08), false, 0.32, true)
			_add_box(root, Vector3(0.55, 0.88, -0.15), Vector3(0.14, 0.02, 0.1), Color(0.55, 0.48, 0.38), false, 0.85)
		1:
			# Bread board, glazed pie dish, stoneware crock, copper colander, ladle
			_add_box(root, Vector3(-0.45, 0.875, 0.05), Vector3(0.5, 0.03, 0.32), OAK.lightened(0.18), false, 0.65)
			_add_box(root, Vector3(-0.45, 0.9, 0.05), Vector3(0.28, 0.04, 0.14), CREAM.darkened(0.15), false, 0.85)
			_add_cylinder(root, Vector3(0.05, 0.9, 0.12), 0.11, 0.05, Color(0.55, 0.22, 0.18), false, 0.7)
			_add_cylinder(root, Vector3(0.05, 0.93, 0.12), 0.1, 0.03, Color(0.62, 0.28, 0.2), false, 0.65)
			_add_cylinder(root, Vector3(0.35, 1.02, -0.05), 0.08, 0.26, CLAY, false, 0.8)
			_add_cylinder(root, Vector3(0.35, 1.16, -0.05), 0.07, 0.04, CLAY.darkened(0.12), false, 0.8)
			_add_cylinder(root, Vector3(0.55, 0.95, 0.12), 0.1, 0.12, COPPER.lightened(0.05), false, 0.35, true)
			_add_cylinder(root, Vector3(0.55, 1.02, 0.12), 0.09, 0.02, COPPER, false, 0.32, true)
			# Ladle across
			_add_box(root, Vector3(0.2, 0.9, -0.2), Vector3(0.35, 0.02, 0.025), IRON, false, 0.4)
			_add_cylinder(root, Vector3(0.0, 0.9, -0.2), 0.04, 0.03, COPPER.darkened(0.05), false, 0.35, true)
		2:
			# Market veg: wicker basket, roots, chop block, salt crock, tea towel
			_add_box(root, Vector3(-0.4, 0.9, 0.05), Vector3(0.32, 0.14, 0.26), Color(0.5, 0.36, 0.2), false, 0.7)
			_add_box(root, Vector3(-0.4, 0.99, 0.05), Vector3(0.28, 0.04, 0.22), Color(0.42, 0.3, 0.16), false, 0.7)
			# Greens + roots peeking
			_add_box(root, Vector3(-0.4, 1.04, 0.05), Vector3(0.22, 0.05, 0.16), Color(0.28, 0.42, 0.18), false, 0.85)
			_add_cylinder(root, Vector3(-0.35, 1.02, 0.12), 0.025, 0.1, Color(0.85, 0.45, 0.15), false, 0.7)
			_add_cylinder(root, Vector3(-0.42, 1.02, 0.0), 0.022, 0.12, Color(0.9, 0.5, 0.18), false, 0.7)
			_add_cylinder(root, Vector3(-0.3, 1.0, -0.02), 0.03, 0.08, Color(0.75, 0.25, 0.15), false, 0.7)
			# Chop block + knife
			_add_box(root, Vector3(0.3, 0.88, -0.08), Vector3(0.4, 0.06, 0.3), OAK.lightened(0.1), false, 0.6)
			_add_box(root, Vector3(0.35, 0.92, -0.02), Vector3(0.2, 0.015, 0.035), IRON, false, 0.35)
			_add_box(root, Vector3(0.22, 0.92, -0.02), Vector3(0.06, 0.02, 0.03), Color(0.32, 0.2, 0.1), false, 0.6)
			# Salt crock
			_add_cylinder(root, Vector3(0.55, 0.95, 0.18), 0.05, 0.12, CREAM.darkened(0.06), false, 0.85)
			_add_cylinder(root, Vector3(0.55, 1.02, 0.18), 0.04, 0.03, CREAM.darkened(0.12), false, 0.85)
			_add_box(root, Vector3(0.1, 0.875, 0.25), Vector3(0.18, 0.015, 0.12), Color(0.7, 0.72, 0.68), false, 0.8)
		_:
			# Pastry: rolling pin, flour dust, butter crock, mixing bowl, cutters
			_add_cylinder(root, Vector3(-0.35, 0.9, 0.05), 0.032, 0.42, OAK.lightened(0.12), false, 0.6)
			_add_cylinder(root, Vector3(-0.55, 0.9, 0.05), 0.04, 0.06, MAHOGANY, false, 0.55)
			_add_cylinder(root, Vector3(-0.15, 0.9, 0.05), 0.04, 0.06, MAHOGANY, false, 0.55)
			_add_box(root, Vector3(0.1, 0.865, 0.1), Vector3(0.4, 0.012, 0.3), CREAM.lightened(0.08), false, 0.92)
			# Butter crock
			_add_cylinder(root, Vector3(0.45, 0.94, -0.12), 0.08, 0.1, CREAM.darkened(0.12), false, 0.85)
			_add_cylinder(root, Vector3(0.45, 1.02, -0.12), 0.07, 0.05, CREAM.darkened(0.18), false, 0.85)
			_add_cylinder(root, Vector3(0.45, 1.06, -0.12), 0.03, 0.03, CLAY.darkened(0.05), false, 0.8)
			# Mixing bowl
			_add_cylinder(root, Vector3(0.15, 0.92, -0.18), 0.12, 0.1, CLAY.lightened(0.05), false, 0.8)
			_add_cylinder(root, Vector3(0.15, 0.98, -0.18), 0.13, 0.02, CLAY, false, 0.75)
			# Copper measure
			_add_cylinder(root, Vector3(-0.1, 0.92, 0.22), 0.06, 0.1, COPPER, false, 0.35, true)
			_add_box(root, Vector3(0.35, 0.875, 0.2), Vector3(0.12, 0.02, 0.08), IRON.lightened(0.15), false, 0.4)
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
			# Stone flags (conservatory) — loop 95: irregular pavers + moss, not pale Minecraft slabs
			var pw := width * (0.78 + float(i % 3) * 0.08)
			var pd := 0.46 + float((i + seed0) % 2) * 0.06
			var col := STONE.lightened(0.04) if (i + seed0) % 2 == 0 else STONE.darkened(0.06)
			if (i + seed0) % 3 == 0:
				col = Color(0.5, 0.48, 0.42)
			# Raised flag body
			_add_box(root, Vector3(ox, 0.025, z), Vector3(pw, 0.04, pd), col, false, 0.7)
			# Bevel / edge shadow
			_add_box(root, Vector3(ox, 0.012, z), Vector3(pw * 1.02, 0.012, pd * 1.02), Color(0.38, 0.36, 0.32), false, 0.8)
			# Mortar seam
			_add_box(root, Vector3(ox, 0.018, z + pd * 0.48), Vector3(pw * 0.9, 0.01, 0.04), Color(0.42, 0.4, 0.36), false, 0.85)
			# Moss tuft on corners (period damp conservatory)
			if (i + seed0) % 3 != 1:
				_add_box(
					root,
					Vector3(ox + pw * 0.28, 0.04, z - pd * 0.2),
					Vector3(0.08, 0.012, 0.06),
					Color(0.22, 0.38, 0.18), false, 0.9
				)
			if (i + seed0) % 4 == 0:
				_add_box(
					root,
					Vector3(ox - pw * 0.25, 0.038, z + pd * 0.15),
					Vector3(0.06, 0.01, 0.05),
					Color(0.28, 0.42, 0.2), false, 0.9
				)
	# Stone path side gravel curb
	if surface == "stone":
		_add_box(root, Vector3(-width * 0.5, 0.015, 0), Vector3(0.08, 0.025, length * 0.95), Color(0.48, 0.45, 0.4), false, 0.75)
		_add_box(root, Vector3(width * 0.5, 0.015, 0), Vector3(0.08, 0.025, length * 0.95), Color(0.48, 0.45, 0.4), false, 0.75)
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
		# Teak garden settle (loop 101) — solid high-back only (no picket/window grid)
		var teak := Color(0.42, 0.28, 0.14)
		var teak_d := Color(0.3, 0.18, 0.08)
		var teak_l := Color(0.52, 0.36, 0.18)
		# Solid seat plank
		_add_box(root, Vector3(0, seat_y - 0.02, 0.02), Vector3(w * 0.96, 0.08, seat_d), teak, true, 0.55)
		_add_box(root, Vector3(0, seat_y + 0.025, 0.02), Vector3(w * 0.93, 0.03, seat_d * 0.9), teak_l, false, 0.58)
		_add_box(root, Vector3(0, seat_y + 0.01, 0.24), Vector3(w * 0.95, 0.04, 0.035), teak_d, false, 0.55)
		# Full solid back slab (front + rear — never empty or grid)
		_add_box(root, Vector3(0, 0.82, -0.2), Vector3(w * 0.9, 0.7, 0.07), teak_d, true, 0.52)
		_add_box(root, Vector3(0, 0.82, -0.16), Vector3(w * 0.86, 0.64, 0.03), teak, false, 0.55)
		# Three horizontal face rails only (settle language, not window panes)
		_add_box(root, Vector3(0, 0.58, -0.14), Vector3(w * 0.84, 0.05, 0.04), teak_l, false, 0.5)
		_add_box(root, Vector3(0, 0.85, -0.14), Vector3(w * 0.84, 0.04, 0.04), teak, false, 0.5)
		_add_box(root, Vector3(0, 1.1, -0.14), Vector3(w * 0.88, 0.07, 0.05), teak_l, true, 0.5)
		# Soft crest curve
		_add_box(root, Vector3(0, 1.16, -0.13), Vector3(w * 0.4, 0.04, 0.04), teak, false, 0.5)
		# Side uprights flush with back
		for sx in [-1.0, 1.0]:
			var ex: float = sx * w * 0.44
			_add_box(root, Vector3(ex, 0.8, -0.18), Vector3(0.1, 0.72, 0.1), teak_d, true, 0.5)
			# Arm + solid side panel
			_add_box(root, Vector3(ex, 0.58, 0.02), Vector3(0.1, 0.14, 0.46), teak, true, 0.52)
			_add_box(root, Vector3(ex, 0.68, 0.02), Vector3(0.11, 0.05, 0.48), teak_l, false, 0.5)
			_add_box(root, Vector3(ex, 0.55, -0.02), Vector3(0.06, 0.35, 0.36), teak_d, false, 0.55)
			# Legs
			_add_box(root, Vector3(ex, 0.22, 0.16), Vector3(0.08, 0.4, 0.08), teak_d, true, 0.52)
			_add_box(root, Vector3(ex, 0.22, -0.16), Vector3(0.08, 0.4, 0.08), teak_d, true, 0.52)
			_add_box(root, Vector3(ex, 0.03, 0.16), Vector3(0.1, 0.04, 0.12), teak, true, 0.52)
			_add_box(root, Vector3(ex, 0.03, -0.16), Vector3(0.1, 0.04, 0.12), teak, true, 0.52)
		_add_box(root, Vector3(0, 0.16, 0.0), Vector3(w * 0.82, 0.04, 0.05), teak_d, false, 0.55)
		_add_box(root, Vector3(0, 0.16, 0.0), Vector3(0.05, 0.04, 0.32), teak_d, false, 0.55)
	_add_contact_shadow(root, w * 0.5, 0.38)
	return root


static func _make_urn(prop: Dictionary) -> Node3D:
	## Stone / terracotta pedestal urn — loop 102: trailing ivy only (no green cubes).
	var root := Node3D.new()
	root.name = "Urn"
	var seed0: int = int(prop.get("seed", 0))
	var scale: float = float(prop.get("scale", 1.0))
	var body := STONE if seed0 % 2 == 0 else CLAY
	_add_cylinder(root, Vector3(0, 0.12 * scale, 0), 0.22 * scale, 0.2 * scale, body.darkened(0.05), true, 0.7)
	_add_cylinder(root, Vector3(0, 0.35 * scale, 0), 0.12 * scale, 0.28 * scale, body, true, 0.7)
	_add_cylinder(root, Vector3(0, 0.55 * scale, 0), 0.2 * scale, 0.12 * scale, body.lightened(0.05), false, 0.7)
	_add_cylinder(root, Vector3(0, 0.62 * scale, 0), 0.16 * scale, 0.05 * scale, body.darkened(0.08), false, 0.7)
	# Soil pad
	_add_cylinder(root, Vector3(0, 0.64 * scale, 0), 0.14 * scale, 0.04 * scale, Color(0.18, 0.12, 0.08), false, 0.9)
	var leaf_a := Color(0.18, 0.4, 0.14)
	var leaf_b := Color(0.12, 0.32, 0.1)
	var stem_c := Color(0.26, 0.22, 0.1)
	# Thin upright stems
	for si in 4:
		var sa := float(si) * 0.9 + float(seed0) * 0.25
		var sx: float = cos(sa) * 0.04 * scale
		var sz: float = sin(sa) * 0.04 * scale
		_add_cylinder(root, Vector3(sx, 0.78 * scale, sz), 0.008 * scale, 0.24 * scale, stem_c, false, 0.85)
	# Trailing vines down urn sides (thin stems + tiny leaves)
	for i in 5:
		var ang := float(i) * TAU / 5.0 + float(seed0) * 0.4
		var lx: float = cos(ang) * 0.14 * scale
		var lz: float = sin(ang) * 0.14 * scale
		# Vine stem hanging down
		_add_cylinder(root, Vector3(lx, 0.55 * scale, lz), 0.008 * scale, 0.28 * scale, stem_c, false, 0.85)
		# Tiny leaf pairs along vine (thin, not cubes)
		for j in 3:
			var jy: float = 0.68 * scale - float(j) * 0.08 * scale
			_add_box(root, Vector3(lx + cos(ang) * 0.03 * scale, jy, lz + sin(ang) * 0.03 * scale),
				Vector3(0.05 * scale, 0.012 * scale, 0.02 * scale), leaf_a if j % 2 == 0 else leaf_b, false, 0.92)
		# Crown tip fronds (very thin vertical blades)
		_add_box(root, Vector3(lx * 0.4, 0.88 * scale, lz * 0.4),
			Vector3(0.015 * scale, 0.12 * scale, 0.04 * scale), leaf_b, false, 0.92)
	_add_contact_shadow(root, 0.25 * scale, 0.25 * scale)
	return root


static func _make_watering_can(prop: Dictionary) -> Node3D:
	## Copper watering can — conservatory service prop.
	var root := Node3D.new()
	root.name = "WateringCan"
	var scale: float = float(prop.get("scale", 1.0))
	_add_cylinder(root, Vector3(0, 0.12 * scale, 0), 0.1 * scale, 0.2 * scale, COPPER, true, 0.35, true)
	_add_cylinder(root, Vector3(0, 0.24 * scale, 0), 0.11 * scale, 0.04 * scale, COPPER.lightened(0.08), false, 0.32, true)
	_add_box(root, Vector3(0.14 * scale, 0.16 * scale, 0), Vector3(0.16 * scale, 0.04 * scale, 0.04 * scale), COPPER, false, 0.35)
	_add_cylinder(root, Vector3(0.22 * scale, 0.14 * scale, 0), 0.03 * scale, 0.06 * scale, COPPER.darkened(0.05), false, 0.35, true)
	_add_box(root, Vector3(-0.02 * scale, 0.28 * scale, 0), Vector3(0.04 * scale, 0.12 * scale, 0.03 * scale), COPPER.darkened(0.08), false, 0.35)
	_add_contact_shadow(root, 0.14 * scale, 0.12 * scale)
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
		# Straight arm + frosted cup
		_add_box(root, Vector3(0, y, 0.1), Vector3(0.035, 0.035, 0.14), BRASS, false, 0.3)
		_add_cylinder(root, Vector3(0, y - 0.04, 0.18), 0.055, 0.1, Color(0.9, 0.86, 0.7), false, 0.45)
	elif style == 1:
		# Curved double-scroll arm + glass globe
		_add_box(root, Vector3(0.04, y - 0.02, 0.08), Vector3(0.1, 0.03, 0.03), BRASS, false, 0.3)
		_add_box(root, Vector3(0.08, y - 0.06, 0.12), Vector3(0.03, 0.1, 0.03), BRASS.darkened(0.05), false, 0.3)
		_add_sphere_blob(root, Vector3(0.08, y - 0.14, 0.16), 0.06, Color(0.92, 0.9, 0.78))
	else:
		# Candle plate sconce
		_add_box(root, Vector3(0, y - 0.02, 0.1), Vector3(0.03, 0.03, 0.12), BRASS, false, 0.3)
		_add_cylinder(root, Vector3(0, y - 0.06, 0.16), 0.07, 0.02, BRASS.lightened(0.05), false, 0.28, true)
		_add_cylinder(root, Vector3(0, y + 0.02, 0.16), 0.018, 0.14, CANDLE, false, 0.55)
		_add_sphere_blob(root, Vector3(0, y + 0.1, 0.16), 0.025, Color(1.0, 0.78, 0.35))
	var lamp := OmniLight3D.new()
	lamp.light_color = Color(1.0, 0.85, 0.55)
	lamp.light_energy = 0.5 + float(style) * 0.06
	lamp.omni_range = 3.2 + float(style) * 0.3
	lamp.position = Vector3(0.0 if style != 1 else 0.08, y - 0.06, 0.18)
	root.add_child(lamp)
	return root


static func _make_oil_lamp(prop: Dictionary) -> Node3D:
	## Argand oil lamp (loop 102): short amber chimney in brass cage —
	## never a tall pale toilet-paper tube.
	var root := Node3D.new()
	root.name = "OilLamp"
	var h: float = float(prop.get("height", 1.05))
	var ppos: Array = prop.get("pos", [0, 0, 0])
	var seed0: int = int(prop.get("seed", int(absf(h * 17.0 + float(ppos[0]) * 7.0 + float(ppos[2]) * 11.0))))
	var style := seed0 % 3
	# Stem height scales; chimney is FIXED short size so tall props stay readable
	var stem_top: float = clampf(h * 0.48, 0.38, 0.58)
	if style == 0:
		# Mahogany pedestal Argand
		_add_cylinder(root, Vector3(0, 0.04, 0), 0.12, 0.08, MAHOGANY_DARK, true, 0.5)
		_add_cylinder(root, Vector3(0, 0.12, 0), 0.08, 0.1, MAHOGANY, true, 0.48)
		_add_cylinder(root, Vector3(0, stem_top * 0.55, 0), 0.035, stem_top * 0.7, BRASS, true, 0.3, true)
	elif style == 1:
		# Brass tripod
		_add_cylinder(root, Vector3(0, 0.05, 0), 0.1, 0.06, BRASS.darkened(0.1), true, 0.32, true)
		for a in [0.0, 120.0, 240.0]:
			var rad := deg_to_rad(a)
			_add_box(root, Vector3(cos(rad) * 0.1, 0.03, sin(rad) * 0.1), Vector3(0.14, 0.03, 0.04), BRASS, true, 0.32)
		_add_cylinder(root, Vector3(0, stem_top * 0.55, 0), 0.03, stem_top * 0.75, BRASS.lightened(0.05), true, 0.28, true)
	else:
		# Ebony base + copper stem
		_add_box(root, Vector3(0, 0.04, 0), Vector3(0.18, 0.08, 0.18), Color(0.1, 0.08, 0.07), true, 0.55)
		_add_box(root, Vector3(0, 0.12, 0), Vector3(0.12, 0.06, 0.12), Color(0.14, 0.1, 0.08), true, 0.5)
		_add_cylinder(root, Vector3(0, stem_top * 0.55, 0), 0.032, stem_top * 0.7, COPPER, true, 0.35, true)
	# Bulbous oil font (wide, metal-dominant)
	var font_c := BRASS.darkened(0.05) if style != 2 else COPPER.darkened(0.05)
	var fy: float = stem_top + 0.02
	_add_cylinder(root, Vector3(0, fy, 0), 0.11, 0.1, font_c, false, 0.28, true)
	_add_cylinder(root, Vector3(0, fy + 0.07, 0), 0.09, 0.05, font_c.lightened(0.08), false, 0.28, true)
	# Brass gallery / burner collar
	_add_cylinder(root, Vector3(0, fy + 0.11, 0), 0.065, 0.035, BRASS, false, 0.28, true)
	_add_cylinder(root, Vector3(0, fy + 0.14, 0), 0.05, 0.025, BRASS.darkened(0.08), false, 0.3, true)
	# Short amber chimney (fixed ~0.14 tall) + brass cage ribs
	var glass := Color(0.72, 0.58, 0.32)
	var glass_hi := Color(0.82, 0.68, 0.4)
	var cy: float = fy + 0.22
	_add_cylinder(root, Vector3(0, cy, 0), 0.045, 0.14, glass, false, 0.42)
	_add_cylinder(root, Vector3(0, cy, 0), 0.032, 0.12, glass_hi, false, 0.38)
	# Vertical brass cage (4 ribs) so silhouette reads as lamp not paper roll
	for i in 4:
		var ang := float(i) * TAU / 4.0 + 0.2
		_add_box(root, Vector3(cos(ang) * 0.048, cy, sin(ang) * 0.048), Vector3(0.012, 0.13, 0.012), BRASS.darkened(0.05), false, 0.3)
	# Top cap + bottom collar ring
	_add_cylinder(root, Vector3(0, cy + 0.08, 0), 0.04, 0.03, BRASS, false, 0.28, true)
	_add_cylinder(root, Vector3(0, cy - 0.08, 0), 0.05, 0.02, BRASS.darkened(0.1), false, 0.3, true)
	# Flame glow inside
	_add_sphere_blob(root, Vector3(0, cy - 0.02, 0), 0.028, Color(1.0, 0.78, 0.35))
	var light := OmniLight3D.new()
	light.light_color = Color(1.0, 0.84, 0.52)
	light.light_energy = 0.9 + float(style) * 0.08
	light.omni_range = 4.0 + float(style) * 0.3
	light.position = Vector3(0, cy, 0)
	root.add_child(light)
	_add_contact_shadow(root, 0.14, 0.14)
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
	## Wall copper pan rail — varied pans + ladles (loop 80 side volume).
	var root := Node3D.new()
	root.name = "PotRack"
	var seed0: int = int(prop.get("seed", 0))
	_add_box(root, Vector3(0, 2.2, 0), Vector3(2.05, 0.08, 0.12), MAHOGANY_DARK, true, 0.5)
	_add_box(root, Vector3(-0.95, 1.75, 0), Vector3(0.07, 0.95, 0.07), MAHOGANY, true, 0.5)
	_add_box(root, Vector3(0.95, 1.75, 0), Vector3(0.07, 0.95, 0.07), MAHOGANY, true, 0.5)
	# Cross brace
	_add_box(root, Vector3(0, 1.85, 0), Vector3(1.85, 0.04, 0.05), MAHOGANY_DARK, false, 0.5)
	# 5 hangers: pans + ladle/spoon mix
	for i in 5:
		var x := -0.7 + i * 0.35
		_add_cylinder(root, Vector3(x, 2.08, 0.06), 0.012, 0.14, IRON, false, 0.4)
		var pr: float = 0.08 + float((i * 3 + seed0) % 5) * 0.028
		var ph: float = 0.055 + float((i + seed0 * 2) % 4) * 0.032
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
			_add_cylinder(root, Vector3(x, 1.82, 0.1), pr, ph, pcol, false, 0.35, true)
			_add_cylinder(root, Vector3(x, 1.72, 0.1), pr + 0.02, 0.03, pcol.lightened(0.08), false, 0.35, true)
		elif shape == 1:
			_add_cylinder(root, Vector3(x, 1.78, 0.1), pr * 1.2, ph * 0.7, pcol, false, 0.35, true)
			_add_box(root, Vector3(x + pr * 0.85, 1.78, 0.1), Vector3(0.1, 0.025, 0.04), pcol, false, 0.35)
		elif shape == 2:
			_add_cylinder(root, Vector3(x, 1.85, 0.1), pr * 0.75, ph * 1.25, pcol.darkened(0.05), false, 0.35, true)
			_add_cylinder(root, Vector3(x, 1.98, 0.1), 0.03, 0.04, BRASS, false, 0.3, true)
		else:
			# Ladle
			_add_cylinder(root, Vector3(x, 1.85, 0.1), 0.012, 0.35, IRON.lightened(0.08), false, 0.4)
			_add_cylinder(root, Vector3(x, 1.65, 0.12), 0.06, 0.05, pcol, false, 0.35, true)
			_add_box(root, Vector3(x, 2.0, 0.08), Vector3(0.03, 0.04, 0.06), OAK, false, 0.55)
	return root

static func _make_copper_pot(prop: Dictionary) -> Node3D:
	## seed: kettle / pan / stockpot / jug / coal scuttle — no clone still-lifes.
	var root := Node3D.new()
	root.name = "CopperPot"
	var scale: float = prop.get("scale", 1.0)
	var seed0: int = int(prop.get("seed", 0))
	var style := seed0 % 5
	var col := COPPER if style % 2 == 0 else COPPER.darkened(0.08)
	if style == 0:
		# Classic kettle + bail handle
		_add_cylinder(root, Vector3(0, 0.12 * scale, 0), 0.14 * scale, 0.22 * scale, col, true, 0.35, true)
		_add_cylinder(root, Vector3(0, 0.24 * scale, 0), 0.15 * scale, 0.03 * scale, col.lightened(0.1), false, 0.3, true)
		_add_cylinder(root, Vector3(0, 0.25 * scale, 0), 0.1 * scale, 0.03 * scale, Color(0.18, 0.1, 0.06), false)
		_add_box(root, Vector3(0.16 * scale, 0.14 * scale, 0), Vector3(0.04 * scale, 0.08 * scale, 0.12 * scale), col, false, 0.35)
		_add_box(root, Vector3(-0.16 * scale, 0.14 * scale, 0), Vector3(0.04 * scale, 0.08 * scale, 0.12 * scale), col, false, 0.35)
		_add_box(root, Vector3(0, 0.3 * scale, 0), Vector3(0.34 * scale, 0.02 * scale, 0.02 * scale), col.darkened(0.05), false, 0.35)
	elif style == 1:
		# Wide shallow pan + long handle
		_add_cylinder(root, Vector3(0, 0.08 * scale, 0), 0.18 * scale, 0.12 * scale, col.lightened(0.05), true, 0.35, true)
		_add_cylinder(root, Vector3(0, 0.15 * scale, 0), 0.19 * scale, 0.025 * scale, col, false, 0.3, true)
		_add_box(root, Vector3(0.22 * scale, 0.1 * scale, 0), Vector3(0.16 * scale, 0.03 * scale, 0.05 * scale), col, false, 0.35)
		_add_box(root, Vector3(-0.16 * scale, 0.1 * scale, 0), Vector3(0.08 * scale, 0.03 * scale, 0.05 * scale), col, false, 0.35)
	elif style == 2:
		# Tall stockpot with lid knob
		_add_cylinder(root, Vector3(0, 0.16 * scale, 0), 0.12 * scale, 0.3 * scale, col.darkened(0.05), true, 0.35, true)
		_add_cylinder(root, Vector3(0, 0.32 * scale, 0), 0.125 * scale, 0.03 * scale, col, false, 0.3, true)
		_add_cylinder(root, Vector3(0, 0.36 * scale, 0), 0.04 * scale, 0.05 * scale, BRASS, false, 0.3, true)
		_add_box(root, Vector3(0.13 * scale, 0.2 * scale, 0), Vector3(0.03 * scale, 0.1 * scale, 0.08 * scale), col, false, 0.35)
		_add_box(root, Vector3(-0.13 * scale, 0.2 * scale, 0), Vector3(0.03 * scale, 0.1 * scale, 0.08 * scale), col, false, 0.35)
	elif style == 3:
		# Water jug / ewer with spout
		_add_cylinder(root, Vector3(0, 0.14 * scale, 0), 0.1 * scale, 0.26 * scale, col.lightened(0.04), true, 0.35, true)
		_add_cylinder(root, Vector3(0, 0.28 * scale, 0), 0.06 * scale, 0.06 * scale, col, false, 0.32, true)
		_add_box(root, Vector3(0.12 * scale, 0.2 * scale, 0), Vector3(0.1 * scale, 0.04 * scale, 0.05 * scale), col, false, 0.35)
		_add_box(root, Vector3(-0.1 * scale, 0.18 * scale, 0), Vector3(0.04 * scale, 0.12 * scale, 0.03 * scale), col.darkened(0.05), false, 0.35)
	else:
		# Coal scuttle / bucket with hoop
		_add_cylinder(root, Vector3(0, 0.12 * scale, 0), 0.15 * scale, 0.22 * scale, col.darkened(0.1), true, 0.4, true)
		_add_cylinder(root, Vector3(0, 0.22 * scale, 0), 0.16 * scale, 0.03 * scale, IRON.lightened(0.1), false, 0.45)
		_add_box(root, Vector3(0, 0.28 * scale, 0), Vector3(0.02 * scale, 0.12 * scale, 0.28 * scale), IRON, false, 0.4)
		_add_box(root, Vector3(0.1 * scale, 0.14 * scale, 0.1 * scale), Vector3(0.06 * scale, 0.04 * scale, 0.06 * scale), Color(0.12, 0.1, 0.1), false, 0.8)
	_add_contact_shadow(root, 0.18 * scale, 0.18 * scale)
	return root


static func _make_copper_scrap(prop: Dictionary) -> Node3D:
	## Rooke scrap heap — seed forks coil / plate / tube piles (uniqueness, not pot clones).
	var root := Node3D.new()
	root.name = "CopperScrap"
	var s: float = float(prop.get("scale", 1.0))
	var seed0: int = int(prop.get("seed", 0))
	var style := seed0 % 3
	# Low wood tray / board under scrap
	_add_box(root, Vector3(0, 0.03 * s, 0), Vector3(0.55 * s, 0.05 * s, 0.4 * s), OAK.darkened(0.12), true, 0.65)
	if style == 0:
		# Nested coil rings + filings
		for i in 4:
			var r := (0.08 + float(i) * 0.035) * s
			var y := (0.08 + float(i) * 0.04) * s
			_add_cylinder(root, Vector3(-0.05 * s, y, 0.02 * s), r, 0.035 * s, COPPER.darkened(float(i) * 0.03), false, 0.35, true)
		_add_box(root, Vector3(0.14 * s, 0.08 * s, -0.05 * s), Vector3(0.18 * s, 0.03 * s, 0.12 * s), COPPER.lightened(0.05), false, 0.35)
		_add_box(root, Vector3(0.12 * s, 0.11 * s, 0.05 * s), Vector3(0.1 * s, 0.025 * s, 0.08 * s), BRASS.darkened(0.1), false, 0.3)
		for j in 5:
			var fx := (-0.15 + float(j) * 0.07) * s
			_add_sphere_blob(root, Vector3(fx, 0.07 * s, 0.12 * s), 0.02 * s, COPPER.lightened(0.08))
	elif style == 1:
		# Flattened plate stack + bent tube
		for i in 3:
			_add_box(root, Vector3(-0.08 * s, (0.07 + float(i) * 0.025) * s, 0.0), Vector3(0.28 * s, 0.02 * s, 0.22 * s), COPPER.darkened(float(i) * 0.04), false, 0.35)
		_add_cylinder(root, Vector3(0.16 * s, 0.12 * s, 0.05 * s), 0.025 * s, 0.28 * s, COPPER.lightened(0.04), false, 0.35, true)
		_add_cylinder(root, Vector3(0.12 * s, 0.1 * s, -0.1 * s), 0.02 * s, 0.18 * s, BRASS.darkened(0.08), false, 0.3, true)
		_add_box(root, Vector3(0.0, 0.14 * s, 0.1 * s), Vector3(0.12 * s, 0.04 * s, 0.08 * s), IRON.lightened(0.1), false, 0.4)
	else:
		# Tube bundle + scrap nugget + iron clamp
		for i in 5:
			var ox := (-0.12 + float(i) * 0.06) * s
			_add_cylinder(root, Vector3(ox, 0.1 * s, 0.0), 0.018 * s, 0.32 * s, COPPER.darkened(float(i % 3) * 0.04), false, 0.35, true)
		_add_box(root, Vector3(0.0, 0.18 * s, 0.0), Vector3(0.35 * s, 0.03 * s, 0.06 * s), IRON, false, 0.4)
		_add_sphere_blob(root, Vector3(0.15 * s, 0.1 * s, 0.1 * s), 0.05 * s, COPPER.darkened(0.06))
		_add_box(root, Vector3(-0.15 * s, 0.09 * s, 0.12 * s), Vector3(0.1 * s, 0.04 * s, 0.08 * s), BRASS.darkened(0.12), false, 0.3)
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
	# Seed-unique top dressing (loop 96: denser still-life on each bench)
	var iron_mid := Color(0.36, 0.36, 0.38)
	var dress := seed0 % 3
	if dress == 0:
		# Measuring plate + ruler + calipers + oil can
		_add_box(root, Vector3(-0.4, 0.93, 0.15), Vector3(0.35, 0.04, 0.25), BRASS, false, 0.3)
		_add_box(root, Vector3(0.0, 0.94, 0.25), Vector3(0.55, 0.03, 0.08), iron_mid, false, 0.45)
		_add_box(root, Vector3(-0.15, 0.95, 0.3), Vector3(0.08, 0.04, 0.22), iron_mid.lightened(0.1), false, 0.45)
		_add_cylinder(root, Vector3(0.6, 0.97, 0.1), 0.06, 0.18, BRASS, false, 0.3, true)
		_add_box(root, Vector3(0.35, 0.93, -0.15), Vector3(0.28, 0.02, 0.18), PAPER, false)
		_add_cylinder(root, Vector3(-0.7, 0.98, -0.2), 0.045, 0.12, COPPER, false, 0.35, true)
		_add_box(root, Vector3(0.15, 0.94, 0.05), Vector3(0.12, 0.03, 0.04), iron_mid, false, 0.4)  # bit
	elif dress == 1:
		# Plans + wrench + copper stock + chalk
		_add_box(root, Vector3(0.3, 0.92, -0.1), Vector3(0.45, 0.03, 0.32), PAPER, false)
		_add_box(root, Vector3(0.35, 0.94, -0.08), Vector3(0.3, 0.01, 0.22), PAPER.darkened(0.08), false)
		_add_box(root, Vector3(0.32, 0.95, -0.05), Vector3(0.18, 0.008, 0.12), PAPER.darkened(0.12), false)
		_add_box(root, Vector3(-0.5, 0.94, 0.1), Vector3(0.5, 0.03, 0.08), iron_mid, false, 0.45)  # wrench
		_add_box(root, Vector3(-0.2, 0.95, 0.15), Vector3(0.08, 0.05, 0.14), iron_mid.lightened(0.08), false, 0.45)
		_add_cylinder(root, Vector3(0.7, 0.98, 0.15), 0.05, 0.16, COPPER, false, 0.35, true)
		_add_cylinder(root, Vector3(-0.75, 0.97, -0.15), 0.04, 0.1, CREAM, false)  # chalk
		_add_box(root, Vector3(0.05, 0.93, 0.25), Vector3(0.2, 0.025, 0.12), OAK, false, 0.55)
	else:
		# Vice + wood block + copper + rule + scrap
		_add_box(root, Vector3(0.75, 0.98, -0.15), Vector3(0.22, 0.14, 0.16), iron_mid, false, 0.45)  # vice
		_add_cylinder(root, Vector3(0.75, 1.1, -0.15), 0.035, 0.12, iron_mid.lightened(0.1), false, 0.45)
		_add_cylinder(root, Vector3(0.75, 1.12, -0.05), 0.02, 0.08, BRASS, false, 0.3, true)
		_add_box(root, Vector3(-0.55, 0.95, 0.0), Vector3(0.28, 0.03, 0.2), Color(0.22, 0.14, 0.1), false, 0.6)
		_add_cylinder(root, Vector3(-0.2, 0.98, 0.2), 0.05, 0.12, COPPER, false, 0.35, true)
		_add_box(root, Vector3(0.2, 0.93, 0.2), Vector3(0.35, 0.04, 0.2), BRASS.darkened(0.1), false, 0.3)
		_add_box(root, Vector3(0.0, 0.93, -0.25), Vector3(0.4, 0.02, 0.06), iron_mid, false, 0.45)  # rule
		_add_box(root, Vector3(-0.75, 0.94, 0.2), Vector3(0.12, 0.05, 0.1), COPPER.darkened(0.1), false, 0.35)
	_add_contact_shadow(root, width * 0.5, 0.55)
	return root

static func _make_tool_rack(prop: Dictionary) -> Node3D:
	## Wall rack — each seed hangs a DIFFERENT tool set (uniqueness rule).
	## Not seven identical black bars.
	var root := Node3D.new()
	root.name = "ToolRack"
	var seed0: int = int(prop.get("seed", 0))
	_add_box(root, Vector3(0, 1.35, 0), Vector3(1.55, 0.1, 0.1), MAHOGANY_DARK, true, 0.5)
	_add_box(root, Vector3(0, 0.55, 0), Vector3(1.55, 0.08, 0.1), MAHOGANY_DARK, true, 0.5)
	_add_box(root, Vector3(-0.72, 0.95, 0), Vector3(0.08, 0.9, 0.08), MAHOGANY, true, 0.5)
	_add_box(root, Vector3(0.72, 0.95, 0), Vector3(0.08, 0.9, 0.08), MAHOGANY, true, 0.5)
	# 6 pegs, each tool kind unique by (seed + slot)
	for i in 6:
		var x := -0.55 + float(i) * 0.22
		_add_cylinder(root, Vector3(x, 1.28, 0.08), 0.015, 0.1, OAK, false, 0.55)
		var kind := (i + seed0 * 3) % 6
		match kind:
			0:  # claw hammer
				_add_box(root, Vector3(x, 0.95, 0.1), Vector3(0.04, 0.5, 0.04), Color(0.28, 0.18, 0.1), false, 0.55)
				_add_box(root, Vector3(x, 0.68, 0.14), Vector3(0.18, 0.1, 0.08), IRON, false, 0.35)
				_add_box(root, Vector3(x + 0.1, 0.66, 0.14), Vector3(0.06, 0.04, 0.04), IRON.lightened(0.1), false, 0.35)
			1:  # Rooke wrench (open jaw)
				_add_box(root, Vector3(x, 0.95, 0.1), Vector3(0.035, 0.48, 0.035), IRON.darkened(0.1), false, 0.4)
				_add_box(root, Vector3(x, 0.68, 0.14), Vector3(0.14, 0.06, 0.08), IRON, false, 0.35)
				_add_box(root, Vector3(x + 0.08, 0.62, 0.16), Vector3(0.05, 0.12, 0.05), IRON.lightened(0.08), false, 0.35)
			2:  # tongs
				_add_box(root, Vector3(x - 0.03, 0.95, 0.1), Vector3(0.025, 0.52, 0.025), IRON, false, 0.4)
				_add_box(root, Vector3(x + 0.03, 0.95, 0.1), Vector3(0.025, 0.52, 0.025), IRON, false, 0.4)
				_add_box(root, Vector3(x, 1.18, 0.1), Vector3(0.1, 0.04, 0.03), IRON.darkened(0.05), false, 0.4)
			3:  # wood plane
				_add_box(root, Vector3(x, 0.88, 0.12), Vector3(0.1, 0.12, 0.28), OAK.lightened(0.08), false, 0.55)
				_add_box(root, Vector3(x, 0.82, 0.22), Vector3(0.08, 0.03, 0.06), IRON, false, 0.4)
			4:  # file + handle
				_add_box(root, Vector3(x, 0.95, 0.1), Vector3(0.03, 0.45, 0.03), Color(0.35, 0.22, 0.12), false, 0.55)
				_add_box(root, Vector3(x, 0.7, 0.12), Vector3(0.05, 0.35, 0.05), IRON.lightened(0.15), false, 0.4)
			_:  # copper-headed mallet
				_add_box(root, Vector3(x, 0.95, 0.1), Vector3(0.04, 0.48, 0.04), OAK, false, 0.55)
				_add_cylinder(root, Vector3(x, 0.7, 0.14), 0.07, 0.12, COPPER, false, 0.35, true)
	# Lower pegs: shorter seed-unique set
	for i in 3:
		var x2 := -0.35 + float(i) * 0.35
		var kind2 := (i + seed0 + 2) % 4
		_add_cylinder(root, Vector3(x2, 0.58, 0.08), 0.012, 0.08, OAK, false, 0.55)
		if kind2 == 0:
			_add_box(root, Vector3(x2, 0.38, 0.1), Vector3(0.04, 0.32, 0.04), Color(0.22, 0.15, 0.1), false, 0.55)
			_add_box(root, Vector3(x2, 0.24, 0.14), Vector3(0.12, 0.06, 0.08), IRON, false, 0.4)
		elif kind2 == 1:
			_add_cylinder(root, Vector3(x2, 0.4, 0.12), 0.025, 0.35, BRASS.darkened(0.1), false, 0.35, true)
		elif kind2 == 2:
			_add_box(root, Vector3(x2, 0.4, 0.12), Vector3(0.18, 0.05, 0.05), IRON, false, 0.4)
		else:
			_add_cylinder(root, Vector3(x2, 0.38, 0.12), 0.04, 0.1, COPPER, false, 0.35, true)
	# Bits on rail shelf
	if seed0 % 2 == 0:
		_add_cylinder(root, Vector3(-0.35, 0.62, 0.08), 0.04, 0.08, COPPER, false, 0.35, true)
		_add_cylinder(root, Vector3(-0.2, 0.62, 0.08), 0.035, 0.07, BRASS, false, 0.3, true)
	else:
		_add_box(root, Vector3(0.2, 0.62, 0.08), Vector3(0.22, 0.05, 0.12), OAK.lightened(0.1), false, 0.55)
		_add_cylinder(root, Vector3(0.45, 0.62, 0.08), 0.03, 0.06, COPPER, false, 0.35, true)
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
		_add_box(root, Vector3(0, 0.5, 0), Vector3(0.36, 0.05, 0.36), Color(0.42, 0.3, 0.16), true, 0.55)
		for sx in [-1.0, 1.0]:
			for sz in [-1.0, 1.0]:
				_add_box(root, Vector3(sx * 0.13, 0.24, sz * 0.13), Vector3(0.04, 0.48, 0.04), MAHOGANY_DARK, true, 0.5)
		_add_box(root, Vector3(0, 0.14, 0), Vector3(0.28, 0.03, 0.28), MAHOGANY, false, 0.5)
	else:
		# Upholstered stool — velvet seat, dark legs (not pale mesh wood)
		_add_cylinder(root, Vector3(0, 0.5, 0), 0.18, 0.08, VELVET_GREEN.darkened(0.05), true, 0.9)
		_add_cylinder(root, Vector3(0, 0.44, 0), 0.16, 0.04, MAHOGANY_DARK, false, 0.45)
		for a in [0.0, 90.0, 180.0, 270.0]:
			var rad := deg_to_rad(a)
			_add_cylinder(root, Vector3(cos(rad) * 0.11, 0.22, sin(rad) * 0.11), 0.025, 0.44, MAHOGANY_DARK, true)
	_add_contact_shadow(root, 0.22, 0.22)
	return root

# ─── Gallery / aetheric ──────────────────────────────────────────────────────

static func _make_machine(prop: Dictionary) -> Node3D:
	## Secondary gallery apparatus — loop 96: denser counter-wound coils, glass dome,
	## gauges, mid-grey base (not plain copper cylinder stack).
	var root := Node3D.new()
	root.name = "Machine"
	var height: float = float(prop.get("height", 2.6))
	var seed0: int = int(prop.get("seed", int(height * 10.0)))
	var col_h: float = maxf(height * 0.68, 1.35)
	var iron_mid := Color(0.34, 0.34, 0.36)
	var oak_d := Color(0.26, 0.16, 0.09)
	# Plinth + oak deck
	_add_box(root, Vector3(0, 0.1, 0), Vector3(1.05, 0.2, 0.95), iron_mid, true, 0.45)
	_add_box(root, Vector3(0, 0.24, 0), Vector3(0.92, 0.1, 0.82), oak_d, true, 0.5)
	_add_box(root, Vector3(0, 0.3, 0), Vector3(0.78, 0.04, 0.7), COPPER.darkened(0.15), false, 0.35)
	# Brass core column
	var col_mid: float = 0.4 + col_h * 0.45
	_add_cylinder(root, Vector3(0, col_mid, 0), 0.28, col_h * 0.85, BRASS, true, 0.32, true)
	# 5 copper coil bands with winding ticks
	for i in 5:
		var y: float = 0.48 + float(i) * (col_h * 0.16)
		var r: float = 0.4 - float(i) * 0.025
		var copper_col: Color = COPPER if i % 2 == 0 else COPPER.darkened(0.08)
		_add_cylinder(root, Vector3(0, y, 0), r, 0.07, copper_col, false, 0.32, true)
		_add_cylinder(root, Vector3(0, y + 0.025, 0), r * 0.9, 0.025, copper_col.lightened(0.08), false, 0.3, true)
		var wind := 1.0 if i % 2 == 0 else -1.0
		for s in 8:
			var ang: float = float(s) * (TAU / 8.0) * wind
			_add_box(
				root,
				Vector3(cos(ang) * r * 0.95, y + (float(s) / 8.0 - 0.5) * 0.05 * wind, sin(ang) * r * 0.95),
				Vector3(0.04, 0.03, 0.07),
				copper_col.lightened(0.05), false, 0.28
			)
	var top_y: float = 0.4 + col_h * 0.9
	_add_cylinder(root, Vector3(0, top_y, 0), 0.32, 0.08, BRASS.lightened(0.05), false, 0.3, true)
	# Loop 104: short bulbous scientific chamber — solid frosted teal glass + brass cage
	# (alpha glass reads as pale toilet-paper tube under filmic tonemap)
	var glass_c := Color(0.35, 0.55, 0.58)
	var glass_hi := Color(0.45, 0.68, 0.72)
	_add_cylinder(root, Vector3(0, top_y + 0.12, 0), 0.16, 0.16, glass_c, false, 0.35)
	_add_cylinder(root, Vector3(0, top_y + 0.2, 0), 0.12, 0.1, glass_hi, false, 0.32)
	_add_cylinder(root, Vector3(0, top_y + 0.28, 0), 0.08, 0.06, glass_c.darkened(0.05), false, 0.35)
	# Brass cage ribs + gallery
	for ri in 4:
		var ra := float(ri) * TAU / 4.0
		_add_box(root, Vector3(cos(ra) * 0.15, top_y + 0.16, sin(ra) * 0.15), Vector3(0.02, 0.18, 0.02), BRASS, false, 0.28)
	_add_cylinder(root, Vector3(0, top_y + 0.06, 0), 0.18, 0.03, BRASS.darkened(0.05), false, 0.28, true)
	_add_cylinder(root, Vector3(0, top_y + 0.3, 0), 0.1, 0.03, BRASS, false, 0.28, true)
	# Emissive core (unshaded) — short, bright, not a tall white column
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
	core.position = Vector3(0, top_y + 0.16, 0)
	root.add_child(core)
	var glow_s := MeshInstance3D.new()
	var gsm := SphereMesh.new()
	gsm.radius = 0.055
	gsm.height = 0.11
	glow_s.mesh = gsm
	var gsmat := StandardMaterial3D.new()
	gsmat.albedo_color = Color(0.5, 0.9, 1.0)
	gsmat.emission_enabled = true
	gsmat.emission = Color(0.4, 0.85, 1.0)
	gsmat.emission_energy_multiplier = 2.0
	gsmat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	glow_s.material_override = gsmat
	glow_s.position = Vector3(0, top_y + 0.2, 0)
	root.add_child(glow_s)
	# Side instruments + pipes (seed forks layout)
	if seed0 % 2 == 0:
		_add_box(root, Vector3(0.48, 0.55, 0.12), Vector3(0.26, 0.42, 0.3), oak_d, true, 0.48)
		for gi in 2:
			_add_cylinder(root, Vector3(0.48, 0.7 + float(gi) * 0.16, 0.22), 0.07, 0.035, BRASS, false, 0.28, true)
			_add_cylinder(root, Vector3(0.48, 0.71 + float(gi) * 0.16, 0.24), 0.05, 0.01, Color(0.85, 0.88, 0.8), false, 0.5)
		_add_cylinder(root, Vector3(-0.45, 0.85, 0.05), 0.045, 0.7, COPPER, false, 0.32, true)
		_add_box(root, Vector3(-0.45, 1.15, 0.2), Vector3(0.1, 0.1, 0.35), COPPER.darkened(0.05), false, 0.32)
	else:
		_add_box(root, Vector3(-0.48, 0.55, 0.1), Vector3(0.26, 0.4, 0.3), oak_d, true, 0.48)
		_add_cylinder(root, Vector3(-0.48, 0.82, 0.2), 0.08, 0.04, BRASS, false, 0.28, true)
		_add_cylinder(root, Vector3(0.42, 0.9, -0.15), 0.04, 0.55, COPPER, false, 0.32, true)
		_add_box(root, Vector3(0.42, 0.55, -0.15), Vector3(0.22, 0.2, 0.22), iron_mid, true, 0.45)
		_add_cylinder(root, Vector3(0.42, 0.7, -0.15), 0.06, 0.04, BRASS, false, 0.3, true)
	# Valve wheel
	_add_cylinder(root, Vector3(0.0, 0.55, 0.42), 0.1, 0.03, BRASS, false, 0.28, true)
	_add_box(root, Vector3(0.0, 0.55, 0.42), Vector3(0.18, 0.02, 0.02), BRASS.lightened(0.05), false, 0.28)
	_add_box(root, Vector3(0.0, 0.55, 0.42), Vector3(0.02, 0.02, 0.18), BRASS.lightened(0.05), false, 0.28)
	var glow := OmniLight3D.new()
	glow.light_color = Color(0.55, 0.82, 0.95)
	glow.light_energy = 0.9
	glow.omni_range = 4.0
	glow.position = Vector3(0, top_y + 0.1, 0.1)
	root.add_child(glow)
	_add_contact_shadow(root, 0.55, 0.5)
	return root

static func _make_aetheric_machine(prop: Dictionary) -> Node3D:
	## Novel-true Aetheric Engine — loop 93: mid-grey iron posts (not black), denser
	## counter-wound coil turns, frosted glass dome, brighter aether core, more brass.
	var root := Node3D.new()
	root.name = "AethericMachine"
	var height: float = float(prop.get("height", 2.95))
	var oak := Color(0.42, 0.28, 0.14)
	var oak_d := Color(0.26, 0.16, 0.09)
	# Mid-grey iron (pure dark metal → black under filmic tonemap)
	var iron_frame := Color(0.34, 0.34, 0.36)
	var iron_dark := Color(0.26, 0.26, 0.28)
	# Square oak base with copper inlay plate + brass edge
	_add_box(root, Vector3(0, 0.1, 0), Vector3(1.65, 0.2, 1.65), oak_d, true, 0.5)
	_add_box(root, Vector3(0, 0.24, 0), Vector3(1.48, 0.1, 1.48), oak, true, 0.52)
	_add_box(root, Vector3(0, 0.32, 0), Vector3(1.32, 0.06, 1.32), COPPER.darkened(0.12), false, 0.35)
	_add_box(root, Vector3(0, 0.35, 0), Vector3(1.38, 0.02, 1.38), BRASS.darkened(0.15), false, 0.32)
	# Corner iron footings + brass bolts
	for sx in [-1.0, 1.0]:
		for sz in [-1.0, 1.0]:
			_add_box(root, Vector3(sx * 0.72, 0.06, sz * 0.72), Vector3(0.16, 0.12, 0.16), iron_dark, true, 0.45)
			_add_cylinder(root, Vector3(sx * 0.72, 0.14, sz * 0.72), 0.03, 0.03, BRASS, false, 0.3, true)
	# Frame posts — iron clad with brass caps + mid collars
	for sx in [-1.0, 1.0]:
		for sz in [-1.0, 1.0]:
			_add_box(root, Vector3(sx * 0.5, height * 0.45, sz * 0.5), Vector3(0.1, height * 0.78, 0.1), iron_frame, true, 0.45)
			_add_box(root, Vector3(sx * 0.5, height * 0.45, sz * 0.5), Vector3(0.06, height * 0.72, 0.06), oak_d, false, 0.5)
			_add_cylinder(root, Vector3(sx * 0.5, height * 0.86, sz * 0.5), 0.07, 0.06, BRASS, false, 0.28, true)
			_add_cylinder(root, Vector3(sx * 0.5, height * 0.5, sz * 0.5), 0.065, 0.04, BRASS.darkened(0.1), false, 0.3, true)
	# Top ring beams (brass-capped oak)
	_add_box(root, Vector3(0, height * 0.9, 0), Vector3(1.2, 0.08, 1.2), oak_d, false, 0.48)
	_add_box(root, Vector3(0, height * 0.94, 0), Vector3(1.1, 0.04, 1.1), BRASS.darkened(0.1), false, 0.3)
	_add_box(root, Vector3(0, height * 0.97, 0), Vector3(0.95, 0.03, 0.95), BRASS.lightened(0.05), false, 0.28)
	# FIVE copper coils denser with counter-wound turns (loop 93)
	var coil_ys := [0.45, 0.85, 1.25, 1.65, 2.0]
	var coil_rs := [0.72, 0.58, 0.46, 0.36, 0.26]
	var coil_hs := [0.13, 0.12, 0.11, 0.1, 0.09]
	for i in 5:
		var y: float = coil_ys[i]
		var r: float = coil_rs[i]
		var ch: float = coil_hs[i]
		var copper_col: Color = COPPER if i % 2 == 0 else COPPER.darkened(0.08)
		_add_cylinder(root, Vector3(0, y, 0), r, ch, copper_col, false, 0.3, true)
		_add_cylinder(root, Vector3(0, y + ch * 0.35, 0), r * 0.9, ch * 0.22, copper_col.lightened(0.08), false, 0.28, true)
		var wind := 1.0 if i % 2 == 0 else -1.0
		for s in 12:
			var ang: float = float(s) * (TAU / 12.0) * wind
			var bx: float = cos(ang) * r * 0.94
			var bz: float = sin(ang) * r * 0.94
			var by: float = y + (float(s) / 12.0 - 0.5) * ch * 0.95 * wind
			var bar_c: Color = copper_col.lightened(0.06) if s % 2 == 0 else copper_col.darkened(0.04)
			_add_box(root, Vector3(bx, by, bz), Vector3(0.055, 0.035, 0.09), bar_c, false, 0.28)
		var side := 1.0 if i % 2 == 0 else -1.0
		_add_box(root, Vector3(side * r * 0.97, y, 0), Vector3(0.08, ch + 0.04, 0.11), BRASS, false, 0.28)
	# Central spine + brass collar
	_add_cylinder(root, Vector3(0, height * 0.48, 0), 0.09, height * 0.65, BRASS, true, 0.28, true)
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
	dmat.emission = Color(0.25, 0.55, 0.7)
	dmat.emission_energy_multiplier = 0.9
	dmat.roughness = 0.25
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
	# Compact emissive aether core (inside dome)
	var core := MeshInstance3D.new()
	var cm := CylinderMesh.new()
	cm.top_radius = 0.07
	cm.bottom_radius = 0.07
	cm.height = 0.16
	core.mesh = cm
	var cmat := StandardMaterial3D.new()
	cmat.albedo_color = Color(0.5, 0.9, 1.0)
	cmat.emission_enabled = true
	cmat.emission = Color(0.4, 0.85, 1.0)
	cmat.emission_energy_multiplier = 3.2
	cmat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	core.material_override = cmat
	core.position = Vector3(0, dome_y, 0)
	root.add_child(core)
	var glow := MeshInstance3D.new()
	var sm := SphereMesh.new()
	sm.radius = 0.1
	sm.height = 0.2
	glow.mesh = sm
	var smat := StandardMaterial3D.new()
	smat.albedo_color = Color(0.55, 0.92, 1.0)
	smat.emission_enabled = true
	smat.emission = Color(0.45, 0.85, 1.0)
	smat.emission_energy_multiplier = 2.4
	smat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	glow.material_override = smat
	glow.position = Vector3(0, dome_y + 0.06, 0)
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
	# Lights
	var warm := OmniLight3D.new()
	warm.light_color = Color(1.0, 0.78, 0.45)
	warm.light_energy = 0.95
	warm.omni_range = 5.2
	warm.position = Vector3(0.3, 1.1, 0.35)
	root.add_child(warm)
	var cool := OmniLight3D.new()
	cool.light_color = Color(0.55, 0.85, 1.0)
	cool.light_energy = 1.05
	cool.omni_range = 4.0
	cool.position = Vector3(0, height * 0.72, 0)
	root.add_child(cool)
	_add_contact_shadow(root, 0.95, 0.95)
	return root

static func _make_chalk_board(prop: Dictionary) -> Node3D:
	## Workshop / gallery slate — loop 89: denser marks that read from room centre.
	var root := Node3D.new()
	root.name = "ChalkBoard"
	var seed0: int = int(prop.get("seed", 0))
	var w := 1.35 + float(seed0 % 3) * 0.08
	var h := 0.95 + float(seed0 % 2) * 0.08
	_add_box(root, Vector3(0, 1.2, 0), Vector3(w, h, 0.06), MAHOGANY_DARK, true, 0.45)
	_add_box(root, Vector3(0, 1.2, 0.03), Vector3(w - 0.12, h - 0.12, 0.02), CHALK, false, 0.85)
	# Frame lip
	_add_box(root, Vector3(0, 1.2 + h * 0.48, 0.02), Vector3(w - 0.04, 0.03, 0.04), MAHOGANY, false, 0.48)
	_add_box(root, Vector3(0, 1.2 - h * 0.48, 0.02), Vector3(w - 0.04, 0.03, 0.04), MAHOGANY, false, 0.48)
	# Bright chalk so marks survive distance / filmic tonemap (loop 102: thicker strokes)
	var chalk := Color(0.98, 0.98, 0.95)
	var chalk_dim := Color(0.88, 0.9, 0.85)
	match seed0 % 4:
		0:
			# Equations / coil notes — multi-line dense
			for li in 8:
				var ly := 1.5 - float(li) * 0.08
				var lw := 0.6 + float((li + seed0) % 4) * 0.1
				var lx := -0.12 + float(li % 3) * 0.06
				_add_box(root, Vector3(lx, ly, 0.05), Vector3(lw, 0.022, 0.014), chalk, false, 0.95)
			_add_cylinder(root, Vector3(0.35, 1.05, 0.05), 0.14, 0.014, chalk, false, 0.95)
			_add_cylinder(root, Vector3(0.35, 1.05, 0.05), 0.07, 0.012, chalk_dim, false, 0.95)
			_add_box(root, Vector3(-0.35, 1.0, 0.05), Vector3(0.35, 0.02, 0.014), chalk, false, 0.95)
			_add_box(root, Vector3(-0.4, 1.35, 0.05), Vector3(0.1, 0.1, 0.012), chalk, false, 0.95)
		1:
			# Concentric coils + radii (engine notes) — thicker for room-length read
			_add_cylinder(root, Vector3(0.0, 1.22, 0.05), 0.3, 0.016, chalk, false, 0.95)
			_add_cylinder(root, Vector3(0.0, 1.22, 0.05), 0.2, 0.014, chalk_dim, false, 0.95)
			_add_cylinder(root, Vector3(0.0, 1.22, 0.05), 0.1, 0.012, chalk, false, 0.95)
			_add_box(root, Vector3(0.0, 1.22, 0.05), Vector3(0.6, 0.02, 0.012), chalk, false, 0.95)
			_add_box(root, Vector3(0.0, 1.22, 0.05), Vector3(0.02, 0.6, 0.012), chalk, false, 0.95)
			# Spiral arc ticks + label bars
			for di in 6:
				var ang := float(di) * 0.55
				_add_box(root, Vector3(cos(ang) * 0.22, 1.22 + sin(ang) * 0.22, 0.05), Vector3(0.2, 0.016, 0.012), chalk_dim, false, 0.95)
			_add_box(root, Vector3(-0.35, 1.5, 0.05), Vector3(0.45, 0.022, 0.014), chalk, false, 0.95)
			_add_box(root, Vector3(0.3, 0.96, 0.05), Vector3(0.4, 0.02, 0.014), chalk, false, 0.95)
			_add_box(root, Vector3(-0.35, 0.96, 0.05), Vector3(0.3, 0.018, 0.014), chalk, false, 0.95)
		2:
			# Dense grid / ledger + bold annotations
			for i in 7:
				var yy := 0.9 + float(i) * 0.09
				_add_box(root, Vector3(0.0, yy, 0.05), Vector3(1.0, 0.012, 0.012), chalk_dim, false, 0.95)
			for j in 6:
				var xx := -0.48 + float(j) * 0.18
				_add_box(root, Vector3(xx, 1.2, 0.05), Vector3(0.012, 0.65, 0.012), chalk_dim, false, 0.95)
			# Bold fill cells
			_add_box(root, Vector3(-0.2, 1.35, 0.05), Vector3(0.14, 0.07, 0.01), chalk, false, 0.95)
			_add_box(root, Vector3(0.2, 1.15, 0.05), Vector3(0.14, 0.07, 0.01), chalk, false, 0.95)
			_add_box(root, Vector3(0.0, 1.0, 0.05), Vector3(0.22, 0.018, 0.012), chalk, false, 0.95)
		_:
			# Wave / aether trace + axis + labels
			for i in 9:
				var wx := -0.48 + float(i) * 0.11
				var wy := 1.18 + sin(float(i) * 0.85 + float(seed0)) * 0.16
				_add_box(root, Vector3(wx, wy, 0.05), Vector3(0.14, 0.016, 0.012), chalk, false, 0.95)
			# Baseline + vertical axis
			_add_box(root, Vector3(0.0, 0.98, 0.05), Vector3(1.0, 0.014, 0.012), chalk_dim, false, 0.95)
			_add_box(root, Vector3(-0.48, 1.2, 0.05), Vector3(0.014, 0.55, 0.012), chalk_dim, false, 0.95)
			_add_box(root, Vector3(-0.25, 1.48, 0.05), Vector3(0.45, 0.018, 0.012), chalk, false, 0.95)
			_add_cylinder(root, Vector3(0.35, 1.05, 0.05), 0.1, 0.012, chalk, false, 0.95)
			# Tick marks on axis
			for t in 5:
				_add_box(root, Vector3(-0.3 + float(t) * 0.15, 0.95, 0.05), Vector3(0.012, 0.04, 0.01), chalk, false, 0.95)
	# Chalk rail + sticks
	_add_box(root, Vector3(0, 0.7, 0.05), Vector3(w - 0.1, 0.05, 0.1), MAHOGANY, false, 0.5)
	_add_cylinder(root, Vector3(-0.3, 0.76, 0.06), 0.012, 0.08, CREAM, false)
	_add_cylinder(root, Vector3(-0.15, 0.76, 0.05), 0.012, 0.07, CREAM.darkened(0.1), false)
	if seed0 % 2 == 0:
		_add_cylinder(root, Vector3(0.2, 0.76, 0.06), 0.012, 0.09, Color(0.4, 0.55, 0.7), false)
		_add_box(root, Vector3(0.4, 0.76, 0.05), Vector3(0.08, 0.02, 0.04), Color(0.55, 0.12, 0.1), false, 0.7)
	else:
		_add_cylinder(root, Vector3(0.15, 0.76, 0.06), 0.012, 0.08, Color(0.55, 0.35, 0.25), false)
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
			ph = clampf(ph, 0.45, 1.55)
			pw = clampf(pw, 0.4, 1.2)
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
	# Fallback full mesh plant
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


static func _add_plant_mesh_fronds(root: Node3D, pw: float, ph: float, is_fern: bool, seed0: int) -> void:
	## Side-volume fronds (loop 100: denser crown fans mask painted green-ball centres).
	## No sphere blobs — only stems + flat leaves.
	var pot_top := ph * 0.34
	var crown := ph * 0.78
	var leaf_a := Color(0.22, 0.42, 0.16)
	var leaf_b := Color(0.18, 0.38, 0.14)
	var leaf_c := Color(0.28, 0.48, 0.2)
	var stem_c := Color(0.32, 0.28, 0.14)
	var n_stems := 5 if is_fern else 4
	for i in n_stems:
		var ang := float(i) * (TAU / float(n_stems)) + float(seed0) * 0.4
		var r := pw * (0.07 + float(i % 2) * 0.03)
		var sx: float = cos(ang) * r
		var sz: float = sin(ang) * r
		var sh: float = (crown - pot_top) * (0.55 + float((i + seed0) % 2) * 0.12)
		_add_cylinder(root, Vector3(sx, pot_top + sh * 0.5, sz), 0.008 * pw + 0.005, sh, stem_c, false, 0.88)
		var tip_y: float = pot_top + sh
		if is_fern:
			for j in 3:
				var fang := ang + float(j - 1) * 0.45
				var fl := pw * (0.16 + float(j) * 0.03)
				_add_box(
					root,
					Vector3(sx + cos(fang) * fl * 0.35, tip_y - float(j) * 0.025 * ph, sz + sin(fang) * fl * 0.35),
					Vector3(0.03 * pw, 0.014, fl * 0.9),
					leaf_a if j % 2 == 0 else leaf_b,
					false,
					0.92
				)
		else:
			# Palm-ish radiating blades from tip (hides card crown blob from sides)
			for j in 4:
				var pang := ang + float(j) * 0.55 - 0.8
				var bl := pw * (0.16 + float(j % 2) * 0.05)
				_add_box(
					root,
					Vector3(sx + cos(pang) * bl * 0.4, tip_y + 0.02 * ph, sz + sin(pang) * bl * 0.4),
					Vector3(0.028 * pw, bl * 0.55, 0.022 * pw),
					leaf_c if j % 2 == 0 else leaf_a,
					false,
					0.9
				)
	# Thin mid-height side blades only (loop 101: no blocky leaf cubes)
	for k in 5:
		var kang := float(k) * TAU / 5.0 + 0.25
		var kr: float = pw * 0.16
		_add_box(
			root,
			Vector3(cos(kang) * kr, pot_top + (crown - pot_top) * 0.45, sin(kang) * kr),
			Vector3(0.018 * pw, 0.1 * ph, 0.06 * pw),
			leaf_b if k % 2 == 0 else leaf_a,
			false,
			0.92
		)
	# One soft mid-canopy blob only (was three heavy dark spheres)
	_add_sphere_blob(root, Vector3(0.0, crown * 0.95, 0.0), pw * 0.06, leaf_a)


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
	## Victorian brass gasolier (loop 101) — bowl, curved arms, inverted cone shades
	## (not modern cylinder tubes).
	var root := Node3D.new()
	root.name = "Chandelier"
	var hang: float = float(_prop.get("hang", 2.95))
	var glass := Color(0.9, 0.84, 0.65)
	var glass_hi := Color(0.95, 0.9, 0.75)
	# Ceiling rose + drop rod
	_add_cylinder(root, Vector3(0, hang + 0.28, 0), 0.08, 0.04, BRASS.darkened(0.05), false, 0.3, true)
	_add_cylinder(root, Vector3(0, hang + 0.14, 0), 0.018, 0.32, BRASS, false, 0.28, true)
	# Central font / reservoir bowl
	_add_cylinder(root, Vector3(0, hang - 0.02, 0), 0.14, 0.08, BRASS, false, 0.28, true)
	_add_cylinder(root, Vector3(0, hang - 0.1, 0), 0.2, 0.06, BRASS.darkened(0.08), false, 0.3, true)
	_add_cylinder(root, Vector3(0, hang - 0.16, 0), 0.12, 0.05, BRASS.lightened(0.05), false, 0.28, true)
	# Six curved arms + inverted cone shades + candle cups
	for i in 6:
		var a := float(i) * 60.0
		var rad := deg_to_rad(a)
		var ax: float = cos(rad) * 0.32
		var az: float = sin(rad) * 0.32
		# Arm (two segments for curve suggestion)
		_add_box(root, Vector3(ax * 0.35, hang - 0.04, az * 0.35), Vector3(0.22, 0.03, 0.03), BRASS, false, 0.3)
		_add_box(root, Vector3(ax * 0.75, hang - 0.08, az * 0.75), Vector3(0.16, 0.025, 0.025), BRASS.darkened(0.05), false, 0.3)
		# Cup + collar
		_add_cylinder(root, Vector3(ax, hang - 0.12, az), 0.04, 0.05, BRASS, false, 0.28, true)
		_add_cylinder(root, Vector3(ax, hang - 0.16, az), 0.055, 0.03, BRASS.lightened(0.05), false, 0.28, true)
		# Inverted cone shade (stacked taper — Victorian glass, not tube)
		_add_cylinder(root, Vector3(ax, hang - 0.22, az), 0.07, 0.06, glass, false, 0.4)
		_add_cylinder(root, Vector3(ax, hang - 0.28, az), 0.05, 0.06, glass_hi, false, 0.38)
		_add_cylinder(root, Vector3(ax, hang - 0.33, az), 0.03, 0.04, glass.darkened(0.05), false, 0.4)
		# Flame tip
		_add_sphere_blob(root, Vector3(ax, hang - 0.18, az), 0.02, Color(1.0, 0.82, 0.4))
	# Small crystal-drop suggestion under bowl
	for j in 4:
		var ja := float(j) * 90.0 + 20.0
		var jr := deg_to_rad(ja)
		_add_box(root, Vector3(cos(jr) * 0.08, hang - 0.22, sin(jr) * 0.08), Vector3(0.02, 0.08, 0.02), Color(0.85, 0.88, 0.9), false, 0.35)
	var light := OmniLight3D.new()
	light.light_color = Color(1.0, 0.88, 0.6)
	light.light_energy = 1.0
	light.omni_range = 7.2
	light.position = Vector3(0, hang - 0.2, 0)
	root.add_child(light)
	return root


static func _make_fireplace(prop: Dictionary) -> Node3D:
	## Marble surround + firebox + seed mantel kit (clock / urns / candlesticks).
	var root := Node3D.new()
	root.name = "Fireplace"
	var seed0: int = int(prop.get("seed", 0))
	# Outer surround + moulded lintel
	_add_box(root, Vector3(0, 0.72, -0.05), Vector3(1.75, 1.45, 0.42), MARBLE, true, 0.35)
	_add_box(root, Vector3(0, 1.35, 0.08), Vector3(1.55, 0.08, 0.12), MARBLE.darkened(0.05), false, 0.32)
	# Inner dark firebox recess
	_add_box(root, Vector3(0, 0.55, 0.12), Vector3(0.95, 0.85, 0.28), Color(0.06, 0.05, 0.05), false, 0.9)
	# Mantel shelf
	_add_box(root, Vector3(0, 1.45, 0.02), Vector3(1.95, 0.1, 0.55), MARBLE, true, 0.3)
	_add_box(root, Vector3(0, 1.5, 0.05), Vector3(1.85, 0.03, 0.48), MARBLE.lightened(0.05), false, 0.3)
	# Mantel ornaments by seed
	match seed0 % 3:
		0:
			_add_cylinder(root, Vector3(-0.55, 1.58, 0.05), 0.06, 0.18, BRASS, false, 0.3, true)
			_add_cylinder(root, Vector3(0.55, 1.58, 0.05), 0.06, 0.18, BRASS, false, 0.3, true)
			_add_box(root, Vector3(0, 1.55, 0.08), Vector3(0.2, 0.12, 0.1), Color(0.12, 0.1, 0.1), false, 0.4)
			_add_box(root, Vector3(0, 1.65, 0.08), Vector3(0.14, 0.1, 0.06), Color(0.85, 0.82, 0.75), false, 0.45)
		1:
			# Twin urns + centre candlesticks
			_add_cylinder(root, Vector3(-0.5, 1.6, 0.05), 0.07, 0.2, CREAM.darkened(0.08), false, 0.7)
			_add_cylinder(root, Vector3(0.5, 1.6, 0.05), 0.07, 0.2, CREAM.darkened(0.08), false, 0.7)
			_add_cylinder(root, Vector3(-0.15, 1.55, 0.08), 0.025, 0.14, CANDLE, false, 0.55)
			_add_cylinder(root, Vector3(0.15, 1.55, 0.08), 0.025, 0.14, CANDLE, false, 0.55)
			_add_sphere_blob(root, Vector3(-0.15, 1.65, 0.08), 0.02, Color(1.0, 0.75, 0.35))
			_add_sphere_blob(root, Vector3(0.15, 1.65, 0.08), 0.02, Color(1.0, 0.75, 0.35))
		_:
			# Carriage clock + small vases
			_add_box(root, Vector3(0.0, 1.58, 0.06), Vector3(0.18, 0.22, 0.1), BRASS.darkened(0.1), false, 0.32)
			_add_box(root, Vector3(0.0, 1.62, 0.1), Vector3(0.12, 0.1, 0.02), Color(0.9, 0.88, 0.8), false, 0.5)
			_add_cylinder(root, Vector3(-0.5, 1.56, 0.05), 0.05, 0.14, Color(0.35, 0.2, 0.15), false, 0.7)
			_add_cylinder(root, Vector3(0.5, 1.56, 0.05), 0.05, 0.14, Color(0.35, 0.2, 0.15), false, 0.7)
	# Columns / pilasters with capital
	_add_box(root, Vector3(-0.72, 0.7, 0.12), Vector3(0.16, 1.25, 0.22), MARBLE, false, 0.32)
	_add_box(root, Vector3(0.72, 0.7, 0.12), Vector3(0.16, 1.25, 0.22), MARBLE, false, 0.32)
	_add_box(root, Vector3(-0.72, 1.3, 0.14), Vector3(0.2, 0.08, 0.24), MARBLE.darkened(0.04), false, 0.32)
	_add_box(root, Vector3(0.72, 1.3, 0.14), Vector3(0.2, 0.08, 0.24), MARBLE.darkened(0.04), false, 0.32)
	# Hearth + fire dogs (loop 86 richer grate)
	_add_box(root, Vector3(0, 0.04, 0.35), Vector3(1.5, 0.08, 0.55), STONE, true, 0.55)
	_add_box(root, Vector3(0, 0.08, 0.38), Vector3(1.2, 0.03, 0.4), STONE.darkened(0.1), false, 0.6)
	# Andirons (mid-grey iron so not pure black under filmic)
	var grate_iron := Color(0.36, 0.36, 0.38)
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
	# Loop 95: multi-layer emissive flame that reads from room centre (not flat red slab)
	# Base glow plate
	var base_em := MeshInstance3D.new()
	var base_m := BoxMesh.new()
	base_m.size = Vector3(0.7, 0.12, 0.08)
	base_em.mesh = base_m
	var base_mat := StandardMaterial3D.new()
	base_mat.albedo_color = Color(1.0, 0.35, 0.08)
	base_mat.emission_enabled = true
	base_mat.emission = Color(1.0, 0.3, 0.05)
	base_mat.emission_energy_multiplier = 3.2
	base_mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	base_em.material_override = base_mat
	base_em.position = Vector3(0, 0.32, 0.32)
	root.add_child(base_em)
	# Stacked flame tongues (taller, staggered, more orange→yellow)
	for fi in 5:
		var em := MeshInstance3D.new()
		var em_mesh := BoxMesh.new()
		var fw := 0.42 - float(fi) * 0.06
		var fh := 0.14 + float(fi) * 0.07
		em_mesh.size = Vector3(fw, fh, 0.035)
		em.mesh = em_mesh
		var emat := StandardMaterial3D.new()
		var t := float(fi) / 4.0
		var warm := Color(1.0, 0.35 + t * 0.45, 0.08 + t * 0.15)
		emat.albedo_color = warm
		emat.emission_enabled = true
		emat.emission = warm
		emat.emission_energy_multiplier = 3.5 - float(fi) * 0.35
		emat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		em.material_override = emat
		em.position = Vector3(float((fi % 3) - 1) * 0.08, 0.36 + float(fi) * 0.09, 0.3 + float(fi) * 0.012)
		root.add_child(em)
	# Coal embers
	for ei in 4:
		var ember := MeshInstance3D.new()
		var ems := BoxMesh.new()
		ems.size = Vector3(0.08, 0.04, 0.05)
		ember.mesh = ems
		var emat2 := StandardMaterial3D.new()
		emat2.albedo_color = Color(1.0, 0.25, 0.05)
		emat2.emission_enabled = true
		emat2.emission = Color(1.0, 0.2, 0.0)
		emat2.emission_energy_multiplier = 2.5
		emat2.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		ember.material_override = emat2
		ember.position = Vector3(-0.2 + float(ei) * 0.12, 0.22, 0.28)
		root.add_child(ember)
	var fire := OmniLight3D.new()
	fire.light_color = Color(1.0, 0.55, 0.25)
	fire.light_energy = 1.85
	fire.omni_range = 6.5
	fire.position = Vector3(0, 0.55, 0.45)
	root.add_child(fire)
	_add_contact_shadow(root, 0.95, 0.55)
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
	return root

static func _make_glass_wall(feat: Dictionary) -> Node3D:
	## Conservatory iron-framed glass. Loop 91: painted garden plate is the exterior
	## (no green sphere-blob overlay). Mullion grid + light glass tint only.
	var root := Node3D.new()
	root.name = "GlassWall"
	var pos: Array = feat.get("pos", [0, 0, 0])
	root.position = Vector3(pos[0], pos[1], pos[2])
	root.rotation_degrees.y = feat.get("yaw", 0.0)
	var w: float = feat.get("width", 2.5)
	var h: float = feat.get("height", 3.2)
	var seed0: int = int(feat.get("seed", int(absf(float(pos[0]) * 5.0 + float(pos[2]) * 3.0))))
	# --- Garden exterior plate (unshaded) just inside wall, never behind opaque panel ---
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
		vmat.albedo_color = Color(1.08, 1.1, 1.05)  # slight lift for filmic
	else:
		vmat.albedo_color = Color(0.45, 0.62, 0.4)
	vmat.roughness = 1.0
	vmat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	vmat.cull_mode = BaseMaterial3D.CULL_DISABLED
	view_mi.material_override = vmat
	# +Z into room so facade wall at exterior cannot hide the plate
	view_mi.position = Vector3(0, h * 0.5, 0.02)
	root.add_child(view_mi)
	# Subtle sill ledge only (do NOT paint opaque sky/lawn bands or hedge orbs over plate)
	_add_box(root, Vector3(0, 0.06, 0.08), Vector3(w - 0.1, 0.08, 0.12), STONE.darkened(0.05), false, 0.7)
	# Brass/copper glazing bar caps at corners (period conservatory detail)
	for sx in [-1.0, 1.0]:
		for sy in [0.08, h - 0.08]:
			_add_box(root, Vector3(sx * (w * 0.5 - 0.05), sy, 0.14), Vector3(0.08, 0.06, 0.06), BRASS.darkened(0.1), false, 0.35)
	# Perimeter iron (in front of view) — mid-grey so not pure black frame
	var bar := 0.07
	var frame_iron := Color(0.34, 0.34, 0.36)
	_add_box(root, Vector3(0, bar * 0.5, 0.1), Vector3(w, bar, 0.09), frame_iron, true, 0.45)
	_add_box(root, Vector3(0, h - bar * 0.5, 0.1), Vector3(w, bar, 0.09), frame_iron, true, 0.45)
	_add_box(root, Vector3(-w * 0.5 + bar * 0.5, h * 0.5, 0.1), Vector3(bar, h, 0.09), frame_iron, true, 0.45)
	_add_box(root, Vector3(w * 0.5 - bar * 0.5, h * 0.5, 0.1), Vector3(bar, h, 0.09), frame_iron, true, 0.45)
	# Mullion grid — thinner, slightly brass-tinged for period conservatory
	for i in 4:
		var fx2 := -w * 0.35 + float(i) * (w * 0.23)
		_add_box(root, Vector3(fx2, h * 0.5, 0.11), Vector3(0.035, h - 0.14, 0.04), frame_iron.lightened(0.08), false, 0.45)
	for j in 3:
		var fy := h * 0.22 * float(j + 1)
		_add_box(root, Vector3(0, fy, 0.11), Vector3(w - 0.14, 0.035, 0.04), frame_iron.lightened(0.08), false, 0.45)
	# Very light glass tint — garden plate must dominate
	var glass := MeshInstance3D.new()
	var gm := BoxMesh.new()
	gm.size = Vector3(w - 0.14, h - 0.14, 0.01)
	glass.mesh = gm
	var gmat := StandardMaterial3D.new()
	gmat.albedo_color = Color(0.78, 0.88, 0.92, 0.1)
	gmat.metallic = 0.08
	gmat.roughness = 0.06
	gmat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	gmat.cull_mode = BaseMaterial3D.CULL_DISABLED
	gmat.depth_draw_mode = BaseMaterial3D.DEPTH_DRAW_ALWAYS
	glass.material_override = gmat
	glass.position = Vector3(0, h * 0.5, 0.13)
	root.add_child(glass)
	var fill := OmniLight3D.new()
	fill.light_color = Color(0.82, 0.94, 0.98)
	fill.light_energy = 0.7
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
	## Victorian looking-glass (loop 105): silvered mid-tone plate with room silhouette
	## + sheen — never black void, never light-blue placeholder bars.
	var root := Node3D.new()
	root.name = "Mirror"
	var pos: Array = feat.get("pos", [0, 0, 0])
	root.position = Vector3(pos[0], pos[1], pos[2])
	root.rotation_degrees.y = feat.get("yaw", 0.0)
	var w: float = float(feat.get("width", 1.05))
	var h: float = float(feat.get("height", 1.45))
	# Ornate gilt frame + dark liner
	_add_box(root, Vector3(0, 0, 0.04), Vector3(w + 0.12, h + 0.12, 0.09), BRASS, true, 0.32)
	_add_box(root, Vector3(0, 0, 0.07), Vector3(w + 0.04, h + 0.04, 0.04), BRASS.darkened(0.1), false, 0.35)
	_add_box(root, Vector3(0, 0, 0.085), Vector3(w - 0.08, h - 0.08, 0.03), Color(0.18, 0.12, 0.08), false, 0.55)
	# Inner gold bead
	_add_box(root, Vector3(0, 0, 0.09), Vector3(w - 0.12, h - 0.12, 0.012), BRASS.lightened(0.08), false, 0.3)
	# Crest + corner bosses
	_add_box(root, Vector3(0, h * 0.5 + 0.08, 0.06), Vector3(0.28, 0.14, 0.05), BRASS.lightened(0.1), false, 0.3)
	_add_box(root, Vector3(0, h * 0.5 + 0.14, 0.06), Vector3(0.12, 0.07, 0.04), BRASS, false, 0.3)
	for sx in [-1.0, 1.0]:
		for sy in [-1.0, 1.0]:
			_add_box(root, Vector3(sx * (w * 0.48), sy * (h * 0.48), 0.07), Vector3(0.09, 0.09, 0.04), BRASS.lightened(0.05), false, 0.3)
	# Silver plate (texture mid-tone silver + silhouette; boost if missing)
	var glass := MeshInstance3D.new()
	var gm := QuadMesh.new()
	gm.size = Vector2(w - 0.18, h - 0.18)
	glass.mesh = gm
	var gmat := StandardMaterial3D.new()
	var plate_tex := _load_tex("res://assets/rooms/textures/victorian/mirror_plate.jpg")
	if plate_tex:
		gmat.albedo_texture = plate_tex
		gmat.albedo_color = Color(1.15, 1.18, 1.22)  # lift silver so plate reads at room distance
	else:
		gmat.albedo_color = Color(0.55, 0.6, 0.65)
	gmat.roughness = 1.0
	gmat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	gmat.cull_mode = BaseMaterial3D.CULL_DISABLED
	glass.material_override = gmat
	glass.position = Vector3(0, 0, 0.105)
	root.add_child(glass)
	# Soft diagonal sheen strip (gilt catch light — not abstract bars)
	_add_unshaded_plate(root, Vector3(-w * 0.12, h * 0.08, 0.112), Vector3(0.04, h * 0.55, 0.003), Color(0.72, 0.76, 0.8))
	_add_unshaded_plate(root, Vector3(w * 0.22, -h * 0.05, 0.112), Vector3(0.025, h * 0.35, 0.003), Color(0.62, 0.66, 0.7))
	# Soft catch light
	var catch_l := OmniLight3D.new()
	catch_l.light_color = Color(0.92, 0.94, 1.0)
	catch_l.light_energy = 0.28
	catch_l.omni_range = 1.8
	catch_l.position = Vector3(0.12, 0.1, 0.4)
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
		# Loop 70: solid mesh bulk so edge-on walk-bys aren't paper-thin cards
		var bulk_kind: String = str(prop.get("mesh_bulk", ""))
		if bulk_kind == "" and solid:
			# Infer from texture filename (CONTENT swap: desk.png=chesterfield, sofa.png=writing desk)
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
			_add_billboard_mesh_bulk(root, bulk_kind, width, height)

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


static func _add_billboard_mesh_bulk(root: Node3D, bulk: String, width: float, height: float) -> void:
	## Low-poly solid volume *behind* the painted card (card faces +Z at z≈0).
	## Keep all bulk z-max ≤ -0.04 so front hero art is never covered.
	match bulk:
		"sofa":
			# Chesterfield depth behind card: seat/back/arms/legs only in -Z half
			var sw: float = clampf(width * 0.88, 1.6, 2.4)
			_add_box(root, Vector3(0, 0.2, -0.28), Vector3(sw, 0.16, 0.42), MAHOGANY_DARK, false, 0.42)
			_add_box(root, Vector3(0, 0.4, -0.26), Vector3(sw * 0.9, 0.2, 0.38), VELVET_GREEN_DEEP, false, 0.88)
			_add_box(root, Vector3(0, 0.78, -0.42), Vector3(sw * 0.94, 0.58, 0.16), VELVET_GREEN, false, 0.9)
			for sx in [-1.0, 1.0]:
				_add_box(root, Vector3(sx * (sw * 0.42), 0.55, -0.28),
					Vector3(0.16, 0.38, 0.38), VELVET_GREEN_DEEP, false, 0.88)
				_add_cylinder(root, Vector3(sx * (sw * 0.4), 0.08, -0.12), 0.035, 0.14, MAHOGANY, false)
				_add_cylinder(root, Vector3(sx * (sw * 0.4), 0.08, -0.4), 0.035, 0.14, MAHOGANY, false)
		"desk":
			var dw: float = clampf(width * 0.85, 1.1, 1.6)
			_add_box(root, Vector3(0, 0.78, -0.22), Vector3(dw, 0.05, 0.42), MAHOGANY, false, 0.45)
			_add_box(root, Vector3(0, 0.81, -0.22), Vector3(dw * 0.9, 0.012, 0.36), Color(0.1, 0.16, 0.1), false, 0.72)
			_add_box(root, Vector3(-0.42, 0.38, -0.22), Vector3(0.38, 0.7, 0.4), MAHOGANY_DARK, false, 0.42)
			_add_box(root, Vector3(0.42, 0.38, -0.22), Vector3(0.38, 0.7, 0.4), MAHOGANY_DARK, false, 0.42)
			_add_box(root, Vector3(0, 0.95, -0.4), Vector3(dw * 0.9, 0.28, 0.06), MAHOGANY, false, 0.45)
		"wing":
			var ww: float = clampf(width * 0.75, 0.7, 1.0)
			_add_box(root, Vector3(0, 0.35, -0.22), Vector3(ww, 0.2, 0.4), MAHOGANY_DARK, false, 0.42)
			_add_box(root, Vector3(0, 0.5, -0.18), Vector3(ww * 0.9, 0.14, 0.36), VELVET_RED.darkened(0.05), false, 0.9)
			_add_box(root, Vector3(0, 0.95, -0.36), Vector3(ww * 0.92, 0.85, 0.14), VELVET_RED, false, 0.9)
			for sx in [-1.0, 1.0]:
				_add_box(root, Vector3(sx * ww * 0.4, 1.0, -0.22),
					Vector3(0.12, 0.6, 0.28), VELVET_RED.darkened(0.08), false, 0.88)
				_add_box(root, Vector3(sx * ww * 0.4, 0.6, -0.12),
					Vector3(0.12, 0.18, 0.35), VELVET_RED.darkened(0.05), false, 0.88)
		"chair":
			var cw: float = clampf(width * 0.7, 0.45, 0.65)
			_add_box(root, Vector3(0, 0.46, -0.12), Vector3(cw, 0.08, 0.28), MAHOGANY, false, 0.48)
			_add_box(root, Vector3(0, 0.52, -0.12), Vector3(cw * 0.9, 0.06, 0.24), VELVET_GREEN, false, 0.9)
			_add_box(root, Vector3(0, 0.95, -0.28), Vector3(cw * 0.95, 0.75, 0.06), MAHOGANY, false, 0.45)
			for sx in [-1.0, 1.0]:
				_add_cylinder(root, Vector3(sx * cw * 0.35, 0.22, -0.02), 0.028, 0.4, MAHOGANY_DARK, false)
				_add_cylinder(root, Vector3(sx * cw * 0.35, 0.22, -0.24), 0.025, 0.4, MAHOGANY_DARK, false)
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
