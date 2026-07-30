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
	## Loop 194: partner writing desk — solid-mat mahogany + leather + brass (not iron/wood washout).
	if prop.get("billboard", false) and prop.get("texture", "") != "":
		return _make_billboard_prop(prop)
	var root := Node3D.new()
	root.name = "Desk"
	var top_y := 0.78
	var mat_m := _solid_matte(Color(0.3, 0.14, 0.08), 0.72)
	var mat_md := _solid_matte(Color(0.18, 0.09, 0.05), 0.78)
	var mat_leather := _solid_matte(Color(0.12, 0.18, 0.1), 0.88)
	var mat_br := _solid_metal(Color(0.72, 0.56, 0.28), 0.3)
	var mat_br_d := _solid_metal(Color(0.55, 0.42, 0.2), 0.35)
	var mat_paper := _solid_matte(Color(0.84, 0.78, 0.62), 0.92)
	var mat_paper_d := _solid_matte(Color(0.76, 0.7, 0.54), 0.92)
	var mat_ink := _solid_matte(Color(0.1, 0.1, 0.14), 0.85)
	var mat_pen := _solid_matte(Color(0.28, 0.14, 0.08), 0.75)
	var mat_candle := _solid_matte(Color(0.95, 0.82, 0.45), 0.7)
	var mat_seal := _solid_matte(Color(0.55, 0.12, 0.1), 0.85)
	# Top + leather + apron
	_add_mesh_box(root, Vector3(0, top_y, 0), Vector3(1.55, 0.055, 0.82), mat_m)
	_add_mesh_box(root, Vector3(0, top_y + 0.03, 0), Vector3(1.42, 0.014, 0.7), mat_leather)
	_add_mesh_box(root, Vector3(0, top_y - 0.04, 0), Vector3(1.52, 0.03, 0.8), mat_md)
	# Twin pedestals
	_add_mesh_box(root, Vector3(-0.52, 0.38, 0), Vector3(0.42, 0.72, 0.74), mat_md)
	_add_mesh_box(root, Vector3(0.52, 0.38, 0), Vector3(0.42, 0.72, 0.74), mat_md)
	for side in [-1.0, 1.0]:
		for i in 3:
			var dy := 0.18 + i * 0.2
			_add_mesh_box(root, Vector3(side * 0.52, dy, 0.35), Vector3(0.36, 0.16, 0.05), mat_m)
			_add_mesh_cyl(root, Vector3(side * 0.52, dy, 0.39), 0.014, 0.022, mat_br, false)
	_add_mesh_box(root, Vector3(0, top_y - 0.12, 0.34), Vector3(0.55, 0.12, 0.05), mat_m)
	_add_mesh_cyl(root, Vector3(0, top_y - 0.12, 0.38), 0.014, 0.022, mat_br, false)
	for lx in [-0.62, -0.42, 0.42, 0.62]:
		for lz in [-0.28, 0.28]:
			_add_mesh_cyl(root, Vector3(lx, 0.08, lz), 0.035, 0.14, mat_md, true)
			_add_mesh_cyl(root, Vector3(lx, 0.02, lz), 0.05, 0.035, mat_m, false)
	# Pigeonhole gallery
	_add_mesh_box(root, Vector3(0, top_y + 0.08, -0.3), Vector3(1.38, 0.04, 0.22), mat_md)
	_add_mesh_box(root, Vector3(0, top_y + 0.38, -0.32), Vector3(1.4, 0.05, 0.08), mat_m)
	for sx in [-1.0, 1.0]:
		_add_mesh_box(root, Vector3(sx * 0.68, top_y + 0.23, -0.3), Vector3(0.05, 0.3, 0.2), mat_m)
	for i in 3:
		var gx := -0.4 + float(i) * 0.4
		_add_mesh_box(root, Vector3(gx, top_y + 0.23, -0.32), Vector3(0.03, 0.28, 0.06), mat_md)
	_add_mesh_box(root, Vector3(-0.4, top_y + 0.14, -0.28), Vector3(0.12, 0.08, 0.08), mat_paper_d)
	_add_mesh_box(root, Vector3(0.0, top_y + 0.14, -0.28), Vector3(0.1, 0.06, 0.08), mat_paper)
	_add_mesh_box(root, Vector3(0.4, top_y + 0.14, -0.28), Vector3(0.08, 0.1, 0.08), mat_pen)
	# Still-life: papers + ink + candlestick
	_add_mesh_box(root, Vector3(0.28, top_y + 0.04, 0.12), Vector3(0.34, 0.012, 0.24), mat_paper)
	_add_mesh_box(root, Vector3(0.32, top_y + 0.05, 0.08), Vector3(0.22, 0.01, 0.16), mat_paper_d)
	_add_mesh_box(root, Vector3(-0.25, top_y + 0.04, -0.05), Vector3(0.28, 0.01, 0.2), mat_paper)
	_add_mesh_box(root, Vector3(0.05, top_y + 0.06, -0.12), Vector3(0.055, 0.05, 0.055), mat_ink)
	_add_mesh_cyl(root, Vector3(0.12, top_y + 0.09, -0.08), 0.012, 0.14, mat_pen, false)
	_add_mesh_cyl(root, Vector3(-0.35, top_y + 0.02, 0.15), 0.055, 0.035, mat_md, false)
	_add_mesh_cyl(root, Vector3(-0.35, top_y + 0.08, 0.15), 0.028, 0.09, mat_m, false)
	_add_mesh_cyl(root, Vector3(-0.35, top_y + 0.13, 0.15), 0.045, 0.02, mat_br_d, false)
	_add_mesh_cyl(root, Vector3(-0.35, top_y + 0.26, 0.15), 0.02, 0.22, mat_candle, false)
	var mat_flame_d := StandardMaterial3D.new()
	mat_flame_d.albedo_color = Color(1.0, 0.78, 0.4, 0.9)
	mat_flame_d.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	mat_flame_d.emission_enabled = true
	mat_flame_d.emission = Color(1.0, 0.72, 0.3)
	mat_flame_d.emission_energy_multiplier = 1.8
	mat_flame_d.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	_add_mesh_cyl(root, Vector3(-0.35, top_y + 0.38, 0.15), 0.022, 0.035, mat_flame_d, false)
	_add_mesh_box(root, Vector3(0.45, top_y + 0.05, -0.15), Vector3(0.12, 0.04, 0.08), mat_seal)
	_add_contact_shadow(root, 0.9, 0.55)
	var flame := OmniLight3D.new()
	flame.light_color = Color(1.0, 0.78, 0.42)
	flame.light_energy = 0.45
	flame.omni_range = 2.6
	flame.position = Vector3(-0.35, top_y + 0.36, 0.15)
	root.add_child(flame)
	return root

static func _make_chair(prop: Dictionary) -> Node3D:
	## Loop 198: side chair — solid-mat mahogany + velvet (no wood/fabric washout mid-FOV).
	if prop.get("billboard", false) and prop.get("texture", "") != "":
		return _make_billboard_prop(prop)
	var root := Node3D.new()
	root.name = "Chair"
	var seed0: int = int(prop.get("seed", 0))
	var fabric: Color = prop.get("fabric", VELVET_GREEN if seed0 % 2 == 0 else VELVET_RED.darkened(0.15))
	var mat_fab := _solid_matte(fabric, 0.92)
	var mat_fab_d := _solid_matte(fabric.darkened(0.12), 0.94)
	var mat_fab_dd := _solid_matte(fabric.darkened(0.2), 0.94)
	var mat_m := _solid_matte(Color(0.3, 0.14, 0.08), 0.72)
	var mat_md := _solid_matte(Color(0.18, 0.09, 0.05), 0.78)
	var mat_ml := _solid_matte(Color(0.36, 0.18, 0.1), 0.7)
	var mat_br := _solid_metal(Color(0.72, 0.56, 0.28), 0.3)
	_add_mesh_box(root, Vector3(0, 0.42, 0.02), Vector3(0.5, 0.08, 0.5), mat_m)
	_add_mesh_box(root, Vector3(0, 0.5, 0.02), Vector3(0.46, 0.1, 0.46), mat_fab)
	_add_mesh_box(root, Vector3(0, 0.56, 0.02), Vector3(0.4, 0.04, 0.4), mat_fab_d)
	_add_mesh_box(root, Vector3(0, 0.52, 0.25), Vector3(0.44, 0.012, 0.018), mat_fab_dd)
	for i in 5:
		_add_mesh_cyl(root, Vector3(-0.18 + float(i) * 0.09, 0.46, 0.26), 0.009, 0.012, mat_br, false)
	for sx in [-1.0, 1.0]:
		_add_mesh_box(root, Vector3(sx * 0.21, 0.95, -0.2), Vector3(0.045, 0.9, 0.05), mat_m)
		_add_mesh_cyl(root, Vector3(sx * 0.21, 0.95, -0.2), 0.022, 0.85, mat_md, false)
	_add_mesh_box(root, Vector3(0, 1.36, -0.19), Vector3(0.46, 0.08, 0.055), mat_m)
	_add_mesh_box(root, Vector3(0, 1.42, -0.18), Vector3(0.28, 0.04, 0.04), mat_ml)
	_add_mesh_box(root, Vector3(0, 0.58, -0.2), Vector3(0.4, 0.05, 0.04), mat_md)
	match seed0 % 3:
		0:
			for bx in [-0.1, 0.0, 0.1]:
				_add_mesh_box(root, Vector3(bx, 0.98, -0.18), Vector3(0.035, 0.65, 0.03), mat_m)
			_add_mesh_box(root, Vector3(0, 1.15, -0.18), Vector3(0.32, 0.03, 0.03), mat_md)
		1:
			_add_mesh_box(root, Vector3(0, 1.02, -0.2), Vector3(0.32, 0.55, 0.04), mat_m)
			_add_mesh_box(root, Vector3(0, 1.02, -0.15), Vector3(0.26, 0.48, 0.05), mat_fab)
			_add_mesh_cyl(root, Vector3(0, 1.05, -0.13), 0.12, 0.35, mat_fab_d, false)
			for bi in 2:
				_add_mesh_cyl(root, Vector3((float(bi) - 0.5) * 0.1, 1.05, -0.1), 0.012, 0.014, mat_fab_dd, false)
		_:
			_add_mesh_box(root, Vector3(0, 0.98, -0.18), Vector3(0.06, 0.65, 0.035), mat_md)
			_add_mesh_box(root, Vector3(0, 1.2, -0.17), Vector3(0.26, 0.05, 0.03), mat_m)
			for sx in [-1.0, 1.0]:
				_add_mesh_box(root, Vector3(sx * 0.1, 0.9, -0.18), Vector3(0.035, 0.4, 0.028), mat_m)
	for offset in [Vector3(-0.18, 0.2, 0.18), Vector3(0.18, 0.2, 0.18)]:
		_add_mesh_cyl(root, offset, 0.028, 0.38, mat_md, true)
		_add_mesh_cyl(root, Vector3(offset.x, 0.08, offset.z), 0.032, 0.08, mat_m, false)
		_add_mesh_cyl(root, Vector3(offset.x, 0.02, offset.z), 0.04, 0.03, mat_md, false)
	for offset in [Vector3(-0.18, 0.2, -0.18), Vector3(0.18, 0.2, -0.18)]:
		_add_mesh_cyl(root, offset, 0.025, 0.38, mat_md, true)
		_add_mesh_cyl(root, Vector3(offset.x, 0.02, offset.z), 0.036, 0.03, mat_m, false)
	_add_mesh_box(root, Vector3(0, 0.12, 0.0), Vector3(0.34, 0.025, 0.025), mat_m)
	_add_mesh_box(root, Vector3(-0.17, 0.12, 0.0), Vector3(0.025, 0.025, 0.3), mat_m)
	_add_mesh_box(root, Vector3(0.17, 0.12, 0.0), Vector3(0.025, 0.025, 0.3), mat_m)
	_add_contact_shadow(root, 0.4, 0.38)
	return root

static func _make_armchair(prop: Dictionary) -> Node3D:
	## Loop 199: Victorian wing — solid-mat mahogany + velvet (no wood/fabric washout mid-FOV).
	## Side FOV: ONE tall plane + leading roll; front detail inset only (loop 165 geometry).
	if prop.get("billboard", false) and prop.get("texture", "") != "":
		return _make_billboard_prop(prop)
	var root := Node3D.new()
	root.name = "Armchair"
	var fabric: Color = prop.get("fabric", VELVET_RED)
	var mat_fab := _solid_matte(fabric, 0.92)
	var mat_fab_d := _solid_matte(fabric.darkened(0.1), 0.94)
	var mat_fab_dd := _solid_matte(fabric.darkened(0.2), 0.94)
	var mat_fab_l := _solid_matte(fabric.lightened(0.05), 0.9)
	var mat_m := _solid_matte(Color(0.3, 0.14, 0.08), 0.72)
	var mat_md := _solid_matte(Color(0.18, 0.09, 0.05), 0.78)
	# Slim mahogany seat rail
	_add_mesh_box(root, Vector3(0, 0.22, 0.02), Vector3(0.78, 0.055, 0.7), mat_md)
	_add_mesh_box(root, Vector3(0, 0.26, 0.02), Vector3(0.82, 0.022, 0.72), mat_m)
	# Seat + front bolster
	_add_mesh_box(root, Vector3(0, 0.4, 0.08), Vector3(0.7, 0.16, 0.56), mat_fab)
	_add_mesh_box(root, Vector3(0, 0.5, 0.1), Vector3(0.62, 0.04, 0.48), mat_fab_d)
	_add_mesh_cyl_rot(root, Vector3(0, 0.44, 0.34), 0.065, 0.66, mat_fab_l, Vector3(0, 0, PI * 0.5))
	for bx in [-0.14, 0.0, 0.14]:
		for bz in [-0.04, 0.1]:
			_add_mesh_cyl(root, Vector3(bx, 0.53, bz), 0.011, 0.01, mat_fab_dd, false)
	# Back: ONE deep shell (not 3 nested stairs). Front pad is coplanar inset only.
	_add_mesh_box(root, Vector3(0, 0.95, -0.12), Vector3(0.62, 0.95, 0.28), mat_fab)
	_add_mesh_box(root, Vector3(0, 0.96, 0.0), Vector3(0.5, 0.78, 0.06), mat_fab_d)
	_add_mesh_box(root, Vector3(0, 0.98, 0.02), Vector3(0.4, 0.55, 0.03), mat_fab_l)
	# Crown roll (horizontal, sits on shell top — not a third terrace slab)
	_add_mesh_cyl_rot(root, Vector3(0, 1.38, -0.1), 0.09, 0.55, mat_fab, Vector3(0, 0, PI * 0.5))
	_add_mesh_cyl_rot(root, Vector3(0, 1.42, -0.14), 0.055, 0.38, mat_fab_d, Vector3(0, 0, PI * 0.5))
	_add_mesh_box(root, Vector3(0, 1.44, -0.2), Vector3(0.26, 0.035, 0.07), mat_m)
	# Wings: full-height outer envelope (same depth as back shell so side is continuous)
	for sx in [-1.0, 1.0]:
		_add_mesh_box(root, Vector3(sx * 0.36, 0.92, 0.0), Vector3(0.2, 0.95, 0.52), mat_fab)
		_add_mesh_cyl(root, Vector3(sx * 0.36, 0.92, 0.24), 0.1, 0.9, mat_fab, false)
		_add_mesh_cyl(root, Vector3(sx * 0.36, 1.1, 0.18), 0.075, 0.5, mat_fab_d, false)
		_add_mesh_box(root, Vector3(sx * 0.46, 0.92, 0.0), Vector3(0.02, 0.88, 0.42), mat_fab_dd)
		_add_mesh_cyl_rot(root, Vector3(sx * 0.36, 0.56, 0.1), 0.055, 0.42, mat_fab_l, Vector3(PI * 0.5, 0, 0))
		_add_mesh_cyl(root, Vector3(sx * 0.36, 0.56, 0.32), 0.045, 0.06, mat_fab, false)
		_add_mesh_cyl(root, Vector3(sx * 0.36, 0.34, 0.18), 0.022, 0.14, mat_md, true)
		_add_mesh_cyl(root, Vector3(sx * 0.36, 0.27, 0.24), 0.03, 0.05, mat_m, false)
	# Diamond button tufts on front pad only
	for row in 4:
		var by := 0.72 + float(row) * 0.15
		var odd := row % 2 == 1
		var cols: Array = [-0.09, 0.09] if odd else [-0.13, 0.0, 0.13]
		for bx_v in cols:
			_add_mesh_cyl(root, Vector3(float(bx_v), by, 0.04), 0.011, 0.01, mat_fab_dd, false)
	# Turned legs + slim H-stretcher
	for sx in [-1.0, 1.0]:
		_add_mesh_cyl(root, Vector3(sx * 0.28, 0.1, 0.24), 0.026, 0.17, mat_md, true)
		_add_mesh_cyl(root, Vector3(sx * 0.28, 0.02, 0.24), 0.036, 0.022, mat_m, false)
		_add_mesh_cyl(root, Vector3(sx * 0.26, 0.1, -0.2), 0.024, 0.17, mat_md, true)
		_add_mesh_cyl(root, Vector3(sx * 0.26, 0.02, -0.2), 0.034, 0.022, mat_m, false)
	_add_mesh_box(root, Vector3(0, 0.1, 0.02), Vector3(0.5, 0.016, 0.016), mat_m)
	_add_mesh_box(root, Vector3(-0.26, 0.1, 0.02), Vector3(0.016, 0.016, 0.38), mat_m)
	_add_mesh_box(root, Vector3(0.26, 0.1, 0.02), Vector3(0.016, 0.016, 0.38), mat_m)
	_add_contact_shadow(root, 0.55, 0.5)
	return root

static func _make_ottoman(prop: Dictionary) -> Node3D:
	## Loop 199: soft tufted footstool — solid-mat velvet + mahogany (no washout mid-FOV).
	## seed: 0 square chesterfield · 1 round drum · 2 long fringe bench.
	var root := Node3D.new()
	root.name = "Ottoman"
	var fabric: Color = prop.get("fabric", VELVET_GREEN.darkened(0.08))
	var mat_fab := _solid_matte(fabric, 0.92)
	var mat_fab_d := _solid_matte(fabric.darkened(0.12), 0.94)
	var mat_fab_dd := _solid_matte(fabric.darkened(0.24), 0.94)
	var mat_fab_l := _solid_matte(fabric.lightened(0.05), 0.9)
	var mat_m := _solid_matte(Color(0.3, 0.14, 0.08), 0.72)
	var mat_md := _solid_matte(Color(0.18, 0.09, 0.05), 0.78)
	var mat_br := _solid_metal(Color(0.72, 0.56, 0.28), 0.3)
	var seed0: int = int(prop.get("seed", 0))
	var style := seed0 % 3
	var w: float = float(prop.get("width", 0.78 if style != 2 else 0.95))
	var d: float = float(prop.get("depth", 0.56 if style != 1 else 0.52))
	if style == 1:
		# Round drum — stepped dome + button ring, turned feet (morning)
		var r: float = w * 0.4
		_add_mesh_cyl(root, Vector3(0, 0.08, 0), r * 0.92, 0.08, mat_md, true)
		_add_mesh_cyl(root, Vector3(0, 0.14, 0), r * 0.98, 0.05, mat_m, false)
		_add_mesh_cyl(root, Vector3(0, 0.28, 0), r, 0.22, mat_fab, true)
		_add_mesh_cyl(root, Vector3(0, 0.4, 0), r * 0.9, 0.1, mat_fab_d, false)
		_add_mesh_cyl(root, Vector3(0, 0.46, 0), r * 0.72, 0.06, mat_fab_l, false)
		_add_mesh_cyl(root, Vector3(0, 0.5, 0), r * 0.45, 0.04, mat_fab_d, false)
		_add_mesh_cyl(root, Vector3(0, 0.18, 0), r * 1.02, 0.04, mat_fab_dd, false)
		for i in 8:
			var ang := float(i) * TAU / 8.0
			_add_mesh_cyl(root, Vector3(cos(ang) * r * 0.42, 0.48, sin(ang) * r * 0.42), 0.02, 0.018, mat_fab_dd, false)
		_add_mesh_cyl(root, Vector3(0, 0.52, 0), 0.022, 0.02, mat_fab_dd, false)
		_add_mesh_cyl(root, Vector3(0, 0.34, 0), r * 1.04, 0.06, mat_fab_l, false)
		for i in 4:
			var ang2 := float(i) * TAU / 4.0 + 0.35
			var fx := cos(ang2) * r * 0.62
			var fz := sin(ang2) * r * 0.62
			_add_mesh_cyl(root, Vector3(fx, 0.05, fz), 0.032, 0.1, mat_m, true)
			_add_mesh_cyl(root, Vector3(fx, 0.01, fz), 0.042, 0.025, mat_md, false)
	elif style == 2:
		# Long fringe bench — rolled ends, diamond tufts, mahogany rail
		_add_mesh_box(root, Vector3(0, 0.12, 0), Vector3(w * 0.96, 0.08, d * 0.9), mat_md)
		_add_mesh_box(root, Vector3(0, 0.17, 0), Vector3(w, 0.03, d * 0.96), mat_m)
		_add_mesh_box(root, Vector3(0, 0.3, 0), Vector3(w * 0.94, 0.2, d * 0.88), mat_fab)
		_add_mesh_box(root, Vector3(0, 0.42, 0), Vector3(w * 0.86, 0.06, d * 0.78), mat_fab_d)
		for i in 4:
			var bx := (float(i) / 3.0 - 0.5) * w * 0.68
			_add_mesh_cyl(root, Vector3(bx, 0.46, 0), d * 0.28, 0.08, mat_fab_l, false)
		_add_mesh_cyl_rot(root, Vector3(0, 0.36, d * 0.38), 0.05, w * 0.88, mat_fab_l, Vector3(0, 0, PI * 0.5))
		_add_mesh_cyl_rot(root, Vector3(0, 0.36, -d * 0.38), 0.05, w * 0.88, mat_fab_l, Vector3(0, 0, PI * 0.5))
		for sx in [-1.0, 1.0]:
			_add_mesh_cyl_rot(root, Vector3(sx * w * 0.42, 0.36, 0), 0.055, d * 0.7, mat_fab_d, Vector3(PI * 0.5, 0, 0))
			_add_mesh_cyl(root, Vector3(sx * w * 0.44, 0.4, 0), 0.06, 0.08, mat_fab, false)
		for i in 5:
			for j in 2:
				var bx2 := (float(i) / 4.0 - 0.5) * w * 0.72
				var bz2 := (float(j) - 0.5) * d * 0.32
				_add_mesh_cyl(root, Vector3(bx2, 0.5, bz2), 0.018, 0.016, mat_fab_dd, false)
		for i in 9:
			var fx := (float(i) / 8.0 - 0.5) * w * 0.88
			_add_mesh_box(root, Vector3(fx, 0.1, d * 0.44), Vector3(0.04, 0.1, 0.02), mat_fab_dd)
			_add_mesh_box(root, Vector3(fx, 0.1, -d * 0.44), Vector3(0.04, 0.1, 0.02), mat_fab_dd)
		for i in 7:
			var t := float(i) / 6.0
			_add_mesh_cyl(root, Vector3(-w * 0.4 + t * w * 0.8, 0.2, d * 0.42), 0.012, 0.014, mat_br, false)
		for sx in [-1.0, 1.0]:
			for sz in [-1.0, 1.0]:
				_add_mesh_cyl(root, Vector3(sx * w * 0.4, 0.055, sz * d * 0.34), 0.03, 0.1, mat_m, true)
				_add_mesh_cyl(root, Vector3(sx * w * 0.4, 0.012, sz * d * 0.34), 0.04, 0.028, mat_md, false)
	else:
		# Square chesterfield footstool (drawing-room hero)
		_add_mesh_box(root, Vector3(0, 0.1, 0), Vector3(w * 0.92, 0.07, d * 0.9), mat_md)
		_add_mesh_box(root, Vector3(0, 0.15, 0), Vector3(w * 0.98, 0.035, d * 0.96), mat_m)
		_add_mesh_box(root, Vector3(0, 0.28, 0), Vector3(w * 0.9, 0.18, d * 0.86), mat_fab)
		_add_mesh_box(root, Vector3(0, 0.39, 0), Vector3(w * 0.78, 0.08, d * 0.72), mat_fab_d)
		_add_mesh_box(root, Vector3(0, 0.45, 0), Vector3(w * 0.62, 0.05, d * 0.55), mat_fab_l)
		_add_mesh_cyl_rot(root, Vector3(0, 0.34, d * 0.38), 0.055, w * 0.82, mat_fab_l, Vector3(0, 0, PI * 0.5))
		_add_mesh_cyl_rot(root, Vector3(0, 0.34, -d * 0.38), 0.055, w * 0.82, mat_fab_l, Vector3(0, 0, PI * 0.5))
		_add_mesh_cyl_rot(root, Vector3(w * 0.4, 0.34, 0), 0.055, d * 0.72, mat_fab_l, Vector3(PI * 0.5, 0, 0))
		_add_mesh_cyl_rot(root, Vector3(-w * 0.4, 0.34, 0), 0.055, d * 0.72, mat_fab_l, Vector3(PI * 0.5, 0, 0))
		for sx in [-1.0, 1.0]:
			for sz in [-1.0, 1.0]:
				_add_mesh_cyl(root, Vector3(sx * w * 0.36, 0.36, sz * d * 0.32), 0.055, 0.1, mat_fab, false)
		for row in 3:
			var by := 0.48
			var odd := row % 2 == 1
			var cols: Array = [-0.12, 0.12] if odd else [-0.2, 0.0, 0.2]
			for bx_v in cols:
				var bz_v := (float(row) - 1.0) * d * 0.18
				_add_mesh_cyl(root, Vector3(float(bx_v), by, bz_v), 0.02, 0.016, mat_fab_dd, false)
		for i in 7:
			var fx := (float(i) / 6.0 - 0.5) * w * 0.82
			_add_mesh_box(root, Vector3(fx, 0.1, d * 0.42), Vector3(0.035, 0.09, 0.018), mat_fab_dd)
			_add_mesh_box(root, Vector3(fx, 0.1, -d * 0.42), Vector3(0.035, 0.09, 0.018), mat_fab_dd)
		for i in 5:
			var fz := (float(i) / 4.0 - 0.5) * d * 0.75
			_add_mesh_box(root, Vector3(w * 0.44, 0.1, fz), Vector3(0.018, 0.09, 0.035), mat_fab_dd)
			_add_mesh_box(root, Vector3(-w * 0.44, 0.1, fz), Vector3(0.018, 0.09, 0.035), mat_fab_dd)
		for i in 6:
			var t := float(i) / 5.0
			_add_mesh_cyl(root, Vector3(-w * 0.38 + t * w * 0.76, 0.18, d * 0.44), 0.011, 0.012, mat_br, false)
			_add_mesh_cyl(root, Vector3(-w * 0.38 + t * w * 0.76, 0.18, -d * 0.44), 0.011, 0.012, mat_br, false)
		for sx in [-1.0, 1.0]:
			for sz in [-1.0, 1.0]:
				_add_mesh_cyl(root, Vector3(sx * w * 0.34, 0.05, sz * d * 0.3), 0.034, 0.1, mat_m, true)
				_add_mesh_cyl(root, Vector3(sx * w * 0.34, 0.012, sz * d * 0.3), 0.044, 0.028, mat_md, false)
	_add_contact_shadow(root, w * 0.55, d * 0.55)
	return root


static func _make_letter_stack(prop: Dictionary) -> Node3D:
	## Loop 200: sealed letters / vellum packet — solid-mat paper + seal (no washout).
	var root := Node3D.new()
	root.name = "LetterStack"
	var seed0: int = int(prop.get("seed", 0))
	var mat_paper := _solid_matte(Color(0.84, 0.78, 0.62), 0.92)
	var mat_paper_d := _solid_matte(Color(0.76, 0.7, 0.54), 0.92)
	var mat_paper_l := _solid_matte(Color(0.88, 0.82, 0.68), 0.9)
	var mat_ink := _solid_matte(Color(0.1, 0.1, 0.14), 0.85)
	var mat_ink_l := _solid_matte(Color(0.22, 0.22, 0.28), 0.85)
	var mat_seal := _solid_matte(Color(0.55, 0.12, 0.1), 0.85)
	var mat_ribbon := _solid_matte(Color(0.45, 0.18, 0.14), 0.88)
	for i in 3 + seed0 % 2:
		var y := 0.02 + float(i) * 0.012
		var ox := float((i + seed0) % 3) * 0.01
		var mat_i := mat_paper if i % 2 == 0 else mat_paper_d
		_add_mesh_box(root, Vector3(ox, y, 0), Vector3(0.18 - float(i) * 0.01, 0.008, 0.12), mat_i)
	_add_mesh_box(root, Vector3(0.02, 0.055, 0.02), Vector3(0.16, 0.004, 0.11), mat_paper_l)
	_add_mesh_box(root, Vector3(0.0, 0.06, 0.0), Vector3(0.1, 0.002, 0.008), mat_ink)
	_add_mesh_box(root, Vector3(0.02, 0.06, 0.02), Vector3(0.08, 0.002, 0.006), mat_ink_l)
	_add_mesh_cyl(root, Vector3(0.05, 0.07, 0.03), 0.018, 0.008, mat_seal, false)
	_add_mesh_box(root, Vector3(-0.02, 0.04, 0), Vector3(0.02, 0.01, 0.14), mat_ribbon)
	return root


static func _make_tea_tray(prop: Dictionary) -> Node3D:
	## Loop 200: tea at four — solid-mat silver tray + china (no metal/china washout mid-FOV).
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
			trim = Color(0.65, 0.5, 0.24)
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
	var mat_china := _solid_matte(china, 0.55)
	var mat_china_d := _solid_matte(china_d, 0.58)
	var mat_china_l := _solid_matte(china.lightened(0.04), 0.5)
	var mat_band := _solid_matte(band, 0.45)
	var mat_trim := _solid_metal(trim, 0.32)
	var mat_trim_l := _solid_metal(trim.lightened(0.08), 0.28)
	var mat_sil := _solid_metal(Color(0.58, 0.58, 0.62), 0.28)
	var mat_sil_d := _solid_metal(Color(0.42, 0.42, 0.46), 0.32)
	var mat_sil_hi := _solid_metal(Color(0.7, 0.7, 0.74), 0.24)
	var mat_tea := _solid_matte(Color(0.45, 0.28, 0.12), 0.75)
	# Pewter/silver tray — oval via stacked cylinders
	_add_mesh_cyl(root, Vector3(0, 0.012, 0), 0.24, 0.014, mat_sil_d, false)
	_add_mesh_cyl(root, Vector3(0, 0.02, 0), 0.22, 0.01, mat_sil, false)
	_add_mesh_box(root, Vector3(0, 0.016, 0), Vector3(0.5, 0.012, 0.28), mat_sil)
	_add_mesh_box(root, Vector3(0, 0.024, 0), Vector3(0.46, 0.008, 0.24), mat_sil_hi)
	_add_mesh_cyl(root, Vector3(0, 0.034, 0), 0.23, 0.012, mat_sil_d, false)
	_add_mesh_box(root, Vector3(0, 0.036, 0.14), Vector3(0.46, 0.016, 0.016), mat_sil)
	_add_mesh_box(root, Vector3(0, 0.036, -0.14), Vector3(0.46, 0.016, 0.016), mat_sil)
	_add_mesh_box(root, Vector3(0.22, 0.036, 0), Vector3(0.016, 0.016, 0.26), mat_sil)
	_add_mesh_box(root, Vector3(-0.22, 0.036, 0), Vector3(0.016, 0.016, 0.26), mat_sil)
	for sx in [-1.0, 1.0]:
		_add_mesh_box(root, Vector3(sx * 0.26, 0.04, 0), Vector3(0.03, 0.022, 0.08), mat_sil_d)
		_add_mesh_cyl_rot(root, Vector3(sx * 0.275, 0.05, 0), 0.014, 0.05, mat_sil_hi, Vector3(0, 0, PI * 0.5))
	# ── Teapot hero ──
	var tx := -0.09
	var tz := 0.01
	var by0 := 0.05
	_add_mesh_cyl(root, Vector3(tx, by0 + 0.01, tz), 0.04, 0.012, mat_china_d, false)
	_add_mesh_cyl(root, Vector3(tx, by0 + 0.045, tz), 0.072, 0.04, mat_china, false)
	_add_mesh_cyl(root, Vector3(tx, by0 + 0.07, tz), 0.068, 0.04, mat_china, false)
	_add_mesh_cyl(root, Vector3(tx, by0 + 0.095, tz), 0.055, 0.028, mat_china_d, false)
	_add_mesh_cyl(root, Vector3(tx, by0 + 0.072, tz), 0.074, 0.01, mat_band, false)
	_add_mesh_cyl(root, Vector3(tx, by0 + 0.12, tz), 0.045, 0.028, mat_china, false)
	_add_mesh_cyl(root, Vector3(tx, by0 + 0.138, tz), 0.032, 0.016, mat_china_d, false)
	_add_mesh_cyl(root, Vector3(tx, by0 + 0.155, tz), 0.014, 0.016, mat_trim, false)
	_add_mesh_cyl(root, Vector3(tx, by0 + 0.168, tz), 0.01, 0.01, mat_trim_l, false)
	_add_mesh_box(root, Vector3(tx + 0.055, by0 + 0.06, tz), Vector3(0.05, 0.024, 0.024), mat_china_d)
	_add_mesh_cyl_rot(root, Vector3(tx + 0.1, by0 + 0.075, tz), 0.014, 0.07, mat_china_d, Vector3(0, 0, -0.55))
	_add_mesh_cyl(root, Vector3(tx + 0.13, by0 + 0.09, tz), 0.011, 0.018, mat_china_d, false)
	_add_mesh_cyl_rot(root, Vector3(tx - 0.08, by0 + 0.07, tz), 0.012, 0.055, mat_china_d, Vector3(0, 0, PI * 0.5))
	_add_mesh_box(root, Vector3(tx - 0.09, by0 + 0.095, tz), Vector3(0.03, 0.014, 0.022), mat_china_d)
	_add_mesh_box(root, Vector3(tx - 0.09, by0 + 0.045, tz), Vector3(0.028, 0.012, 0.022), mat_china_d)
	# ── Two cups + saucers ──
	for i in 2:
		var cx := 0.08 + float(i) * 0.11
		var cz := 0.05 - float(i) * 0.09
		_add_mesh_cyl(root, Vector3(cx, by0 + 0.008, cz), 0.045, 0.008, mat_china_d, false)
		_add_mesh_cyl(root, Vector3(cx, by0 + 0.014, cz), 0.035, 0.006, mat_china, false)
		_add_mesh_cyl(root, Vector3(cx, by0 + 0.035, cz), 0.024, 0.035, mat_china, false)
		_add_mesh_cyl(root, Vector3(cx, by0 + 0.055, cz), 0.028, 0.008, mat_band if i == 0 else mat_trim, false)
		_add_mesh_cyl(root, Vector3(cx, by0 + 0.06, cz), 0.03, 0.006, mat_china_l, false)
		_add_mesh_box(root, Vector3(cx + 0.03, by0 + 0.038, cz), Vector3(0.014, 0.026, 0.012), mat_china_d)
		_add_mesh_cyl(root, Vector3(cx, by0 + 0.042, cz), 0.018, 0.004, mat_tea, false)
	# Cream jug
	var jx := 0.04
	var jz := -0.09
	_add_mesh_cyl(root, Vector3(jx, by0 + 0.03, jz), 0.02, 0.045, mat_china, false)
	_add_mesh_cyl(root, Vector3(jx, by0 + 0.055, jz), 0.022, 0.01, mat_band, false)
	_add_mesh_box(root, Vector3(jx + 0.025, by0 + 0.045, jz), Vector3(0.024, 0.014, 0.016), mat_china_d)
	_add_mesh_box(root, Vector3(jx - 0.02, by0 + 0.038, jz), Vector3(0.01, 0.028, 0.012), mat_china_d)
	# Sugar bowl + lid
	var sx2 := -0.02
	var sz2 := -0.07
	_add_mesh_cyl(root, Vector3(sx2, by0 + 0.028, sz2), 0.028, 0.032, mat_china, false)
	_add_mesh_cyl(root, Vector3(sx2, by0 + 0.048, sz2), 0.03, 0.01, mat_band, false)
	_add_mesh_cyl(root, Vector3(sx2, by0 + 0.058, sz2), 0.024, 0.016, mat_china, false)
	_add_mesh_cyl(root, Vector3(sx2, by0 + 0.07, sz2), 0.01, 0.014, mat_trim, false)
	# Teaspoons
	_add_mesh_box(root, Vector3(0.15, by0 + 0.01, -0.02), Vector3(0.08, 0.005, 0.01), mat_sil_hi)
	_add_mesh_box(root, Vector3(0.19, by0 + 0.01, -0.035), Vector3(0.06, 0.004, 0.008), mat_sil)
	return root


static func _make_sofa(prop: Dictionary) -> Node3D:
	## Loop 200: olive chesterfield — solid-mat velvet + mahogany (no fabric/wood washout mid-FOV).
	if prop.get("billboard", false) and prop.get("texture", "") != "":
		return _make_billboard_prop(prop)
	var root := Node3D.new()
	root.name = "Sofa"
	var width: float = float(prop.get("width", 2.35))
	var fabric: Color = prop.get("fabric", VELVET_GREEN)
	var mat_fab := _solid_matte(fabric, 0.92)
	var mat_fab_d := _solid_matte(fabric.darkened(0.1), 0.94)
	var mat_fab_dd := _solid_matte(fabric.darkened(0.22), 0.94)
	var mat_fab_l := _solid_matte(fabric.lightened(0.04), 0.9)
	var mat_m := _solid_matte(Color(0.3, 0.14, 0.08), 0.72)
	var mat_md := _solid_matte(Color(0.18, 0.09, 0.05), 0.78)
	var mat_br := _solid_metal(Color(0.72, 0.56, 0.28), 0.3)
	# Slim mahogany plinth (visible under skirt)
	_add_mesh_box(root, Vector3(0, 0.14, 0.02), Vector3(width * 0.98, 0.07, 0.86), mat_md)
	_add_mesh_box(root, Vector3(0, 0.2, 0.02), Vector3(width, 0.03, 0.9), mat_m)
	# Seat deck — one continuous buttoned pad
	_add_mesh_box(root, Vector3(0, 0.34, 0.06), Vector3(width - 0.1, 0.16, 0.76), mat_fab)
	_add_mesh_box(root, Vector3(0, 0.44, 0.08), Vector3(width - 0.18, 0.08, 0.66), mat_fab_d)
	for i in 3:
		var cx: float = (i - 1) * (width * 0.28)
		_add_mesh_box(root, Vector3(cx, 0.48, 0.1), Vector3(width * 0.25, 0.06, 0.6), mat_fab_d)
		_add_mesh_box(root, Vector3(cx, 0.52, 0.1), Vector3(width * 0.22, 0.03, 0.52), mat_fab)
		for j in 3:
			for k in 2:
				var bx := cx + (float(j) - 1.0) * 0.1
				var bz := 0.0 + float(k) * 0.16
				_add_mesh_cyl(root, Vector3(bx, 0.55, bz), 0.014, 0.012, mat_fab_dd, false)
	_add_mesh_cyl_rot(root, Vector3(0, 0.4, 0.4), 0.065, width * 0.86, mat_fab_l, Vector3(0, 0, PI * 0.5))
	# Back: continuous buttoned shell + crown scroll
	_add_mesh_box(root, Vector3(0, 0.85, -0.3), Vector3(width * 0.96, 0.72, 0.2), mat_fab)
	_add_mesh_box(root, Vector3(0, 0.88, -0.18), Vector3(width * 0.88, 0.64, 0.1), mat_fab_d)
	_add_mesh_box(root, Vector3(0, 0.92, -0.1), Vector3(width * 0.78, 0.5, 0.05), mat_fab_l)
	for row in 5:
		var by := 0.58 + float(row) * 0.12
		var odd := row % 2 == 1
		var n := 5 if odd else 6
		for i in n:
			var bx := (float(i) / float(maxi(n - 1, 1)) - 0.5) * width * 0.72
			_add_mesh_cyl(root, Vector3(bx, by, -0.06), 0.015, 0.012, mat_fab_dd, false)
	_add_mesh_cyl_rot(root, Vector3(0, 1.18, -0.14), 0.075, width * 0.78, mat_fab, Vector3(0, 0, PI * 0.5))
	_add_mesh_cyl_rot(root, Vector3(0, 1.22, -0.2), 0.048, width * 0.5, mat_fab_d, Vector3(0, 0, PI * 0.5))
	_add_mesh_box(root, Vector3(0, 1.24, -0.28), Vector3(width * 0.42, 0.04, 0.08), mat_m)
	_add_mesh_box(root, Vector3(0, 1.28, -0.28), Vector3(width * 0.18, 0.035, 0.06), mat_md)
	# Scrolled arm ends + velvet rolls
	for sx in [-1.0, 1.0]:
		var ax: float = sx * (width * 0.5 - 0.12)
		_add_mesh_box(root, Vector3(ax, 0.55, 0.02), Vector3(0.2, 0.4, 0.76), mat_fab)
		_add_mesh_cyl(root, Vector3(ax, 0.7, 0.06), 0.1, 0.52, mat_fab_d, false)
		_add_mesh_cyl_rot(root, Vector3(ax, 0.76, 0.02), 0.08, 0.68, mat_fab_l, Vector3(PI * 0.5, 0, 0))
		_add_mesh_cyl(root, Vector3(ax + sx * 0.06, 0.72, 0.0), 0.07, 0.48, mat_fab, false)
		_add_mesh_cyl(root, Vector3(ax + sx * 0.02, 0.55, 0.38), 0.055, 0.14, mat_m, false)
		_add_mesh_cyl_rot(root, Vector3(ax + sx * 0.02, 0.62, 0.42), 0.04, 0.12, mat_md, Vector3(PI * 0.5, 0, 0))
		_add_mesh_cyl(root, Vector3(ax, 0.38, 0.3), 0.035, 0.18, mat_m, false)
		for k in 3:
			_add_mesh_cyl(root, Vector3(ax, 0.82, -0.1 + float(k) * 0.14), 0.012, 0.01, mat_fab_dd, false)
	for i in 11:
		var fx := (float(i) / 10.0 - 0.5) * width * 0.9
		_add_mesh_box(root, Vector3(fx, 0.11, 0.4), Vector3(0.04, 0.09, 0.02), mat_fab_dd)
	for i in 9:
		var t := float(i) / 8.0
		_add_mesh_cyl(root, Vector3(-width * 0.42 + t * width * 0.84, 0.22, 0.42), 0.01, 0.012, mat_br, false)
	for sx in [-1.0, 0.0, 1.0]:
		_add_mesh_cyl(root, Vector3(sx * width * 0.38, 0.06, 0.28), 0.03, 0.11, mat_m, true)
		_add_mesh_cyl(root, Vector3(sx * width * 0.38, 0.012, 0.28), 0.04, 0.024, mat_md, false)
		_add_mesh_cyl(root, Vector3(sx * width * 0.38, 0.06, -0.24), 0.028, 0.11, mat_m, true)
		_add_mesh_cyl(root, Vector3(sx * width * 0.38, 0.012, -0.24), 0.038, 0.024, mat_md, false)
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
	# Loop 204: solid-mat lip/fringe (no wood washout on floor edge)
	var mat_border := _solid_matte(Color(0.18, 0.08, 0.06), 0.94)
	var mat_fringe := _solid_matte(Color(0.42, 0.28, 0.16), 0.95)
	var mat_gold := _solid_matte(Color(0.55, 0.4, 0.2), 0.75)
	var mat_gold_d := _solid_matte(Color(0.45, 0.32, 0.16), 0.8)
	var mat_med := _solid_matte(Color(0.45, 0.18, 0.12), 0.88)
	if has_tex:
		var bw := 0.035
		_add_mesh_box(root, Vector3(0, 0.038, sd * 0.5 - bw * 0.5), Vector3(sw * 0.99, 0.012, bw), mat_border)
		_add_mesh_box(root, Vector3(0, 0.038, -sd * 0.5 + bw * 0.5), Vector3(sw * 0.99, 0.012, bw), mat_border)
		_add_mesh_box(root, Vector3(sw * 0.5 - bw * 0.5, 0.038, 0), Vector3(bw, 0.012, sd * 0.97), mat_border)
		_add_mesh_box(root, Vector3(-sw * 0.5 + bw * 0.5, 0.038, 0), Vector3(bw, 0.012, sd * 0.97), mat_border)
		var fringe_n := int(clampf(sw * 8.0, 8.0, 28.0))
		for fi in fringe_n:
			var fx := -sw * 0.45 + (sw * 0.9) * (float(fi) / float(maxi(fringe_n - 1, 1)))
			_add_mesh_box(root, Vector3(fx, 0.032, sd * 0.5 + 0.02), Vector3(0.04, 0.008, 0.05), mat_fringe)
			_add_mesh_box(root, Vector3(fx, 0.032, -sd * 0.5 - 0.02), Vector3(0.04, 0.008, 0.05), mat_fringe)
	else:
		var bw := 0.08
		_add_mesh_box(root, Vector3(0, 0.04, sd * 0.5 - bw * 0.5), Vector3(sw * 0.98, 0.02, bw), mat_border)
		_add_mesh_box(root, Vector3(0, 0.04, -sd * 0.5 + bw * 0.5), Vector3(sw * 0.98, 0.02, bw), mat_border)
		_add_mesh_box(root, Vector3(sw * 0.5 - bw * 0.5, 0.04, 0), Vector3(bw, 0.02, sd * 0.94), mat_border)
		_add_mesh_box(root, Vector3(-sw * 0.5 + bw * 0.5, 0.04, 0), Vector3(bw, 0.02, sd * 0.94), mat_border)
		_add_mesh_box(root, Vector3(0, 0.042, 0), Vector3(sw * 0.88, 0.01, 0.025), mat_gold)
		_add_mesh_box(root, Vector3(0, 0.042, 0), Vector3(0.025, 0.01, sd * 0.88), mat_gold)
		if sw > 2.5 and sd > 2.0:
			_add_mesh_cyl(root, Vector3(0, 0.048, 0), minf(sw, sd) * 0.06, 0.01, mat_gold_d, false)
			_add_mesh_cyl(root, Vector3(0, 0.05, 0), minf(sw, sd) * 0.035, 0.01, mat_med, false)
	return root

static func _make_bookshelf(prop: Dictionary) -> Node3D:
	## Loop 195: library case — solid-mat wood + leather spines (no texture washout).
	var root := Node3D.new()
	root.name = "Bookshelf"
	var width: float = prop.get("width", 1.7)
	var height: float = prop.get("height", 2.5)
	var depth: float = prop.get("depth", 0.36)
	var seed0: int = int(prop.get("seed", 0))
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
	var mat_case := _solid_matte(case_col, 0.78)
	var mat_case_d := _solid_matte(case_dark, 0.82)
	var mat_case_l := _solid_matte(case_col.lightened(0.06), 0.75)
	var mat_br := _solid_metal(Color(0.72, 0.56, 0.28), 0.3)
	var mat_br_d := _solid_metal(Color(0.55, 0.42, 0.2), 0.35)
	var mat_br_l := _solid_metal(Color(0.8, 0.65, 0.35), 0.28)
	var mat_paper := _solid_matte(Color(0.84, 0.78, 0.62), 0.92)
	var mat_marble := _solid_matte(Color(0.82, 0.8, 0.76), 0.65)
	var mat_globe := _solid_matte(Color(0.35, 0.42, 0.5), 0.7)
	var mat_cream := _solid_matte(Color(0.82, 0.76, 0.64), 0.9)
	_add_mesh_box(root, Vector3(0, height * 0.5, -depth * 0.35), Vector3(width, height, 0.04), mat_case)
	_add_mesh_box(root, Vector3(-width * 0.5 + 0.03, height * 0.5, 0), Vector3(0.06, height, depth), mat_case_d)
	_add_mesh_box(root, Vector3(width * 0.5 - 0.03, height * 0.5, 0), Vector3(0.06, height, depth), mat_case_d)
	_add_mesh_box(root, Vector3(-width * 0.5 + 0.05, height * 0.55, depth * 0.35), Vector3(0.03, height * 0.7, 0.04), mat_case_l)
	_add_mesh_box(root, Vector3(width * 0.5 - 0.05, height * 0.55, depth * 0.35), Vector3(0.03, height * 0.7, 0.04), mat_case_l)
	_add_mesh_box(root, Vector3(0, height - 0.05, 0.02), Vector3(width + 0.08, 0.1, depth + 0.08), mat_case)
	if seed0 % 2 == 0:
		_add_mesh_box(root, Vector3(0, height - 0.12, 0.04), Vector3(width + 0.02, 0.05, depth + 0.02), mat_case_d)
	_add_mesh_box(root, Vector3(0, 0.06, 0.02), Vector3(width + 0.04, 0.12, depth + 0.04), mat_case_d)
	_add_mesh_box(root, Vector3(0, 0.14, 0.04), Vector3(width + 0.02, 0.04, depth + 0.02), mat_case_d)
	var shelf_n := 5
	for i in shelf_n:
		var y: float = 0.38 + i * (height - 0.55) / float(shelf_n - 1)
		_add_mesh_box(root, Vector3(0, y, 0.02), Vector3(width * 0.92, 0.035, depth * 0.9), mat_case_l)
		if (i + seed0) % 2 == 0:
			_add_mesh_box(root, Vector3(-width * 0.38, y + 0.1, 0.06), Vector3(0.035, 0.16, 0.14), mat_br_d)
			_add_mesh_box(root, Vector3(width * 0.38, y + 0.1, 0.06), Vector3(0.035, 0.16, 0.14), mat_br_d)
		var x := -width * 0.36
		var bi := 0
		while x < width * 0.36:
			if (bi + i + seed0) % 13 == 0:
				for k in 3:
					var fcol := _book_color(i + bi + k + seed0 * 3)
					var mat_f := _solid_matte(fcol, 0.88)
					_add_mesh_box(root, Vector3(x + 0.07, y + 0.025 + float(k) * 0.022, depth * 0.04), Vector3(0.13, 0.018, depth * 0.48), mat_f)
					_add_mesh_box(root, Vector3(x + 0.13, y + 0.025 + float(k) * 0.022, depth * 0.04), Vector3(0.008, 0.016, depth * 0.45), mat_br_l)
				x += 0.16
				bi += 1
				continue
			var bw: float = 0.028 + float((i + bi + seed0) % 7) * 0.012
			var bh: float = 0.14 + float((i * 3 + bi + seed0 * 2) % 7) * 0.028
			var bd: float = depth * (0.42 + float((bi + seed0) % 4) * 0.06)
			var bcol := _book_color(i + bi + seed0 * 7)
			var mat_b := _solid_matte(bcol, 0.88)
			var mat_bd := _solid_matte(bcol.darkened(0.1), 0.9)
			var cx := x + bw * 0.5
			var cy := y + 0.018 + bh * 0.5
			var pull := 0.02 if (bi + seed0) % 9 == 0 else 0.0
			var cz := depth * 0.04 + pull
			_add_mesh_box(root, Vector3(cx, cy, cz), Vector3(bw * 0.94, bh, bd), mat_b)
			_add_mesh_box(root, Vector3(cx, cy, cz + bd * 0.42), Vector3(bw * 0.22, bh * 0.92, 0.008), mat_bd)
			_add_mesh_box(root, Vector3(cx, y + 0.018 + bh - 0.012, cz + bd * 0.35), Vector3(bw * 0.9, 0.014, bd * 0.55), mat_bd)
			_add_mesh_box(root, Vector3(cx, y + 0.028, cz + bd * 0.35), Vector3(bw * 0.9, 0.012, bd * 0.55), mat_bd)
			var bands := 1 + (bi + i + seed0) % 3
			for g in bands:
				var gy := y + 0.018 + bh * (0.35 + float(g) * 0.18)
				_add_mesh_box(root, Vector3(cx, gy, cz + bd * 0.48), Vector3(bw * 0.78, 0.008, 0.01), mat_br)
			if (bi + seed0) % 5 == 0:
				_add_mesh_box(root, Vector3(cx, cy + bh * 0.05, cz + bd * 0.5), Vector3(bw * 0.55, bh * 0.18, 0.01), mat_br_d)
			if (bi + i) % 8 == 0:
				_add_mesh_box(root, Vector3(cx, cy - bh * 0.15, cz + bd * 0.5), Vector3(bw * 0.7, bh * 0.12, 0.008), mat_paper)
			x += bw + 0.004
			bi += 1
		if i == (1 + seed0 % 3):
			if seed0 % 2 == 0:
				_add_mesh_cyl(root, Vector3(width * 0.22, y + 0.1, 0.04), 0.04, 0.12, mat_marble, false)
				_add_mesh_cyl(root, Vector3(width * 0.22, y + 0.2, 0.04), 0.045, 0.05, _solid_matte(Color(0.78, 0.76, 0.72), 0.55), false)
			else:
				_add_mesh_cyl(root, Vector3(-width * 0.2, y + 0.12, 0.05), 0.055, 0.06, _solid_matte(Color(0.35, 0.42, 0.5), 0.7), false)
				_add_mesh_cyl(root, Vector3(-width * 0.2, y + 0.04, 0.05), 0.03, 0.04, mat_br, false)
	if seed0 % 2 == 0:
		_add_mesh_box(root, Vector3(-0.15, height + 0.02, 0.05), Vector3(0.18, 0.035, 0.12), _solid_matte(_book_color(seed0), 0.88))
		_add_mesh_box(root, Vector3(-0.12, height + 0.055, 0.04), Vector3(0.14, 0.025, 0.1), _solid_matte(_book_color(seed0 + 2), 0.88))
		_add_mesh_box(root, Vector3(0.2, height + 0.03, 0.05), Vector3(0.12, 0.04, 0.1), mat_br_d)
	else:
		_add_mesh_cyl(root, Vector3(0.1, height + 0.08, 0.04), 0.05, 0.12, mat_cream, false)
		_add_mesh_box(root, Vector3(-0.2, height + 0.025, 0.04), Vector3(0.16, 0.03, 0.11), _solid_matte(_book_color(seed0 + 1), 0.88))
	_add_contact_shadow(root, width * 0.55, depth * 0.7)
	return root


static func _make_crock_shelf(prop: Dictionary) -> Node3D:
	## Loop 193: kitchen open dresser — solid-mat oak frame + plates/crocks/copper
	## (not texture-washed wood cubes mid-FOV).
	var root := Node3D.new()
	root.name = "CrockShelf"
	var width: float = float(prop.get("width", 1.4))
	var height: float = float(prop.get("height", 1.7))
	var depth: float = float(prop.get("depth", 0.32))
	var seed0: int = int(prop.get("seed", 1))
	var mat_oak := _solid_matte(Color(0.48, 0.34, 0.18), 0.78)
	var mat_oak_d := _solid_matte(Color(0.36, 0.24, 0.12), 0.82)
	var mat_oak_l := _solid_matte(Color(0.56, 0.42, 0.26), 0.75)
	var mat_cream := _solid_matte(Color(0.84, 0.78, 0.66), 0.9)
	var mat_cream_d := _solid_matte(Color(0.74, 0.68, 0.56), 0.9)
	var mat_clay := _solid_matte(Color(0.72, 0.46, 0.28), 0.9)
	var mat_clay_d := _solid_matte(Color(0.58, 0.36, 0.22), 0.9)
	var mat_cop := _solid_metal(Color(0.7, 0.42, 0.18), 0.32)
	var mat_cop_d := _solid_metal(Color(0.58, 0.34, 0.14), 0.36)
	var mat_cop_l := _solid_metal(Color(0.78, 0.5, 0.24), 0.28)
	# Frame: back, sides, plinth, cornice
	_add_mesh_box(root, Vector3(0, height * 0.5, -depth * 0.35), Vector3(width, height, 0.04), mat_oak)
	_add_mesh_box(root, Vector3(-width * 0.48, height * 0.5, 0), Vector3(0.05, height, depth), mat_oak_d)
	_add_mesh_box(root, Vector3(width * 0.48, height * 0.5, 0), Vector3(0.05, height, depth), mat_oak_d)
	_add_mesh_box(root, Vector3(0, 0.05, 0.01), Vector3(width + 0.04, 0.1, depth + 0.04), mat_oak_d)
	_add_mesh_box(root, Vector3(0, height - 0.04, 0.01), Vector3(width + 0.05, 0.08, depth + 0.04), mat_oak_l)
	# Front edge bead on cornice
	_add_mesh_box(root, Vector3(0, height - 0.02, depth * 0.35), Vector3(width * 0.95, 0.03, 0.03), mat_oak)
	var shelves := 3
	for i in shelves:
		var y: float = 0.35 + float(i) * ((height - 0.5) / float(maxi(shelves - 1, 1)))
		_add_mesh_box(root, Vector3(0, y, 0.02), Vector3(width * 0.9, 0.035, depth * 0.88), mat_oak_l)
		var n := 3 + (i + seed0) % 2
		for j in n:
			var x := -width * 0.32 + float(j) * (width * 0.64 / float(maxi(n - 1, 1)))
			var kind := (i * 3 + j + seed0) % 5
			if kind == 0:
				_add_mesh_cyl(root, Vector3(x, y + 0.035, 0.04), 0.09, 0.025, mat_cream, false)
				_add_mesh_cyl(root, Vector3(x, y + 0.055, 0.04), 0.08, 0.02, mat_cream_d, false)
				_add_mesh_cyl(root, Vector3(x, y + 0.07, 0.04), 0.07, 0.015, mat_cream, false)
			elif kind == 1:
				_add_mesh_cyl(root, Vector3(x, y + 0.1, 0.04), 0.07, 0.16, mat_clay if (j + seed0) % 2 == 0 else mat_clay_d, false)
				_add_mesh_cyl(root, Vector3(x, y + 0.19, 0.04), 0.06, 0.03, mat_clay_d, false)
			elif kind == 2:
				_add_mesh_cyl(root, Vector3(x, y + 0.04, 0.04), 0.07, 0.02, mat_cop_d, false)
				_add_mesh_cyl(root, Vector3(x, y + 0.09, 0.04), 0.09, 0.1, mat_cop, false)
				_add_mesh_cyl(root, Vector3(x, y + 0.15, 0.04), 0.1, 0.02, mat_cop_l, false)
				_add_mesh_box(root, Vector3(x + 0.09, y + 0.09, 0.04), Vector3(0.05, 0.03, 0.03), mat_cop)
			elif kind == 3:
				_add_mesh_cyl(root, Vector3(x, y + 0.08, 0.04), 0.055, 0.14, mat_cream_d, false)
				_add_mesh_cyl(root, Vector3(x, y + 0.16, 0.04), 0.04, 0.04, mat_cream, false)
				_add_mesh_box(root, Vector3(x + 0.06, y + 0.1, 0.04), Vector3(0.04, 0.08, 0.03), mat_cream_d)
			else:
				_add_mesh_cyl(root, Vector3(x, y + 0.04, 0.04), 0.1, 0.035, mat_cream_d, false)
				_add_mesh_cyl(root, Vector3(x, y + 0.07, 0.04), 0.07, 0.03, mat_cream, false)
	_add_contact_shadow(root, width * 0.5, depth * 0.6)
	return root


static func _make_tool_shelf(prop: Dictionary) -> Node3D:
	## Loop 194: workshop tool case — solid-mat oak + iron/copper parts (not washed wood cubes).
	var root := Node3D.new()
	root.name = "ToolShelf"
	var width: float = float(prop.get("width", 1.3))
	var height: float = float(prop.get("height", 1.9))
	var depth: float = float(prop.get("depth", 0.34))
	var seed0: int = int(prop.get("seed", 2))
	var mat_oak := _solid_matte(Color(0.4, 0.26, 0.12), 0.8)
	var mat_oak_d := _solid_matte(Color(0.28, 0.16, 0.08), 0.84)
	var mat_oak_l := _solid_matte(Color(0.5, 0.36, 0.2), 0.78)
	var mat_plinth := _solid_matte(Color(0.2, 0.12, 0.07), 0.82)
	var mat_iron := _solid_metal(Color(0.38, 0.38, 0.4), 0.48)
	var mat_iron_l := _solid_metal(Color(0.48, 0.48, 0.5), 0.45)
	var mat_iron_d := _solid_metal(Color(0.28, 0.28, 0.3), 0.52)
	var mat_cop := _solid_metal(Color(0.65, 0.38, 0.16), 0.34)
	var mat_wood_part := _solid_matte(Color(0.42, 0.28, 0.14), 0.75)
	_add_mesh_box(root, Vector3(0, height * 0.5, -depth * 0.35), Vector3(width, height, 0.04), mat_oak_d)
	_add_mesh_box(root, Vector3(-width * 0.48, height * 0.5, 0), Vector3(0.05, height, depth), mat_oak)
	_add_mesh_box(root, Vector3(width * 0.48, height * 0.5, 0), Vector3(0.05, height, depth), mat_oak)
	_add_mesh_box(root, Vector3(0, 0.05, 0.01), Vector3(width + 0.04, 0.1, depth + 0.04), mat_plinth)
	_add_mesh_box(root, Vector3(0, height - 0.04, 0.01), Vector3(width + 0.04, 0.06, depth + 0.04), mat_oak_l)
	# Peg rail
	_add_mesh_box(root, Vector3(0, height - 0.2, 0.12), Vector3(width * 0.85, 0.03, 0.04), mat_oak_l)
	for i in 4:
		var y: float = 0.32 + float(i) * ((height - 0.45) / 3.0)
		_add_mesh_box(root, Vector3(0, y, 0.02), Vector3(width * 0.9, 0.035, depth * 0.88), mat_oak)
		var n := 2 + (i + seed0) % 2
		for j in n:
			var x := -width * 0.28 + float(j) * (width * 0.55 / float(maxi(n - 1, 1)))
			var kind := (i + j + seed0) % 4
			if kind == 0:
				# Timber offcut board
				_add_mesh_box(root, Vector3(x, y + 0.06, 0.04), Vector3(0.28, 0.06, 0.12), mat_oak_l)
			elif kind == 1:
				# Rooke wrench
				_add_mesh_box(root, Vector3(x, y + 0.1, 0.04), Vector3(0.22, 0.04, 0.04), mat_iron)
				_add_mesh_box(root, Vector3(x + 0.1, y + 0.1, 0.04), Vector3(0.06, 0.08, 0.05), mat_iron_l)
			elif kind == 2:
				# Tool block + upright bit
				_add_mesh_box(root, Vector3(x, y + 0.08, 0.04), Vector3(0.16, 0.1, 0.12), mat_wood_part)
				_add_mesh_cyl(root, Vector3(x, y + 0.14, 0.1), 0.02, 0.16, mat_iron_d, false)
			else:
				# Copper stock tube
				_add_mesh_cyl(root, Vector3(x, y + 0.1, 0.04), 0.06, 0.14, mat_cop, false)
	# Hanging tools on peg rail (handles + heads)
	for i in 3 + seed0 % 2:
		var px := -width * 0.3 + float(i) * 0.2
		_add_mesh_cyl(root, Vector3(px, height - 0.35, 0.14), 0.012, 0.28, mat_iron_d, false)
		_add_mesh_box(root, Vector3(px, height - 0.5, 0.14), Vector3(0.08, 0.05, 0.04), mat_iron)
	_add_contact_shadow(root, width * 0.5, depth * 0.6)
	return root

static func _make_side_table(prop: Dictionary) -> Node3D:
	## Loop 199: occasional tables — solid-mat mahogany base + dress (no wood/brass washout).
	## base style: 0 tripod · 1 square 4-leg · 2 demi-lune console.
	if prop.get("billboard", false) and prop.get("texture", "") != "":
		return _make_billboard_prop(prop)
	var root := Node3D.new()
	root.name = "SideTable"
	var seed0: int = int(prop.get("seed", 0))
	var base := seed0 % 3
	var dress := (seed0 / 3) % 4
	var mat_m := _solid_matte(Color(0.3, 0.14, 0.08), 0.72)
	var mat_md := _solid_matte(Color(0.18, 0.09, 0.05), 0.78)
	var mat_ml := _solid_matte(Color(0.36, 0.18, 0.1), 0.7)
	var mat_br := _solid_metal(Color(0.72, 0.56, 0.28), 0.3)
	var mat_br_d := _solid_metal(Color(0.55, 0.42, 0.2), 0.35)
	if base == 0:
		# Tripod pedestal (short warm feet — long dark bars read as rug L-junk)
		_add_mesh_cyl(root, Vector3(0, 0.64, 0), 0.3, 0.04, mat_m, true)
		_add_mesh_cyl(root, Vector3(0, 0.67, 0), 0.32, 0.025, mat_md, false)
		_add_mesh_cyl(root, Vector3(0, 0.61, 0), 0.28, 0.02, mat_ml, false)
		_add_mesh_cyl(root, Vector3(0, 0.52, 0), 0.09, 0.1, mat_m, true)
		_add_mesh_cyl(root, Vector3(0, 0.4, 0), 0.055, 0.16, mat_md, true)
		_add_mesh_cyl(root, Vector3(0, 0.28, 0), 0.07, 0.1, mat_m, true)
		_add_mesh_cyl(root, Vector3(0, 0.16, 0), 0.1, 0.08, mat_md, true)
		_add_mesh_cyl(root, Vector3(0, 0.06, 0), 0.12, 0.06, mat_m, true)
		for a in [0.0, 120.0, 240.0]:
			var rad := deg_to_rad(a)
			var fx := cos(rad) * 0.12
			var fz := sin(rad) * 0.12
			_add_mesh_box(root, Vector3(fx, 0.04, fz), Vector3(0.12, 0.035, 0.055), mat_m)
			_add_mesh_cyl(root, Vector3(fx * 1.2, 0.025, fz * 1.2), 0.028, 0.035, mat_ml, false)
	elif base == 1:
		# Square top + apron drawer + four turned legs
		_add_mesh_box(root, Vector3(0, 0.64, 0), Vector3(0.55, 0.04, 0.55), mat_m)
		_add_mesh_box(root, Vector3(0, 0.67, 0), Vector3(0.58, 0.02, 0.58), mat_md)
		_add_mesh_box(root, Vector3(0, 0.56, 0.24), Vector3(0.5, 0.1, 0.04), mat_m)
		_add_mesh_box(root, Vector3(0, 0.56, -0.24), Vector3(0.5, 0.1, 0.04), mat_m)
		_add_mesh_box(root, Vector3(0.24, 0.56, 0), Vector3(0.04, 0.1, 0.46), mat_m)
		_add_mesh_box(root, Vector3(-0.24, 0.56, 0), Vector3(0.04, 0.1, 0.46), mat_m)
		_add_mesh_box(root, Vector3(0, 0.56, 0.26), Vector3(0.28, 0.06, 0.02), mat_md)
		_add_mesh_cyl(root, Vector3(0, 0.56, 0.28), 0.012, 0.02, mat_br, false)
		for sx in [-1.0, 1.0]:
			for sz in [-1.0, 1.0]:
				_add_mesh_cyl(root, Vector3(sx * 0.2, 0.4, sz * 0.2), 0.032, 0.24, mat_md, true)
				_add_mesh_cyl(root, Vector3(sx * 0.2, 0.22, sz * 0.2), 0.024, 0.18, mat_m, false)
				_add_mesh_cyl(root, Vector3(sx * 0.2, 0.08, sz * 0.2), 0.03, 0.12, mat_md, false)
				_add_mesh_cyl(root, Vector3(sx * 0.2, 0.02, sz * 0.2), 0.04, 0.04, mat_m, false)
		_add_mesh_box(root, Vector3(0, 0.2, 0), Vector3(0.36, 0.025, 0.36), mat_m)
	else:
		# Demi-lune console
		_add_mesh_box(root, Vector3(0, 0.64, 0.05), Vector3(0.72, 0.045, 0.36), mat_m)
		_add_mesh_cyl(root, Vector3(0, 0.64, 0.05), 0.34, 0.045, mat_m, true)
		_add_mesh_cyl(root, Vector3(0, 0.67, 0.05), 0.32, 0.02, mat_md, false)
		_add_mesh_box(root, Vector3(0, 0.55, 0.12), Vector3(0.55, 0.08, 0.04), mat_m)
		_add_mesh_cyl(root, Vector3(-0.22, 0.36, 0.1), 0.03, 0.5, mat_md, true)
		_add_mesh_cyl(root, Vector3(0.22, 0.36, 0.1), 0.03, 0.5, mat_md, true)
		_add_mesh_cyl(root, Vector3(0.0, 0.36, -0.06), 0.032, 0.5, mat_md, true)
		_add_mesh_cyl(root, Vector3(-0.22, 0.02, 0.1), 0.04, 0.04, mat_m, false)
		_add_mesh_cyl(root, Vector3(0.22, 0.02, 0.1), 0.04, 0.04, mat_m, false)
		_add_mesh_cyl(root, Vector3(0.0, 0.02, -0.06), 0.04, 0.04, mat_m, false)
		_add_mesh_box(root, Vector3(0, 0.28, 0.06), Vector3(0.42, 0.03, 0.14), mat_m)
	# Top dressing — thin leather folios / lamp / pot / candle
	var top_y := 0.69
	if prop.get("bare", false):
		_add_contact_shadow(root, 0.34, 0.34)
		return root
	if dress == 0:
		# Mini Argand + thin octavo — solid-mat font + amber glass (not brass washout)
		var mat_font := _solid_metal(Color(0.48, 0.34, 0.16), 0.4)
		var mat_g := StandardMaterial3D.new()
		mat_g.albedo_color = Color(1.0, 0.82, 0.48, 0.55)
		mat_g.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
		mat_g.emission_enabled = true
		mat_g.emission = Color(1.0, 0.72, 0.35)
		mat_g.emission_energy_multiplier = 1.4
		mat_g.roughness = 0.15
		mat_g.shading_mode = BaseMaterial3D.SHADING_MODE_PER_PIXEL
		var mat_ghi := StandardMaterial3D.new()
		mat_ghi.albedo_color = Color(1.0, 0.92, 0.62, 0.35)
		mat_ghi.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
		mat_ghi.emission_enabled = true
		mat_ghi.emission = Color(1.0, 0.85, 0.45)
		mat_ghi.emission_energy_multiplier = 1.7
		mat_ghi.roughness = 0.1
		var mat_flame := StandardMaterial3D.new()
		mat_flame.albedo_color = Color(1.0, 0.88, 0.5, 0.7)
		mat_flame.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
		mat_flame.emission_enabled = true
		mat_flame.emission = Color(1.0, 0.8, 0.4)
		mat_flame.emission_energy_multiplier = 2.0
		mat_flame.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		_add_mesh_cyl(root, Vector3(0, top_y + 0.015, 0), 0.045, 0.028, mat_md, false)
		_add_mesh_cyl(root, Vector3(0, top_y + 0.05, 0), 0.04, 0.045, mat_font, false)
		_add_mesh_cyl(root, Vector3(0, top_y + 0.08, 0), 0.032, 0.018, mat_br_d, false)
		_add_mesh_cyl(root, Vector3(0, top_y + 0.2, 0), 0.028, 0.2, mat_g, false)
		_add_mesh_cyl(root, Vector3(0, top_y + 0.2, 0), 0.018, 0.16, mat_ghi, false)
		_add_mesh_cyl(root, Vector3(0, top_y + 0.12, 0), 0.014, 0.02, mat_flame, false)
		_add_table_folio(root, Vector3(0.12, top_y + 0.02, 0.04), seed0 + 2, 0.0)
		var lamp := OmniLight3D.new()
		lamp.light_color = Color(1.0, 0.85, 0.55)
		lamp.light_energy = 0.55
		lamp.omni_range = 2.6
		lamp.position = Vector3(0, top_y + 0.22, 0)
		root.add_child(lamp)
	elif dress == 1:
		# Stacked thin folios + cream crock
		var mat_cream := _solid_matte(Color(0.82, 0.76, 0.64), 0.9)
		var mat_cream_d := _solid_matte(Color(0.7, 0.64, 0.52), 0.9)
		_add_table_folio_stack(root, Vector3(-0.04, top_y + 0.01, 0.0), seed0, 3)
		_add_mesh_cyl(root, Vector3(0.12, top_y + 0.05, 0.08), 0.038, 0.09, mat_cream, false)
		_add_mesh_cyl(root, Vector3(0.12, top_y + 0.11, 0.08), 0.028, 0.025, mat_cream_d, false)
	elif dress == 2:
		# Classic clay flower pot — solid-mat terracotta + irregular blooms
		var mat_pot := _solid_matte(Color(0.7, 0.4, 0.22), 0.92)
		var mat_pot_d := _solid_matte(Color(0.52, 0.3, 0.15), 0.94)
		var mat_soil := _solid_matte(Color(0.14, 0.09, 0.05), 0.95)
		var mat_leaf := _solid_matte(Color(0.22, 0.4, 0.14), 0.9)
		var mat_leaf_d := _solid_matte(Color(0.14, 0.3, 0.1), 0.9)
		var mat_fl_r := _solid_matte(Color(0.62, 0.16, 0.14), 0.88)
		var mat_fl_p := _solid_matte(Color(0.7, 0.35, 0.4), 0.88)
		var mat_fl_w := _solid_matte(Color(0.82, 0.72, 0.55), 0.9)
		_add_mesh_cyl(root, Vector3(0, top_y + 0.01, 0), 0.1, 0.016, mat_pot_d, false)
		_add_mesh_cyl(root, Vector3(0, top_y + 0.04, 0), 0.055, 0.05, mat_pot_d, false)
		_add_mesh_cyl(root, Vector3(0, top_y + 0.1, 0), 0.075, 0.1, mat_pot, false)
		_add_mesh_cyl(root, Vector3(0, top_y + 0.16, 0), 0.09, 0.04, mat_pot, false)
		_add_mesh_cyl(root, Vector3(0, top_y + 0.185, 0), 0.1, 0.02, mat_pot_d, false)
		_add_mesh_cyl(root, Vector3(0, top_y + 0.19, 0), 0.07, 0.012, mat_soil, false)
		_add_mesh_box(root, Vector3(0.0, top_y + 0.22, 0.0), Vector3(0.1, 0.025, 0.08), mat_leaf)
		_add_mesh_box(root, Vector3(0.03, top_y + 0.23, 0.02), Vector3(0.06, 0.015, 0.05), mat_leaf_d)
		_add_mesh_box(root, Vector3(-0.025, top_y + 0.225, -0.02), Vector3(0.05, 0.012, 0.045), mat_leaf)
		_add_mesh_cyl(root, Vector3(0.0, top_y + 0.245, 0.01), 0.022, 0.018, mat_fl_r, false)
		_add_mesh_cyl(root, Vector3(0.035, top_y + 0.24, -0.015), 0.016, 0.014, mat_fl_p, false)
		_add_mesh_cyl(root, Vector3(-0.03, top_y + 0.238, 0.02), 0.014, 0.012, mat_fl_w, false)
		_add_mesh_cyl(root, Vector3(0.015, top_y + 0.255, -0.02), 0.012, 0.01, mat_fl_r, false)
	else:
		# Candlestick + letters (drawing-room identity)
		var mat_candle := _solid_matte(Color(0.95, 0.82, 0.45), 0.7)
		var mat_paper := _solid_matte(Color(0.84, 0.78, 0.62), 0.92)
		var mat_paper_d := _solid_matte(Color(0.76, 0.7, 0.54), 0.92)
		var mat_ink := _solid_matte(Color(0.1, 0.1, 0.14), 0.85)
		var mat_flame_c := StandardMaterial3D.new()
		mat_flame_c.albedo_color = Color(1.0, 0.78, 0.35, 0.85)
		mat_flame_c.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
		mat_flame_c.emission_enabled = true
		mat_flame_c.emission = Color(1.0, 0.72, 0.3)
		mat_flame_c.emission_energy_multiplier = 1.8
		mat_flame_c.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		_add_mesh_cyl(root, Vector3(-0.08, top_y + 0.02, 0.0), 0.05, 0.03, mat_md, false)
		_add_mesh_cyl(root, Vector3(-0.08, top_y + 0.08, 0.0), 0.025, 0.08, mat_m, false)
		_add_mesh_cyl(root, Vector3(-0.08, top_y + 0.13, 0.0), 0.04, 0.02, mat_br_d, false)
		_add_mesh_cyl(root, Vector3(-0.08, top_y + 0.26, 0.0), 0.018, 0.22, mat_candle, false)
		_add_mesh_cyl(root, Vector3(-0.08, top_y + 0.38, 0.0), 0.02, 0.03, mat_flame_c, false)
		_add_mesh_box(root, Vector3(0.08, top_y, 0.02), Vector3(0.16, 0.01, 0.11), mat_paper)
		_add_mesh_box(root, Vector3(0.1, top_y + 0.012, 0.0), Vector3(0.14, 0.008, 0.1), mat_paper_d)
		_add_mesh_box(root, Vector3(0.12, top_y + 0.01, -0.08), Vector3(0.08, 0.02, 0.04), mat_md)
		_add_mesh_cyl(root, Vector3(0.12, top_y + 0.03, -0.08), 0.006, 0.1, mat_ink, false)
		var candle_l := OmniLight3D.new()
		candle_l.light_color = Color(1.0, 0.82, 0.5)
		candle_l.light_energy = 0.4
		candle_l.omni_range = 2.2
		candle_l.position = Vector3(-0.08, top_y + 0.36, 0.0)
		root.add_child(candle_l)
	_add_contact_shadow(root, 0.34, 0.34)
	return root

static func _make_hall_table(prop: Dictionary) -> Node3D:
	## Loop 195: hall console — solid-mat mahogany base (not iron/wood washout mid-FOV).
	var root := Node3D.new()
	root.name = "HallTable"
	var seed0: int = int(prop.get("seed", 0))
	var base := seed0 % 3
	var dress := (seed0 / 3) % 4
	var top_y := 0.82
	var mat_m := _solid_matte(Color(0.3, 0.14, 0.08), 0.72)
	var mat_md := _solid_matte(Color(0.18, 0.09, 0.05), 0.78)
	var mat_ml := _solid_matte(Color(0.36, 0.18, 0.1), 0.7)
	var mat_br_ht := _solid_metal(Color(0.55, 0.42, 0.2), 0.35)
	if base == 0:
		_add_mesh_box(root, Vector3(0, top_y, 0), Vector3(1.4, 0.05, 0.5), mat_m)
		_add_mesh_box(root, Vector3(0, top_y - 0.04, 0), Vector3(1.35, 0.04, 0.46), mat_md)
		_add_mesh_box(root, Vector3(0, top_y - 0.12, 0), Vector3(1.28, 0.08, 0.42), mat_m)
		_add_mesh_box(root, Vector3(0, 0.4, 0), Vector3(1.15, 0.03, 0.4), mat_md)
		for sx in [-1.0, 1.0]:
			for sz in [-0.12, 0.12]:
				var lx: float = float(sx) * 0.52
				var lz: float = float(sz)
				_add_mesh_cyl(root, Vector3(lx, 0.68, lz), 0.038, 0.08, mat_m, true)
				_add_mesh_cyl(root, Vector3(lx, 0.55, lz), 0.028, 0.18, mat_md, false)
				_add_mesh_cyl(root, Vector3(lx, 0.4, lz), 0.035, 0.1, mat_m, false)
				_add_mesh_cyl(root, Vector3(lx, 0.22, lz), 0.025, 0.22, mat_md, false)
				_add_mesh_cyl(root, Vector3(lx, 0.08, lz), 0.032, 0.08, mat_m, false)
				_add_mesh_cyl(root, Vector3(lx, 0.02, lz), 0.05, 0.04, mat_ml, false)
	elif base == 1:
		_add_mesh_box(root, Vector3(0, top_y, 0), Vector3(1.35, 0.06, 0.48), mat_m)
		_add_mesh_box(root, Vector3(0, top_y + 0.03, 0), Vector3(1.28, 0.02, 0.42), mat_ml)
		_add_mesh_box(root, Vector3(0, top_y - 0.1, 0), Vector3(1.2, 0.08, 0.4), mat_md)
		for sx in [-0.48, 0.48]:
			_add_mesh_box(root, Vector3(sx, 0.42, 0), Vector3(0.16, 0.72, 0.36), mat_md)
			_add_mesh_box(root, Vector3(sx, 0.42, 0.16), Vector3(0.12, 0.55, 0.04), mat_m)
			_add_mesh_box(root, Vector3(sx, 0.04, 0), Vector3(0.2, 0.08, 0.4), mat_m)
		_add_mesh_box(root, Vector3(0, 0.22, 0), Vector3(0.9, 0.04, 0.32), mat_m)
		_add_mesh_cyl(root, Vector3(0, 0.42, 0), 0.03, 0.02, mat_br_ht, false)
	else:
		_add_mesh_box(root, Vector3(0, top_y, 0.06), Vector3(1.25, 0.05, 0.38), mat_m)
		_add_mesh_cyl(root, Vector3(0, top_y, 0.06), 0.55, 0.05, mat_m, false)
		_add_mesh_box(root, Vector3(0, top_y - 0.1, 0.08), Vector3(1.05, 0.06, 0.28), mat_md)
		for leg in [Vector3(-0.4, 0.0, 0.1), Vector3(0.4, 0.0, 0.1), Vector3(0.0, 0.0, -0.05)]:
			_add_mesh_cyl(root, Vector3(leg.x, 0.65, leg.z), 0.035, 0.08, mat_m, false)
			_add_mesh_cyl(root, Vector3(leg.x, 0.45, leg.z), 0.025, 0.28, mat_md, false)
			_add_mesh_cyl(root, Vector3(leg.x, 0.22, leg.z), 0.03, 0.12, mat_m, false)
			_add_mesh_cyl(root, Vector3(leg.x, 0.02, leg.z), 0.04, 0.04, mat_ml, false)
		_add_mesh_box(root, Vector3(0, 0.35, 0.08), Vector3(0.7, 0.03, 0.15), mat_m)
	var ty := top_y + 0.05
	# Loop 196: dress kits solid mats (0/1/3 join kit 2)
	var mat_d_md := _solid_matte(Color(0.18, 0.09, 0.05), 0.78)
	var mat_d_m := _solid_matte(Color(0.3, 0.14, 0.08), 0.72)
	var mat_d_paper := _solid_matte(Color(0.84, 0.78, 0.62), 0.92)
	var mat_d_paper_d := _solid_matte(Color(0.76, 0.7, 0.54), 0.92)
	var mat_d_cream := _solid_matte(Color(0.82, 0.76, 0.64), 0.9)
	var mat_d_cream_d := _solid_matte(Color(0.7, 0.64, 0.52), 0.9)
	var mat_d_br := _solid_metal(Color(0.72, 0.56, 0.28), 0.3)
	var mat_d_br_d := _solid_metal(Color(0.55, 0.42, 0.2), 0.35)
	var mat_d_candle := _solid_matte(Color(0.95, 0.82, 0.45), 0.7)
	var mat_d_clock := _solid_matte(Color(0.88, 0.86, 0.78), 0.55)
	var mat_d_hat := _solid_matte(Color(0.55, 0.28, 0.18), 0.88)
	var mat_d_hat_d := _solid_matte(Color(0.48, 0.24, 0.14), 0.9)
	var mat_d_silver := _solid_metal(Color(0.65, 0.65, 0.68), 0.35)
	var mat_d_silver_l := _solid_metal(Color(0.75, 0.75, 0.78), 0.32)
	var mat_d_seal := _solid_matte(Color(0.55, 0.12, 0.1), 0.85)
	if dress == 0:
		# Card tray + dual candlesticks + carriage clock
		_add_mesh_box(root, Vector3(-0.35, ty, 0.05), Vector3(0.36, 0.03, 0.22), mat_d_md)
		_add_mesh_box(root, Vector3(-0.35, ty + 0.03, 0.05), Vector3(0.28, 0.01, 0.16), mat_d_paper)
		_add_mesh_box(root, Vector3(-0.32, ty + 0.045, 0.02), Vector3(0.2, 0.008, 0.11), mat_d_paper_d)
		_add_mesh_box(root, Vector3(0.05, ty, 0.08), Vector3(0.14, 0.02, 0.09), mat_d_cream_d)
		for sx in [-0.15, 0.42]:
			_add_mesh_cyl(root, Vector3(sx, ty + 0.02, -0.05), 0.055, 0.04, mat_d_md, false)
			_add_mesh_cyl(root, Vector3(sx, ty + 0.08, -0.05), 0.035, 0.08, mat_d_m, false)
			_add_mesh_cyl(root, Vector3(sx, ty + 0.14, -0.05), 0.04, 0.03, mat_d_br_d, false)
			_add_mesh_cyl(root, Vector3(sx, ty + 0.26, -0.05), 0.018, 0.22, mat_d_candle, false)
			var _fl0 := StandardMaterial3D.new()
			_fl0.albedo_color = Color(1.0, 0.8, 0.4, 0.9)
			_fl0.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
			_fl0.emission_enabled = true
			_fl0.emission = Color(1.0, 0.72, 0.3)
			_fl0.emission_energy_multiplier = 1.7
			_fl0.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
			_add_mesh_cyl(root, Vector3(sx, ty + 0.4, -0.05), 0.025, 0.0325, _fl0, false)
		_add_mesh_box(root, Vector3(0.12, ty + 0.08, -0.12), Vector3(0.1, 0.14, 0.06), mat_d_br_d)
		_add_mesh_box(root, Vector3(0.12, ty + 0.08, -0.09), Vector3(0.07, 0.1, 0.02), mat_d_clock)
		_add_mesh_box(root, Vector3(0.12, ty + 0.16, -0.12), Vector3(0.08, 0.02, 0.05), mat_d_br)
		var lamp0 := OmniLight3D.new()
		lamp0.light_color = Color(1.0, 0.85, 0.55)
		lamp0.light_energy = 0.55
		lamp0.omni_range = 3.0
		lamp0.position = Vector3(0.42, ty + 0.38, -0.05)
		root.add_child(lamp0)
	elif dress == 1:
		# Hat box + gloves + brass candlestick
		_add_mesh_cyl(root, Vector3(-0.35, ty + 0.1, 0), 0.14, 0.18, mat_d_hat, false)
		_add_mesh_cyl(root, Vector3(-0.35, ty + 0.2, 0), 0.15, 0.03, mat_d_hat_d, false)
		_add_mesh_box(root, Vector3(0.05, ty, 0.08), Vector3(0.18, 0.025, 0.12), mat_d_cream_d)
		_add_mesh_box(root, Vector3(0.07, ty + 0.02, 0.05), Vector3(0.12, 0.015, 0.08), mat_d_cream)
		_add_mesh_cyl(root, Vector3(0.4, ty + 0.02, 0), 0.07, 0.03, mat_d_br_d, false)
		_add_mesh_cyl(root, Vector3(0.4, ty + 0.08, 0), 0.025, 0.1, mat_d_br_d, false)
		_add_mesh_cyl(root, Vector3(0.4, ty + 0.14, 0), 0.05, 0.025, mat_d_br, false)
		_add_mesh_cyl(root, Vector3(0.4, ty + 0.28, 0), 0.02, 0.24, mat_d_candle, false)
		var _fl1 := StandardMaterial3D.new()
		_fl1.albedo_color = Color(1.0, 0.8, 0.4, 0.9)
		_fl1.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
		_fl1.emission_enabled = true
		_fl1.emission = Color(1.0, 0.72, 0.3)
		_fl1.emission_energy_multiplier = 1.7
		_fl1.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		_add_mesh_cyl(root, Vector3(0.4, ty + 0.42, 0), 0.028, 0.0364, _fl1, false)
		_add_mesh_box(root, Vector3(0.0, ty, -0.1), Vector3(0.22, 0.04, 0.14), mat_d_md)
		var lamp1 := OmniLight3D.new()
		lamp1.light_color = Color(1.0, 0.82, 0.5)
		lamp1.light_energy = 0.4
		lamp1.omni_range = 2.4
		lamp1.position = Vector3(0.4, ty + 0.4, 0)
		root.add_child(lamp1)
	elif dress == 2:
		# Loop 185: porcelain bud vase + blooms — not cream cylinder cake mid-FOV.
		var mat_vase := _solid_matte(Color(0.78, 0.74, 0.68), 0.45)
		var mat_vase_d := _solid_matte(Color(0.55, 0.5, 0.44), 0.5)
		var mat_blue := _solid_matte(Color(0.22, 0.32, 0.48), 0.4)
		var mat_leaf := _solid_matte(Color(0.2, 0.38, 0.14), 0.9)
		var mat_fl_r := _solid_matte(Color(0.62, 0.18, 0.16), 0.88)
		var mat_fl_p := _solid_matte(Color(0.72, 0.4, 0.42), 0.88)
		var mat_fl_y := _solid_matte(Color(0.78, 0.62, 0.28), 0.9)
		# Slim bottle/bud vase (narrow neck — not wedding-cake tiers)
		_add_mesh_cyl(root, Vector3(0.32, ty + 0.02, 0), 0.045, 0.025, mat_vase_d, false)
		_add_mesh_cyl(root, Vector3(0.32, ty + 0.1, 0), 0.055, 0.14, mat_vase, false)
		_add_mesh_cyl(root, Vector3(0.32, ty + 0.12, 0), 0.058, 0.018, mat_blue, false)
		_add_mesh_cyl(root, Vector3(0.32, ty + 0.2, 0), 0.03, 0.08, mat_vase_d, false)
		_add_mesh_cyl(root, Vector3(0.32, ty + 0.25, 0), 0.04, 0.02, mat_vase, false)
		# Irregular bloom cluster + leaves (not one sphere lid)
		_add_mesh_box(root, Vector3(0.32, ty + 0.28, 0.0), Vector3(0.08, 0.02, 0.06), mat_leaf)
		_add_mesh_cyl(root, Vector3(0.32, ty + 0.3, 0.01), 0.02, 0.016, mat_fl_r, false)
		_add_mesh_cyl(root, Vector3(0.35, ty + 0.295, -0.015), 0.016, 0.012, mat_fl_p, false)
		_add_mesh_cyl(root, Vector3(0.29, ty + 0.292, 0.02), 0.014, 0.012, mat_fl_y, false)
		_add_mesh_cyl(root, Vector3(0.34, ty + 0.31, 0.0), 0.012, 0.01, mat_fl_r, false)
		# Calling cards + ink tray
		_add_mesh_box(root, Vector3(-0.32, ty + 0.005, 0.05), Vector3(0.28, 0.015, 0.16), _solid_matte(PAPER, 0.92))
		_add_mesh_box(root, Vector3(-0.3, ty + 0.018, 0.02), Vector3(0.2, 0.008, 0.11), _solid_matte(PAPER.darkened(0.06), 0.92))
		_add_mesh_box(root, Vector3(0.0, ty + 0.01, -0.08), Vector3(0.14, 0.025, 0.09), _solid_matte(MAHOGANY_DARK, 0.55))
		_add_mesh_cyl(root, Vector3(0.02, ty + 0.06, -0.08), 0.014, 0.08, _solid_matte(INK, 0.6), false)
	else:
		# Silver tray + correspondence + mini Argand (solid mats)
		_add_mesh_box(root, Vector3(0.0, ty, 0.0), Vector3(0.55, 0.02, 0.32), mat_d_silver)
		_add_mesh_box(root, Vector3(0.0, ty + 0.015, 0.0), Vector3(0.5, 0.01, 0.28), mat_d_silver_l)
		_add_mesh_box(root, Vector3(-0.1, ty + 0.03, 0.02), Vector3(0.2, 0.01, 0.14), mat_d_paper)
		_add_mesh_box(root, Vector3(-0.08, ty + 0.04, 0.0), Vector3(0.16, 0.008, 0.1), mat_d_paper_d)
		_add_mesh_cyl(root, Vector3(0.18, ty + 0.02, -0.05), 0.038, 0.028, mat_d_md, false)
		_add_mesh_cyl(root, Vector3(0.18, ty + 0.055, -0.05), 0.035, 0.04, _solid_matte(Color(0.48, 0.34, 0.16), 0.75), false)
		_add_mesh_cyl(root, Vector3(0.18, ty + 0.085, -0.05), 0.028, 0.016, mat_d_br_d, false)
		# Amber glass chimney (alpha emission — keep untextured color path via solid-like mat)
		var glass := MeshInstance3D.new()
		var gmesh := CylinderMesh.new()
		gmesh.top_radius = 0.026
		gmesh.bottom_radius = 0.026
		gmesh.height = 0.18
		glass.mesh = gmesh
		var gmat := StandardMaterial3D.new()
		gmat.albedo_color = Color(0.95, 0.78, 0.42, 0.42)
		gmat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
		gmat.emission_enabled = true
		gmat.emission = Color(1.0, 0.85, 0.5)
		gmat.emission_energy_multiplier = 0.6
		gmat.shading_mode = BaseMaterial3D.SHADING_MODE_PER_PIXEL
		glass.material_override = gmat
		glass.position = Vector3(0.18, ty + 0.2, -0.05)
		root.add_child(glass)
		var _fl2 := StandardMaterial3D.new()
		_fl2.albedo_color = Color(1.0, 0.8, 0.4, 0.9)
		_fl2.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
		_fl2.emission_enabled = true
		_fl2.emission = Color(1.0, 0.72, 0.3)
		_fl2.emission_energy_multiplier = 1.7
		_fl2.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		_add_mesh_cyl(root, Vector3(0.18, ty + 0.12, -0.05), 0.014, 0.0182, _fl2, false)
		_add_mesh_box(root, Vector3(0.35, ty + 0.02, 0.08), Vector3(0.12, 0.04, 0.08), mat_d_seal)
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
	## Loop 197: cast-iron Victorian range — solid-mat iron/brass/copper (no metal washout).
	var root := Node3D.new()
	root.name = "KitchenRange"
	var mat_iron := _solid_metal(Color(0.38, 0.38, 0.4), 0.5)
	var mat_body := _solid_metal(Color(0.32, 0.32, 0.34), 0.55)
	var mat_iron_d := _solid_metal(Color(0.22, 0.22, 0.24), 0.58)
	var mat_iron_l := _solid_metal(Color(0.48, 0.48, 0.5), 0.48)
	var mat_soot := _solid_matte(Color(0.16, 0.15, 0.14), 0.9)
	var mat_stone := _solid_matte(Color(0.55, 0.52, 0.46), 0.85)
	var mat_stone_d := _solid_matte(Color(0.42, 0.4, 0.35), 0.88)
	var mat_br := _solid_metal(Color(0.72, 0.56, 0.28), 0.3)
	var mat_br_d := _solid_metal(Color(0.55, 0.42, 0.2), 0.35)
	var mat_br_l := _solid_metal(Color(0.78, 0.62, 0.32), 0.28)
	var mat_cop := _solid_metal(Color(0.7, 0.42, 0.18), 0.32)
	var mat_cop_d := _solid_metal(Color(0.58, 0.34, 0.14), 0.36)
	var mat_cop_l := _solid_metal(Color(0.78, 0.5, 0.24), 0.28)
	var mat_log := _solid_matte(Color(0.22, 0.12, 0.07), 0.85)
	var mat_log_l := _solid_matte(Color(0.32, 0.16, 0.09), 0.82)
	var mat_ash := _solid_matte(Color(0.2, 0.16, 0.12), 0.9)
	# Hearth plinth + ash lip + fender rail
	_add_mesh_box(root, Vector3(0, 0.07, 0.08), Vector3(2.4, 0.14, 1.05), mat_stone)
	_add_mesh_box(root, Vector3(0, 0.12, 0.48), Vector3(1.2, 0.05, 0.32), mat_stone_d)
	_add_mesh_box(root, Vector3(0, 0.18, 0.55), Vector3(0.9, 0.08, 0.06), mat_iron_d)
	_add_mesh_box(root, Vector3(-0.42, 0.22, 0.5), Vector3(0.06, 0.16, 0.08), mat_iron)
	_add_mesh_box(root, Vector3(0.42, 0.22, 0.5), Vector3(0.06, 0.16, 0.08), mat_iron)
	_add_mesh_cyl(root, Vector3(0, 0.28, 0.55), 0.02, 0.7, mat_br_d, false)
	# Main body + top band
	_add_mesh_box(root, Vector3(0, 0.68, 0), Vector3(2.2, 1.15, 0.9), mat_body)
	_add_mesh_box(root, Vector3(0, 1.2, 0.02), Vector3(2.22, 0.08, 0.92), mat_iron)
	for sx in [-1.0, 1.0]:
		_add_mesh_box(root, Vector3(sx * 1.08, 0.68, 0.08), Vector3(0.1, 1.05, 0.72), mat_iron_d)
		for ri in 6:
			var ry := 0.28 + float(ri) * 0.16
			_add_mesh_cyl(root, Vector3(sx * 1.12, ry, 0.4), 0.015, 0.018, mat_iron_l, false)
	_add_mesh_box(root, Vector3(0, 1.22, 0.46), Vector3(2.22, 0.035, 0.04), mat_br)
	_add_mesh_box(root, Vector3(0, 0.2, 0.46), Vector3(2.22, 0.03, 0.04), mat_br_d)
	_add_mesh_box(root, Vector3(-1.08, 0.7, 0.46), Vector3(0.04, 1.05, 0.03), mat_br_d)
	_add_mesh_box(root, Vector3(1.08, 0.7, 0.46), Vector3(0.04, 1.05, 0.03), mat_br_d)
	# Twin oven doors
	for door_x in [-0.55, 0.55]:
		_add_mesh_box(root, Vector3(door_x, 0.58, 0.44), Vector3(0.78, 0.72, 0.08), mat_iron)
		_add_mesh_box(root, Vector3(door_x, 0.58, 0.49), Vector3(0.58, 0.52, 0.025), mat_iron_d)
		_add_mesh_box(root, Vector3(door_x, 0.58, 0.505), Vector3(0.42, 0.36, 0.02), mat_iron_l)
		_add_mesh_box(root, Vector3(door_x, 0.58, 0.51), Vector3(0.42, 0.03, 0.015), mat_iron)
		_add_mesh_box(root, Vector3(door_x, 0.58, 0.51), Vector3(0.03, 0.36, 0.015), mat_iron)
		for hy in [0.85, 0.32]:
			_add_mesh_box(root, Vector3(door_x - 0.34, hy, 0.48), Vector3(0.07, 0.09, 0.045), mat_br)
		_add_mesh_cyl(root, Vector3(door_x + 0.18, 0.68, 0.54), 0.014, 0.05, mat_br, false)
		_add_mesh_cyl(root, Vector3(door_x + 0.18, 0.48, 0.54), 0.014, 0.05, mat_br, false)
		_add_mesh_cyl(root, Vector3(door_x + 0.18, 0.58, 0.56), 0.016, 0.22, mat_br_l, false)
	for wx in [-0.32, 0.32]:
		_add_mesh_box(root, Vector3(wx, 1.0, 0.44), Vector3(0.42, 0.22, 0.06), mat_iron)
		_add_mesh_box(root, Vector3(wx, 1.0, 0.48), Vector3(0.3, 0.14, 0.02), mat_iron_d)
		_add_mesh_cyl(root, Vector3(wx, 1.0, 0.52), 0.012, 0.1, mat_br, false)
	_add_mesh_box(root, Vector3(0, 0.42, 0.4), Vector3(0.58, 0.48, 0.1), mat_soot)
	_add_mesh_box(root, Vector3(0, 0.22, 0.4), Vector3(0.52, 0.06, 0.2), mat_ash)
	for gi in 5:
		var gx := -0.18 + float(gi) * 0.09
		_add_mesh_box(root, Vector3(gx, 0.34, 0.44), Vector3(0.025, 0.26, 0.035), mat_iron_d)
	_add_mesh_box(root, Vector3(-0.16, 0.28, 0.42), Vector3(0.06, 0.14, 0.1), mat_iron)
	_add_mesh_box(root, Vector3(0.16, 0.28, 0.42), Vector3(0.06, 0.14, 0.1), mat_iron)
	_add_mesh_box(root, Vector3(-0.06, 0.3, 0.36), Vector3(0.38, 0.07, 0.11), mat_log)
	_add_mesh_box(root, Vector3(0.08, 0.36, 0.37), Vector3(0.28, 0.06, 0.09), mat_log_l)
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
	# Hotplate — four rings
	_add_mesh_box(root, Vector3(0, 1.28, 0), Vector3(2.22, 0.08, 0.9), mat_iron_d)
	for ring_x in [-0.7, -0.22, 0.22, 0.7]:
		_add_mesh_cyl(root, Vector3(ring_x, 1.34, 0.05), 0.16, 0.03, mat_iron, false)
		_add_mesh_cyl(root, Vector3(ring_x, 1.36, 0.05), 0.145, 0.015, mat_br_d, false)
		_add_mesh_cyl(root, Vector3(ring_x, 1.37, 0.05), 0.07, 0.02, mat_iron_d, false)
	# Hotplate vessels
	_add_mesh_cyl(root, Vector3(-0.7, 1.42, 0.05), 0.08, 0.04, mat_cop_d, false)
	_add_mesh_cyl(root, Vector3(-0.7, 1.5, 0.05), 0.12, 0.12, mat_cop, false)
	_add_mesh_cyl(root, Vector3(-0.7, 1.52, 0.05), 0.1, 0.12, _solid_metal(Color(0.78, 0.48, 0.22), 0.32), false)
	_add_mesh_cyl(root, Vector3(-0.7, 1.6, 0.05), 0.06, 0.04, mat_cop_d, false)
	_add_mesh_cyl(root, Vector3(-0.7, 1.64, 0.05), 0.03, 0.03, mat_br, false)
	_add_mesh_box(root, Vector3(-0.52, 1.5, 0.05), Vector3(0.12, 0.025, 0.03), mat_cop_d)
	_add_mesh_box(root, Vector3(-0.82, 1.52, 0.05), Vector3(0.04, 0.08, 0.03), mat_cop)
	_add_mesh_cyl(root, Vector3(-0.2, 1.42, 0.08), 0.09, 0.1, mat_cop_l, false)
	_add_mesh_cyl(root, Vector3(-0.2, 1.48, 0.08), 0.095, 0.02, mat_cop_l, false)
	_add_mesh_box(root, Vector3(-0.02, 1.44, 0.08), Vector3(0.14, 0.02, 0.03), mat_cop)
	_add_mesh_cyl(root, Vector3(0.25, 1.4, 0.05), 0.14, 0.04, mat_iron_d, false)
	_add_mesh_cyl(root, Vector3(0.25, 1.43, 0.05), 0.145, 0.02, mat_iron, false)
	_add_mesh_box(root, Vector3(0.48, 1.41, 0.05), Vector3(0.2, 0.022, 0.035), mat_iron_l)
	_add_mesh_cyl(root, Vector3(0.7, 1.42, 0.05), 0.07, 0.08, mat_cop_d, false)
	_add_mesh_cyl(root, Vector3(0.7, 1.48, 0.05), 0.075, 0.02, mat_cop_l, false)
	_add_mesh_cyl(root, Vector3(0.7, 1.5, 0.05), 0.025, 0.025, mat_br, false)
	# Mantel shelf + still-life
	_add_mesh_box(root, Vector3(0, 1.52, 0.12), Vector3(2.35, 0.06, 0.58), mat_iron)
	_add_mesh_box(root, Vector3(0, 1.56, 0.12), Vector3(2.32, 0.02, 0.54), mat_br_d)
	_add_mesh_cyl(root, Vector3(-0.75, 1.64, 0.12), 0.07, 0.14, _solid_matte(Color(0.78, 0.72, 0.6), 0.9), false)
	_add_mesh_cyl(root, Vector3(-0.75, 1.73, 0.12), 0.055, 0.03, _solid_matte(Color(0.7, 0.64, 0.52), 0.9), false)
	_add_mesh_cyl(root, Vector3(-0.4, 1.62, 0.15), 0.05, 0.1, _solid_matte(Color(0.55, 0.52, 0.48), 0.75), false)
	_add_mesh_box(root, Vector3(-0.05, 1.6, 0.18), Vector3(0.2, 0.03, 0.1), mat_log_l)
	_add_mesh_cyl(root, Vector3(0.25, 1.66, 0.15), 0.025, 0.14, _solid_matte(Color(0.95, 0.82, 0.45), 0.7), false)
	var _fl3 := StandardMaterial3D.new()
	_fl3.albedo_color = Color(1.0, 0.8, 0.4, 0.9)
	_fl3.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	_fl3.emission_enabled = true
	_fl3.emission = Color(1.0, 0.72, 0.3)
	_fl3.emission_energy_multiplier = 1.7
	_fl3.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	_add_mesh_cyl(root, Vector3(0.25, 1.75, 0.15), 0.022, 0.0286, _fl3, false)
	_add_mesh_cyl(root, Vector3(0.65, 1.64, 0.12), 0.08, 0.12, _solid_matte(Color(0.72, 0.46, 0.28), 0.9), false)
	_add_mesh_cyl(root, Vector3(0.65, 1.72, 0.12), 0.06, 0.03, _solid_matte(Color(0.58, 0.36, 0.22), 0.9), false)
	# Side boiler
	_add_mesh_cyl(root, Vector3(1.05, 0.85, -0.05), 0.18, 0.9, mat_iron, true)
	_add_mesh_cyl(root, Vector3(1.05, 1.3, -0.05), 0.19, 0.06, mat_br_d, false)
	_add_mesh_cyl(root, Vector3(1.05, 0.45, -0.05), 0.19, 0.06, mat_iron_d, false)
	_add_mesh_cyl(root, Vector3(1.05, 1.0, 0.12), 0.03, 0.04, mat_br, false)
	# Loop 176: continuous flue shaft (not grey ziggurat crown mid-FOV).
	# Period range: tall rectangular flue + iron bands + one cornice cap only.
	var mat_flue := _solid_matte(Color(0.3, 0.3, 0.32), 0.55)
	var mat_flue_d := _solid_matte(Color(0.2, 0.2, 0.22), 0.58)
	var mat_flue_l := _solid_matte(Color(0.42, 0.42, 0.44), 0.5)
	var mat_brass_f := _solid_copper_mat(Color(0.62, 0.48, 0.22), 0.35)  # darkened brass-ish
	# Throat plate on range top (joins body to flue — wide, low)
	_add_mesh_box(root, Vector3(0, 1.68, -0.08), Vector3(0.9, 0.1, 0.55), mat_flue)
	_add_mesh_box(root, Vector3(0, 1.74, -0.08), Vector3(0.78, 0.04, 0.48), mat_brass_f)
	# ONE continuous shaft (constant section — bands are surface only)
	_add_mesh_box(root, Vector3(0, 2.2, -0.1), Vector3(0.48, 0.95, 0.4), mat_flue_d)
	# Horizontal iron bands (identity, not width steps)
	for bi in 4:
		var by := 1.9 + float(bi) * 0.18
		_add_mesh_box(root, Vector3(0, by, -0.1), Vector3(0.52, 0.035, 0.44), mat_flue_l)
	# Corner rivets along front edges
	for ri in 5:
		var ry := 1.85 + float(ri) * 0.15
		_add_mesh_cyl(root, Vector3(-0.22, ry, 0.1), 0.016, 0.02, mat_flue_l, false)
		_add_mesh_cyl(root, Vector3(0.22, ry, 0.1), 0.016, 0.02, mat_flue_l, false)
	# Front smoke plate + brass damper pull
	_add_mesh_box(root, Vector3(0, 2.05, 0.12), Vector3(0.28, 0.4, 0.035), mat_flue)
	_add_mesh_box(root, Vector3(0, 2.05, 0.14), Vector3(0.18, 0.28, 0.02), mat_flue_d)
	_add_mesh_cyl(root, Vector3(0, 2.0, 0.16), 0.018, 0.07, mat_brass_f, false)
	# Single cornice cap (one moulding, not Minecraft steps)
	_add_mesh_box(root, Vector3(0, 2.7, -0.1), Vector3(0.58, 0.06, 0.48), mat_flue_l)
	_add_mesh_box(root, Vector3(0, 2.76, -0.1), Vector3(0.42, 0.05, 0.36), mat_flue_d)
	# Tiny chimney pot (cylinder — period cue)
	_add_mesh_cyl(root, Vector3(0, 2.88, -0.1), 0.08, 0.16, mat_flue, false)
	_add_mesh_cyl(root, Vector3(0, 2.96, -0.1), 0.1, 0.04, mat_flue_l, false)
	# Short hanging rail under mantel
	_add_mesh_box(root, Vector3(0, 1.62, 0.38), Vector3(1.4, 0.03, 0.04), mat_log)
	_add_mesh_cyl(root, Vector3(-0.4, 1.48, 0.4), 0.09, 0.05, mat_cop, false)
	_add_mesh_box(root, Vector3(-0.22, 1.48, 0.4), Vector3(0.14, 0.02, 0.03), mat_cop_d)
	_add_mesh_cyl(root, Vector3(-0.4, 1.55, 0.38), 0.008, 0.12, mat_iron, false)
	_add_mesh_cyl(root, Vector3(0.35, 1.46, 0.4), 0.08, 0.08, mat_cop_l, false)
	_add_mesh_cyl(root, Vector3(0.35, 1.52, 0.4), 0.03, 0.025, mat_br, false)
	_add_mesh_cyl(root, Vector3(0.35, 1.56, 0.38), 0.008, 0.1, mat_iron, false)
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
	## Loop 194: Welsh dresser — solid-mat oak base + plate rack + ware (not washed cubes).
	var root := Node3D.new()
	root.name = "Dresser"
	var seed0: int = int(prop.get("seed", 0))
	var w := 1.7
	var mat_oak_l := _solid_matte(Color(0.52, 0.38, 0.2), 0.78)
	var mat_oak_d := _solid_matte(Color(0.4, 0.28, 0.14), 0.82)
	var mat_oak := _solid_matte(Color(0.46, 0.32, 0.16), 0.8)
	var mat_br := _solid_metal(Color(0.72, 0.56, 0.28), 0.3)
	var mat_cream := _solid_matte(Color(0.84, 0.78, 0.66), 0.9)
	var mat_cream_d := _solid_matte(Color(0.74, 0.68, 0.56), 0.9)
	var mat_clay := _solid_matte(Color(0.72, 0.46, 0.28), 0.9)
	var mat_clay_d := _solid_matte(Color(0.58, 0.36, 0.22), 0.9)
	var mat_cop := _solid_metal(Color(0.7, 0.42, 0.18), 0.32)
	var mat_cop_d := _solid_metal(Color(0.58, 0.34, 0.14), 0.36)
	var mat_cop_l := _solid_metal(Color(0.78, 0.5, 0.24), 0.28)
	var mat_cloth := _solid_matte(Color(0.78, 0.72, 0.6), 0.92)
	# Base cupboard + doors + knobs
	_add_mesh_box(root, Vector3(0, 0.55, 0), Vector3(w, 1.05, 0.42), mat_oak_l)
	_add_mesh_box(root, Vector3(-0.35, 0.55, 0.2), Vector3(0.7, 0.85, 0.04), mat_oak_d)
	_add_mesh_box(root, Vector3(0.35, 0.55, 0.2), Vector3(0.7, 0.85, 0.04), mat_oak_d)
	_add_mesh_cyl(root, Vector3(-0.35, 0.55, 0.24), 0.02, 0.08, mat_br, false)
	_add_mesh_cyl(root, Vector3(0.35, 0.55, 0.24), 0.02, 0.08, mat_br, false)
	# Upper plate rack
	_add_mesh_box(root, Vector3(0, 1.55, -0.05), Vector3(w, 0.08, 0.36), mat_oak)
	_add_mesh_box(root, Vector3(0, 2.0, -0.05), Vector3(w, 0.08, 0.36), mat_oak)
	_add_mesh_box(root, Vector3(0, 2.4, -0.05), Vector3(w, 0.1, 0.38), mat_oak_l)
	_add_mesh_box(root, Vector3(-w * 0.48, 1.75, -0.05), Vector3(0.06, 1.3, 0.36), mat_oak)
	_add_mesh_box(root, Vector3(w * 0.48, 1.75, -0.05), Vector3(0.06, 1.3, 0.36), mat_oak)
	_add_mesh_box(root, Vector3(0, 1.75, -0.2), Vector3(w * 0.95, 1.3, 0.04), mat_oak_d)
	for i in 5:
		var px := -0.6 + i * 0.3
		var kind := (i + seed0) % 4
		if kind == 0:
			_add_mesh_cyl(root, Vector3(px, 1.6, 0.04), 0.1, 0.025, mat_cream, false)
			_add_mesh_cyl(root, Vector3(px, 1.625, 0.04), 0.09, 0.02, mat_cream_d, false)
			_add_mesh_cyl(root, Vector3(px, 1.645, 0.04), 0.08, 0.018, mat_cream, false)
		elif kind == 1:
			_add_mesh_cyl(root, Vector3(px, 1.7, 0.04), 0.065, 0.16, mat_clay if (i + seed0) % 2 == 0 else mat_clay_d, false)
			_add_mesh_cyl(root, Vector3(px, 1.8, 0.04), 0.055, 0.035, mat_clay_d, false)
		elif kind == 2:
			_add_mesh_cyl(root, Vector3(px, 1.62, 0.04), 0.065, 0.02, mat_cop_d, false)
			_add_mesh_cyl(root, Vector3(px, 1.68, 0.04), 0.085, 0.1, mat_cop, false)
			_add_mesh_cyl(root, Vector3(px, 1.74, 0.04), 0.095, 0.02, mat_cop_l, false)
			_add_mesh_box(root, Vector3(px + 0.09, 1.68, 0.04), Vector3(0.05, 0.035, 0.03), mat_cop)
		else:
			_add_mesh_cyl(root, Vector3(px, 1.68, 0.04), 0.05, 0.14, mat_cream_d, false)
			_add_mesh_box(root, Vector3(px + 0.05, 1.7, 0.04), Vector3(0.035, 0.08, 0.03), mat_cream_d)
		_add_mesh_cyl(root, Vector3(px + 0.02, 2.06, 0.04), 0.085, 0.025, mat_cream_d, false)
		if (i + seed0) % 2 == 0:
			_add_mesh_cyl(root, Vector3(px, 2.46, 0.02), 0.09, 0.022, mat_cream_d, false)
			_add_mesh_cyl(root, Vector3(px, 2.48, 0.02), 0.08, 0.018, mat_cream, false)
		else:
			_add_mesh_cyl(root, Vector3(px, 2.52, 0.02), 0.055, 0.12, mat_clay, false)
			_add_mesh_cyl(root, Vector3(px, 2.6, 0.02), 0.04, 0.03, mat_clay_d, false)
	# Work-top ware
	_add_mesh_cyl(root, Vector3(0.5, 1.18, 0.08), 0.07, 0.18, mat_clay if seed0 % 2 == 0 else mat_clay_d, false)
	_add_mesh_cyl(root, Vector3(0.5, 1.28, 0.08), 0.05, 0.04, mat_clay_d, false)
	_add_mesh_cyl(root, Vector3(0.65, 1.14, 0.02), 0.06, 0.14, mat_clay, false)
	_add_mesh_cyl(root, Vector3(-0.5, 1.12, 0.08), 0.065, 0.04, mat_cop_d, false)
	_add_mesh_cyl(root, Vector3(-0.5, 1.18, 0.08), 0.09, 0.12, mat_cop, false)
	_add_mesh_cyl(root, Vector3(-0.5, 1.26, 0.08), 0.095, 0.025, mat_cop_l, false)
	_add_mesh_box(root, Vector3(-0.38, 1.18, 0.08), Vector3(0.05, 0.06, 0.04), mat_cop)
	_add_mesh_cyl(root, Vector3(-0.25, 1.12, 0.02), 0.07, 0.02, mat_cop_d, false)
	_add_mesh_cyl(root, Vector3(-0.25, 1.15, 0.02), 0.085, 0.06, mat_cop, false)
	_add_mesh_cyl(root, Vector3(-0.25, 1.19, 0.02), 0.09, 0.02, mat_cop_l, false)
	_add_mesh_box(root, Vector3(-0.1, 1.15, 0.02), Vector3(0.14, 0.02, 0.035), mat_cop)
	_add_mesh_box(root, Vector3(0.1, 1.1, 0.1), Vector3(0.2, 0.03, 0.14), mat_cloth)
	_add_contact_shadow(root, 0.9, 0.3)
	return root

static func _make_sink(prop: Dictionary) -> Node3D:
	## Loop 179: Victorian butler sink — fireclay oval basin + scrubbed drain board +
	## brass hand-pump (not white Minecraft slab / T-pipe mid-FOV).
	var root := Node3D.new()
	root.name = "Sink"
	var seed0: int = int(prop.get("seed", 0))
	var wood := Color(0.42, 0.28, 0.16) if seed0 % 2 == 0 else Color(0.48, 0.32, 0.18)
	var wood_d := Color(0.32, 0.2, 0.1) if seed0 % 2 == 0 else Color(0.36, 0.22, 0.12)
	# Warm fireclay / stoneware (not pure white CREAM slab)
	var ware := Color(0.78, 0.74, 0.64)
	var ware_d := Color(0.62, 0.58, 0.5)
	var ware_l := Color(0.84, 0.8, 0.7)
	var well := Color(0.32, 0.38, 0.42)
	var mat_ware := _solid_matte(ware, 0.55)
	var mat_ware_d := _solid_matte(ware_d, 0.6)
	var mat_ware_l := _solid_matte(ware_l, 0.5)
	var mat_well := _solid_matte(well, 0.45)
	var mat_wood := _solid_matte(wood, 0.72)
	var mat_wood_d := _solid_matte(wood_d, 0.75)
	var mat_board := _solid_matte(Color(0.7, 0.6, 0.42), 0.78)
	var mat_board_d := _solid_matte(Color(0.58, 0.48, 0.32), 0.8)
	var mat_brass := _solid_metal(BRASS, 0.28)
	var mat_brass_d := _solid_metal(BRASS.darkened(0.12), 0.32)
	var mat_iron := _solid_matte(IRON.lightened(0.12), 0.55)
	# —— Base cabinet (mahogany service) ——
	_add_mesh_box(root, Vector3(0, 0.42, 0), Vector3(1.18, 0.78, 0.6), mat_wood)
	_add_mesh_box(root, Vector3(0, 0.06, 0.02), Vector3(1.24, 0.1, 0.64), mat_wood_d)
	# Fielded double doors + recessed panels + brass knobs
	_add_mesh_box(root, Vector3(-0.28, 0.4, 0.3), Vector3(0.52, 0.7, 0.04), mat_wood_d)
	_add_mesh_box(root, Vector3(0.28, 0.4, 0.3), Vector3(0.52, 0.7, 0.04), mat_wood_d)
	_add_mesh_box(root, Vector3(-0.28, 0.4, 0.32), Vector3(0.4, 0.5, 0.014), mat_wood)
	_add_mesh_box(root, Vector3(0.28, 0.4, 0.32), Vector3(0.4, 0.5, 0.014), mat_wood)
	_add_mesh_cyl(root, Vector3(-0.1, 0.4, 0.34), 0.02, 0.05, mat_brass, false)
	_add_mesh_cyl(root, Vector3(0.1, 0.4, 0.34), 0.02, 0.05, mat_brass, false)
	# —— Counter apron (stoneware lip, not flat white box) ——
	_add_mesh_box(root, Vector3(0.08, 0.86, 0.02), Vector3(1.12, 0.1, 0.56), mat_ware_d)
	_add_mesh_box(root, Vector3(0.08, 0.92, 0.28), Vector3(1.08, 0.05, 0.04), mat_ware)
	# —— Scrubbed oak drain board (LEFT) with groove ribs ——
	_add_mesh_box(root, Vector3(-0.38, 0.95, 0.02), Vector3(0.42, 0.05, 0.5), mat_board)
	_add_mesh_box(root, Vector3(-0.38, 0.98, 0.02), Vector3(0.38, 0.012, 0.46), mat_board_d)
	for gi in 5:
		var gz := -0.18 + float(gi) * 0.09
		_add_mesh_box(root, Vector3(-0.38, 0.99, gz), Vector3(0.34, 0.01, 0.018), mat_board)
	# Slope lip toward basin
	_add_mesh_box(root, Vector3(-0.16, 0.96, 0.02), Vector3(0.06, 0.03, 0.48), mat_board_d)
	# —— Fireclay butler basin (RIGHT) — oval well via cylinders, not rim-wall slab ——
	# Outer oval shell
	_add_mesh_cyl(root, Vector3(0.22, 0.96, 0.02), 0.22, 0.14, mat_ware, false)
	_add_mesh_cyl(root, Vector3(0.22, 0.96, 0.02), 0.18, 0.14, mat_ware, false)
	# Stretch oval with side cheek walls
	_add_mesh_box(root, Vector3(0.22, 0.96, 0.02), Vector3(0.5, 0.12, 0.36), mat_ware)
	# Thick rolled rim (reads ceramic lip, not Minecraft wall)
	_add_mesh_cyl(root, Vector3(0.22, 1.04, 0.02), 0.24, 0.035, mat_ware_l, false)
	_add_mesh_box(root, Vector3(0.22, 1.04, 0.02), Vector3(0.54, 0.03, 0.4), mat_ware_l)
	# Deep wet well (recessed, darker, not coplanar white)
	_add_mesh_cyl(root, Vector3(0.22, 0.92, 0.02), 0.16, 0.08, mat_well, false)
	_add_mesh_box(root, Vector3(0.22, 0.9, 0.02), Vector3(0.38, 0.05, 0.26), mat_well)
	# Drain grate
	_add_mesh_cyl(root, Vector3(0.22, 0.94, 0.02), 0.035, 0.015, mat_iron, false)
	_add_mesh_box(root, Vector3(0.22, 0.945, 0.02), Vector3(0.05, 0.008, 0.012), mat_ware_d)
	_add_mesh_box(root, Vector3(0.22, 0.945, 0.02), Vector3(0.012, 0.008, 0.05), mat_ware_d)
	# —— Backsplash: glazed tile field + dark rail (not single cream slab) ——
	var mat_tile := _solid_matte(Color(0.82, 0.78, 0.68), 0.45)
	var mat_grout := _solid_matte(Color(0.5, 0.48, 0.42), 0.85)
	var mat_rail := _solid_matte(Color(0.42, 0.28, 0.16), 0.7)
	_add_mesh_box(root, Vector3(0, 1.22, -0.26), Vector3(1.16, 0.48, 0.035), mat_tile)
	for ti in 4:
		_add_mesh_box(
			root,
			Vector3(-0.42 + float(ti) * 0.28, 1.22, -0.24),
			Vector3(0.24, 0.4, 0.02),
			mat_tile if ti % 2 == 0 else _solid_matte(Color(0.78, 0.74, 0.64), 0.5)
		)
	# Horizontal grout + vertical seams
	_add_mesh_box(root, Vector3(0, 1.22, -0.235), Vector3(1.1, 0.012, 0.01), mat_grout)
	for ti in 3:
		_add_mesh_box(root, Vector3(-0.28 + float(ti) * 0.28, 1.22, -0.235), Vector3(0.012, 0.42, 0.01), mat_grout)
	_add_mesh_box(root, Vector3(0, 1.02, -0.23), Vector3(1.14, 0.035, 0.025), mat_rail)
	# —— Brass hand-pump (column + curved spout + lever — not T-pipe) ——
	# Base flange on rim
	_add_mesh_cyl(root, Vector3(0.38, 1.08, -0.08), 0.06, 0.03, mat_brass_d, false)
	# Vertical pump barrel
	_add_mesh_cyl(root, Vector3(0.38, 1.28, -0.08), 0.038, 0.38, mat_brass, false)
	_add_mesh_cyl(root, Vector3(0.38, 1.28, -0.08), 0.045, 0.08, mat_brass_d, false)
	# Cap + finial
	_add_mesh_cyl(root, Vector3(0.38, 1.5, -0.08), 0.055, 0.05, mat_brass, false)
	_add_mesh_cyl(root, Vector3(0.38, 1.54, -0.08), 0.02, 0.04, mat_brass_d, false)
	# Curved spout: horizontal arm + downturn nozzle into basin
	_add_mesh_cyl_rot(root, Vector3(0.22, 1.42, -0.02), 0.022, 0.28, mat_brass, Vector3(0, 0, PI * 0.5))
	_add_mesh_cyl(root, Vector3(0.08, 1.36, 0.04), 0.02, 0.12, mat_brass, false)
	_add_mesh_cyl(root, Vector3(0.08, 1.28, 0.06), 0.028, 0.04, mat_brass_d, false)
	# Pump lever (side arm + grip)
	_add_mesh_box(root, Vector3(0.5, 1.32, -0.08), Vector3(0.04, 0.18, 0.04), mat_brass_d)
	_add_mesh_cyl_rot(root, Vector3(0.6, 1.4, -0.08), 0.016, 0.16, mat_brass, Vector3(0, 0, PI * 0.5))
	_add_mesh_cyl(root, Vector3(0.68, 1.4, -0.08), 0.022, 0.05, mat_brass_d, false)
	# —— Drain-board still-life (soap, cloth, crock — not mystery cubes) ——
	if seed0 % 2 == 0:
		# Soap cake + folded cloth + small stoneware crock
		_add_mesh_box(root, Vector3(-0.42, 1.02, 0.16), Vector3(0.1, 0.03, 0.07), _solid_matte(Color(0.86, 0.82, 0.7), 0.9))
		_add_mesh_box(root, Vector3(-0.28, 1.0, 0.18), Vector3(0.16, 0.015, 0.1), _solid_matte(Color(0.62, 0.68, 0.7), 0.85))
		_add_mesh_cyl(root, Vector3(-0.48, 1.05, -0.1), 0.04, 0.08, mat_ware_d, false)
		_add_mesh_cyl(root, Vector3(-0.48, 1.1, -0.1), 0.03, 0.025, mat_ware, false)
	else:
		# Copper scrub bowl + clay jar + cloth
		_add_mesh_cyl(root, Vector3(-0.4, 1.02, 0.1), 0.055, 0.02, _solid_metal(COPPER.darkened(0.1), 0.4), false)
		_add_mesh_cyl(root, Vector3(-0.4, 1.06, 0.1), 0.065, 0.07, _solid_metal(COPPER, 0.38), false)
		_add_mesh_cyl(root, Vector3(-0.4, 1.1, 0.1), 0.07, 0.018, _solid_metal(COPPER.lightened(0.08), 0.35), false)
		_add_mesh_cyl(root, Vector3(-0.48, 1.04, -0.12), 0.035, 0.07, _solid_matte(CLAY, 0.85), false)
		_add_mesh_box(root, Vector3(-0.22, 0.995, 0.18), Vector3(0.14, 0.012, 0.09), _solid_matte(Color(0.6, 0.66, 0.68), 0.85))
	_add_contact_shadow(root, 0.64, 0.38)
	return root

static func _make_prep_table(prop: Dictionary) -> Node3D:
	## Loop 201: solid-mat scrubbed top + oak frame (kits already solid from 192+).
	var root := Node3D.new()
	root.name = "PrepTable"
	var width: float = float(prop.get("width", 1.8))
	var seed0: int = int(prop.get("seed", 0))
	var kit := seed0 % 4
	var top_col := Color(0.74, 0.64, 0.44) if kit != 2 else Color(0.7, 0.6, 0.42)
	var mat_top := _solid_matte(top_col, 0.82)
	var mat_top_d := _solid_matte(top_col.darkened(0.08), 0.85)
	var mat_top_dd := _solid_matte(top_col.darkened(0.12), 0.88)
	var mat_apron := _solid_matte(Color(0.55, 0.42, 0.28), 0.78)
	var mat_leg := _solid_matte(Color(0.38, 0.26, 0.14), 0.8)
	var mat_brace := _solid_matte(Color(0.4, 0.28, 0.14), 0.82)
	_add_mesh_box(root, Vector3(0, 0.82, 0), Vector3(width, 0.06, 0.85), mat_top)
	_add_mesh_box(root, Vector3(0, 0.72, 0), Vector3(width - 0.1, 0.12, 0.78), mat_apron)
	_add_mesh_box(root, Vector3(0, 0.86, 0.42), Vector3(width * 0.98, 0.025, 0.03), mat_top_d)
	_add_mesh_box(root, Vector3(0, 0.855, -0.15), Vector3(width * 0.55, 0.008, 0.35), mat_top_dd)
	for lx in [-width * 0.4, width * 0.4]:
		for lz in [-0.32, 0.32]:
			_add_mesh_box(root, Vector3(lx, 0.4, lz), Vector3(0.08, 0.78, 0.08), mat_leg)
	_add_mesh_box(root, Vector3(0, 0.18, 0), Vector3(width * 0.75, 0.04, 0.7), mat_brace)
	# Lower shelf — bread tin + crock + pan
	var mat_sh_oak := _solid_matte(Color(0.52, 0.4, 0.24), 0.82)
	var mat_sh_oak_d := _solid_matte(Color(0.38, 0.26, 0.14), 0.85)
	var mat_sh_tin := _solid_matte(Color(0.55, 0.5, 0.4), 0.7)
	var mat_sh_crock := _solid_matte(Color(0.7, 0.6, 0.48), 0.9)
	var mat_sh_crock_d := _solid_matte(Color(0.55, 0.45, 0.35), 0.9)
	var mat_sh_cop := _solid_metal(Color(0.65, 0.38, 0.16), 0.35)
	_add_mesh_box(root, Vector3(0, 0.28, 0), Vector3(width * 0.72, 0.03, 0.55), mat_sh_oak)
	# Bread tin with lid seam
	_add_mesh_box(root, Vector3(-width * 0.18, 0.36, 0.05), Vector3(0.26, 0.12, 0.2), mat_sh_tin)
	_add_mesh_box(root, Vector3(-width * 0.18, 0.43, 0.05), Vector3(0.24, 0.02, 0.18), mat_sh_oak_d)
	_add_mesh_box(root, Vector3(-width * 0.18, 0.4, 0.05), Vector3(0.02, 0.08, 0.18), mat_sh_oak_d)
	# Salt crock on shelf
	_add_mesh_cyl(root, Vector3(width * 0.05, 0.38, 0.1), 0.055, 0.12, mat_sh_crock, false)
	_add_mesh_cyl(root, Vector3(width * 0.05, 0.45, 0.1), 0.04, 0.025, mat_sh_crock_d, false)
	# Upside copper pan nest
	_add_mesh_cyl(root, Vector3(width * 0.22, 0.35, -0.08), 0.09, 0.04, mat_sh_cop, false)
	_add_mesh_cyl(root, Vector3(width * 0.22, 0.39, -0.08), 0.07, 0.03, mat_sh_cop, false)
	match kit:
		0:
			# Loop 210: flour still-life rewrite — plump sack, cottage loaf, scored board,
			# rolling pin, proper apples (not brown log + brick + red nubs mid-FOV).
			var mat_hess := _solid_matte(Color(0.5, 0.4, 0.26), 0.96)
			var mat_hess_d := _solid_matte(Color(0.38, 0.3, 0.18), 0.96)
			var mat_hess_l := _solid_matte(Color(0.58, 0.48, 0.32), 0.95)
			var mat_dust := _solid_matte(Color(0.78, 0.7, 0.52), 0.97)
			var mat_twine := _solid_matte(Color(0.28, 0.2, 0.12), 0.9)
			var mat_stamp := _solid_matte(Color(0.32, 0.12, 0.08), 0.88)
			var mat_crust := _solid_matte(Color(0.52, 0.34, 0.16), 0.9)
			var mat_crust_d := _solid_matte(Color(0.4, 0.24, 0.1), 0.9)
			var mat_crumb := _solid_matte(Color(0.82, 0.7, 0.48), 0.94)
			var mat_board := _solid_matte(Color(0.64, 0.52, 0.34), 0.84)
			var mat_board_d := _solid_matte(Color(0.5, 0.38, 0.22), 0.86)
			var mat_board_e := _solid_matte(Color(0.42, 0.3, 0.16), 0.82)
			var mat_pin := _solid_matte(Color(0.62, 0.48, 0.3), 0.78)
			var mat_pin_h := _solid_matte(Color(0.3, 0.16, 0.09), 0.72)
			var mat_cop := _solid_metal(Color(0.72, 0.44, 0.18), 0.3)
			var mat_cop_l := _solid_metal(Color(0.8, 0.52, 0.26), 0.26)
			var mat_iron_b := _solid_metal(Color(0.5, 0.5, 0.52), 0.4)
			var mat_cloth := _solid_matte(Color(0.62, 0.58, 0.48), 0.95)
			var mat_crock := _solid_matte(Color(0.74, 0.66, 0.54), 0.9)
			var mat_crock_d := _solid_matte(Color(0.58, 0.5, 0.4), 0.9)
			var mat_apple_a := _solid_matte(Color(0.58, 0.16, 0.12), 0.88)
			var mat_apple_b := _solid_matte(Color(0.48, 0.2, 0.1), 0.88)
			var mat_apple_c := _solid_matte(Color(0.62, 0.22, 0.14), 0.88)
			var mat_stem := _solid_matte(Color(0.22, 0.14, 0.08), 0.85)
			var mat_leaf := _solid_matte(Color(0.28, 0.42, 0.16), 0.9)
			# --- Plump flour sack (lying, gathered mouth toward centre) ---
			var bx := -0.55
			var by := 0.94
			var bz := 0.0
			# Main body mass (overlapping plump cylinders — not single log)
			_add_mesh_cyl_rot(root, Vector3(bx, by, bz), 0.11, 0.3, mat_hess, Vector3(0, 0, PI * 0.5))
			_add_mesh_cyl_rot(root, Vector3(bx + 0.02, by + 0.03, bz + 0.02), 0.095, 0.26, mat_hess_l, Vector3(0, 0, PI * 0.5))
			_add_mesh_box(root, Vector3(bx, by + 0.04, bz), Vector3(0.26, 0.1, 0.16), mat_hess)
			# Seam panels
			_add_mesh_box(root, Vector3(bx, by + 0.08, bz), Vector3(0.22, 0.01, 0.02), mat_hess_d)
			_add_mesh_box(root, Vector3(bx, by + 0.02, bz + 0.09), Vector3(0.24, 0.06, 0.012), mat_hess_d)
			# Closed butt end (gathered folds)
			_add_mesh_cyl(root, Vector3(bx - 0.15, by, bz), 0.1, 0.04, mat_hess_d, false)
			_add_mesh_cyl(root, Vector3(bx - 0.17, by + 0.02, bz), 0.06, 0.03, mat_hess, false)
			# Open mouth + twine + ear flap toward board
			_add_mesh_cyl(root, Vector3(bx + 0.14, by, bz), 0.08, 0.05, mat_hess_d, false)
			_add_mesh_cyl(root, Vector3(bx + 0.13, by, bz), 0.085, 0.018, mat_twine, false)
			_add_mesh_box(root, Vector3(bx + 0.18, by + 0.04, bz + 0.01), Vector3(0.07, 0.05, 0.055), mat_hess_d)
			_add_mesh_box(root, Vector3(bx + 0.2, by + 0.06, bz), Vector3(0.04, 0.03, 0.04), mat_hess_l)
			# Brand stamp
			_add_mesh_box(root, Vector3(bx - 0.02, by + 0.1, bz), Vector3(0.11, 0.012, 0.08), mat_hess_d)
			_add_mesh_box(root, Vector3(bx - 0.02, by + 0.108, bz), Vector3(0.075, 0.01, 0.05), mat_stamp)
			# Flour spill from mouth
			_add_mesh_box(root, Vector3(bx + 0.22, 0.875, bz + 0.06), Vector3(0.14, 0.01, 0.12), mat_dust)
			_add_mesh_cyl(root, Vector3(bx + 0.2, 0.882, bz + 0.02), 0.045, 0.018, mat_dust, false)
			_add_mesh_cyl(root, Vector3(bx + 0.24, 0.88, bz + 0.08), 0.03, 0.014, mat_dust, false)
			# --- Thick dough board with edge lip + flour dust ---
			_add_mesh_box(root, Vector3(0.18, 0.87, -0.04), Vector3(0.78, 0.04, 0.48), mat_board_d)
			_add_mesh_box(root, Vector3(0.18, 0.892, -0.04), Vector3(0.74, 0.012, 0.44), mat_board)
			_add_mesh_box(root, Vector3(0.18, 0.9, -0.04), Vector3(0.72, 0.006, 0.03), mat_board_e)
			_add_mesh_box(root, Vector3(0.18, 0.9, 0.16), Vector3(0.72, 0.006, 0.03), mat_board_e)
			_add_mesh_box(root, Vector3(0.1, 0.898, -0.02), Vector3(0.42, 0.005, 0.28), mat_dust)
			_add_mesh_cyl(root, Vector3(0.28, 0.9, 0.05), 0.05, 0.01, mat_dust, false)
			# --- Cottage loaf (bottom boule + smaller top + score) ---
			_add_mesh_cyl(root, Vector3(0.08, 0.925, -0.06), 0.1, 0.07, mat_crust, false)
			_add_mesh_cyl(root, Vector3(0.08, 0.94, -0.06), 0.085, 0.04, mat_crumb, false)
			_add_mesh_cyl(root, Vector3(0.08, 0.97, -0.06), 0.065, 0.05, mat_crust, false)
			_add_mesh_cyl(root, Vector3(0.08, 0.995, -0.06), 0.05, 0.025, mat_crumb, false)
			# Crust scores + darker heel
			_add_mesh_box(root, Vector3(0.08, 1.01, -0.06), Vector3(0.08, 0.006, 0.01), mat_crust_d)
			_add_mesh_box(root, Vector3(0.08, 1.005, -0.03), Vector3(0.01, 0.006, 0.06), mat_crust_d)
			_add_mesh_box(root, Vector3(0.02, 0.93, -0.06), Vector3(0.015, 0.05, 0.09), mat_crust_d)
			# --- Rolling pin across board ---
			_add_mesh_cyl_rot(root, Vector3(0.32, 0.915, 0.1), 0.028, 0.38, mat_pin, Vector3(0, 0.35, PI * 0.5))
			_add_mesh_cyl_rot(root, Vector3(0.14, 0.915, 0.05), 0.016, 0.055, mat_pin_h, Vector3(0, 0.35, PI * 0.5))
			_add_mesh_cyl_rot(root, Vector3(0.5, 0.915, 0.15), 0.016, 0.055, mat_pin_h, Vector3(0, 0.35, PI * 0.5))
			# --- Knife with wood handle ---
			_add_mesh_box(root, Vector3(0.42, 0.9, -0.18), Vector3(0.18, 0.008, 0.022), mat_iron_b)
			_add_mesh_box(root, Vector3(0.5, 0.9, -0.18), Vector3(0.1, 0.006, 0.014), mat_iron_b)
			_add_mesh_cyl_rot(root, Vector3(0.32, 0.9, -0.18), 0.012, 0.09, mat_pin_h, Vector3(0, 0, PI * 0.5))
			# Flour scoop
			_add_mesh_box(root, Vector3(-0.12, 0.9, 0.2), Vector3(0.09, 0.03, 0.055), mat_board)
			_add_mesh_cyl_rot(root, Vector3(-0.06, 0.9, 0.2), 0.011, 0.09, mat_board_d, Vector3(0, 0, PI * 0.5))
			# --- Copper basin with rim + flour inside ---
			_add_mesh_cyl(root, Vector3(0.58, 0.9, -0.12), 0.12, 0.055, mat_cop, false)
			_add_mesh_cyl(root, Vector3(0.58, 0.935, -0.12), 0.13, 0.02, mat_cop_l, false)
			_add_mesh_cyl(root, Vector3(0.58, 0.92, -0.12), 0.09, 0.015, mat_dust, false)
			# Linen towel fold
			_add_mesh_box(root, Vector3(0.55, 0.875, 0.16), Vector3(0.16, 0.014, 0.12), mat_cloth)
			_add_mesh_box(root, Vector3(0.58, 0.885, 0.18), Vector3(0.1, 0.01, 0.06), mat_cloth)
			# --- Apples (tiered squat + stem + leaf — not red nubs) ---
			_add_mesh_cyl(root, Vector3(0.28, 0.9, 0.2), 0.04, 0.035, mat_apple_a, false)
			_add_mesh_cyl(root, Vector3(0.28, 0.925, 0.2), 0.045, 0.03, mat_apple_a, false)
			_add_mesh_cyl(root, Vector3(0.28, 0.945, 0.2), 0.032, 0.02, mat_apple_a, false)
			_add_mesh_cyl(root, Vector3(0.28, 0.96, 0.2), 0.006, 0.02, mat_stem, false)
			_add_mesh_box(root, Vector3(0.3, 0.965, 0.2), Vector3(0.03, 0.006, 0.015), mat_leaf)
			_add_mesh_cyl(root, Vector3(0.38, 0.895, 0.16), 0.035, 0.03, mat_apple_b, false)
			_add_mesh_cyl(root, Vector3(0.38, 0.915, 0.16), 0.04, 0.028, mat_apple_b, false)
			_add_mesh_cyl(root, Vector3(0.38, 0.935, 0.16), 0.028, 0.018, mat_apple_b, false)
			_add_mesh_cyl(root, Vector3(0.38, 0.948, 0.16), 0.005, 0.016, mat_stem, false)
			_add_mesh_cyl(root, Vector3(0.22, 0.895, 0.14), 0.032, 0.028, mat_apple_c, false)
			_add_mesh_cyl(root, Vector3(0.22, 0.915, 0.14), 0.036, 0.025, mat_apple_c, false)
			_add_mesh_cyl(root, Vector3(0.22, 0.932, 0.14), 0.024, 0.016, mat_apple_c, false)
			# Salt crock with glaze band
			_add_mesh_cyl(root, Vector3(0.42, 0.91, -0.22), 0.042, 0.08, mat_crock, false)
			_add_mesh_cyl(root, Vector3(0.42, 0.93, -0.22), 0.045, 0.015, mat_crock_d, false)
			_add_mesh_cyl(root, Vector3(0.42, 0.96, -0.22), 0.032, 0.025, mat_crock_d, false)
		1:
			# Baking kit — solid mats including dough/butter mass
			var mat_b_board := _solid_matte(Color(0.64, 0.52, 0.34), 0.85)
			var mat_b_board_d := _solid_matte(Color(0.5, 0.38, 0.22), 0.88)
			var mat_dough := _solid_matte(Color(0.82, 0.74, 0.58), 0.95)
			var mat_pie := _solid_matte(Color(0.55, 0.22, 0.18), 0.85)
			var mat_pie_l := _solid_matte(Color(0.62, 0.28, 0.2), 0.85)
			var mat_crust_b := _solid_matte(Color(0.75, 0.55, 0.35), 0.9)
			var mat_pin := _solid_matte(Color(0.58, 0.44, 0.28), 0.8)
			var mat_pin_h := _solid_matte(Color(0.32, 0.18, 0.1), 0.75)
			var mat_bowl := _solid_matte(Color(0.72, 0.48, 0.3), 0.88)
			var mat_bowl_r := _solid_matte(Color(0.62, 0.4, 0.24), 0.88)
			var mat_butter := _solid_matte(Color(0.88, 0.82, 0.62), 0.94)
			var mat_cut := _solid_metal(Color(0.48, 0.48, 0.5), 0.4)
			var mat_cloth_b := _solid_matte(Color(0.7, 0.72, 0.68), 0.92)
			_add_mesh_box(root, Vector3(-0.4, 0.875, 0.0), Vector3(0.55, 0.03, 0.38), mat_b_board)
			_add_mesh_box(root, Vector3(-0.4, 0.895, 0.0), Vector3(0.28, 0.03, 0.14), mat_dough)
			_add_mesh_cyl(root, Vector3(-0.4, 0.9, 0.0), 0.08, 0.05, mat_dough, false)
			_add_mesh_cyl(root, Vector3(0.1, 0.89, 0.1), 0.12, 0.04, mat_pie, false)
			_add_mesh_cyl(root, Vector3(0.1, 0.92, 0.1), 0.11, 0.025, mat_pie_l, false)
			_add_mesh_cyl(root, Vector3(0.1, 0.935, 0.1), 0.08, 0.02, mat_crust_b, false)
			_add_mesh_cyl_rot(root, Vector3(0.35, 0.9, -0.15), 0.028, 0.42, mat_pin, Vector3(0, 0, PI * 0.5))
			_add_mesh_cyl_rot(root, Vector3(0.12, 0.9, -0.15), 0.018, 0.06, mat_pin_h, Vector3(0, 0, PI * 0.5))
			_add_mesh_cyl_rot(root, Vector3(0.58, 0.9, -0.15), 0.018, 0.06, mat_pin_h, Vector3(0, 0, PI * 0.5))
			_add_mesh_cyl(root, Vector3(0.5, 0.92, 0.15), 0.13, 0.08, mat_bowl, false)
			_add_mesh_cyl(root, Vector3(0.5, 0.97, 0.15), 0.14, 0.02, mat_bowl_r, false)
			_add_mesh_box(root, Vector3(-0.05, 0.875, 0.25), Vector3(0.14, 0.03, 0.1), mat_butter)
			_add_mesh_cyl(root, Vector3(-0.05, 0.895, 0.25), 0.035, 0.03, mat_butter, false)
			_add_mesh_cyl(root, Vector3(0.25, 0.88, 0.22), 0.04, 0.012, mat_cut, false)
			_add_mesh_cyl(root, Vector3(0.35, 0.88, 0.25), 0.032, 0.01, mat_cut, false)
			_add_mesh_box(root, Vector3(-0.55, 0.875, 0.2), Vector3(0.16, 0.012, 0.12), mat_cloth_b)
		2:
			# Market veg kit — solid-mat greens as low leaf pads (no sphere_blob)
			var mat_wick := _solid_matte(Color(0.52, 0.38, 0.2), 0.92)
			var mat_wick_d := _solid_matte(Color(0.4, 0.28, 0.14), 0.94)
			var mat_chop := _solid_matte(Color(0.55, 0.42, 0.26), 0.82)
			var mat_chop_d := _solid_matte(Color(0.42, 0.3, 0.16), 0.85)
			var mat_cleaver := _solid_metal(Color(0.48, 0.48, 0.5), 0.4)
			var mat_cleaver_h := _solid_matte(Color(0.32, 0.2, 0.1), 0.75)
			var mat_crock_v := _solid_matte(Color(0.72, 0.64, 0.52), 0.9)
			var mat_crock_vd := _solid_matte(Color(0.58, 0.5, 0.4), 0.9)
			var mat_cloth_v := _solid_matte(Color(0.72, 0.74, 0.7), 0.92)
			var mat_carrot := _solid_matte(Color(0.85, 0.5, 0.18), 0.88)
			var mat_green_a := _solid_matte(Color(0.26, 0.4, 0.16), 0.9)
			var mat_green_b := _solid_matte(Color(0.3, 0.42, 0.18), 0.9)
			var mat_green_c := _solid_matte(Color(0.22, 0.36, 0.14), 0.9)
			var mat_root := _solid_matte(Color(0.85, 0.45, 0.15), 0.88)
			var mat_root_b := _solid_matte(Color(0.9, 0.5, 0.18), 0.88)
			var mat_apple_v := _solid_matte(Color(0.52, 0.16, 0.12), 0.9)
			_add_mesh_cyl(root, Vector3(-0.38, 0.9, 0.0), 0.16, 0.08, mat_wick, false)
			_add_mesh_cyl(root, Vector3(-0.38, 0.88, 0.0), 0.14, 0.03, mat_wick_d, false)
			_add_mesh_cyl(root, Vector3(-0.38, 0.95, 0.0), 0.17, 0.025, mat_wick_d, false)
			_add_mesh_box(root, Vector3(-0.38, 0.93, 0.12), Vector3(0.3, 0.04, 0.02), mat_wick_d)
			_add_mesh_box(root, Vector3(-0.38, 0.93, -0.12), Vector3(0.3, 0.04, 0.02), mat_wick_d)
			_add_mesh_cyl(root, Vector3(-0.38, 0.98, 0.0), 0.08, 0.05, mat_green_a, false)
			_add_mesh_cyl(root, Vector3(-0.32, 1.0, 0.06), 0.05, 0.035, mat_green_b, false)
			_add_mesh_cyl(root, Vector3(-0.42, 0.99, -0.04), 0.045, 0.03, mat_green_c, false)
			_add_mesh_cyl(root, Vector3(-0.34, 1.02, 0.04), 0.032, 0.028, mat_root, false)
			_add_mesh_cyl(root, Vector3(-0.44, 1.0, 0.0), 0.028, 0.025, mat_root_b, false)
			_add_mesh_cyl_rot(root, Vector3(-0.28, 0.98, -0.04), 0.015, 0.1, mat_carrot, Vector3(0, 0, PI * 0.35))
			_add_mesh_cyl_rot(root, Vector3(-0.48, 0.98, 0.05), 0.012, 0.08, mat_carrot, Vector3(0, 0, -PI * 0.3))
			_add_mesh_box(root, Vector3(0.3, 0.9, -0.05), Vector3(0.42, 0.09, 0.3), mat_chop)
			_add_mesh_box(root, Vector3(0.3, 0.86, -0.05), Vector3(0.46, 0.035, 0.33), mat_chop_d)
			_add_mesh_box(root, Vector3(0.36, 0.96, 0.02), Vector3(0.2, 0.015, 0.04), mat_cleaver)
			_add_mesh_cyl_rot(root, Vector3(0.22, 0.96, 0.02), 0.014, 0.07, mat_cleaver_h, Vector3(0, 0, PI * 0.5))
			_add_mesh_cyl(root, Vector3(0.52, 0.93, 0.16), 0.045, 0.09, mat_crock_v, false)
			_add_mesh_cyl(root, Vector3(0.52, 0.99, 0.16), 0.036, 0.022, mat_crock_vd, false)
			_add_mesh_box(root, Vector3(0.08, 0.875, 0.22), Vector3(0.18, 0.012, 0.12), mat_cloth_v)
			_add_mesh_cyl(root, Vector3(0.52, 0.9, -0.14), 0.038, 0.04, mat_apple_v, false)
		_:
			# Scullery kit — solid-mat pestle head + spoon bowl
			var mat_herb_b := _solid_matte(Color(0.58, 0.46, 0.3), 0.85)
			var mat_leaf_a := _solid_matte(Color(0.28, 0.4, 0.18), 0.92)
			var mat_leaf_b := _solid_matte(Color(0.32, 0.38, 0.16), 0.92)
			var mat_stone_m := _solid_matte(Color(0.58, 0.55, 0.48), 0.88)
			var mat_stone_r := _solid_matte(Color(0.48, 0.45, 0.4), 0.88)
			var mat_pestle := _solid_matte(Color(0.4, 0.28, 0.14), 0.8)
			var mat_col := _solid_metal(Color(0.7, 0.42, 0.18), 0.32)
			var mat_col_l := _solid_metal(Color(0.78, 0.5, 0.24), 0.28)
			var mat_hole := _solid_matte(Color(0.15, 0.12, 0.1), 0.9)
			var mat_spoon := _solid_matte(Color(0.5, 0.38, 0.22), 0.8)
			var mat_ladle := _solid_metal(Color(0.38, 0.38, 0.4), 0.45)
			var mat_ladle_c := _solid_metal(Color(0.62, 0.36, 0.16), 0.35)
			var mat_cloth_s := _solid_matte(Color(0.68, 0.7, 0.66), 0.92)
			var mat_jar := _solid_matte(Color(0.78, 0.72, 0.58), 0.9)
			var mat_jar_d := _solid_matte(Color(0.65, 0.58, 0.46), 0.9)
			_add_mesh_box(root, Vector3(-0.35, 0.875, 0.05), Vector3(0.48, 0.03, 0.32), mat_herb_b)
			_add_mesh_box(root, Vector3(-0.4, 0.9, 0.05), Vector3(0.22, 0.03, 0.14), mat_leaf_a)
			_add_mesh_box(root, Vector3(-0.28, 0.9, -0.05), Vector3(0.16, 0.025, 0.12), mat_leaf_b)
			_add_mesh_cyl(root, Vector3(0.15, 0.92, 0.05), 0.09, 0.1, mat_stone_m, false)
			_add_mesh_cyl(root, Vector3(0.15, 0.98, 0.05), 0.1, 0.03, mat_stone_r, false)
			_add_mesh_cyl(root, Vector3(0.22, 1.05, 0.08), 0.02, 0.16, mat_pestle, false)
			_add_mesh_cyl(root, Vector3(0.22, 0.98, 0.08), 0.03, 0.035, mat_pestle, false)
			_add_mesh_cyl(root, Vector3(0.5, 0.9, -0.1), 0.12, 0.05, mat_col, false)
			_add_mesh_cyl(root, Vector3(0.5, 0.94, -0.1), 0.13, 0.02, mat_col_l, false)
			for hi in 4:
				var hx := 0.45 + float(hi % 2) * 0.08
				var hz := -0.14 + float(hi / 2) * 0.08
				_add_mesh_cyl(root, Vector3(hx, 0.92, hz), 0.012, 0.01, mat_hole, false)
			_add_mesh_box(root, Vector3(-0.1, 0.89, -0.2), Vector3(0.32, 0.015, 0.03), mat_spoon)
			_add_mesh_cyl(root, Vector3(-0.26, 0.89, -0.2), 0.028, 0.02, mat_spoon, false)
			_add_mesh_box(root, Vector3(0.25, 0.89, 0.22), Vector3(0.28, 0.015, 0.025), mat_ladle)
			_add_mesh_cyl(root, Vector3(0.08, 0.89, 0.22), 0.035, 0.025, mat_ladle_c, false)
			_add_mesh_box(root, Vector3(0.5, 0.875, 0.2), Vector3(0.16, 0.015, 0.12), mat_cloth_s)
			_add_mesh_cyl(root, Vector3(-0.55, 0.92, 0.2), 0.045, 0.1, mat_jar, false)
			_add_mesh_cyl(root, Vector3(-0.55, 0.98, 0.2), 0.035, 0.03, mat_jar_d, false)
	_add_contact_shadow(root, width * 0.5, 0.5)
	return root


static func _make_floor_path(prop: Dictionary) -> Node3D:
	## Loop 203: walk path solid mats — iron tread / wood boards / stone flags (no washout).
	## Loop 212: stone = irregular garden flags (not pale game slabs + green rivet dots mid-FOV).
	##          iron = darker worn tread, smaller recessed bolts (not bright rivet grid).
	var root := Node3D.new()
	root.name = "FloorPath"
	var length: float = float(prop.get("length", 3.5))
	var width: float = float(prop.get("width", 0.9))
	var seed0: int = int(prop.get("seed", 0))
	var surface: String = str(prop.get("surface", "stone"))
	var n := int(clampf(length / 0.55, 3.0, 14.0))
	var mat_iron_mid := _solid_metal(Color(0.28, 0.28, 0.3), 0.55)
	var mat_iron_light := _solid_metal(Color(0.34, 0.34, 0.36), 0.52)
	var mat_iron_dark := _solid_metal(Color(0.2, 0.2, 0.22), 0.58)
	var mat_iron_edge := _solid_metal(Color(0.38, 0.36, 0.34), 0.5)
	var mat_iron_hi := _solid_metal(Color(0.4, 0.4, 0.42), 0.5)
	var mat_riv := _solid_metal(Color(0.32, 0.3, 0.28), 0.5)
	var mat_br_d := _solid_metal(Color(0.48, 0.36, 0.18), 0.38)
	var mat_cop_scuff := _solid_metal(Color(0.48, 0.28, 0.12), 0.42)
	var mat_oak := _solid_matte(Color(0.48, 0.34, 0.18), 0.78)
	var mat_oak_d := _solid_matte(Color(0.36, 0.24, 0.12), 0.82)
	var mat_oak_dd := _solid_matte(Color(0.3, 0.2, 0.1), 0.85)
	# Stone bed: warm earth grit (not pale metal grey)
	var mat_grit := _solid_matte(Color(0.38, 0.34, 0.28), 0.92)
	var mat_grit_d := _solid_matte(Color(0.28, 0.24, 0.18), 0.94)
	var mat_grit_l := _solid_matte(Color(0.44, 0.4, 0.32), 0.9)
	# Moss: dark muted (not bright lime rivet dots)
	var mat_moss := _solid_matte(Color(0.16, 0.24, 0.12), 0.94)
	var mat_moss_l := _solid_matte(Color(0.2, 0.28, 0.14), 0.94)
	var mat_peb := _solid_matte(Color(0.4, 0.36, 0.3), 0.88)
	if surface == "iron":
		_add_mesh_box(root, Vector3(0, 0.01, 0), Vector3(width * 0.98, 0.014, length * 0.98), mat_iron_dark)
		_add_mesh_box(root, Vector3(-width * 0.48, 0.03, 0), Vector3(0.05, 0.04, length * 0.96), mat_iron_mid)
		_add_mesh_box(root, Vector3(width * 0.48, 0.03, 0), Vector3(0.05, 0.04, length * 0.96), mat_iron_mid)
		for ez in [-1.0, 1.0]:
			for ex in [-1.0, 1.0]:
				_add_mesh_cyl(root, Vector3(ex * width * 0.48, 0.05, ez * length * 0.46), 0.025, 0.04, mat_br_d, false)
	for i in n:
		var z := -length * 0.5 + 0.3 + float(i) * (length / float(n))
		var ox := 0.03 * float(((i + seed0) % 3) - 1)
		if surface == "iron":
			var pw := width * (0.8 + float(i % 2) * 0.04)
			var pd := 0.46
			var mat_pl := mat_iron_light if (i + seed0) % 2 == 0 else mat_iron_mid
			_add_mesh_box(root, Vector3(ox, 0.026, z), Vector3(pw, 0.026, pd), mat_pl)
			# Thin wear groove only (not heavy bright frame)
			_add_mesh_box(root, Vector3(ox, 0.04, z - pd * 0.42), Vector3(pw * 0.92, 0.008, 0.022), mat_iron_edge)
			_add_mesh_box(root, Vector3(ox, 0.04, z + pd * 0.42), Vector3(pw * 0.92, 0.008, 0.022), mat_iron_edge)
			if (i + seed0) % 2 == 0:
				for r in 2:
					var rx := ox - pw * 0.2 + float(r) * (pw * 0.4)
					_add_mesh_box(root, Vector3(rx, 0.038, z), Vector3(0.03, 0.006, pd * 0.55), mat_iron_hi)
			# Corner bolts only (recessed dark, not bright rivet grid)
			for cx in [-1.0, 1.0]:
				for cz in [-1.0, 1.0]:
					_add_mesh_cyl(root, Vector3(ox + cx * pw * 0.4, 0.042, z + cz * pd * 0.38), 0.012, 0.01, mat_riv, false)
			_add_mesh_box(root, Vector3(ox, 0.018, z + pd * 0.5), Vector3(pw * 0.88, 0.008, 0.03), mat_iron_dark)
			if (i + seed0) % 5 == 0:
				_add_mesh_box(root, Vector3(ox + pw * 0.12, 0.04, z - 0.04), Vector3(0.1, 0.006, 0.06), mat_cop_scuff)
		elif surface == "wood":
			var mat_w := mat_oak if (i + seed0) % 2 == 0 else mat_oak_d
			_add_mesh_box(root, Vector3(ox, 0.02, z), Vector3(width * 0.9, 0.035, 0.52), mat_w)
			_add_mesh_box(root, Vector3(ox, 0.015, z + 0.22), Vector3(width * 0.85, 0.008, 0.02), mat_oak_dd)
		else:
			# Garden flagstones — irregular sizes, warm stone, dark grit gaps
			var pw := width * (0.48 + float((i * 2 + seed0) % 5) * 0.1)
			var pd := 0.32 + float((i + seed0 * 2) % 5) * 0.08
			var col: Color
			match (i + seed0) % 6:
				0:
					col = Color(0.48, 0.44, 0.36)
				1:
					col = Color(0.42, 0.38, 0.32)
				2:
					col = Color(0.52, 0.46, 0.38)
				3:
					col = Color(0.4, 0.36, 0.3)
				4:
					col = Color(0.5, 0.45, 0.36)
				_:
					col = Color(0.44, 0.4, 0.33)
			var mat_flag := _solid_matte(col, 0.88)
			var mat_flag_d := _solid_matte(col.darkened(0.12), 0.9)
			var mat_flag_l := _solid_matte(col.lightened(0.06), 0.86)
			# Strong stagger so flags don't read as aligned game tiles
			var stagger: float = ((float((i * 5 + seed0 * 3) % 7) - 3.0) * 0.09)
			var fx: float = ox + stagger
			var hy := 0.018 + float((i + seed0) % 3) * 0.005
			# Dark grit bed under each flag
			_add_mesh_box(root, Vector3(fx, 0.005, z), Vector3(pw * 1.22, 0.01, pd * 1.25), mat_grit_d)
			# Main flag (slightly trapezoid feel via dual offset boxes)
			_add_mesh_box(root, Vector3(fx, hy, z), Vector3(pw, 0.032, pd), mat_flag)
			_add_mesh_box(root, Vector3(fx + pw * 0.04, hy + 0.002, z + pd * 0.03), Vector3(pw * 0.88, 0.02, pd * 0.88), mat_flag_l)
			# Worn edge chip
			if (i + seed0) % 2 == 0:
				_add_mesh_box(root, Vector3(fx + pw * 0.35, hy + 0.012, z - pd * 0.28), Vector3(pw * 0.22, 0.01, pd * 0.2), mat_flag_d)
			if (i + seed0) % 3 == 0:
				_add_mesh_box(root, Vector3(fx - pw * 0.3, hy + 0.01, z + pd * 0.25), Vector3(pw * 0.18, 0.01, pd * 0.18), mat_flag_d)
			# Sparse dark moss in joints only (low flat pads — not bright rivets)
			if (i + seed0) % 3 == 0:
				_add_mesh_box(root, Vector3(fx + pw * 0.42, 0.012, z), Vector3(0.06, 0.008, pd * 0.45), mat_moss)
			if (i + seed0) % 2 == 1:
				_add_mesh_box(root, Vector3(fx, 0.012, z + pd * 0.48), Vector3(pw * 0.4, 0.008, 0.05), mat_moss_l)
			# Occasional grit pebble (warm brown, not metal)
			if (i + seed0) % 4 == 2:
				_add_mesh_cyl(root, Vector3(fx - pw * 0.25, hy + 0.012, z + pd * 0.1), 0.018, 0.012, mat_peb, false)
	if surface == "stone":
		# Continuous gravel bed + low stone curbs (garden path identity)
		_add_mesh_box(root, Vector3(0, 0.004, 0), Vector3(width * 1.05, 0.01, length * 0.98), mat_grit)
		_add_mesh_box(root, Vector3(0, 0.008, 0), Vector3(width * 0.9, 0.008, length * 0.92), mat_grit_l)
		# Low irregular curbs (not continuous pipe rails)
		for side in [-1.0, 1.0]:
			for ci in 8:
				var cz := -length * 0.42 + float(ci) * (length * 0.84 / 7.0)
				var cw := 0.12 + float((ci + seed0) % 3) * 0.03
				var ch := 0.028 + float((ci + seed0) % 2) * 0.008
				var cx: float = float(side) * (width * 0.52 + float(ci % 2) * 0.02)
				var mat_c: StandardMaterial3D = mat_grit_d if ci % 2 == 0 else mat_peb
				_add_mesh_box(root, Vector3(cx, ch * 0.5, cz), Vector3(cw, ch, 0.35 + float(ci % 3) * 0.08), mat_c)
				if ci % 3 == 0:
					_add_mesh_box(root, Vector3(cx, 0.01, cz + 0.12), Vector3(0.05, 0.008, 0.08), mat_moss)
	return root


static func _make_garden_bench(prop: Dictionary) -> Node3D:
	## Loop 178: park bench — OPEN cast-iron ends (not black fridge slab mid-FOV).
	## seed 0: iron scroll ends + oak seat slats. seed 1: teak settle.
	var root := Node3D.new()
	root.name = "GardenBench"
	var seed0: int = int(prop.get("seed", 0))
	var w: float = float(prop.get("width", 1.35))
	var seat_y := 0.44
	var seat_d := 0.48
	if seed0 % 2 == 0:
		# Solid matte iron (true greys → no wood/velvet misclass)
		var mat_i := _solid_matte(Color(0.16, 0.17, 0.16), 0.48)
		var mat_ih := _solid_matte(Color(0.26, 0.27, 0.25), 0.45)
		var mat_id := _solid_matte(Color(0.1, 0.11, 0.1), 0.52)
		var mat_oak := _solid_matte(Color(0.55, 0.4, 0.22), 0.7)
		var mat_oak_d := _solid_matte(Color(0.42, 0.28, 0.14), 0.72)
		var mat_brass := _solid_copper_mat(Color(0.65, 0.5, 0.24), 0.35)
		# Seat frame (thin rails only)
		_add_mesh_box(root, Vector3(0, seat_y - 0.04, 0.16), Vector3(w * 0.9, 0.035, 0.04), mat_i)
		_add_mesh_box(root, Vector3(0, seat_y - 0.04, -0.16), Vector3(w * 0.9, 0.035, 0.04), mat_i)
		# 6 oak seat slats with clear air gaps
		for i in 6:
			var t := float(i) / 5.0
			var z := -0.18 + t * 0.4
			_add_mesh_box(root, Vector3(0, seat_y, z), Vector3(w * 0.88, 0.03, 0.045), mat_oak if i % 2 == 0 else mat_oak_d)
		_add_mesh_box(root, Vector3(0, seat_y + 0.01, 0.23), Vector3(w * 0.9, 0.03, 0.025), mat_oak_d)
		# Open back: rails + thin spindles only (air through — not solid wall)
		_add_mesh_box(root, Vector3(0, 0.56, -0.22), Vector3(w * 0.92, 0.04, 0.035), mat_i)
		_add_mesh_box(root, Vector3(0, 0.95, -0.22), Vector3(w * 0.92, 0.045, 0.035), mat_ih)
		_add_mesh_box(root, Vector3(0, 1.08, -0.2), Vector3(w * 0.55, 0.04, 0.03), mat_i)
		# Crest finial
		_add_mesh_cyl(root, Vector3(0, 1.14, -0.2), 0.03, 0.06, mat_ih, false)
		for i in 8:
			var t := float(i) / 7.0
			var bx: float = -w * 0.4 + t * w * 0.8
			_add_mesh_box(root, Vector3(bx, 0.76, -0.2), Vector3(0.028, 0.36, 0.022), mat_id)
			if i % 2 == 0:
				_add_mesh_box(root, Vector3(bx, 0.76, -0.185), Vector3(0.016, 0.3, 0.014), mat_oak_d)
		# OPEN end standards — frame outline + scroll, no solid side panel
		for sx in [-1.0, 1.0]:
			var ex: float = sx * w * 0.47
			# Front/back legs (slender)
			_add_mesh_box(root, Vector3(ex, 0.22, 0.16), Vector3(0.045, 0.4, 0.045), mat_i)
			_add_mesh_box(root, Vector3(ex, 0.22, -0.18), Vector3(0.045, 0.4, 0.045), mat_i)
			# Scroll feet (outward curl)
			_add_mesh_box(root, Vector3(ex, 0.03, 0.2), Vector3(0.06, 0.04, 0.12), mat_ih)
			_add_mesh_box(root, Vector3(ex, 0.03, -0.22), Vector3(0.06, 0.04, 0.12), mat_ih)
			_add_mesh_cyl(root, Vector3(ex, 0.035, 0.28), 0.035, 0.035, mat_i, false)
			_add_mesh_cyl(root, Vector3(ex, 0.035, -0.3), 0.035, 0.035, mat_i, false)
			# Upright + open arm (air under armrest)
			_add_mesh_box(root, Vector3(ex, 0.78, -0.18), Vector3(0.04, 0.5, 0.04), mat_i)
			_add_mesh_box(root, Vector3(ex, 0.66, 0.02), Vector3(0.045, 0.04, 0.4), mat_ih)
			_add_mesh_cyl(root, Vector3(ex, 0.66, 0.24), 0.03, 0.05, mat_ih, false)
			# Diagonal brace (scroll suggestion) — open triangle, not panel
			_add_mesh_box(root, Vector3(ex, 0.4, -0.02), Vector3(0.03, 0.03, 0.28), mat_id)
			_add_mesh_box(root, Vector3(ex, 0.5, 0.08), Vector3(0.03, 0.18, 0.03), mat_id)
			# Brass medallion
			_add_mesh_cyl(root, Vector3(ex + sx * 0.01, 0.85, -0.18), 0.04, 0.025, mat_brass, false)
		# Stretchers under seat (thin X)
		_add_mesh_box(root, Vector3(0, 0.16, 0.0), Vector3(w * 0.82, 0.028, 0.03), mat_id)
		_add_mesh_box(root, Vector3(0, 0.16, 0.0), Vector3(0.03, 0.028, 0.28), mat_id)
	else:
		# Teak garden settle — solid-mat ladder-back + seat slats (loop 202)
		var mat_teak := _solid_matte(Color(0.42, 0.28, 0.14), 0.72)
		var mat_teak_d := _solid_matte(Color(0.3, 0.18, 0.08), 0.78)
		var mat_teak_l := _solid_matte(Color(0.52, 0.36, 0.18), 0.7)
		var mat_cush := _solid_matte(Color(0.55, 0.42, 0.28), 0.88)
		_add_mesh_box(root, Vector3(0, seat_y - 0.05, 0.0), Vector3(w * 0.94, 0.05, seat_d * 0.95), mat_teak_d)
		for i in 5:
			var t := float(i) / 4.0
			var z := -0.18 + t * 0.36
			_add_mesh_box(root, Vector3(0, seat_y, z), Vector3(w * 0.9, 0.04, 0.05), mat_teak_l if i % 2 == 0 else mat_teak)
		_add_mesh_box(root, Vector3(0, seat_y + 0.04, 0.02), Vector3(w * 0.88, 0.035, seat_d * 0.75), mat_cush)
		_add_mesh_box(root, Vector3(0, 0.58, -0.22), Vector3(w * 0.9, 0.05, 0.05), mat_teak_d)
		_add_mesh_box(root, Vector3(0, 0.85, -0.22), Vector3(w * 0.88, 0.04, 0.04), mat_teak)
		_add_mesh_box(root, Vector3(0, 1.1, -0.22), Vector3(w * 0.9, 0.06, 0.05), mat_teak_l)
		_add_mesh_box(root, Vector3(0, 1.16, -0.2), Vector3(w * 0.4, 0.04, 0.04), mat_teak)
		for i in 7:
			var t := float(i) / 6.0
			var bx: float = -w * 0.38 + t * w * 0.76
			_add_mesh_box(root, Vector3(bx, 0.85, -0.2), Vector3(0.035, 0.48, 0.03), mat_teak_d if i % 2 == 0 else mat_teak)
		for sx in [-1.0, 1.0]:
			var ex: float = sx * w * 0.45
			_add_mesh_box(root, Vector3(ex, 0.85, -0.2), Vector3(0.08, 0.65, 0.08), mat_teak_d)
			_add_mesh_box(root, Vector3(ex, 0.62, 0.05), Vector3(0.09, 0.06, 0.42), mat_teak_l)
			_add_mesh_cyl(root, Vector3(ex, 0.62, 0.24), 0.04, 0.05, mat_teak, false)
			_add_mesh_box(root, Vector3(ex, 0.22, 0.16), Vector3(0.07, 0.4, 0.07), mat_teak_d)
			_add_mesh_box(root, Vector3(ex, 0.22, -0.18), Vector3(0.07, 0.4, 0.07), mat_teak_d)
			_add_mesh_box(root, Vector3(ex, 0.03, 0.16), Vector3(0.09, 0.04, 0.1), mat_teak)
			_add_mesh_box(root, Vector3(ex, 0.03, -0.18), Vector3(0.09, 0.04, 0.1), mat_teak)
		_add_mesh_box(root, Vector3(0, 0.15, 0.0), Vector3(w * 0.8, 0.035, 0.04), mat_teak_d)
		_add_mesh_box(root, Vector3(0, 0.15, 0.0), Vector3(0.04, 0.035, 0.3), mat_teak_d)
	_add_contact_shadow(root, w * 0.5, 0.38)
	return root


static func _make_urn(prop: Dictionary) -> Node3D:
	## Loop 183: Victorian pedestal garden urn — bowl on turned stem (not amphora
	## cylinder stack / milk-churn mid-FOV). ONE dark stone mat throughout.
	var root := Node3D.new()
	root.name = "Urn"
	var seed0: int = int(prop.get("seed", 0))
	var scale: float = float(prop.get("scale", 1.0))
	# Dark warm sandstone (pale cream washes white under conservatory glass)
	var body_c := Color(0.42, 0.36, 0.28) if seed0 % 2 == 0 else Color(0.4, 0.35, 0.3)
	var mat := _solid_matte(body_c, 0.92)
	var mat_soil := _solid_matte(Color(0.14, 0.09, 0.05), 0.95)
	var mat_la := _solid_matte(Color(0.18, 0.34, 0.12), 0.9)
	var mat_lb := _solid_matte(Color(0.12, 0.26, 0.08), 0.9)
	# Round base disc (not square Minecraft plinth)
	_add_mesh_cyl(root, Vector3(0, 0.03 * scale, 0), 0.2 * scale, 0.06 * scale, mat, true)
	_add_mesh_cyl(root, Vector3(0, 0.07 * scale, 0), 0.16 * scale, 0.03 * scale, mat, false)
	# Turned pedestal stem (narrow — reads as stem, not barrel stack)
	_add_mesh_cyl(root, Vector3(0, 0.16 * scale, 0), 0.07 * scale, 0.12 * scale, mat, true)
	_add_mesh_cyl(root, Vector3(0, 0.28 * scale, 0), 0.09 * scale, 0.1 * scale, mat, true)
	_add_mesh_cyl(root, Vector3(0, 0.36 * scale, 0), 0.06 * scale, 0.08 * scale, mat, false)
	# Cup/bowl (wide mouth — garden urn identity)
	_add_mesh_cyl(root, Vector3(0, 0.48 * scale, 0), 0.14 * scale, 0.14 * scale, mat, true)
	_add_mesh_cyl(root, Vector3(0, 0.56 * scale, 0), 0.2 * scale, 0.1 * scale, mat, true)
	# Rolled rim
	_add_mesh_cyl(root, Vector3(0, 0.62 * scale, 0), 0.22 * scale, 0.035 * scale, mat, false)
	# Inner soil
	_add_mesh_cyl(root, Vector3(0, 0.6 * scale, 0), 0.14 * scale, 0.025 * scale, mat_soil, false)
	# Two loop handles on bowl (small C — not long vertical bars)
	for sx in [-1.0, 1.0]:
		_add_mesh_box(root, Vector3(sx * 0.2 * scale, 0.52 * scale, 0), Vector3(0.03 * scale, 0.1 * scale, 0.04 * scale), mat)
		_add_mesh_box(root, Vector3(sx * 0.22 * scale, 0.58 * scale, 0), Vector3(0.04 * scale, 0.025 * scale, 0.04 * scale), mat)
		_add_mesh_box(root, Vector3(sx * 0.18 * scale, 0.46 * scale, 0), Vector3(0.035 * scale, 0.025 * scale, 0.04 * scale), mat)
	# Trailing ivy from rim (side drape, not upright crown)
	for i in 3:
		var ang := float(i) * TAU / 3.0 + float(seed0) * 0.4
		var lx: float = cos(ang) * 0.14 * scale
		var lz: float = sin(ang) * 0.14 * scale
		_add_mesh_box(
			root,
			Vector3(lx, 0.55 * scale, lz),
			Vector3(0.05 * scale, 0.012 * scale, 0.03 * scale),
			mat_la if i % 2 == 0 else mat_lb
		)
		_add_mesh_box(
			root,
			Vector3(lx * 1.1, 0.5 * scale, lz * 1.1),
			Vector3(0.04 * scale, 0.01 * scale, 0.025 * scale),
			mat_lb if i % 2 == 0 else mat_la
		)
	_add_contact_shadow(root, 0.22 * scale, 0.22 * scale)
	return root


static func _make_watering_can(prop: Dictionary) -> Node3D:
	## Loop 174: solid-metal copper Haws can (no metal_copper.jpg grain = weave/wicker).
	## Loop 173 cop_l hit CLAY; body texture grain next to trug read as basket.
	var root := Node3D.new()
	root.name = "WateringCan"
	var s: float = float(prop.get("scale", 1.0))
	var cop := Color(0.82, 0.42, 0.18)
	var cop_l := Color(0.9, 0.48, 0.2)
	var cop_d := Color(0.58, 0.3, 0.12)
	# Smooth solid copper (high metal, no albedo texture)
	var mat_c := _solid_copper_mat(cop, 0.28)
	var mat_l := _solid_copper_mat(cop_l, 0.22)
	var mat_d := _solid_copper_mat(cop_d, 0.35)
	_add_mesh_cyl(root, Vector3(0, 0.02 * s, 0), 0.1 * s, 0.03 * s, mat_d, true)
	_add_mesh_cyl(root, Vector3(0, 0.14 * s, 0), 0.13 * s, 0.22 * s, mat_c, true)
	_add_mesh_cyl(root, Vector3(0, 0.26 * s, 0), 0.135 * s, 0.028 * s, mat_l, false)
	_add_mesh_cyl(root, Vector3(0, 0.28 * s, 0), 0.1 * s, 0.018 * s, mat_d, false)
	# Open mouth
	var mat_dark := StandardMaterial3D.new()
	mat_dark.albedo_color = Color(0.16, 0.09, 0.05)
	mat_dark.roughness = 0.9
	_add_mesh_cyl(root, Vector3(0, 0.275 * s, 0), 0.078 * s, 0.016 * s, mat_dark, false)
	# Spout + rose
	_add_mesh_box(root, Vector3(0.12 * s, 0.18 * s, 0), Vector3(0.1 * s, 0.05 * s, 0.05 * s), mat_c)
	_add_mesh_cyl_rot(root, Vector3(0.26 * s, 0.16 * s, 0), 0.04 * s, 0.24 * s, mat_c, Vector3(0, 0, PI * 0.5))
	_add_mesh_cyl_rot(root, Vector3(0.4 * s, 0.12 * s, 0), 0.032 * s, 0.1 * s, mat_d, Vector3(0, 0, PI * 0.58))
	_add_mesh_cyl(root, Vector3(0.48 * s, 0.09 * s, 0), 0.06 * s, 0.026 * s, mat_l, false)
	_add_mesh_cyl(root, Vector3(0.48 * s, 0.075 * s, 0), 0.052 * s, 0.014 * s, mat_d, false)
	for di in 5:
		var dang := float(di) * TAU / 5.0
		_add_mesh_cyl(
			root,
			Vector3(0.48 * s + cos(dang) * 0.024 * s, 0.068 * s, sin(dang) * 0.024 * s),
			0.007 * s, 0.008 * s, mat_dark, false
		)
	# C-handle
	_add_mesh_box(root, Vector3(-0.11 * s, 0.14 * s, 0), Vector3(0.035 * s, 0.05 * s, 0.04 * s), mat_d)
	_add_mesh_box(root, Vector3(-0.17 * s, 0.2 * s, 0), Vector3(0.035 * s, 0.14 * s, 0.04 * s), mat_c)
	_add_mesh_box(root, Vector3(-0.13 * s, 0.28 * s, 0), Vector3(0.09 * s, 0.035 * s, 0.04 * s), mat_l)
	# Wire bail
	_add_mesh_cyl(root, Vector3(-0.045 * s, 0.36 * s, 0), 0.011 * s, 0.12 * s, mat_d, false)
	_add_mesh_cyl(root, Vector3(0.045 * s, 0.36 * s, 0), 0.011 * s, 0.12 * s, mat_d, false)
	_add_mesh_box(root, Vector3(0, 0.43 * s, 0), Vector3(0.11 * s, 0.016 * s, 0.02 * s), mat_c)
	_add_contact_shadow(root, 0.22 * s, 0.15 * s)
	return root


static func _solid_copper_mat(color: Color, roughness: float = 0.28) -> StandardMaterial3D:
	## Smooth copper (no metal_copper.jpg grain → no basket-weave read).
	return _solid_metal(color, roughness)


static func _solid_metal(color: Color, roughness: float = 0.28) -> StandardMaterial3D:
	## Smooth untextured metal (brass/copper/iron) — no metal_*.jpg grain washout.
	var mat := StandardMaterial3D.new()
	mat.albedo_color = color
	mat.metallic = 0.82
	mat.roughness = roughness
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_PER_PIXEL
	return mat


static func _solid_matte(color: Color, roughness: float = 0.9) -> StandardMaterial3D:
	## Untextured matte albedo — bypass _mat_for (no wood/clay/stone washout).
	var mat := StandardMaterial3D.new()
	mat.albedo_color = color
	mat.metallic = 0.0
	mat.roughness = roughness
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_PER_PIXEL
	return mat


static func _add_mesh_cyl(
	parent: Node3D, pos: Vector3, radius: float, height: float, mat: Material, solid: bool
) -> void:
	var body: Node3D = StaticBody3D.new() if solid else Node3D.new()
	var mesh := CylinderMesh.new()
	mesh.top_radius = radius
	mesh.bottom_radius = radius
	mesh.height = height
	var mi := MeshInstance3D.new()
	mi.mesh = mesh
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


static func _add_mesh_cyl_rot(
	parent: Node3D, pos: Vector3, radius: float, height: float, mat: Material, euler: Vector3
) -> void:
	var body := Node3D.new()
	var mesh := CylinderMesh.new()
	mesh.top_radius = radius
	mesh.bottom_radius = radius
	mesh.height = height
	var mi := MeshInstance3D.new()
	mi.mesh = mesh
	mi.material_override = mat
	body.add_child(mi)
	body.position = pos
	body.rotation = euler
	parent.add_child(body)


static func _add_mesh_box(
	parent: Node3D, pos: Vector3, size: Vector3, mat: Material, solid: bool = false
) -> void:
	## solid=true adds StaticBody3D collision (doors / walk-blockers).
	var body: Node3D = StaticBody3D.new() if solid else Node3D.new()
	var mesh := BoxMesh.new()
	mesh.size = size
	var mi := MeshInstance3D.new()
	mi.mesh = mesh
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


static func _make_wall_sconce(prop: Dictionary) -> Node3D:
	## Loop 187: Victorian gas wall sconce — backplate + curved arm + frosted shade
	## (not thin brass L-stick mid-FOV).
	var root := Node3D.new()
	root.name = "WallSconce"
	var y: float = float(prop.get("height", 2.1))
	var ppos: Array = prop.get("pos", [0, 0, 0])
	var seed0: int = int(prop.get("seed", int(absf(
		y * 10.0 + float(prop.get("yaw", 0.0)) + float(ppos[0]) * 3.0 + float(ppos[2]) * 5.0
	))))
	var style := seed0 % 3
	var mat_br := _solid_metal(BRASS, 0.28)
	var mat_br_d := _solid_metal(BRASS.darkened(0.12), 0.32)
	var mat_br_l := _solid_metal(BRASS.lightened(0.06), 0.25)
	# Frosted amber shade (alpha + emission — never brass path)
	var mat_shade := StandardMaterial3D.new()
	mat_shade.albedo_color = Color(0.92, 0.8, 0.52, 0.5)
	mat_shade.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	mat_shade.metallic = 0.0
	mat_shade.roughness = 0.4
	mat_shade.emission_enabled = true
	mat_shade.emission = Color(1.0, 0.85, 0.5)
	mat_shade.emission_energy_multiplier = 0.7
	mat_shade.shading_mode = BaseMaterial3D.SHADING_MODE_PER_PIXEL
	# Ornate backplate (reads on wall — not a tiny brass nub)
	_add_mesh_box(root, Vector3(0, y, 0.01), Vector3(0.12, 0.2, 0.03), mat_br_d)
	_add_mesh_box(root, Vector3(0, y, 0.025), Vector3(0.08, 0.14, 0.02), mat_br)
	_add_mesh_cyl(root, Vector3(0, y + 0.08, 0.03), 0.035, 0.025, mat_br_l, false)
	_add_mesh_cyl(root, Vector3(0, y - 0.08, 0.03), 0.03, 0.02, mat_br_d, false)
	if style == 0:
		# Straight arm + inverted bell shade
		_add_mesh_box(root, Vector3(0, y, 0.12), Vector3(0.035, 0.035, 0.18), mat_br)
		_add_mesh_cyl(root, Vector3(0, y, 0.22), 0.04, 0.035, mat_br_d, false)
		_add_mesh_cyl(root, Vector3(0, y - 0.02, 0.22), 0.05, 0.02, mat_br, false)
		var shade := MeshInstance3D.new()
		var sm := CylinderMesh.new()
		sm.top_radius = 0.03
		sm.bottom_radius = 0.07
		sm.height = 0.1
		sm.radial_segments = 10
		shade.mesh = sm
		shade.material_override = mat_shade
		shade.position = Vector3(0, y - 0.08, 0.22)
		root.add_child(shade)
		_add_mesh_cyl(root, Vector3(0, y - 0.13, 0.22), 0.065, 0.012, mat_br_d, false)
		var _fl4 := StandardMaterial3D.new()
		_fl4.albedo_color = Color(1.0, 0.8, 0.4, 0.9)
		_fl4.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
		_fl4.emission_enabled = true
		_fl4.emission = Color(1.0, 0.72, 0.3)
		_fl4.emission_energy_multiplier = 1.7
		_fl4.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		_add_mesh_cyl(root, Vector3(0, y - 0.04, 0.22), 0.025, 0.0325, _fl4, false)
	elif style == 1:
		# Double-curve arm + globe
		_add_mesh_box(root, Vector3(0, y - 0.02, 0.1), Vector3(0.03, 0.03, 0.12), mat_br)
		_add_mesh_box(root, Vector3(0.02, y - 0.08, 0.16), Vector3(0.03, 0.1, 0.03), mat_br_d)
		_add_mesh_box(root, Vector3(0.02, y - 0.12, 0.2), Vector3(0.03, 0.03, 0.08), mat_br)
		_add_mesh_cyl(root, Vector3(0.02, y - 0.14, 0.24), 0.035, 0.025, mat_br_l, false)
		var globe := MeshInstance3D.new()
		var gm := SphereMesh.new()
		gm.radius = 0.06
		gm.height = 0.12
		globe.mesh = gm
		globe.material_override = mat_shade
		globe.position = Vector3(0.02, y - 0.18, 0.24)
		root.add_child(globe)
		var _fl5 := StandardMaterial3D.new()
		_fl5.albedo_color = Color(1.0, 0.8, 0.4, 0.9)
		_fl5.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
		_fl5.emission_enabled = true
		_fl5.emission = Color(1.0, 0.72, 0.3)
		_fl5.emission_energy_multiplier = 1.7
		_fl5.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		_add_mesh_cyl(root, Vector3(0.02, y - 0.16, 0.24), 0.028, 0.0364, _fl5, false)
	else:
		# Candle plate with drip pan + glass chimney
		_add_mesh_box(root, Vector3(0, y - 0.02, 0.12), Vector3(0.03, 0.03, 0.16), mat_br)
		_add_mesh_cyl(root, Vector3(0, y - 0.08, 0.2), 0.07, 0.02, mat_br_d, false)
		_add_mesh_cyl(root, Vector3(0, y - 0.06, 0.2), 0.025, 0.04, mat_br, false)
		_add_mesh_cyl(root, Vector3(0, y + 0.02, 0.2), 0.018, 0.14, _solid_matte(CANDLE, 0.7), false)
		# Slim glass chimney (alpha)
		var chim := MeshInstance3D.new()
		var cm := CylinderMesh.new()
		cm.top_radius = 0.028
		cm.bottom_radius = 0.032
		cm.height = 0.12
		chim.mesh = cm
		chim.material_override = mat_shade
		chim.position = Vector3(0, y + 0.02, 0.2)
		root.add_child(chim)
		var _fl6 := StandardMaterial3D.new()
		_fl6.albedo_color = Color(1.0, 0.8, 0.4, 0.9)
		_fl6.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
		_fl6.emission_enabled = true
		_fl6.emission = Color(1.0, 0.72, 0.3)
		_fl6.emission_energy_multiplier = 1.7
		_fl6.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		_add_mesh_cyl(root, Vector3(0, y + 0.1, 0.2), 0.022, 0.0286, _fl6, false)

	var lamp := OmniLight3D.new()
	lamp.light_color = Color(1.0, 0.86, 0.55)
	lamp.light_energy = 0.55 + float(style) * 0.05
	lamp.omni_range = 3.4 + float(style) * 0.25
	lamp.position = Vector3(0.0 if style != 1 else 0.02, y - 0.08, 0.2)
	root.add_child(lamp)
	return root


static func _make_oil_lamp(prop: Dictionary) -> Node3D:
	## Loop 198: freestanding Argand — solid-mat stem/font + amber glass (no wood/brass washout).
	var root := Node3D.new()
	root.name = "OilLamp"
	var h: float = float(prop.get("height", 1.0))
	var ppos: Array = prop.get("pos", [0, 0, 0])
	var seed0: int = int(prop.get("seed", int(absf(h * 17.0 + float(ppos[0]) * 7.0 + float(ppos[2]) * 11.0))))
	var style := seed0 % 3
	var stem_top: float = clampf(h * 0.22, 0.16, 0.26)
	var mat_wd := _solid_matte(Color(0.18, 0.09, 0.05), 0.78)
	var mat_w := _solid_matte(Color(0.3, 0.14, 0.08), 0.72)
	var mat_br := _solid_metal(Color(0.72, 0.56, 0.28), 0.3)
	var mat_br_d := _solid_metal(Color(0.55, 0.42, 0.2), 0.35)
	var mat_font := _solid_metal(Color(0.48, 0.34, 0.16), 0.4)
	var mat_font_d := _solid_metal(Color(0.38, 0.26, 0.12), 0.45)
	var mat_font_l := _solid_metal(Color(0.55, 0.4, 0.2), 0.38)
	if style == 0:
		_add_mesh_cyl(root, Vector3(0, 0.02, 0), 0.09, 0.035, mat_wd, true)
		_add_mesh_cyl(root, Vector3(0, 0.045, 0), 0.06, 0.022, mat_w, false)
		_add_mesh_cyl(root, Vector3(0, stem_top * 0.5, 0), 0.02, stem_top * 0.72, mat_w, false)
		_add_mesh_cyl(root, Vector3(0, stem_top * 0.82, 0), 0.028, 0.022, mat_br_d, false)
	elif style == 1:
		_add_mesh_cyl(root, Vector3(0, 0.025, 0), 0.05, 0.03, mat_wd, true)
		for a in [0.0, 120.0, 240.0]:
			var rad := deg_to_rad(a)
			_add_mesh_box(root, Vector3(cos(rad) * 0.08, 0.018, sin(rad) * 0.08), Vector3(0.1, 0.018, 0.028), mat_w)
			_add_mesh_cyl(root, Vector3(cos(rad) * 0.11, 0.014, sin(rad) * 0.11), 0.016, 0.022, mat_wd, false)
		_add_mesh_cyl(root, Vector3(0, stem_top * 0.5, 0), 0.019, stem_top * 0.72, mat_w, false)
		_add_mesh_cyl(root, Vector3(0, stem_top * 0.82, 0), 0.028, 0.022, mat_br_d, false)
	else:
		_add_mesh_box(root, Vector3(0, 0.02, 0), Vector3(0.13, 0.035, 0.13), mat_wd)
		_add_mesh_box(root, Vector3(0, 0.045, 0), Vector3(0.09, 0.022, 0.09), mat_w)
		_add_mesh_cyl(root, Vector3(0, stem_top * 0.5, 0), 0.018, stem_top * 0.7, mat_w, false)
		_add_mesh_cyl(root, Vector3(0, stem_top * 0.82, 0), 0.028, 0.022, mat_br_d, false)
	var fy: float = stem_top + 0.01
	_add_mesh_cyl(root, Vector3(0, fy, 0), 0.05, 0.022, mat_font_d, false)
	_add_mesh_cyl(root, Vector3(0, fy + 0.035, 0), 0.065, 0.05, mat_font, false)
	_add_mesh_cyl(root, Vector3(0, fy + 0.065, 0), 0.055, 0.018, mat_font_l, false)
	_add_mesh_cyl(root, Vector3(0.055, fy + 0.035, 0), 0.014, 0.022, mat_font_d, false)
	_add_mesh_cyl(root, Vector3(0, fy + 0.082, 0), 0.048, 0.02, mat_br, false)
	_add_mesh_cyl(root, Vector3(0, fy + 0.098, 0), 0.036, 0.014, mat_br_d, false)
	# Amber glass chimney — wider + stronger emission for mid-FOV (still alpha, not brass)
	var glass_h: float = clampf(h * 0.42, 0.32, 0.48)
	var cy: float = fy + 0.1 + glass_h * 0.5
	# Outer glass shell via solid matte emission (no _mat_for brass path)
	var mat_g := StandardMaterial3D.new()
	mat_g.albedo_color = Color(1.0, 0.82, 0.48, 0.55)
	mat_g.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	mat_g.emission_enabled = true
	mat_g.emission = Color(1.0, 0.72, 0.35)
	mat_g.emission_energy_multiplier = 1.6
	mat_g.roughness = 0.15
	mat_g.shading_mode = BaseMaterial3D.SHADING_MODE_PER_PIXEL
	_add_mesh_cyl(root, Vector3(0, cy, 0), 0.048, glass_h, mat_g, false)
	var mat_ghi := StandardMaterial3D.new()
	mat_ghi.albedo_color = Color(1.0, 0.92, 0.62, 0.35)
	mat_ghi.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	mat_ghi.emission_enabled = true
	mat_ghi.emission = Color(1.0, 0.85, 0.45)
	mat_ghi.emission_energy_multiplier = 1.9
	mat_ghi.roughness = 0.1
	_add_mesh_cyl(root, Vector3(0, cy + glass_h * 0.02, 0), 0.032, glass_h * 0.82, mat_ghi, false)
	# Chimney lip
	_add_mesh_cyl(root, Vector3(0, cy + glass_h * 0.48, 0), 0.055, 0.02, mat_g, false)
	# Two cage rods (slightly thicker for mid-FOV)
	var mat_iron := _solid_metal(Color(0.34, 0.34, 0.36), 0.5)
	for i in 2:
		var ang := float(i) * PI + 0.35
		_add_mesh_box(
			root,
			Vector3(cos(ang) * 0.048, cy, sin(ang) * 0.048),
			Vector3(0.008, glass_h * 0.72, 0.008),
			mat_iron
		)
	_add_mesh_cyl(root, Vector3(0, cy + glass_h * 0.42, 0), 0.03, 0.014, mat_iron, false)
	# Flame glow disc
	var mat_flame := StandardMaterial3D.new()
	mat_flame.albedo_color = Color(1.0, 0.88, 0.5, 0.7)
	mat_flame.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	mat_flame.emission_enabled = true
	mat_flame.emission = Color(1.0, 0.8, 0.4)
	mat_flame.emission_energy_multiplier = 2.2
	mat_flame.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	_add_mesh_cyl(root, Vector3(0, fy + 0.12, 0), 0.022, 0.03, mat_flame, false)
	var light := OmniLight3D.new()
	light.light_color = Color(1.0, 0.86, 0.58)
	light.light_energy = 0.85 + float(style) * 0.06
	light.omni_range = 3.8 + float(style) * 0.2
	light.position = Vector3(0, cy, 0)
	root.add_child(light)
	_add_contact_shadow(root, 0.1, 0.1)
	return root


static func _make_wall_vine(prop: Dictionary) -> Node3D:
	## Loop 205: climbing ivy — solid-mat stems + leaf blobs (no wood washout).
	var root := Node3D.new()
	root.name = "WallVine"
	var height: float = float(prop.get("height", 1.8))
	var width: float = float(prop.get("width", 1.4))
	var mat_stem := _solid_matte(Color(0.18, 0.26, 0.1), 0.92)
	var mat_a := _solid_matte(Color(0.2, 0.4, 0.16), 0.9)
	var mat_b := _solid_matte(Color(0.14, 0.32, 0.1), 0.9)
	var mat_c := _solid_matte(Color(0.26, 0.46, 0.18), 0.9)
	for i in 6:
		var x := -width * 0.4 + float(i) * (width * 0.16)
		var sh := height * (0.45 + float(i % 3) * 0.12)
		_add_mesh_cyl(root, Vector3(x, 0.25 + sh * 0.5, 0.01), 0.008, sh, mat_stem, false)
	for j in 28:
		var t := float(j)
		var fx := -width * 0.42 + fmod(t * 0.29, width * 0.84)
		var fy := 0.2 + fmod(t * 0.41, height * 0.85)
		var fz := 0.04 + float(j % 3) * 0.02
		var r := 0.07 + float(j % 4) * 0.015
		var mat_leaf := mat_a if j % 3 == 0 else (mat_b if j % 3 == 1 else mat_c)
		# Compact leaf pads (mesh cyl discs — not foliage path)
		_add_mesh_cyl(root, Vector3(fx, fy, fz), r, r * 0.55, mat_leaf, false)
	_add_mesh_cyl(root, Vector3(0, 0.25, 0.08), 0.18, 0.12, mat_b, false)
	_add_mesh_cyl(root, Vector3(-0.2, 0.2, 0.07), 0.14, 0.1, mat_a, false)
	_add_mesh_cyl(root, Vector3(0.22, 0.22, 0.07), 0.15, 0.1, mat_c, false)
	return root


static func _make_wall_shelf(prop: Dictionary) -> Node3D:
	## Loop 189: oak plate rail + triangle brackets (not stick lumber + black posts mid-FOV).
	## Loop 211: denser still-life — larger plates/crocks/jugs so rails aren't bare sticks mid-FOV.
	var root := Node3D.new()
	root.name = "WallShelf"
	var width: float = float(prop.get("width", 2.4))
	var y: float = float(prop.get("shelf_y", 1.85))
	var seed0: int = int(prop.get("seed", 0))
	var mat_oak := _solid_matte(Color(0.46, 0.32, 0.18), 0.78)
	var mat_oak_d := _solid_matte(Color(0.34, 0.22, 0.12), 0.82)
	var mat_oak_l := _solid_matte(Color(0.54, 0.4, 0.24), 0.75)
	var mat_iron := _solid_metal(Color(0.32, 0.32, 0.34), 0.5)
	var mat_cream := _solid_matte(Color(0.84, 0.78, 0.66), 0.88)
	var mat_cream_d := _solid_matte(Color(0.74, 0.68, 0.56), 0.88)
	var mat_blue := _solid_matte(Color(0.42, 0.52, 0.62), 0.85)
	var mat_blue_d := _solid_matte(Color(0.32, 0.4, 0.5), 0.85)
	var mat_clay := _solid_matte(Color(0.72, 0.46, 0.28), 0.9)
	var mat_clay_d := _solid_matte(Color(0.58, 0.36, 0.22), 0.9)
	var mat_clay_l := _solid_matte(Color(0.78, 0.52, 0.32), 0.88)
	var mat_cop := _solid_metal(Color(0.7, 0.42, 0.18), 0.32)
	var mat_cop_d := _solid_metal(Color(0.58, 0.34, 0.14), 0.36)
	var mat_cop_l := _solid_metal(Color(0.78, 0.5, 0.24), 0.28)
	var mat_pewter := _solid_metal(Color(0.55, 0.55, 0.58), 0.4)
	# Back wall plate (shelf mounts into wall — not free stick)
	_add_mesh_box(root, Vector3(0, y + 0.02, -0.04), Vector3(width * 0.98, 0.14, 0.035), mat_oak_d)
	# Main shelf board + front bead lip (slightly deeper for ware)
	_add_mesh_box(root, Vector3(0, y, 0.07), Vector3(width, 0.05, 0.2), mat_oak)
	_add_mesh_box(root, Vector3(0, y + 0.032, 0.155), Vector3(width * 0.98, 0.03, 0.032), mat_oak_l)
	# Under-rail (plate groove look)
	_add_mesh_box(root, Vector3(0, y - 0.03, 0.02), Vector3(width * 0.92, 0.022, 0.045), mat_oak_d)
	# Triangle wood brackets + iron L (not hanging black posts)
	var bracket_xs: Array = [-width * 0.38, width * 0.38]
	if width > 1.6:
		bracket_xs = [-width * 0.4, 0.0, width * 0.4]
	for sx in bracket_xs:
		_add_mesh_box(root, Vector3(sx, y - 0.1, -0.02), Vector3(0.05, 0.22, 0.035), mat_oak_d)
		_add_mesh_box(root, Vector3(sx, y - 0.04, 0.06), Vector3(0.05, 0.035, 0.16), mat_oak)
		_add_mesh_box(root, Vector3(sx, y - 0.12, 0.05), Vector3(0.04, 0.04, 0.14), mat_oak_d)
		_add_mesh_box(root, Vector3(sx, y - 0.02, -0.01), Vector3(0.035, 0.06, 0.05), mat_iron)
		_add_mesh_box(root, Vector3(sx, y - 0.18, -0.02), Vector3(0.04, 0.03, 0.03), mat_iron)
	# End returns
	_add_mesh_box(root, Vector3(-width * 0.48, y, 0.05), Vector3(0.045, 0.07, 0.16), mat_oak_d)
	_add_mesh_box(root, Vector3(width * 0.48, y, 0.05), Vector3(0.045, 0.07, 0.16), mat_oak_d)
	# Loop 211: denser packing + larger ware (was width/0.38 → sparse nubs mid-FOV)
	var n := int(clampf(width / 0.26, 4.0, 10.0))
	for i in n:
		var x := -width * 0.4 + float(i) * (width * 0.8 / float(maxi(n - 1, 1)))
		var kind := (i + seed0 * 3) % 6
		match kind:
			0:
				# Stack of 3 dinner plates (readable disc mass)
				var pr: float = 0.095 + float(i % 2) * 0.012
				var pmat := mat_cream if (i + seed0) % 2 == 0 else mat_cream_d
				_add_mesh_cyl(root, Vector3(x, y + 0.035, 0.06), pr, 0.016, pmat, false)
				_add_mesh_cyl(root, Vector3(x, y + 0.055, 0.06), pr * 0.92, 0.014, mat_cream_d, false)
				_add_mesh_cyl(root, Vector3(x, y + 0.072, 0.06), pr * 0.85, 0.014, pmat, false)
				# Rim lip
				_add_mesh_cyl(root, Vector3(x, y + 0.08, 0.06), pr * 0.95, 0.008, mat_cream, false)
			1:
				# Edge-on plate leaning against wall (silhouette from walk)
				var er: float = 0.1
				var emat := mat_blue if (i + seed0) % 3 == 0 else mat_cream
				_add_mesh_cyl_rot(root, Vector3(x, y + 0.1, 0.02), er, 0.018, emat, Vector3(PI * 0.5, 0.15, 0))
				_add_mesh_cyl_rot(root, Vector3(x + 0.04, y + 0.09, 0.04), er * 0.85, 0.014, mat_cream_d, Vector3(PI * 0.5, -0.2, 0))
			2:
				# Lidded crock with glaze band
				var ch: float = 0.12 + float((i + seed0) % 3) * 0.02
				var cr: float = 0.055 + float(i % 2) * 0.01
				var cmat := mat_clay if i % 2 == 0 else mat_clay_d
				_add_mesh_cyl(root, Vector3(x, y + ch * 0.45, 0.055), cr, ch, cmat, false)
				_add_mesh_cyl(root, Vector3(x, y + ch * 0.55, 0.055), cr + 0.008, 0.018, mat_blue_d if (i + seed0) % 2 == 0 else mat_clay_l, false)
				_add_mesh_cyl(root, Vector3(x, y + ch + 0.02, 0.055), cr * 0.85, 0.03, mat_clay_d, false)
				_add_mesh_cyl(root, Vector3(x, y + ch + 0.04, 0.055), cr * 0.45, 0.02, mat_clay_l, false)
			3:
				# Copper basin / skillet
				var cr: float = 0.07 + float((i + seed0) % 3) * 0.012
				var cmat := mat_cop if i % 2 == 0 else mat_cop_d
				_add_mesh_cyl(root, Vector3(x, y + 0.04, 0.06), cr * 0.7, 0.016, mat_cop_d, false)
				_add_mesh_cyl(root, Vector3(x, y + 0.075, 0.06), cr, 0.06, cmat, false)
				_add_mesh_cyl(root, Vector3(x, y + 0.11, 0.06), cr + 0.014, 0.016, mat_cop_l, false)
				_add_mesh_box(root, Vector3(x + cr * 0.9, y + 0.075, 0.06), Vector3(0.055, 0.028, 0.03), cmat)
			4:
				# Cream jug with handle + spout mass
				_add_mesh_cyl(root, Vector3(x, y + 0.08, 0.055), 0.045, 0.12, mat_cream_d, false)
				_add_mesh_cyl(root, Vector3(x, y + 0.15, 0.055), 0.035, 0.04, mat_cream, false)
				_add_mesh_cyl(root, Vector3(x, y + 0.05, 0.055), 0.05, 0.025, mat_cream, false)
				_add_mesh_box(root, Vector3(x + 0.05, y + 0.09, 0.055), Vector3(0.035, 0.06, 0.025), mat_cream_d)
				_add_mesh_box(root, Vector3(x - 0.04, y + 0.14, 0.055), Vector3(0.04, 0.02, 0.03), mat_cream)
			_:
				# Pewter tankard or blue-band jar
				if (i + seed0) % 2 == 0:
					_add_mesh_cyl(root, Vector3(x, y + 0.07, 0.055), 0.042, 0.1, mat_pewter, false)
					_add_mesh_cyl(root, Vector3(x, y + 0.13, 0.055), 0.045, 0.02, mat_pewter, false)
					_add_mesh_box(root, Vector3(x + 0.05, y + 0.08, 0.055), Vector3(0.03, 0.05, 0.022), mat_pewter)
				else:
					_add_mesh_cyl(root, Vector3(x, y + 0.07, 0.055), 0.048, 0.1, mat_cream, false)
					_add_mesh_cyl(root, Vector3(x, y + 0.08, 0.055), 0.052, 0.02, mat_blue, false)
					_add_mesh_cyl(root, Vector3(x, y + 0.13, 0.055), 0.04, 0.025, mat_cream_d, false)
	# Secondary front row of small saucers (fills empty rail gaps)
	var n2 := int(clampf(width / 0.35, 2.0, 6.0))
	for j in n2:
		var x2 := -width * 0.32 + float(j) * (width * 0.64 / float(maxi(n2 - 1, 1))) + float(seed0 % 3) * 0.02
		_add_mesh_cyl(root, Vector3(x2, y + 0.03, 0.11), 0.055, 0.012, mat_cream_d if j % 2 == 0 else mat_cream, false)
	return root


static func _make_pot_rack(prop: Dictionary) -> Node3D:
	## Loop 188: iron pot rail — wall brackets + S-hooks + copper pans
	## (not stick lumber T-frame mid-FOV).
	var root := Node3D.new()
	root.name = "PotRack"
	var seed0: int = int(prop.get("seed", 0))
	var mat_iron := _solid_metal(Color(0.28, 0.28, 0.3), 0.5)
	var mat_iron_d := _solid_metal(Color(0.2, 0.2, 0.22), 0.55)
	var mat_wood := _solid_matte(Color(0.32, 0.2, 0.1), 0.75)
	# Twin iron rails (horizontal) — kitchen rack identity
	_add_mesh_box(root, Vector3(0, 2.15, 0.02), Vector3(2.0, 0.04, 0.05), mat_iron)
	_add_mesh_box(root, Vector3(0, 1.95, 0.02), Vector3(2.0, 0.035, 0.045), mat_iron_d)
	# Wall brackets (oak plate + iron strut) — not free stick posts
	for sx in [-0.9, 0.9]:
		_add_mesh_box(root, Vector3(sx, 2.05, -0.04), Vector3(0.1, 0.35, 0.04), mat_wood)
		_add_mesh_box(root, Vector3(sx, 2.05, 0.06), Vector3(0.05, 0.06, 0.18), mat_iron)
		_add_mesh_box(root, Vector3(sx, 1.95, 0.12), Vector3(0.04, 0.2, 0.04), mat_iron_d)
	# End caps on rails
	_add_mesh_cyl(root, Vector3(-1.0, 2.15, 0.02), 0.03, 0.05, mat_iron, false)
	_add_mesh_cyl(root, Vector3(1.0, 2.15, 0.02), 0.03, 0.05, mat_iron, false)
	_add_mesh_cyl(root, Vector3(-1.0, 1.95, 0.02), 0.025, 0.04, mat_iron_d, false)
	_add_mesh_cyl(root, Vector3(1.0, 1.95, 0.02), 0.025, 0.04, mat_iron_d, false)
	# 5 hangers: S-hooks + copper pans (solid metal)
	for i in 5:
		var x := -0.7 + float(i) * 0.35
		# S-hook from upper rail
		_add_mesh_cyl(root, Vector3(x, 2.05, 0.08), 0.012, 0.16, mat_iron, false)
		_add_mesh_box(root, Vector3(x, 1.95, 0.12), Vector3(0.035, 0.02, 0.05), mat_iron_d)
		var pr: float = 0.11 + float((i * 3 + seed0) % 5) * 0.02
		var pcols: Array = [
			Color(0.72, 0.42, 0.18),
			Color(0.62, 0.36, 0.15),
			Color(0.78, 0.48, 0.22),
			Color(0.55, 0.32, 0.16),
			Color(0.68, 0.5, 0.22),
		]
		var pcol: Color = pcols[(i + seed0) % 5]
		var mat_c := _solid_metal(pcol, 0.32)
		var mat_cd := _solid_metal(pcol.darkened(0.1), 0.36)
		var mat_cl := _solid_metal(pcol.lightened(0.08), 0.28)
		var shape := (i + seed0) % 4
		if shape == 0:
			# Skillet
			_add_mesh_cyl(root, Vector3(x, 1.72, 0.14), pr * 0.9, 0.02, mat_cd, false)
			_add_mesh_cyl(root, Vector3(x, 1.76, 0.14), pr, 0.055, mat_c, false)
			_add_mesh_cyl(root, Vector3(x, 1.8, 0.14), pr + 0.015, 0.018, mat_cl, false)
			_add_mesh_box(root, Vector3(x + pr * 0.95, 1.76, 0.14), Vector3(0.16, 0.022, 0.035), mat_cd)
		elif shape == 1:
			# Deep saute
			_add_mesh_cyl(root, Vector3(x, 1.7, 0.14), pr * 0.85, 0.018, mat_cd, false)
			_add_mesh_cyl(root, Vector3(x, 1.76, 0.14), pr * 1.02, 0.1, mat_c, false)
			_add_mesh_cyl(root, Vector3(x, 1.82, 0.14), pr * 1.08, 0.018, mat_cl, false)
			_add_mesh_box(root, Vector3(x + pr * 0.95, 1.76, 0.14), Vector3(0.12, 0.028, 0.035), mat_c)
		elif shape == 2:
			# Covered pot
			_add_mesh_cyl(root, Vector3(x, 1.68, 0.14), pr * 0.65, 0.018, mat_cd, false)
			_add_mesh_cyl(root, Vector3(x, 1.76, 0.14), pr * 0.85, 0.13, mat_c, false)
			_add_mesh_cyl(root, Vector3(x, 1.84, 0.14), pr * 0.9, 0.022, mat_cl, false)
			_add_mesh_cyl(root, Vector3(x, 1.88, 0.14), 0.035, 0.035, _solid_metal(BRASS, 0.3), false)
		else:
			# Ladle
			_add_mesh_cyl(root, Vector3(x, 1.8, 0.12), 0.012, 0.35, mat_iron, false)
			_add_mesh_cyl(root, Vector3(x, 1.58, 0.16), 0.055, 0.018, mat_cd, false)
			_add_mesh_cyl(root, Vector3(x, 1.62, 0.16), 0.065, 0.055, mat_c, false)
			_add_mesh_box(root, Vector3(x, 1.98, 0.1), Vector3(0.03, 0.04, 0.05), _solid_matte(OAK, 0.7))
	return root


static func _make_copper_pot(prop: Dictionary) -> Node3D:
	## Loop 202: solid-metal copper vessels (no metal_copper.jpg washout mid-FOV).
	var root := Node3D.new()
	root.name = "CopperPot"
	var scale: float = prop.get("scale", 1.0)
	var seed0: int = int(prop.get("seed", 0))
	var style := seed0 % 5
	var col := COPPER if style % 2 == 0 else COPPER.darkened(0.08)
	var mat_c := _solid_metal(col, 0.32)
	var mat_cd := _solid_metal(col.darkened(0.08), 0.36)
	var mat_cl := _solid_metal(col.lightened(0.06), 0.28)
	var mat_br := _solid_metal(BRASS.darkened(0.1), 0.32)
	var mat_br_l := _solid_metal(BRASS, 0.28)
	var mat_iron := _solid_metal(Color(0.42, 0.42, 0.44), 0.48)
	var mat_soot := _solid_matte(Color(0.14, 0.1, 0.08), 0.9)
	if style == 0:
		_add_mesh_cyl(root, Vector3(0, 0.06 * scale, 0), 0.11 * scale, 0.08 * scale, mat_cd, true)
		_add_mesh_cyl(root, Vector3(0, 0.14 * scale, 0), 0.15 * scale, 0.12 * scale, mat_c, true)
		_add_mesh_cyl(root, Vector3(0, 0.22 * scale, 0), 0.13 * scale, 0.08 * scale, mat_cl, true)
		_add_mesh_cyl(root, Vector3(0, 0.28 * scale, 0), 0.14 * scale, 0.03 * scale, mat_cl, false)
		_add_mesh_cyl(root, Vector3(0, 0.3 * scale, 0), 0.09 * scale, 0.025 * scale, mat_soot, false)
		_add_mesh_box(root, Vector3(0.15 * scale, 0.2 * scale, 0), Vector3(0.03 * scale, 0.12 * scale, 0.03 * scale), mat_c)
		_add_mesh_box(root, Vector3(-0.15 * scale, 0.2 * scale, 0), Vector3(0.03 * scale, 0.12 * scale, 0.03 * scale), mat_c)
		_add_mesh_box(root, Vector3(0, 0.32 * scale, 0), Vector3(0.32 * scale, 0.02 * scale, 0.025 * scale), mat_br)
		_add_mesh_box(root, Vector3(0.14 * scale, 0.16 * scale, 0), Vector3(0.08 * scale, 0.04 * scale, 0.06 * scale), mat_cd)
	elif style == 1:
		_add_mesh_cyl(root, Vector3(0, 0.05 * scale, 0), 0.16 * scale, 0.06 * scale, mat_cd, true)
		_add_mesh_cyl(root, Vector3(0, 0.1 * scale, 0), 0.19 * scale, 0.08 * scale, mat_cl, true)
		_add_mesh_cyl(root, Vector3(0, 0.15 * scale, 0), 0.2 * scale, 0.03 * scale, mat_c, false)
		_add_mesh_box(root, Vector3(0.24 * scale, 0.11 * scale, 0), Vector3(0.22 * scale, 0.028 * scale, 0.05 * scale), mat_c)
		_add_mesh_cyl(root, Vector3(0.36 * scale, 0.11 * scale, 0), 0.025 * scale, 0.04 * scale, mat_cd, false)
		_add_mesh_box(root, Vector3(-0.18 * scale, 0.12 * scale, 0), Vector3(0.06 * scale, 0.04 * scale, 0.05 * scale), mat_c)
	elif style == 2:
		_add_mesh_cyl(root, Vector3(0, 0.08 * scale, 0), 0.11 * scale, 0.1 * scale, mat_cd, true)
		_add_mesh_cyl(root, Vector3(0, 0.2 * scale, 0), 0.13 * scale, 0.18 * scale, mat_c, true)
		_add_mesh_cyl(root, Vector3(0, 0.32 * scale, 0), 0.12 * scale, 0.08 * scale, mat_cl, true)
		_add_mesh_cyl(root, Vector3(0, 0.38 * scale, 0), 0.135 * scale, 0.03 * scale, mat_cl, false)
		_add_mesh_cyl(root, Vector3(0, 0.42 * scale, 0), 0.05 * scale, 0.04 * scale, mat_br_l, false)
		_add_mesh_box(root, Vector3(0.14 * scale, 0.24 * scale, 0), Vector3(0.04 * scale, 0.1 * scale, 0.08 * scale), mat_c)
		_add_mesh_box(root, Vector3(-0.14 * scale, 0.24 * scale, 0), Vector3(0.04 * scale, 0.1 * scale, 0.08 * scale), mat_c)
	elif style == 3:
		_add_mesh_cyl(root, Vector3(0, 0.08 * scale, 0), 0.08 * scale, 0.08 * scale, mat_cd, true)
		_add_mesh_cyl(root, Vector3(0, 0.16 * scale, 0), 0.12 * scale, 0.12 * scale, mat_cl, true)
		_add_mesh_cyl(root, Vector3(0, 0.26 * scale, 0), 0.07 * scale, 0.1 * scale, mat_c, true)
		_add_mesh_cyl(root, Vector3(0, 0.32 * scale, 0), 0.06 * scale, 0.04 * scale, mat_cl, false)
		_add_mesh_box(root, Vector3(0.12 * scale, 0.24 * scale, 0), Vector3(0.12 * scale, 0.035 * scale, 0.05 * scale), mat_c)
		_add_mesh_box(root, Vector3(-0.1 * scale, 0.2 * scale, 0), Vector3(0.04 * scale, 0.14 * scale, 0.03 * scale), mat_cd)
		_add_mesh_box(root, Vector3(-0.08 * scale, 0.3 * scale, 0), Vector3(0.1 * scale, 0.025 * scale, 0.03 * scale), mat_cd)
	else:
		_add_mesh_cyl(root, Vector3(0, 0.08 * scale, 0), 0.12 * scale, 0.1 * scale, mat_cd, true)
		_add_mesh_cyl(root, Vector3(0, 0.18 * scale, 0), 0.16 * scale, 0.14 * scale, mat_c, true)
		_add_mesh_cyl(root, Vector3(0, 0.26 * scale, 0), 0.17 * scale, 0.03 * scale, mat_iron, false)
		_add_mesh_box(root, Vector3(0, 0.34 * scale, 0), Vector3(0.025 * scale, 0.14 * scale, 0.3 * scale), mat_iron)
		_add_mesh_box(root, Vector3(0.1 * scale, 0.14 * scale, 0.1 * scale), Vector3(0.06 * scale, 0.04 * scale, 0.06 * scale), mat_soot)
	_add_contact_shadow(root, 0.2 * scale, 0.2 * scale)
	return root


static func _make_copper_scrap(prop: Dictionary) -> Node3D:
	## Loop 203: Rooke scrap heap — solid-mat wood tray + solid-metal copper/iron (no washout).
	var root := Node3D.new()
	root.name = "CopperScrap"
	var s: float = float(prop.get("scale", 1.0))
	var seed0: int = int(prop.get("seed", 0))
	var style := seed0 % 3
	var mat_cu := _solid_metal(COPPER.lightened(0.08), 0.3)
	var mat_cu_d := _solid_metal(COPPER.darkened(0.04), 0.34)
	var mat_cu_hi := _solid_metal(COPPER.lightened(0.16), 0.28)
	var mat_iron := _solid_metal(Color(0.38, 0.38, 0.4), 0.48)
	var mat_iron_l := _solid_metal(Color(0.46, 0.46, 0.48), 0.45)
	var mat_br := _solid_metal(BRASS.lightened(0.05), 0.28)
	var mat_oak := _solid_matte(Color(0.48, 0.34, 0.18), 0.78)
	var mat_oak_d := _solid_matte(Color(0.36, 0.24, 0.12), 0.82)
	var mat_oak_l := _solid_matte(Color(0.56, 0.42, 0.26), 0.75)
	_add_mesh_box(root, Vector3(0, 0.03 * s, 0), Vector3(0.58 * s, 0.05 * s, 0.42 * s), mat_oak_d)
	_add_mesh_box(root, Vector3(0, 0.055 * s, 0), Vector3(0.52 * s, 0.015 * s, 0.36 * s), mat_oak_l)
	if style == 0:
		_add_mesh_cyl(root, Vector3(-0.06 * s, 0.14 * s, 0.0), 0.14 * s, 0.025 * s, mat_oak, false)
		_add_mesh_cyl(root, Vector3(-0.06 * s, 0.28 * s, 0.0), 0.14 * s, 0.025 * s, mat_oak, false)
		_add_mesh_cyl(root, Vector3(-0.06 * s, 0.21 * s, 0.0), 0.09 * s, 0.12 * s, mat_cu_d, false)
		for wi in 6:
			var wa := float(wi) * TAU / 6.0
			_add_mesh_box(root, Vector3(-0.06 * s + cos(wa) * 0.09 * s, 0.21 * s, sin(wa) * 0.09 * s), Vector3(0.02 * s, 0.1 * s, 0.03 * s), mat_cu_hi)
		_add_mesh_cyl(root, Vector3(-0.06 * s, 0.21 * s, 0.0), 0.02 * s, 0.2 * s, mat_iron, false)
		_add_mesh_box(root, Vector3(0.1 * s, 0.21 * s, 0.0), Vector3(0.08 * s, 0.025 * s, 0.025 * s), mat_iron)
		_add_mesh_box(root, Vector3(0.14 * s, 0.28 * s, 0.0), Vector3(0.025 * s, 0.12 * s, 0.025 * s), mat_iron_l)
		_add_mesh_box(root, Vector3(0.16 * s, 0.09 * s, -0.08 * s), Vector3(0.16 * s, 0.02 * s, 0.12 * s), mat_cu_hi)
		_add_mesh_cyl(root, Vector3(0.18 * s, 0.1 * s, 0.1 * s), 0.015 * s, 0.22 * s, mat_cu, false)
		_add_mesh_box(root, Vector3(0.05 * s, 0.08 * s, 0.14 * s), Vector3(0.06 * s, 0.04 * s, 0.05 * s), mat_cu_d)
	elif style == 1:
		for i in 4:
			var py := (0.07 + float(i) * 0.028) * s
			var pw := (0.3 - float(i) * 0.02) * s
			var mat_pl := _solid_metal(COPPER.darkened(float(i) * 0.03), 0.32)
			_add_mesh_box(root, Vector3(-0.06 * s, py, 0.0), Vector3(pw, 0.018 * s, 0.24 * s), mat_pl)
			_add_mesh_box(root, Vector3(-0.06 * s + pw * 0.45, py, 0.0), Vector3(0.015 * s, 0.03 * s, 0.22 * s), mat_cu_hi)
		_add_mesh_cyl(root, Vector3(0.18 * s, 0.14 * s, 0.06 * s), 0.022 * s, 0.32 * s, mat_cu_hi, false)
		_add_mesh_box(root, Vector3(0.18 * s, 0.14 * s, 0.18 * s), Vector3(0.04 * s, 0.04 * s, 0.08 * s), mat_cu_d)
		_add_mesh_cyl(root, Vector3(0.1 * s, 0.12 * s, -0.12 * s), 0.018 * s, 0.2 * s, mat_br, false)
		_add_mesh_box(root, Vector3(0.0, 0.16 * s, 0.12 * s), Vector3(0.14 * s, 0.04 * s, 0.08 * s), mat_iron_l)
	else:
		for i in 5:
			var ox := (-0.14 + float(i) * 0.07) * s
			var oz := (-0.06 + float(i % 3) * 0.04) * s
			var mat_t := _solid_metal(COPPER.darkened(float(i % 3) * 0.03), 0.32)
			_add_mesh_cyl(root, Vector3(ox, 0.1 * s, oz), 0.018 * s, 0.36 * s, mat_t, false)
		_add_mesh_cyl(root, Vector3(0.05 * s, 0.16 * s, 0.02 * s), 0.02 * s, 0.28 * s, mat_cu_hi, false)
		_add_mesh_box(root, Vector3(0.0, 0.2 * s, 0.0), Vector3(0.38 * s, 0.03 * s, 0.06 * s), mat_iron)
		_add_mesh_box(root, Vector3(0.0, 0.2 * s, 0.0), Vector3(0.06 * s, 0.03 * s, 0.28 * s), mat_iron_l)
		_add_mesh_box(root, Vector3(0.16 * s, 0.09 * s, 0.12 * s), Vector3(0.1 * s, 0.035 * s, 0.08 * s), mat_cu_d)
		_add_mesh_box(root, Vector3(-0.16 * s, 0.09 * s, 0.12 * s), Vector3(0.1 * s, 0.04 * s, 0.08 * s), mat_br)
	_add_contact_shadow(root, 0.32 * s, 0.24 * s)
	return root


# ─── Workshop ────────────────────────────────────────────────────────────────

static func _make_workbench(prop: Dictionary) -> Node3D:
	## Loop 195: Rooke bench — solid-mat scrubbed top + mahogany base + tools (no washout).
	var root := Node3D.new()
	root.name = "Workbench"
	var width: float = prop.get("width", 2.8)
	var seed0: int = int(prop.get("seed", int(width * 10.0)))
	var mat_top := _solid_matte(Color(0.62, 0.5, 0.32), 0.82)
	var mat_top_d := _solid_matte(Color(0.5, 0.38, 0.22), 0.85)
	var mat_base := _solid_matte(Color(0.32, 0.16, 0.09), 0.78)
	var mat_base_d := _solid_matte(Color(0.2, 0.1, 0.06), 0.82)
	var mat_br := _solid_metal(Color(0.72, 0.56, 0.28), 0.3)
	var mat_br_d := _solid_metal(Color(0.55, 0.42, 0.2), 0.35)
	var mat_iron := _solid_metal(Color(0.36, 0.36, 0.38), 0.48)
	var mat_iron_l := _solid_metal(Color(0.46, 0.46, 0.48), 0.45)
	var mat_iron_d := _solid_metal(Color(0.28, 0.28, 0.3), 0.52)
	var mat_cop := _solid_metal(Color(0.7, 0.42, 0.18), 0.32)
	var mat_cop_d := _solid_metal(Color(0.58, 0.34, 0.14), 0.36)
	var mat_oak := _solid_matte(Color(0.5, 0.38, 0.22), 0.8)
	var mat_oak_d := _solid_matte(Color(0.38, 0.26, 0.14), 0.84)
	var mat_paper := _solid_matte(Color(0.84, 0.78, 0.62), 0.92)
	var mat_paper_d := _solid_matte(Color(0.76, 0.7, 0.54), 0.92)
	var mat_wood_h := _solid_matte(Color(0.4, 0.26, 0.14), 0.8)
	var mat_cream := _solid_matte(Color(0.9, 0.86, 0.76), 0.9)
	_add_mesh_box(root, Vector3(0, 0.86, 0), Vector3(width, 0.09, 0.95), mat_top)
	_add_mesh_box(root, Vector3(0, 0.8, 0), Vector3(width - 0.04, 0.05, 0.9), mat_top_d)
	_add_mesh_box(root, Vector3(0, 0.91, 0.46), Vector3(width * 0.98, 0.03, 0.04), mat_top_d)
	for lx in [-width * 0.38, width * 0.38]:
		_add_mesh_box(root, Vector3(lx, 0.4, 0), Vector3(0.12, 0.8, 0.85), mat_base)
		_add_mesh_box(root, Vector3(lx, 0.04, 0), Vector3(0.16, 0.08, 0.9), mat_base_d)
	_add_mesh_box(root, Vector3(0, 0.38, 0), Vector3(width * 0.72, 0.08, 0.78), mat_base_d)
	_add_mesh_box(root, Vector3(-width * 0.2, 0.35, 0.35), Vector3(width * 0.28, 0.22, 0.12), mat_base)
	_add_mesh_box(root, Vector3(width * 0.2, 0.35, 0.35), Vector3(width * 0.28, 0.22, 0.12), mat_base)
	_add_mesh_cyl(root, Vector3(-width * 0.2, 0.35, 0.42), 0.02, 0.06, mat_br, false)
	_add_mesh_cyl(root, Vector3(width * 0.2, 0.35, 0.42), 0.02, 0.06, mat_br, false)
	var dress := seed0 % 3
	if dress == 0:
		_add_mesh_box(root, Vector3(-0.45, 0.93, 0.12), Vector3(0.32, 0.035, 0.22), mat_br_d)
		_add_mesh_box(root, Vector3(0.05, 0.935, 0.28), Vector3(0.7, 0.02, 0.05), mat_iron)
		for ti in 6:
			_add_mesh_box(root, Vector3(-0.25 + float(ti) * 0.1, 0.945, 0.3), Vector3(0.01, 0.015, 0.03), mat_iron_d)
		_add_mesh_box(root, Vector3(-0.15, 0.95, 0.15), Vector3(0.06, 0.03, 0.2), mat_iron_l)
		_add_mesh_box(root, Vector3(-0.05, 0.95, 0.05), Vector3(0.18, 0.03, 0.05), mat_iron)
		_add_mesh_box(root, Vector3(0.35, 0.94, 0.05), Vector3(0.42, 0.025, 0.06), mat_iron)
		_add_mesh_box(root, Vector3(0.5, 0.95, 0.05), Vector3(0.08, 0.035, 0.05), mat_wood_h)
		_add_mesh_box(root, Vector3(0.25, 0.94, -0.2), Vector3(0.38, 0.022, 0.05), mat_iron_d)
		_add_mesh_box(root, Vector3(0.4, 0.95, -0.2), Vector3(0.07, 0.03, 0.045), mat_wood_h)
		_add_mesh_cyl(root, Vector3(0.75, 0.95, 0.15), 0.045, 0.035, mat_br_d, false)
		_add_mesh_cyl(root, Vector3(0.75, 1.0, 0.15), 0.065, 0.09, mat_br, false)
		_add_mesh_box(root, Vector3(0.85, 1.02, 0.15), Vector3(0.09, 0.022, 0.025), mat_br_d)
		_add_mesh_box(root, Vector3(-0.7, 0.94, -0.15), Vector3(0.35, 0.04, 0.08), mat_oak)
		_add_mesh_box(root, Vector3(-0.55, 0.96, -0.22), Vector3(0.2, 0.035, 0.06), mat_oak_d)
		_add_mesh_box(root, Vector3(0.1, 0.93, -0.25), Vector3(0.25, 0.02, 0.16), mat_paper)
		_add_mesh_cyl(root, Vector3(-0.75, 0.95, 0.2), 0.055, 0.025, mat_cop_d, false)
		_add_mesh_cyl(root, Vector3(-0.75, 0.98, 0.2), 0.07, 0.05, mat_cop, false)
	elif dress == 1:
		_add_mesh_box(root, Vector3(0.25, 0.92, -0.12), Vector3(0.5, 0.025, 0.34), mat_paper)
		_add_mesh_box(root, Vector3(0.3, 0.94, -0.1), Vector3(0.35, 0.01, 0.24), mat_paper_d)
		_add_mesh_box(root, Vector3(0.28, 0.95, -0.06), Vector3(0.2, 0.008, 0.14), mat_paper_d)
		_add_mesh_box(root, Vector3(-0.55, 0.94, 0.12), Vector3(0.55, 0.03, 0.07), mat_iron)
		_add_mesh_box(root, Vector3(-0.25, 0.95, 0.18), Vector3(0.1, 0.05, 0.14), mat_iron_l)
		_add_mesh_box(root, Vector3(-0.22, 0.95, 0.22), Vector3(0.05, 0.04, 0.08), mat_iron_d)
		_add_mesh_box(root, Vector3(0.65, 0.98, 0.05), Vector3(0.06, 0.14, 0.12), mat_iron)
		_add_mesh_box(root, Vector3(0.65, 0.93, 0.12), Vector3(0.14, 0.04, 0.05), mat_iron_l)
		_add_mesh_box(root, Vector3(0.65, 1.05, 0.12), Vector3(0.14, 0.035, 0.05), mat_iron)
		_add_mesh_cyl(root, Vector3(0.72, 0.99, 0.12), 0.015, 0.12, mat_iron_d, false)
		_add_mesh_cyl(root, Vector3(0.72, 1.08, 0.12), 0.03, 0.025, mat_br_d, false)
		_add_mesh_cyl(root, Vector3(0.55, 0.96, 0.25), 0.022, 0.32, mat_cop, false)
		_add_mesh_cyl(root, Vector3(0.4, 0.96, 0.3), 0.018, 0.22, mat_cop_d, false)
		_add_mesh_box(root, Vector3(-0.7, 0.94, -0.2), Vector3(0.28, 0.03, 0.16), mat_oak)
		_add_mesh_box(root, Vector3(-0.68, 0.97, -0.18), Vector3(0.24, 0.025, 0.14), mat_oak_d)
		_add_mesh_box(root, Vector3(-0.66, 1.0, -0.16), Vector3(0.2, 0.02, 0.12), mat_oak)
		_add_mesh_cyl(root, Vector3(-0.35, 0.95, -0.25), 0.018, 0.08, mat_cream, false)
		_add_mesh_cyl(root, Vector3(0.05, 0.97, 0.22), 0.04, 0.12, mat_wood_h, false)
		_add_mesh_box(root, Vector3(0.05, 0.94, 0.32), Vector3(0.1, 0.06, 0.08), mat_iron)
	else:
		_add_mesh_box(root, Vector3(0.7, 0.98, -0.12), Vector3(0.24, 0.14, 0.18), mat_iron)
		_add_mesh_box(root, Vector3(0.7, 1.08, -0.05), Vector3(0.12, 0.08, 0.1), mat_iron_d)
		_add_mesh_cyl(root, Vector3(0.7, 1.12, 0.05), 0.02, 0.1, mat_br, false)
		_add_mesh_box(root, Vector3(0.7, 1.14, 0.1), Vector3(0.08, 0.04, 0.04), mat_iron_l)
		_add_mesh_box(root, Vector3(-0.5, 0.95, 0.05), Vector3(0.32, 0.06, 0.22), mat_wood_h)
		_add_mesh_box(root, Vector3(-0.45, 1.0, 0.08), Vector3(0.28, 0.02, 0.045), mat_iron)
		_add_mesh_box(root, Vector3(-0.32, 1.01, 0.08), Vector3(0.06, 0.03, 0.04), mat_wood_h)
		_add_mesh_box(root, Vector3(0.15, 0.98, 0.2), Vector3(0.05, 0.12, 0.1), mat_iron)
		_add_mesh_box(root, Vector3(0.15, 0.93, 0.26), Vector3(0.12, 0.03, 0.04), mat_iron)
		_add_mesh_box(root, Vector3(0.15, 1.05, 0.26), Vector3(0.12, 0.03, 0.04), mat_iron_d)
		_add_mesh_cyl(root, Vector3(0.2, 0.99, 0.26), 0.012, 0.1, mat_iron_l, false)
		_add_mesh_box(root, Vector3(-0.15, 0.93, -0.22), Vector3(0.28, 0.02, 0.18), mat_cop_d)
		_add_mesh_box(root, Vector3(0.35, 0.935, -0.25), Vector3(0.5, 0.018, 0.04), mat_iron)
		_add_mesh_box(root, Vector3(-0.75, 0.94, 0.18), Vector3(0.18, 0.05, 0.12), mat_oak)
		_add_mesh_box(root, Vector3(-0.7, 0.97, 0.22), Vector3(0.12, 0.03, 0.08), mat_oak_d)
		_add_mesh_cyl(root, Vector3(0.4, 0.94, 0.15), 0.01, 0.14, _solid_matte(Color(0.75, 0.55, 0.25), 0.85), false)
	_add_contact_shadow(root, width * 0.5, 0.55)
	return root

static func _make_tool_rack(prop: Dictionary) -> Node3D:
	## Loop 196: wall tool rack — solid-mat frame + iron/copper tool heads (not stick washout).
	var root := Node3D.new()
	root.name = "ToolRack"
	var seed0: int = int(prop.get("seed", 0))
	var mat_frame := _solid_matte(Color(0.22, 0.12, 0.07), 0.8)
	var mat_side := _solid_matte(Color(0.32, 0.16, 0.09), 0.78)
	var mat_back := _solid_matte(Color(0.36, 0.24, 0.12), 0.82)
	var mat_wood_h := _solid_matte(Color(0.32, 0.2, 0.1), 0.8)
	var mat_wood_l := _solid_matte(Color(0.42, 0.28, 0.14), 0.78)
	var mat_oak_l := _solid_matte(Color(0.5, 0.38, 0.22), 0.8)
	var mat_iron := _solid_metal(Color(0.36, 0.36, 0.38), 0.48)
	var mat_iron_l := _solid_metal(Color(0.48, 0.48, 0.5), 0.45)
	var mat_iron_d := _solid_metal(Color(0.28, 0.28, 0.3), 0.52)
	var mat_br := _solid_metal(Color(0.72, 0.56, 0.28), 0.3)
	var mat_br_d := _solid_metal(Color(0.55, 0.42, 0.2), 0.35)
	var mat_cop := _solid_metal(Color(0.7, 0.42, 0.18), 0.32)
	var mat_cop_d := _solid_metal(Color(0.58, 0.34, 0.14), 0.36)
	_add_mesh_box(root, Vector3(0, 1.35, 0), Vector3(1.55, 0.1, 0.12), mat_frame)
	_add_mesh_box(root, Vector3(0, 0.55, 0), Vector3(1.55, 0.08, 0.12), mat_frame)
	_add_mesh_box(root, Vector3(-0.72, 0.95, 0), Vector3(0.08, 0.9, 0.1), mat_side)
	_add_mesh_box(root, Vector3(0.72, 0.95, 0), Vector3(0.08, 0.9, 0.1), mat_side)
	_add_mesh_box(root, Vector3(0, 0.95, -0.04), Vector3(1.4, 0.85, 0.03), mat_back)
	for i in 6:
		var x := -0.55 + float(i) * 0.22
		_add_mesh_cyl(root, Vector3(x, 1.28, 0.1), 0.018, 0.12, mat_wood_l, false)
		var kind := (i + seed0 * 3) % 6
		match kind:
			0:  # claw hammer
				_add_mesh_cyl(root, Vector3(x, 0.95, 0.12), 0.028, 0.52, mat_wood_h, false)
				_add_mesh_box(root, Vector3(x, 0.68, 0.16), Vector3(0.22, 0.1, 0.09), mat_iron)
				_add_mesh_box(root, Vector3(x + 0.12, 0.68, 0.16), Vector3(0.08, 0.08, 0.07), mat_iron_l)
				_add_mesh_box(root, Vector3(x - 0.12, 0.66, 0.16), Vector3(0.08, 0.05, 0.06), mat_iron_d)
				_add_mesh_box(root, Vector3(x - 0.16, 0.62, 0.16), Vector3(0.04, 0.08, 0.05), mat_iron)
				_add_mesh_box(root, Vector3(x - 0.16, 0.7, 0.16), Vector3(0.04, 0.08, 0.05), mat_iron)
			1:  # Rooke open-end wrench
				_add_mesh_box(root, Vector3(x, 0.95, 0.12), Vector3(0.04, 0.5, 0.04), mat_iron_d)
				_add_mesh_box(root, Vector3(x, 0.68, 0.16), Vector3(0.2, 0.08, 0.08), mat_iron)
				_add_mesh_box(root, Vector3(x + 0.12, 0.72, 0.18), Vector3(0.06, 0.1, 0.05), mat_iron_l)
				_add_mesh_box(root, Vector3(x + 0.12, 0.64, 0.18), Vector3(0.06, 0.1, 0.05), mat_iron_l)
				_add_mesh_box(root, Vector3(x + 0.16, 0.68, 0.18), Vector3(0.04, 0.05, 0.05), mat_iron)
			2:  # tongs
				_add_mesh_box(root, Vector3(x - 0.035, 0.95, 0.12), Vector3(0.028, 0.55, 0.028), mat_iron)
				_add_mesh_box(root, Vector3(x + 0.035, 0.95, 0.12), Vector3(0.028, 0.55, 0.028), mat_iron)
				_add_mesh_box(root, Vector3(x, 1.15, 0.12), Vector3(0.12, 0.04, 0.04), mat_iron_d)
				_add_mesh_box(root, Vector3(x - 0.05, 0.65, 0.16), Vector3(0.06, 0.04, 0.08), mat_iron_l)
				_add_mesh_box(root, Vector3(x + 0.05, 0.65, 0.16), Vector3(0.06, 0.04, 0.08), mat_iron_l)
			3:  # wood plane
				_add_mesh_box(root, Vector3(x, 0.85, 0.14), Vector3(0.12, 0.1, 0.32), mat_wood_l)
				_add_mesh_box(root, Vector3(x, 0.95, 0.05), Vector3(0.08, 0.1, 0.06), mat_wood_h)
				_add_mesh_box(root, Vector3(x, 0.82, 0.26), Vector3(0.1, 0.04, 0.08), mat_iron)
				_add_mesh_box(root, Vector3(x, 0.88, 0.14), Vector3(0.06, 0.03, 0.12), mat_br_d)
			4:  # file
				_add_mesh_cyl(root, Vector3(x, 1.05, 0.12), 0.03, 0.18, mat_wood_h, false)
				_add_mesh_box(root, Vector3(x, 0.78, 0.12), Vector3(0.045, 0.42, 0.04), mat_iron_l)
				for ti in 4:
					_add_mesh_box(root, Vector3(x + 0.025, 0.65 + float(ti) * 0.08, 0.12), Vector3(0.01, 0.02, 0.035), mat_iron)
			_:  # copper mallet
				_add_mesh_cyl(root, Vector3(x, 0.98, 0.12), 0.03, 0.42, mat_wood_l, false)
				_add_mesh_cyl(root, Vector3(x, 0.72, 0.16), 0.09, 0.14, mat_cop, false)
				_add_mesh_cyl(root, Vector3(x, 0.72, 0.16), 0.1, 0.04, mat_cop_d, false)
	for i in 3:
		var x2 := -0.35 + float(i) * 0.35
		var kind2 := (i + seed0 + 2) % 4
		_add_mesh_cyl(root, Vector3(x2, 0.58, 0.1), 0.014, 0.1, mat_wood_l, false)
		if kind2 == 0:
			_add_mesh_box(root, Vector3(x2, 0.38, 0.12), Vector3(0.035, 0.3, 0.035), mat_wood_h)
			_add_mesh_box(root, Vector3(x2, 0.24, 0.16), Vector3(0.14, 0.08, 0.06), mat_iron)
			_add_mesh_box(root, Vector3(x2 + 0.08, 0.24, 0.16), Vector3(0.06, 0.1, 0.04), mat_iron_l)
		elif kind2 == 1:
			_add_mesh_cyl(root, Vector3(x2, 0.4, 0.14), 0.02, 0.32, mat_br_d, false)
			_add_mesh_box(root, Vector3(x2, 0.55, 0.14), Vector3(0.1, 0.03, 0.03), mat_br)
		elif kind2 == 2:
			_add_mesh_box(root, Vector3(x2, 0.4, 0.14), Vector3(0.05, 0.28, 0.05), mat_iron)
			_add_mesh_box(root, Vector3(x2, 0.24, 0.14), Vector3(0.06, 0.04, 0.04), mat_iron_l)
		else:
			_add_mesh_cyl(root, Vector3(x2, 0.4, 0.14), 0.025, 0.28, mat_iron_d, false)
			_add_mesh_cyl(root, Vector3(x2, 0.28, 0.14), 0.05, 0.08, mat_cop, false)
	if seed0 % 2 == 0:
		_add_mesh_box(root, Vector3(-0.35, 0.62, 0.1), Vector3(0.1, 0.04, 0.08), mat_cop_d)
		_add_mesh_cyl(root, Vector3(-0.18, 0.64, 0.1), 0.03, 0.08, mat_br, false)
		_add_mesh_box(root, Vector3(0.0, 0.62, 0.1), Vector3(0.12, 0.03, 0.06), mat_iron_l)
	else:
		_add_mesh_box(root, Vector3(0.15, 0.62, 0.1), Vector3(0.22, 0.05, 0.12), mat_oak_l)
		_add_mesh_cyl(root, Vector3(0.4, 0.64, 0.1), 0.028, 0.08, mat_cop, false)
		_add_mesh_box(root, Vector3(0.5, 0.62, 0.1), Vector3(0.08, 0.04, 0.06), mat_br_d)
	return root

static func _make_wicker_basket(prop: Dictionary) -> Node3D:
	## Loop 211: oval willow trug — cylinder body + weave ribs (not pale wood crate mid-FOV).
	var root := Node3D.new()
	root.name = "WickerBasket"
	var s: float = float(prop.get("scale", 1.0))
	var seed0: int = int(prop.get("seed", 0))
	var fill: String = str(prop.get("fill", ""))
	if fill == "" and seed0 % 3 == 0:
		fill = "apples"
	elif fill == "" and seed0 % 3 == 1:
		fill = "linen"
	# Warmer darker willow (pale cream read as Minecraft crate)
	var wick := Color(0.48, 0.34, 0.18) if seed0 % 2 == 0 else Color(0.42, 0.3, 0.16)
	var mat_w := _solid_matte(wick, 0.9)
	var mat_wd := _solid_matte(wick.darkened(0.18), 0.92)
	var mat_wl := _solid_matte(wick.lightened(0.1), 0.88)
	var mat_soil := _solid_matte(Color(0.18, 0.12, 0.07), 0.94)
	var rx: float = 0.24 * s
	var rz: float = 0.16 * s
	var h: float = 0.2 * s
	# Oval body from overlapping cylinders (no main box slab)
	_add_mesh_cyl(root, Vector3(0, h * 0.4, 0), rx * 0.55, h * 0.78, mat_w, true)
	_add_mesh_cyl(root, Vector3(rx * 0.35, h * 0.4, 0), rz * 0.95, h * 0.78, mat_w, true)
	_add_mesh_cyl(root, Vector3(-rx * 0.35, h * 0.4, 0), rz * 0.95, h * 0.78, mat_w, true)
	_add_mesh_cyl(root, Vector3(0, h * 0.4, rz * 0.2), rx * 0.48, h * 0.75, mat_wl, false)
	_add_mesh_cyl(root, Vector3(0, h * 0.4, -rz * 0.2), rx * 0.48, h * 0.75, mat_wd, false)
	# Floor of trug
	_add_mesh_cyl(root, Vector3(0, 0.02 * s, 0), rx * 0.7, 0.025 * s, mat_wd, false)
	_add_mesh_box(root, Vector3(0, 0.02 * s, 0), Vector3(rx * 1.1, 0.02 * s, rz * 1.2), mat_wd)
	# Interior soil/shadow bed
	_add_mesh_cyl(root, Vector3(0, h * 0.55, 0), rx * 0.5, 0.02 * s, mat_soil, false)
	# Horizontal weave bands (ribs)
	for bi in 5:
		var by := 0.04 * s + float(bi) * (h * 0.16)
		_add_mesh_cyl(root, Vector3(0, by, 0), rx * 0.72, 0.014 * s, mat_wd if bi % 2 == 0 else mat_wl, false)
		_add_mesh_cyl(root, Vector3(rx * 0.32, by, 0), rz * 1.05, 0.012 * s, mat_wd if bi % 2 == 0 else mat_w, false)
		_add_mesh_cyl(root, Vector3(-rx * 0.32, by, 0), rz * 1.05, 0.012 * s, mat_wd if bi % 2 == 0 else mat_w, false)
	# Vertical stakes around rim
	for vi in 8:
		var ang := float(vi) * TAU / 8.0 + float(seed0) * 0.1
		var vx: float = cos(ang) * rx * 0.65
		var vz: float = sin(ang) * rz * 0.85
		_add_mesh_cyl(root, Vector3(vx, h * 0.42, vz), 0.01 * s, h * 0.7, mat_wd, false)
	# Rim coil
	_add_mesh_cyl(root, Vector3(0, h * 0.85, 0), rx * 0.75, 0.03 * s, mat_wl, false)
	_add_mesh_cyl(root, Vector3(rx * 0.32, h * 0.85, 0), rz * 1.05, 0.028 * s, mat_w, false)
	_add_mesh_cyl(root, Vector3(-rx * 0.32, h * 0.85, 0), rz * 1.05, 0.028 * s, mat_w, false)
	_add_mesh_cyl(root, Vector3(0, h * 0.9, 0), rx * 0.7, 0.018 * s, mat_wd, false)
	# Arched end handles
	for sx in [-1.0, 1.0]:
		var hx: float = sx * rx * 0.75
		_add_mesh_cyl(root, Vector3(hx, h * 0.95, 0), 0.028 * s, 0.08 * s, mat_w, false)
		_add_mesh_cyl(root, Vector3(hx, h * 1.12, 0), 0.022 * s, 0.14 * s, mat_wd, false)
		_add_mesh_cyl_rot(root, Vector3(hx, h * 1.22, 0), 0.018 * s, 0.1 * s, mat_wl, Vector3(0, 0, PI * 0.5))
	if seed0 % 2 == 0:
		# Crossbar handle
		_add_mesh_cyl_rot(root, Vector3(0, h * 1.2, 0), 0.014 * s, rx * 1.4, mat_wd, Vector3(0, 0, PI * 0.5))
	if fill == "apples":
		for ai in 7:
			var ax := cos(float(ai) * 1.05 + float(seed0)) * rx * 0.38
			var az := sin(float(ai) * 1.05) * rz * 0.4
			var acol := Color(0.55, 0.16, 0.12) if ai % 2 == 0 else Color(0.48, 0.2, 0.1)
			if ai % 3 == 2:
				acol = Color(0.58, 0.28, 0.1)
			var mat_a := _solid_matte(acol, 0.9)
			_add_mesh_cyl(root, Vector3(ax, h * 0.68, az), 0.04 * s, 0.035 * s, mat_a, false)
			_add_mesh_cyl(root, Vector3(ax, h * 0.75, az), 0.045 * s, 0.03 * s, mat_a, false)
			_add_mesh_cyl(root, Vector3(ax, h * 0.8, az), 0.03 * s, 0.018 * s, mat_a, false)
	elif fill == "linen":
		var mat_lin := _solid_matte(Color(0.78, 0.72, 0.58), 0.92)
		var mat_lin_d := _solid_matte(Color(0.7, 0.64, 0.5), 0.92)
		var mat_lin_dd := _solid_matte(Color(0.66, 0.6, 0.46), 0.92)
		_add_mesh_cyl(root, Vector3(0, h * 0.7, 0), rx * 0.55, 0.06 * s, mat_lin, false)
		_add_mesh_box(root, Vector3(0.01 * s, h * 0.78, 0.01 * s), Vector3(rx * 0.95, 0.04 * s, rz * 0.85), mat_lin_d)
		_add_mesh_box(root, Vector3(-0.01 * s, h * 0.86, -0.01 * s), Vector3(rx * 0.8, 0.03 * s, rz * 0.7), mat_lin_dd)
		_add_mesh_box(root, Vector3(0.03 * s, h * 0.9, 0.02 * s), Vector3(rx * 0.55, 0.02 * s, rz * 0.5), mat_lin)
	elif fill == "veg":
		var mat_soil2 := _solid_matte(Color(0.26, 0.18, 0.1), 0.92)
		var mat_carrot := _solid_matte(Color(0.78, 0.42, 0.18), 0.88)
		var mat_leaf := _solid_matte(Color(0.22, 0.4, 0.14), 0.9)
		var mat_leaf_d := _solid_matte(Color(0.2, 0.38, 0.14), 0.9)
		var mat_turnip := _solid_matte(Color(0.7, 0.6, 0.38), 0.9)
		_add_mesh_cyl(root, Vector3(0, h * 0.58, 0), rx * 0.5, 0.035 * s, mat_soil2, false)
		for ci in 5:
			var cx := (float(ci) / 4.0 - 0.5) * rx * 0.85
			_add_mesh_cyl(root, Vector3(cx, h * 0.72, rz * 0.12), 0.016 * s, 0.1 * s, mat_carrot, false)
			_add_mesh_box(root, Vector3(cx, h * 0.82, rz * 0.12), Vector3(0.04 * s, 0.022 * s, 0.03 * s), mat_leaf)
		_add_mesh_box(root, Vector3(0.04 * s, h * 0.78, -rz * 0.18), Vector3(0.12 * s, 0.014 * s, 0.08 * s), mat_leaf)
		_add_mesh_box(root, Vector3(-0.06 * s, h * 0.76, -rz * 0.08), Vector3(0.1 * s, 0.012 * s, 0.07 * s), mat_leaf_d)
		_add_mesh_cyl(root, Vector3(rx * 0.22, h * 0.7, -rz * 0.12), 0.038 * s, 0.045 * s, mat_turnip, false)
	_add_contact_shadow(root, rx * 1.15, rz * 1.15)
	return root


static func _make_crate(prop: Dictionary) -> Node3D:
	## Loop 186: shipping crate — board seams + iron straps + corner posts
	## (not solid Minecraft wood cube mid-FOV).
	var root := Node3D.new()
	root.name = "Crate"
	var s: float = float(prop.get("scale", 1.0))
	var seed0: int = int(prop.get("seed", 0))
	var wood_c := Color(0.52, 0.38, 0.22) if seed0 % 2 == 0 else Color(0.46, 0.34, 0.2)
	if seed0 % 5 == 4:
		wood_c = Color(0.4, 0.3, 0.18)
	var mat_w := _solid_matte(wood_c, 0.88)
	var mat_wd := _solid_matte(wood_c.darkened(0.12), 0.9)
	var mat_wl := _solid_matte(wood_c.lightened(0.08), 0.86)
	var mat_iron := _solid_metal(Color(0.28, 0.28, 0.3), 0.55)
	var mat_rope := _solid_matte(Color(0.4, 0.3, 0.16), 0.9)
	var mat_straw := _solid_matte(Color(0.62, 0.52, 0.28), 0.92)
	var mat_stenc := _solid_matte(Color(0.7, 0.64, 0.5), 0.85)
	var mat_ink := _solid_matte(Color(0.2, 0.16, 0.12), 0.8)
	var h: float = (0.36 + float(seed0 % 3) * 0.05) * s
	var w: float = 0.52 * s
	var d: float = 0.42 * s
	var open_lid := seed0 % 4 == 1
	# Floor skids (raise off ground — crate identity)
	_add_mesh_box(root, Vector3(0, 0.02 * s, d * 0.35), Vector3(w * 0.95, 0.04 * s, 0.06 * s), mat_wd)
	_add_mesh_box(root, Vector3(0, 0.02 * s, -d * 0.35), Vector3(w * 0.95, 0.04 * s, 0.06 * s), mat_wd)
	# Main body as separate face boards (gaps between planks)
	# Front/back horizontal planks
	for pi in 4:
		var py: float = 0.08 * s + float(pi) * (h * 0.22)
		_add_mesh_box(root, Vector3(0, py, d * 0.5), Vector3(w * 0.92, h * 0.18, 0.025 * s), mat_w if pi % 2 == 0 else mat_wl)
		_add_mesh_box(root, Vector3(0, py, -d * 0.5), Vector3(w * 0.92, h * 0.18, 0.025 * s), mat_wd if pi % 2 == 0 else mat_w)
	# Side planks
	for pi in 4:
		var py2: float = 0.08 * s + float(pi) * (h * 0.22)
		_add_mesh_box(root, Vector3(w * 0.5, py2, 0), Vector3(0.025 * s, h * 0.18, d * 0.88), mat_wl if pi % 2 == 0 else mat_w)
		_add_mesh_box(root, Vector3(-w * 0.5, py2, 0), Vector3(0.025 * s, h * 0.18, d * 0.88), mat_wd if pi % 2 == 0 else mat_w)
	# Interior fill (solid so no hollow z-fight from side)
	_add_mesh_box(root, Vector3(0, h * 0.48, 0), Vector3(w * 0.82, h * 0.85, d * 0.78), mat_wd)
	# Corner posts
	for sx in [-1.0, 1.0]:
		for sz in [-1.0, 1.0]:
			_add_mesh_box(
				root,
				Vector3(sx * w * 0.48, h * 0.48, sz * d * 0.48),
				Vector3(0.04 * s, h * 0.95, 0.04 * s),
				mat_wd
			)
	# Iron corner straps
	for sx in [-1.0, 1.0]:
		for sz in [-1.0, 1.0]:
			_add_mesh_box(
				root,
				Vector3(sx * w * 0.48, h * 0.15, sz * d * 0.48),
				Vector3(0.05 * s, 0.05 * s, 0.05 * s),
				mat_iron
			)
			_add_mesh_box(
				root,
				Vector3(sx * w * 0.48, h * 0.85, sz * d * 0.48),
				Vector3(0.05 * s, 0.05 * s, 0.05 * s),
				mat_iron
			)
	# Horizontal iron bands (all crates)
	_add_mesh_box(root, Vector3(0, h * 0.25, 0), Vector3(w * 1.02, 0.03 * s, d * 1.02), mat_iron)
	_add_mesh_box(root, Vector3(0, h * 0.72, 0), Vector3(w * 1.02, 0.03 * s, d * 1.02), mat_iron)
	# Lid
	if open_lid:
		_add_mesh_box(root, Vector3(0.0, h + 0.03 * s, -d * 0.35), Vector3(w * 0.95, 0.035 * s, d * 0.85), mat_w)
		_add_mesh_box(root, Vector3(0.0, h - 0.02 * s, 0.0), Vector3(w * 0.7, 0.03 * s, d * 0.55), mat_straw)
	else:
		# Lid boards with seam
		_add_mesh_box(root, Vector3(-w * 0.22, h + 0.015 * s, 0), Vector3(w * 0.42, 0.03 * s, d * 0.92), mat_wl)
		_add_mesh_box(root, Vector3(w * 0.22, h + 0.015 * s, 0), Vector3(w * 0.42, 0.03 * s, d * 0.92), mat_w)
		_add_mesh_box(root, Vector3(0, h + 0.02 * s, 0), Vector3(0.02 * s, 0.035 * s, d * 0.9), mat_wd)
	# Seed forks: rope handles / stencil / hasp
	match seed0 % 4:
		0:
			_add_mesh_box(root, Vector3(0, h * 0.5, d * 0.52), Vector3(0.1 * s, 0.05 * s, 0.025 * s), mat_iron)
		1:
			_add_mesh_cyl(root, Vector3(w * 0.52, h * 0.55, 0), 0.018 * s, 0.14 * s, mat_rope, false)
			_add_mesh_cyl(root, Vector3(-w * 0.52, h * 0.55, 0), 0.018 * s, 0.14 * s, mat_rope, false)
			_add_mesh_box(root, Vector3(w * 0.52, h * 0.62, 0), Vector3(0.03 * s, 0.03 * s, 0.08 * s), mat_rope)
			_add_mesh_box(root, Vector3(-w * 0.52, h * 0.62, 0), Vector3(0.03 * s, 0.03 * s, 0.08 * s), mat_rope)
		2:
			_add_mesh_box(root, Vector3(0, h * 0.55, d * 0.52), Vector3(0.22 * s, 0.1 * s, 0.015 * s), mat_stenc)
			_add_mesh_box(root, Vector3(0, h * 0.58, d * 0.53), Vector3(0.16 * s, 0.02 * s, 0.01 * s), mat_ink)
			_add_mesh_box(root, Vector3(0, h * 0.52, d * 0.53), Vector3(0.12 * s, 0.015 * s, 0.01 * s), mat_ink)
		_:
			_add_mesh_box(root, Vector3(0, h * 0.35, d * 0.52), Vector3(w * 0.9, 0.025 * s, 0.02 * s), mat_iron)
			_add_mesh_box(root, Vector3(0, h * 0.65, d * 0.52), Vector3(w * 0.9, 0.025 * s, 0.02 * s), mat_iron)
	_add_contact_shadow(root, w * 0.55, d * 0.55)
	return root


static func _make_stool(prop: Dictionary) -> Node3D:
	## Loop 198: stools — solid-mat wood + velvet (no washout mid-FOV).
	## seed: 0 tripod oak · 1 four-leg square · 2 padded drum
	var root := Node3D.new()
	root.name = "Stool"
	var seed0: int = int(prop.get("seed", 0))
	var style := seed0 % 3
	var mat_oak := _solid_matte(Color(0.42, 0.28, 0.14), 0.78)
	var mat_oak_l := _solid_matte(Color(0.5, 0.36, 0.2), 0.75)
	var mat_oak_d := _solid_matte(Color(0.34, 0.22, 0.1), 0.82)
	var mat_m := _solid_matte(Color(0.3, 0.14, 0.08), 0.72)
	var mat_md := _solid_matte(Color(0.18, 0.09, 0.05), 0.78)
	if style == 0:
		_add_mesh_cyl(root, Vector3(0, 0.48, 0), 0.21, 0.06, mat_oak, true)
		_add_mesh_cyl(root, Vector3(0, 0.52, 0), 0.19, 0.035, mat_oak_l, false)
		_add_mesh_cyl(root, Vector3(0, 0.54, 0), 0.2, 0.02, mat_oak_d, false)
		_add_mesh_cyl(root, Vector3(0, 0.44, 0), 0.22, 0.025, mat_md, false)
		for a in [0.0, 120.0, 240.0]:
			var rad := deg_to_rad(a)
			var lx := cos(rad) * 0.15
			var lz := sin(rad) * 0.15
			_add_mesh_cyl(root, Vector3(lx, 0.34, lz), 0.034, 0.2, mat_md, true)
			_add_mesh_cyl(root, Vector3(lx, 0.2, lz), 0.025, 0.14, mat_m, false)
			_add_mesh_cyl(root, Vector3(lx, 0.08, lz), 0.03, 0.12, mat_md, false)
			_add_mesh_cyl(root, Vector3(lx, 0.02, lz), 0.042, 0.04, mat_m, false)
		_add_mesh_cyl(root, Vector3(0, 0.16, 0), 0.17, 0.028, mat_md, false)
		_add_mesh_cyl(root, Vector3(0, 0.16, 0), 0.13, 0.02, mat_m, false)
	elif style == 1:
		_add_mesh_box(root, Vector3(0, 0.5, 0), Vector3(0.4, 0.05, 0.4), mat_oak)
		_add_mesh_box(root, Vector3(0, 0.54, 0), Vector3(0.38, 0.025, 0.38), mat_oak_l)
		_add_mesh_box(root, Vector3(0, 0.46, 0.18), Vector3(0.36, 0.05, 0.035), mat_m)
		_add_mesh_box(root, Vector3(0, 0.46, -0.18), Vector3(0.36, 0.05, 0.035), mat_m)
		_add_mesh_box(root, Vector3(0.18, 0.46, 0), Vector3(0.035, 0.05, 0.34), mat_m)
		_add_mesh_box(root, Vector3(-0.18, 0.46, 0), Vector3(0.035, 0.05, 0.34), mat_m)
		for sx in [-1.0, 1.0]:
			for sz in [-1.0, 1.0]:
				_add_mesh_cyl(root, Vector3(sx * 0.15, 0.34, sz * 0.15), 0.032, 0.2, mat_md, true)
				_add_mesh_cyl(root, Vector3(sx * 0.15, 0.18, sz * 0.15), 0.024, 0.16, mat_m, false)
				_add_mesh_cyl(root, Vector3(sx * 0.15, 0.06, sz * 0.15), 0.03, 0.1, mat_md, false)
				_add_mesh_cyl(root, Vector3(sx * 0.15, 0.02, sz * 0.15), 0.04, 0.035, mat_m, false)
		_add_mesh_box(root, Vector3(0, 0.14, 0), Vector3(0.28, 0.028, 0.028), mat_md)
		_add_mesh_box(root, Vector3(-0.14, 0.14, 0), Vector3(0.028, 0.028, 0.26), mat_md)
		_add_mesh_box(root, Vector3(0.14, 0.14, 0), Vector3(0.028, 0.028, 0.26), mat_md)
	else:
		var fab := VELVET_GREEN.darkened(0.08) if seed0 % 2 == 0 else VELVET_RED.darkened(0.12)
		var mat_fab := _solid_matte(fab, 0.92)
		var mat_fab_d := _solid_matte(fab.darkened(0.14), 0.94)
		var mat_fab_dd := _solid_matte(fab.darkened(0.25), 0.94)
		_add_mesh_cyl(root, Vector3(0, 0.36, 0), 0.22, 0.08, mat_md, true)
		_add_mesh_cyl(root, Vector3(0, 0.42, 0), 0.215, 0.04, mat_m, false)
		_add_mesh_cyl(root, Vector3(0, 0.46, 0), 0.2, 0.03, mat_oak_d, false)
		_add_mesh_cyl(root, Vector3(0, 0.52, 0), 0.195, 0.1, mat_fab, true)
		_add_mesh_cyl(root, Vector3(0, 0.58, 0), 0.18, 0.04, mat_fab_d, false)
		_add_mesh_cyl(root, Vector3(0, 0.55, 0), 0.2, 0.015, mat_md, false)
		for ti in 6:
			var ta := float(ti) * TAU / 6.0
			_add_mesh_cyl(root, Vector3(cos(ta) * 0.08, 0.6, sin(ta) * 0.08), 0.012, 0.012, mat_fab_dd, false)
		for a in [0.0, 90.0, 180.0, 270.0]:
			var rad := deg_to_rad(a)
			var lx := cos(rad) * 0.13
			var lz := sin(rad) * 0.13
			_add_mesh_cyl(root, Vector3(lx, 0.26, lz), 0.03, 0.16, mat_md, true)
			_add_mesh_cyl(root, Vector3(lx, 0.12, lz), 0.024, 0.14, mat_m, false)
			_add_mesh_cyl(root, Vector3(lx, 0.02, lz), 0.034, 0.04, mat_m, false)
		_add_mesh_cyl(root, Vector3(0, 0.12, 0), 0.14, 0.022, mat_md, false)
	_add_contact_shadow(root, 0.26, 0.26)
	return root

# ─── Gallery / aetheric ──────────────────────────────────────────────────────

static func _make_machine(prop: Dictionary) -> Node3D:
	## Loop 202: secondary gallery instruments — full solid mats (coil/fork/Leyden).
	## Three silhouettes by seed; never mini-clones of the main aetheric engine.
	var root := Node3D.new()
	root.name = "Machine"
	var height: float = float(prop.get("height", 2.6))
	var seed0: int = int(prop.get("seed", int(height * 10.0)))
	var style := seed0 % 3
	var iron_mid := Color(0.34, 0.34, 0.36)
	var iron_dark := Color(0.24, 0.24, 0.26)
	var oak_d := Color(0.26, 0.16, 0.09)
	var oak := Color(0.4, 0.26, 0.14)
	var mat_br_s := _solid_metal(BRASS, 0.28)
	var mat_br_sd := _solid_metal(BRASS.darkened(0.1), 0.32)
	var mat_br_sl := _solid_metal(BRASS.lightened(0.05), 0.26)
	var mat_cop_s := _solid_metal(COPPER, 0.32)
	var mat_cop_sd := _solid_metal(COPPER.darkened(0.1), 0.36)
	var mat_cop_sl := _solid_metal(COPPER.lightened(0.08), 0.28)
	var mat_oak_s := _solid_matte(oak, 0.72)
	var mat_oak_sd := _solid_matte(oak_d, 0.75)
	var mat_oak_sdd := _solid_matte(oak_d.darkened(0.1), 0.78)
	var mat_iron_s := _solid_matte(iron_mid, 0.55)
	var mat_iron_sd := _solid_matte(iron_dark, 0.58)
	var mat_gauge := _solid_matte(Color(0.85, 0.88, 0.8), 0.5)
	var top_y: float = 1.6
	match style:
		0:
			# Open oak frame + spaced copper coils + amber terminal
			var col_h: float = maxf(height * 0.68, 1.35)
			_add_mesh_box(root, Vector3(0, 0.1, 0), Vector3(1.15, 0.2, 1.05), mat_iron_s)
			_add_mesh_box(root, Vector3(0, 0.24, 0), Vector3(0.98, 0.1, 0.88), mat_oak_sd)
			_add_mesh_box(root, Vector3(0, 0.3, 0), Vector3(0.82, 0.04, 0.74), mat_cop_sd)
			var col_mid: float = 0.4 + col_h * 0.45
			_add_mesh_cyl(root, Vector3(0, col_mid, 0), 0.06, col_h * 0.85, mat_br_sd, true)
			for sx in [-1.0, 1.0]:
				for sz in [-1.0, 1.0]:
					_add_mesh_box(root, Vector3(sx * 0.34, col_mid, sz * 0.34), Vector3(0.065, col_h * 0.8, 0.065), mat_oak_sd)
					_add_mesh_cyl(root, Vector3(sx * 0.34, 0.4 + col_h * 0.85, sz * 0.34), 0.045, 0.045, mat_br_s, false)
			_add_mesh_box(root, Vector3(0, 0.4 + col_h * 0.82, 0), Vector3(0.78, 0.06, 0.78), mat_oak_s)
			_add_mesh_box(root, Vector3(0, 0.4 + col_h * 0.86, 0), Vector3(0.66, 0.03, 0.66), mat_br_sd)
			for i in 4:
				var y: float = 0.52 + float(i) * (col_h * 0.18)
				var r: float = 0.4 - float(i) * 0.04
				var mat_coil := mat_cop_s if i % 2 == 0 else mat_cop_sd
				var mat_coil_l := mat_cop_sl if i % 2 == 0 else mat_cop_s
				_add_mesh_cyl(root, Vector3(0, y, 0), r, 0.055, mat_coil, false)
				_add_mesh_cyl(root, Vector3(0, y + 0.02, 0), r * 0.86, 0.02, mat_coil_l, false)
				_add_mesh_cyl(root, Vector3(0, y, 0), r * 0.5, 0.045, mat_oak_sdd, false)
				var wind := 1.0 if i % 2 == 0 else -1.0
				for s in 10:
					var ang: float = float(s) * (TAU / 10.0) * wind
					_add_mesh_box(root, Vector3(cos(ang) * r * 0.96, y, sin(ang) * r * 0.96), Vector3(0.04, 0.03, 0.06), mat_coil_l)
				var side := 1.0 if i % 2 == 0 else -1.0
				_add_mesh_box(root, Vector3(side * r * 0.95, y, 0), Vector3(0.055, 0.07, 0.07), mat_br_s)
			top_y = 0.42 + col_h * 0.9
			var mat_br0 := _solid_metal(BRASS.lightened(0.05), 0.28)
			var mat_br0d := _solid_metal(BRASS.darkened(0.08), 0.32)
			var mat_amber := _solid_matte(Color(0.72, 0.55, 0.28), 0.35)
			_add_mesh_cyl(root, Vector3(0, top_y, 0), 0.18, 0.05, mat_br0, false)
			_add_mesh_cyl(root, Vector3(0, top_y + 0.06, 0), 0.08, 0.08, mat_br0d, false)
			_add_mesh_cyl(root, Vector3(0, top_y + 0.14, 0), 0.07, 0.1, mat_amber, false)
			_add_mesh_cyl(root, Vector3(0, top_y + 0.2, 0), 0.05, 0.03, mat_br0, false)
			for ri in 4:
				var ra := float(ri) * TAU / 4.0
				_add_mesh_box(root, Vector3(cos(ra) * 0.1, top_y + 0.08, sin(ra) * 0.1), Vector3(0.016, 0.1, 0.016), mat_br0d)
			_add_mesh_box(root, Vector3(0.55, 0.55, 0.1), Vector3(0.28, 0.42, 0.3), mat_oak_sd)
			for gi in 3:
				_add_mesh_cyl(root, Vector3(0.55, 0.62 + float(gi) * 0.12, 0.22), 0.055, 0.025, mat_br_s, false)
				_add_mesh_cyl(root, Vector3(0.55, 0.63 + float(gi) * 0.12, 0.24), 0.04, 0.01, mat_gauge, false)
			_add_mesh_cyl(root, Vector3(-0.5, 0.85, 0.0), 0.035, 0.7, mat_cop_s, false)
			_add_mesh_cyl(root, Vector3(-0.5, 1.25, 0.15), 0.045, 0.04, mat_br_s, false)
		1:
			# Loop 182: OPEN harmonic resonator — not closed iron fridge with cyan hat.
			# Oak plinth + two posts + air-spaced copper diaphragms + tuning fork crown.
			var mat_iron := _solid_matte(iron_mid, 0.55)
			var mat_iron_d := _solid_matte(iron_dark, 0.58)
			var mat_oak := _solid_matte(oak, 0.72)
			var mat_oak_d := _solid_matte(oak_d, 0.75)
			var mat_cop := _solid_metal(COPPER, 0.32)
			var mat_cop_d := _solid_metal(COPPER.darkened(0.1), 0.35)
			var mat_br := _solid_metal(BRASS, 0.28)
			var mat_br_d := _solid_metal(BRASS.darkened(0.1), 0.3)
			# Low oak plinth (instrument base — not full-height cabinet)
			_add_mesh_box(root, Vector3(0, 0.08, 0), Vector3(1.1, 0.16, 0.85), mat_oak_d)
			_add_mesh_box(root, Vector3(0, 0.18, 0), Vector3(1.0, 0.06, 0.75), mat_oak)
			_add_mesh_box(root, Vector3(0, 0.22, 0), Vector3(0.9, 0.03, 0.65), mat_br_d)
			# Two upright posts (open air between — not solid side cheeks)
			for sx in [-1.0, 1.0]:
				_add_mesh_box(root, Vector3(sx * 0.32, 0.95, 0), Vector3(0.08, 1.35, 0.08), mat_iron_d)
				_add_mesh_cyl(root, Vector3(sx * 0.32, 0.3, 0), 0.06, 0.08, mat_br, false)
				_add_mesh_cyl(root, Vector3(sx * 0.32, 1.62, 0), 0.055, 0.06, mat_br, false)
			# Rear thin rail only (not full back panel wall)
			_add_mesh_box(root, Vector3(0, 0.95, -0.22), Vector3(0.08, 1.2, 0.05), mat_iron)
			_add_mesh_box(root, Vector3(0, 1.55, -0.1), Vector3(0.7, 0.04, 0.04), mat_iron_d)
			_add_mesh_box(root, Vector3(0, 0.55, -0.1), Vector3(0.7, 0.04, 0.04), mat_iron_d)
			# Central brass mast
			_add_mesh_cyl(root, Vector3(0, 0.95, 0.05), 0.045, 1.25, mat_br_d, true)
			# Air-spaced copper diaphragms (gaps visible — instrument, not fridge shelves)
			for i in 5:
				var y: float = 0.48 + float(i) * 0.22
				var r: float = 0.28 - float(i) * 0.02
				var cm: Material = mat_cop if i % 2 == 0 else mat_cop_d
				_add_mesh_cyl(root, Vector3(0, y, 0.05), r, 0.045, cm, false)
				_add_mesh_cyl(root, Vector3(0, y + 0.02, 0.05), r * 0.82, 0.02, mat_br_d, false)
			# Cross struts between posts (open triangle braces)
			_add_mesh_box(root, Vector3(0, 0.75, 0.12), Vector3(0.62, 0.03, 0.03), mat_iron)
			_add_mesh_box(root, Vector3(0, 1.25, 0.12), Vector3(0.62, 0.03, 0.03), mat_iron)
			# Side gauge box (small, not cheek wall)
			_add_mesh_box(root, Vector3(0.48, 0.55, 0.15), Vector3(0.22, 0.35, 0.28), mat_oak_d)
			for gi in 2:
				_add_mesh_cyl(root, Vector3(0.48, 0.5 + float(gi) * 0.14, 0.28), 0.045, 0.02, mat_br, false)
			# Copper riser pipe
			_add_mesh_cyl(root, Vector3(-0.48, 0.75, 0.1), 0.03, 0.7, mat_cop, false)
			_add_mesh_cyl(root, Vector3(-0.48, 1.15, 0.2), 0.04, 0.035, mat_br, false)
			# Top bridge + brass fork crown (no fat cyan jar hat mid-FOV)
			_add_mesh_box(root, Vector3(0, 1.65, 0), Vector3(0.75, 0.05, 0.35), mat_iron)
			_add_mesh_box(root, Vector3(0, 1.7, 0), Vector3(0.6, 0.03, 0.28), mat_br_d)
			# Small amber sample vial (not cyan game hat)
			_add_mesh_cyl(root, Vector3(0, 1.78, 0.05), 0.045, 0.1, _solid_matte(Color(0.7, 0.52, 0.28), 0.35), false)
			_add_mesh_cyl(root, Vector3(0, 1.84, 0.05), 0.035, 0.025, mat_br, false)
			# Tuning-fork prongs (identity of resonator)
			_add_mesh_box(root, Vector3(-0.04, 1.95, 0.05), Vector3(0.025, 0.22, 0.025), mat_br)
			_add_mesh_box(root, Vector3(0.04, 1.95, 0.05), Vector3(0.025, 0.22, 0.025), mat_br)
			_add_mesh_box(root, Vector3(0, 1.82, 0.05), Vector3(0.1, 0.025, 0.025), mat_br_d)
			top_y = 2.0
			# Soft warm emission at fork base (not cyan orb)
			var fork_core := MeshInstance3D.new()
			var fcm := SphereMesh.new()
			fcm.radius = 0.03
			fcm.height = 0.06
			fork_core.mesh = fcm
			var fcmat := StandardMaterial3D.new()
			fcmat.albedo_color = Color(0.95, 0.75, 0.4)
			fcmat.emission_enabled = true
			fcmat.emission = Color(0.9, 0.65, 0.3)
			fcmat.emission_energy_multiplier = 1.2
			fcmat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
			fork_core.material_override = fcmat
			fork_core.position = Vector3(0, 1.82, 0.05)
			root.add_child(fork_core)
		_:
			# Leyden / glass-stack apparatus — solid mats + warm amber terminal (not cyan hat)
			var mat_glass := StandardMaterial3D.new()
			mat_glass.albedo_color = Color(0.55, 0.72, 0.7, 0.55)
			mat_glass.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
			mat_glass.metallic = 0.05
			mat_glass.roughness = 0.25
			mat_glass.shading_mode = BaseMaterial3D.SHADING_MODE_PER_PIXEL
			_add_mesh_box(root, Vector3(0, 0.1, 0), Vector3(1.05, 0.2, 1.0), mat_oak_sd)
			_add_mesh_box(root, Vector3(0, 0.24, 0), Vector3(0.92, 0.1, 0.88), mat_oak_s)
			_add_mesh_box(root, Vector3(0, 0.3, 0), Vector3(0.78, 0.04, 0.74), mat_iron_s)
			for i in 3:
				var jx := -0.28 + float(i) * 0.28
				var jh := 0.85 + float(i % 2) * 0.15
				_add_mesh_cyl(root, Vector3(jx, 0.35 + jh * 0.5, 0.05), 0.12, jh, mat_glass, false)
				_add_mesh_cyl(root, Vector3(jx, 0.55, 0.05), 0.125, 0.08, mat_cop_s, false)
				_add_mesh_cyl(root, Vector3(jx, 0.85, 0.05), 0.125, 0.06, mat_cop_sd, false)
				_add_mesh_cyl(root, Vector3(jx, 0.35 + jh, 0.05), 0.08, 0.04, mat_br_s, false)
				_add_mesh_cyl(root, Vector3(jx, 0.4 + jh, 0.05), 0.02, 0.12, mat_br_sd, false)
			_add_mesh_cyl(root, Vector3(0, 1.0, -0.25), 0.04, 1.2, mat_br_s, true)
			for i in 5:
				var y: float = 0.55 + float(i) * 0.18
				var r: float = 0.22 - float(i) * 0.02
				_add_mesh_cyl(root, Vector3(0, y, -0.25), r, 0.04, mat_cop_s if i % 2 == 0 else mat_cop_sd, false)
			_add_mesh_cyl(root, Vector3(0, 1.7, -0.25), 0.1, 0.12, mat_br_sl, false)
			_add_mesh_box(root, Vector3(0, 1.15, -0.08), Vector3(0.55, 0.03, 0.03), mat_br_sd)
			_add_mesh_box(root, Vector3(0, 0.9, 0.0), Vector3(0.6, 0.025, 0.025), mat_cop_s)
			_add_mesh_box(root, Vector3(0.45, 0.55, 0.25), Vector3(0.25, 0.4, 0.28), mat_iron_sd)
			_add_mesh_cyl(root, Vector3(0.45, 0.7, 0.38), 0.06, 0.03, mat_br_s, false)
			_add_mesh_cyl(root, Vector3(0.45, 0.85, 0.38), 0.05, 0.025, mat_br_sd, false)
			top_y = 1.65
			# Warm amber terminal (matches house aether language — not cyan game orb)
			var leyden_g := MeshInstance3D.new()
			var lsm := SphereMesh.new()
			lsm.radius = 0.05
			lsm.height = 0.1
			leyden_g.mesh = lsm
			var lmat := StandardMaterial3D.new()
			lmat.albedo_color = Color(0.95, 0.75, 0.4)
			lmat.emission_enabled = true
			lmat.emission = Color(0.9, 0.65, 0.3)
			lmat.emission_energy_multiplier = 1.5
			lmat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
			leyden_g.material_override = lmat
			leyden_g.position = Vector3(0, 1.72, -0.25)
			root.add_child(leyden_g)
	# Shared: warm brass-energy accent (style 0)
	if style == 0:
		var core := MeshInstance3D.new()
		var cm := CylinderMesh.new()
		cm.top_radius = 0.025
		cm.bottom_radius = 0.025
		cm.height = 0.08
		core.mesh = cm
		var cmat := StandardMaterial3D.new()
		cmat.albedo_color = Color(0.95, 0.75, 0.4)
		cmat.emission_enabled = true
		cmat.emission = Color(0.9, 0.65, 0.3)
		cmat.emission_energy_multiplier = 1.4
		cmat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		core.material_override = cmat
		core.position = Vector3(0, top_y + 0.14, 0)
		root.add_child(core)
	# Front valve wheel (all styles)
	_add_mesh_cyl(root, Vector3(0.0, 0.52, 0.48), 0.1, 0.03, mat_br_s, false)
	_add_mesh_box(root, Vector3(0.0, 0.52, 0.48), Vector3(0.18, 0.02, 0.02), mat_br_sl)
	_add_mesh_box(root, Vector3(0.0, 0.52, 0.48), Vector3(0.02, 0.02, 0.18), mat_br_sl)
	var glow := OmniLight3D.new()
	glow.light_color = Color(0.95, 0.78, 0.55)
	glow.light_energy = 0.55
	glow.omni_range = 3.2
	glow.position = Vector3(0, top_y * 0.7, 0.1)
	root.add_child(glow)
	_add_contact_shadow(root, 0.58, 0.52)
	return root

static func _make_aetheric_machine(prop: Dictionary) -> Node3D:
	## Loop 201: full solid-mat pedestal/coils/frame + loop 191 amber terminal (no wood/brass washout).
	var root := Node3D.new()
	root.name = "AethericMachine"
	var height: float = float(prop.get("height", 2.95))
	var oak := Color(0.42, 0.28, 0.14)
	var oak_d := Color(0.26, 0.16, 0.09)
	var iron_frame := Color(0.34, 0.34, 0.36)
	var iron_dark := Color(0.26, 0.26, 0.28)
	var mat_br := _solid_metal(BRASS, 0.28)
	var mat_br_d := _solid_metal(BRASS.darkened(0.1), 0.32)
	var mat_br_l := _solid_metal(BRASS.lightened(0.08), 0.26)
	var mat_cop := _solid_metal(COPPER, 0.32)
	var mat_cop_d := _solid_metal(COPPER.darkened(0.12), 0.36)
	var mat_cop_l := _solid_metal(COPPER.lightened(0.08), 0.28)
	var mat_oak_d := _solid_matte(oak_d, 0.72)
	var mat_oak := _solid_matte(oak, 0.7)
	var mat_oak_dd := _solid_matte(oak_d.darkened(0.05), 0.78)
	var mat_iron := _solid_matte(iron_frame, 0.55)
	var mat_iron_d := _solid_matte(iron_dark, 0.58)
	# Square oak base with copper inlay plate + brass edge + name plaque
	_add_mesh_box(root, Vector3(0, 0.1, 0), Vector3(1.7, 0.2, 1.7), mat_oak_d)
	_add_mesh_box(root, Vector3(0, 0.24, 0), Vector3(1.52, 0.1, 1.52), mat_oak)
	_add_mesh_box(root, Vector3(0, 0.32, 0), Vector3(1.36, 0.06, 1.36), mat_cop_d)
	_add_mesh_box(root, Vector3(0, 0.35, 0), Vector3(1.42, 0.02, 1.42), mat_br_d)
	_add_mesh_box(root, Vector3(0, 0.28, 0.78), Vector3(0.55, 0.08, 0.04), mat_br_d)
	_add_mesh_box(root, Vector3(0, 0.28, 0.8), Vector3(0.42, 0.05, 0.02), mat_br_l)
	for sx in [-1.0, 1.0]:
		for sz in [-1.0, 1.0]:
			_add_mesh_box(root, Vector3(sx * 0.74, 0.06, sz * 0.74), Vector3(0.18, 0.12, 0.18), mat_iron_d)
			_add_mesh_cyl(root, Vector3(sx * 0.74, 0.14, sz * 0.74), 0.032, 0.03, mat_br, false)
	for sx in [-1.0, 1.0]:
		for sz in [-1.0, 1.0]:
			_add_mesh_box(root, Vector3(sx * 0.52, height * 0.45, sz * 0.52), Vector3(0.11, height * 0.78, 0.11), mat_iron)
			_add_mesh_box(root, Vector3(sx * 0.52, height * 0.45, sz * 0.52), Vector3(0.065, height * 0.72, 0.065), mat_oak_d)
			_add_mesh_cyl(root, Vector3(sx * 0.52, height * 0.86, sz * 0.52), 0.075, 0.06, mat_br, false)
			_add_mesh_cyl(root, Vector3(sx * 0.52, height * 0.5, sz * 0.52), 0.07, 0.04, mat_br_d, false)
			_add_mesh_cyl(root, Vector3(sx * 0.52, height * 0.28, sz * 0.52), 0.065, 0.035, mat_br_d, false)
	_add_mesh_box(root, Vector3(0, height * 0.9, 0), Vector3(1.25, 0.08, 1.25), mat_oak_d)
	_add_mesh_box(root, Vector3(0, height * 0.94, 0), Vector3(1.15, 0.04, 1.15), mat_br_d)
	_add_mesh_box(root, Vector3(0, height * 0.97, 0), Vector3(1.0, 0.03, 1.0), mat_br_l)
	# FIVE copper coils — Y scaled to height so stack fills the frame
	var coil_fracs := [0.18, 0.32, 0.46, 0.58, 0.68]
	var coil_rs := [0.74, 0.6, 0.48, 0.38, 0.28]
	var coil_hs := [0.12, 0.11, 0.1, 0.095, 0.085]
	for i in 5:
		var y: float = height * coil_fracs[i]
		var r: float = coil_rs[i]
		var ch: float = coil_hs[i]
		var mat_coil := mat_cop if i % 2 == 0 else mat_cop_d
		var mat_coil_l := mat_cop_l if i % 2 == 0 else mat_cop
		_add_mesh_cyl(root, Vector3(0, y, 0), r, ch, mat_coil, false)
		_add_mesh_cyl(root, Vector3(0, y + ch * 0.35, 0), r * 0.9, ch * 0.22, mat_coil_l, false)
		_add_mesh_cyl(root, Vector3(0, y, 0), r * 0.55, ch * 0.7, mat_oak_dd, false)
		var wind := 1.0 if i % 2 == 0 else -1.0
		for s in 14:
			var ang: float = float(s) * (TAU / 14.0) * wind
			var bx: float = cos(ang) * r * 0.94
			var bz: float = sin(ang) * r * 0.94
			var by: float = y + (float(s) / 14.0 - 0.5) * ch * 0.9 * wind
			var mat_bar := mat_coil_l if s % 2 == 0 else mat_coil
			_add_mesh_box(root, Vector3(bx, by, bz), Vector3(0.05, 0.032, 0.085), mat_bar)
		var side := 1.0 if i % 2 == 0 else -1.0
		_add_mesh_box(root, Vector3(side * r * 0.97, y, 0), Vector3(0.08, ch + 0.04, 0.11), mat_br)
	# Central spine + collars
	_add_mesh_cyl(root, Vector3(0, height * 0.48, 0), 0.085, height * 0.65, mat_br, true)
	_add_mesh_cyl(root, Vector3(0, height * 0.55, 0), 0.14, 0.05, mat_br_d, false)
	_add_mesh_cyl(root, Vector3(0, height * 0.78, 0), 0.22, 0.08, mat_br_l, false)
	# Brass gallery terminal + warm amber chamber
	var mat_amber := _solid_matte(Color(0.72, 0.52, 0.28), 0.32)
	var mat_amber_d := _solid_matte(Color(0.55, 0.38, 0.2), 0.38)
	var dome_y: float = height * 0.82
	# Brass gallery ring (instrument crown — not teal barrel)
	_add_mesh_cyl(root, Vector3(0, dome_y - 0.12, 0), 0.3, 0.05, mat_br_d, false)
	_add_mesh_cyl(root, Vector3(0, dome_y - 0.06, 0), 0.26, 0.04, mat_br, false)
	# Compact amber glass sample chamber (small jar, not fat hat)
	_add_mesh_cyl(root, Vector3(0, dome_y + 0.02, 0), 0.12, 0.14, mat_amber, false)
	_add_mesh_cyl(root, Vector3(0, dome_y + 0.1, 0), 0.1, 0.04, mat_amber_d, false)
	_add_mesh_cyl(root, Vector3(0, dome_y + 0.14, 0), 0.08, 0.03, mat_br_l, false)
	# Brass cage ribs + top finial
	for ri in 6:
		var ra := float(ri) * TAU / 6.0
		_add_mesh_box(root, Vector3(cos(ra) * 0.2, dome_y, sin(ra) * 0.2), Vector3(0.022, 0.22, 0.022), mat_br)
	_add_mesh_cyl(root, Vector3(0, dome_y + 0.2, 0), 0.05, 0.06, mat_br, false)
	_add_mesh_cyl(root, Vector3(0, dome_y + 0.26, 0), 0.035, 0.04, mat_br_l, false)
	# Warm aether core (copper glow — not cyan game orb)
	var core := MeshInstance3D.new()
	var cm := CylinderMesh.new()
	cm.top_radius = 0.04
	cm.bottom_radius = 0.04
	cm.height = 0.1
	core.mesh = cm
	var cmat := StandardMaterial3D.new()
	cmat.albedo_color = Color(0.95, 0.7, 0.35)
	cmat.emission_enabled = true
	cmat.emission = Color(0.9, 0.55, 0.22)
	cmat.emission_energy_multiplier = 1.5
	cmat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	core.material_override = cmat
	core.position = Vector3(0, dome_y + 0.02, 0)
	root.add_child(core)
	var glow := MeshInstance3D.new()
	var sm := SphereMesh.new()
	sm.radius = 0.05
	sm.height = 0.1
	glow.mesh = sm
	var smat := StandardMaterial3D.new()
	smat.albedo_color = Color(1.0, 0.78, 0.4)
	smat.emission_enabled = true
	smat.emission = Color(0.95, 0.65, 0.28)
	smat.emission_energy_multiplier = 1.2
	smat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	glow.material_override = smat
	glow.position = Vector3(0, dome_y + 0.04, 0)
	root.add_child(glow)
	# Cable runs (copper) down posts
	for sx in [-1.0, 1.0]:
		_add_mesh_cyl(root, Vector3(sx * 0.55, 1.0, 0.35), 0.02, 1.4, mat_cop_d, false)
		_add_mesh_box(root, Vector3(sx * 0.55, 0.35, 0.2), Vector3(0.06, 0.06, 0.35), mat_cop)
		_add_mesh_cyl(root, Vector3(sx * 0.55, 0.55, 0.35), 0.035, 0.04, mat_br, false)
	# South hand-bracket (Rooke adjusts)
	_add_mesh_box(root, Vector3(0.0, 1.05, 0.82), Vector3(0.48, 0.14, 0.24), mat_br)
	_add_mesh_box(root, Vector3(0.0, 0.78, 0.92), Vector3(0.1, 0.6, 0.1), mat_br_d)
	_add_mesh_box(root, Vector3(0.0, 1.25, 0.96), Vector3(0.3, 0.08, 0.16), mat_cop)
	_add_mesh_cyl(root, Vector3(0.0, 1.4, 0.98), 0.08, 0.14, mat_cop, false)
	_add_mesh_cyl(root, Vector3(0.2, 1.05, 0.98), 0.1, 0.05, mat_br_l, false)
	# Gauge bank (left) + valve wheel (right)
	_add_mesh_box(root, Vector3(-0.95, 0.85, 0.15), Vector3(0.28, 0.55, 0.35), mat_oak_d)
	for gi in 3:
		var gy := 0.65 + float(gi) * 0.18
		_add_mesh_cyl(root, Vector3(-0.95, gy, 0.32), 0.06, 0.03, mat_br, false)
		_add_mesh_cyl(root, Vector3(-0.95, gy, 0.34), 0.045, 0.01, _solid_matte(Color(0.85, 0.88, 0.8), 0.5), false)
	_add_mesh_box(root, Vector3(0.95, 0.7, 0.0), Vector3(0.3, 0.1, 0.38), mat_oak)
	_add_mesh_cyl(root, Vector3(0.95, 0.95, 0.0), 0.12, 0.04, mat_br, false)
	_add_mesh_box(root, Vector3(0.95, 0.95, 0.0), Vector3(0.22, 0.03, 0.03), mat_br_l)
	_add_mesh_box(root, Vector3(0.95, 0.95, 0.0), Vector3(0.03, 0.03, 0.22), mat_br_l)
	# Floor ring rail + brass studs
	_add_mesh_cyl(root, Vector3(0, 0.38, 0), 0.85, 0.04, mat_iron, false)
	for si in 8:
		var sang := float(si) * (TAU / 8.0)
		_add_mesh_cyl(root, Vector3(cos(sang) * 0.82, 0.42, sin(sang) * 0.82), 0.025, 0.03, mat_br, false)
	# Warm oil-lamp key lights only (no cyan fill)
	var warm := OmniLight3D.new()
	warm.light_color = Color(1.0, 0.82, 0.55)
	warm.light_energy = 0.5
	warm.omni_range = 4.2
	warm.position = Vector3(0.35, 1.2, 0.45)
	root.add_child(warm)
	var warm2 := OmniLight3D.new()
	warm2.light_color = Color(1.0, 0.72, 0.4)
	warm2.light_energy = 0.35
	warm2.omni_range = 2.8
	warm2.position = Vector3(0, height * 0.78, 0)
	root.add_child(warm2)
	_add_contact_shadow(root, 0.95, 0.95)
	return root

static func _make_chalk_board(prop: Dictionary) -> Node3D:
	## Loop 197: slate board — solid-mat mahogany frame + chalk rail (no wood washout).
	var root := Node3D.new()
	root.name = "ChalkBoard"
	var seed0: int = int(prop.get("seed", 0))
	var w := 1.35 + float(seed0 % 3) * 0.08
	var h := 0.95 + float(seed0 % 2) * 0.08
	var mat_frame_d := _solid_matte(Color(0.18, 0.09, 0.05), 0.78)
	var mat_frame := _solid_matte(Color(0.3, 0.14, 0.08), 0.72)
	var mat_slate_bg := _solid_matte(Color(0.08, 0.09, 0.08), 0.95)
	var mat_chalk := _solid_matte(Color(0.9, 0.86, 0.76), 0.9)
	var mat_chalk_d := _solid_matte(Color(0.82, 0.78, 0.68), 0.9)
	var mat_eraser := _solid_matte(Color(0.55, 0.12, 0.1), 0.85)
	_add_mesh_box(root, Vector3(0, 1.2, 0), Vector3(w, h, 0.06), mat_frame_d)
	_add_mesh_box(root, Vector3(0, 1.2 + h * 0.48, 0.02), Vector3(w - 0.04, 0.03, 0.04), mat_frame)
	_add_mesh_box(root, Vector3(0, 1.2 - h * 0.48, 0.02), Vector3(w - 0.04, 0.03, 0.04), mat_frame)
	_add_mesh_box(root, Vector3(-w * 0.48, 1.2, 0.02), Vector3(0.03, h - 0.06, 0.04), mat_frame)
	_add_mesh_box(root, Vector3(w * 0.48, 1.2, 0.02), Vector3(0.03, h - 0.06, 0.04), mat_frame)
	_add_mesh_box(root, Vector3(0, 1.2, 0.02), Vector3(w - 0.1, h - 0.1, 0.015), mat_slate_bg)
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
	_add_mesh_box(root, Vector3(0, 0.7, 0.05), Vector3(w - 0.1, 0.05, 0.1), mat_frame)
	_add_mesh_cyl(root, Vector3(-0.3, 0.76, 0.06), 0.012, 0.08, mat_chalk, false)
	_add_mesh_cyl(root, Vector3(-0.15, 0.76, 0.05), 0.012, 0.07, mat_chalk_d, false)
	if seed0 % 2 == 0:
		_add_mesh_cyl(root, Vector3(0.2, 0.76, 0.06), 0.012, 0.09, mat_chalk, false)
		_add_mesh_box(root, Vector3(0.4, 0.76, 0.05), Vector3(0.08, 0.02, 0.04), mat_eraser)
	else:
		_add_mesh_cyl(root, Vector3(0.15, 0.76, 0.06), 0.012, 0.08, mat_chalk, false)
		_add_mesh_cyl(root, Vector3(0.3, 0.76, 0.05), 0.01, 0.06, mat_chalk_d, false)
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
			# Loop 209: tight warm shadow under pot only (was pw*0.42 black void disc)
			_add_contact_shadow(root_plant, pw * 0.26, pw * 0.22)
			# Loop 74: denser mesh frond bulk ABOVE pot (~0.35*h) for walk-around sides
			_add_plant_mesh_fronds(root_plant, pw, ph, tex_path.find("fern") >= 0, int(prop.get("seed", 0)))
			return root_plant
	# Fallback full mesh plant — loop 206 solid-mat clay pot + fronds
	var root := Node3D.new()
	root.name = "Plant"
	var scale: float = prop.get("scale", 1.0)
	var tall: bool = prop.get("tall", false)
	var mat_leaf_a := _solid_matte(Color(0.26, 0.46, 0.2), 0.92)
	var mat_leaf_b := _solid_matte(Color(0.18, 0.36, 0.14), 0.92)
	var mat_leaf_c := _solid_matte(Color(0.32, 0.5, 0.24), 0.9)
	var mat_stem := _solid_matte(Color(0.2, 0.3, 0.12), 0.9)
	var mat_clay := _solid_matte(Color(0.7, 0.4, 0.22), 0.92)
	var mat_clay_l := _solid_matte(Color(0.78, 0.48, 0.28), 0.9)
	var mat_soil := _solid_matte(Color(0.16, 0.1, 0.06), 0.95)
	_add_mesh_cyl(root, Vector3(0, 0.18 * scale, 0), 0.2 * scale, 0.34 * scale, mat_clay, true)
	_add_mesh_cyl(root, Vector3(0, 0.35 * scale, 0), 0.24 * scale, 0.05 * scale, mat_clay_l, false)
	_add_mesh_cyl(root, Vector3(0, 0.37 * scale, 0), 0.17 * scale, 0.04 * scale, mat_soil, false)
	var stem_h := 0.42 * scale if tall else 0.22 * scale
	_add_mesh_cyl(root, Vector3(0, 0.4 * scale + stem_h * 0.5, 0), 0.025 * scale, stem_h, mat_stem, false)
	var crown_y := 0.42 * scale + stem_h
	var n_f := 8 if tall else 6
	for i in n_f:
		var ang := float(i) * TAU / float(n_f)
		var bl := (0.28 if tall else 0.2) * scale
		var tip := Vector3(cos(ang) * bl * 0.55, crown_y + 0.08 * scale, sin(ang) * bl * 0.55)
		_add_mesh_box(root, tip, Vector3(bl, 0.02 * scale, 0.04 * scale), mat_leaf_a if i % 2 == 0 else mat_leaf_b)
		_add_mesh_box(
			root,
			Vector3(cos(ang) * bl * 0.3, crown_y + 0.02 * scale, sin(ang) * bl * 0.3),
			Vector3(0.03 * scale, bl * 0.7, 0.025 * scale),
			mat_leaf_c if i % 2 == 0 else mat_leaf_a
		)
	_add_contact_shadow(root, 0.16 * scale, 0.16 * scale)
	return root


static func _add_plant_mesh_fronds(root: Node3D, pw: float, ph: float, is_fern: bool, seed0: int) -> void:
	## Loop 206: solid-mat frond side volume — no wood/clay washout on stems/leaves.
	## Loop 210: denser radial blades + thicker leaf pads so extreme side FOV isn't paper-thin.
	var pot_top := ph * 0.30
	var crown := ph * 0.78
	var mat_leaf_a := _solid_matte(Color(0.22, 0.42, 0.16), 0.92)
	var mat_leaf_b := _solid_matte(Color(0.16, 0.36, 0.12), 0.92)
	var mat_leaf_c := _solid_matte(Color(0.28, 0.48, 0.2), 0.9)
	var mat_stem := _solid_matte(Color(0.28, 0.24, 0.12), 0.88)
	var mat_clay := _solid_matte(Color(0.68, 0.4, 0.22), 0.92)
	var mat_clay_l := _solid_matte(Color(0.76, 0.48, 0.28), 0.9)
	var mat_soil := _solid_matte(Color(0.16, 0.1, 0.06), 0.95)
	# Mesh pot ring under card pot — side volume for terracotta (card still paints front)
	_add_mesh_cyl(root, Vector3(0, pot_top * 0.42, 0), pw * 0.16, pot_top * 0.72, mat_clay, false)
	_add_mesh_cyl(root, Vector3(0, pot_top * 0.78, 0), pw * 0.18, pot_top * 0.12, mat_clay_l, false)
	_add_mesh_cyl(root, Vector3(0, pot_top * 0.82, 0), pw * 0.13, pot_top * 0.08, mat_soil, false)
	var n_stems := 10 if is_fern else 9
	for i in n_stems:
		var ang := float(i) * (TAU / float(n_stems)) + float(seed0) * 0.41
		var r := pw * (0.07 + float(i % 3) * 0.025)
		var sx: float = cos(ang) * r
		var sz: float = sin(ang) * r
		var sh: float = (crown - pot_top) * (0.5 + float((i + seed0) % 4) * 0.1)
		_add_mesh_cyl(root, Vector3(sx, pot_top + sh * 0.5, sz), 0.01 * pw + 0.006, sh, mat_stem, false)
		var tip_y: float = pot_top + sh
		if is_fern:
			for j in 6:
				var t := float(j) / 5.0
				var fang := ang + (float(j % 2) * 2.0 - 1.0) * (0.55 + t * 0.28)
				var fl := pw * (0.18 + (1.0 - t) * 0.1)
				var fy := tip_y - t * sh * 0.55
				_add_mesh_box(
					root,
					Vector3(sx + cos(fang) * fl * 0.42, fy, sz + sin(fang) * fl * 0.42),
					Vector3(fl, 0.016 * ph, 0.04 * pw),
					mat_leaf_a if j % 2 == 0 else mat_leaf_b
				)
				var fang2 := fang + PI * 0.92
				_add_mesh_box(
					root,
					Vector3(sx + cos(fang2) * fl * 0.35, fy - 0.008 * ph, sz + sin(fang2) * fl * 0.35),
					Vector3(fl * 0.85, 0.014 * ph, 0.032 * pw),
					mat_leaf_c if j % 2 == 0 else mat_leaf_a
				)
		else:
			for j in 6:
				var pang := ang + float(j - 2.5) * 0.3
				var bl := pw * (0.24 + float(j % 3) * 0.055)
				var drop := 0.02 * ph + float(j) * 0.018 * ph
				_add_mesh_box(
					root,
					Vector3(sx + cos(pang) * bl * 0.55, tip_y - drop, sz + sin(pang) * bl * 0.55),
					Vector3(bl * 0.95, 0.018 * ph, 0.042 * pw),
					mat_leaf_c if j % 2 == 0 else mat_leaf_a
				)
				_add_mesh_box(
					root,
					Vector3(sx + cos(pang) * bl * 0.35, tip_y - drop - 0.01 * ph, sz + sin(pang) * bl * 0.35),
					Vector3(bl * 0.5, 0.014 * ph, 0.028 * pw),
					mat_leaf_b
				)
	# Dense mid-crown radial collar (fills side silhouette)
	for k in 14:
		var kang := float(k) * TAU / 14.0 + 0.15 + float(seed0 % 5) * 0.05
		var kr: float = pw * (0.14 + float(k % 3) * 0.04)
		var ky: float = pot_top + (crown - pot_top) * (0.28 + float(k % 5) * 0.11)
		var blade_len: float = pw * (0.14 + float(k % 2) * 0.05)
		_add_mesh_box(
			root,
			Vector3(cos(kang) * kr, ky, sin(kang) * kr),
			Vector3(blade_len, 0.018 * ph, 0.038 * pw),
			mat_leaf_b if k % 2 == 0 else mat_leaf_a
		)
	for k in 8:
		var kang := float(k) * TAU / 8.0 + 0.4
		var kr: float = pw * 0.11
		var ky: float = crown * 0.88
		_add_mesh_box(
			root,
			Vector3(cos(kang) * kr, ky, sin(kang) * kr),
			Vector3(pw * 0.16, 0.016 * ph, 0.04 * pw),
			mat_leaf_c if k % 2 == 0 else mat_leaf_a
		)
	# Vertical side pads at 4 compass points — break paper-thin card edge
	for qi in 4:
		var qang := float(qi) * PI * 0.5 + 0.2
		var qx: float = cos(qang) * pw * 0.18
		var qz: float = sin(qang) * pw * 0.18
		_add_mesh_box(
			root,
			Vector3(qx, pot_top + (crown - pot_top) * 0.45, qz),
			Vector3(pw * 0.12, ph * 0.22, pw * 0.08),
			mat_leaf_a if qi % 2 == 0 else mat_leaf_b
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
	## Loop 190: Victorian hall tree — turned post + brass hooks (not thin stick pole mid-FOV).
	var root := Node3D.new()
	root.name = "CoatStand"
	var seed0: int = int(prop.get("seed", 0))
	var mat_w := _solid_matte(Color(0.32, 0.18, 0.1) if seed0 % 2 == 0 else Color(0.22, 0.12, 0.07), 0.72)
	var mat_wd := _solid_matte(Color(0.22, 0.12, 0.07) if seed0 % 2 == 0 else Color(0.16, 0.09, 0.05), 0.75)
	var mat_wl := _solid_matte(Color(0.4, 0.24, 0.14), 0.7)
	var mat_br := _solid_metal(Color(0.72, 0.56, 0.28), 0.3)
	var mat_br_d := _solid_metal(Color(0.58, 0.44, 0.22), 0.34)
	var mat_hat := _solid_matte(Color(0.1, 0.1, 0.11), 0.85)
	var mat_hat_b := _solid_matte(Color(0.14, 0.12, 0.1), 0.85)
	var mat_coat_a := _solid_matte(Color(0.16, 0.12, 0.1) if seed0 % 3 != 1 else Color(0.1, 0.14, 0.2), 0.92)
	var mat_coat_b := _solid_matte(Color(0.2, 0.1, 0.08) if seed0 % 3 != 2 else Color(0.26, 0.2, 0.12), 0.92)
	var mat_scarf := _solid_matte(Color(0.38, 0.12, 0.12), 0.9)
	var mat_cane := _solid_matte(Color(0.28, 0.18, 0.1), 0.7)
	# Wide tripod-ish base disc + stepped foot (furniture mass, not pencil stick)
	_add_mesh_cyl(root, Vector3(0, 0.04, 0), 0.28, 0.06, mat_w, true)
	_add_mesh_cyl(root, Vector3(0, 0.1, 0), 0.18, 0.05, mat_wd, false)
	_add_mesh_cyl(root, Vector3(0, 0.18, 0), 0.1, 0.1, mat_wl, false)
	# Turned column: thick trunk with ring swellings (not one thin pole)
	_add_mesh_cyl(root, Vector3(0, 0.55, 0), 0.055, 0.55, mat_w, true)
	_add_mesh_cyl(root, Vector3(0, 1.0, 0), 0.05, 0.4, mat_wd, false)
	_add_mesh_cyl(root, Vector3(0, 1.4, 0), 0.055, 0.45, mat_w, false)
	_add_mesh_cyl(root, Vector3(0, 1.7, 0), 0.045, 0.2, mat_wd, false)
	# Turned ring beads
	for y in [0.4, 0.72, 1.15, 1.55]:
		_add_mesh_cyl(root, Vector3(0, y, 0), 0.075, 0.035, mat_wl, false)
	# Crown ball
	_add_mesh_cyl(root, Vector3(0, 1.85, 0), 0.06, 0.08, mat_br_d, false)
	# Brass hook ring + radial hooks (solid metal arms)
	_add_mesh_cyl(root, Vector3(0, 1.62, 0), 0.08, 0.04, mat_br, false)
	for i in 5:
		var a := deg_to_rad(float(i) * 72.0 + float(seed0) * 8.0)
		var hx := cos(a) * 0.14
		var hz := sin(a) * 0.14
		_add_mesh_box(root, Vector3(hx, 1.62, hz), Vector3(0.14, 0.022, 0.022), mat_br)
		_add_mesh_cyl(root, Vector3(cos(a) * 0.22, 1.6, sin(a) * 0.22), 0.018, 0.05, mat_br_d, false)
	# Mid peg ring for umbrellas / lower coats
	_add_mesh_cyl(root, Vector3(0, 1.05, 0), 0.07, 0.03, mat_br_d, false)
	for i in 3:
		var a := deg_to_rad(float(i) * 120.0 + 30.0)
		_add_mesh_box(root, Vector3(cos(a) * 0.12, 1.05, sin(a) * 0.12), Vector3(0.1, 0.018, 0.018), mat_br)
	# Hanging coats (soft fabric slabs with collar fold)
	_add_mesh_box(root, Vector3(0.16, 1.2, 0.04), Vector3(0.2, 0.75, 0.08), mat_coat_a)
	_add_mesh_box(root, Vector3(0.16, 1.55, 0.04), Vector3(0.18, 0.08, 0.1), mat_coat_a)
	if seed0 % 2 == 0:
		_add_mesh_box(root, Vector3(-0.12, 1.1, -0.08), Vector3(0.16, 0.55, 0.07), mat_coat_b)
		_add_mesh_box(root, Vector3(-0.12, 1.38, -0.08), Vector3(0.14, 0.06, 0.09), mat_coat_b)
	# Hat: top hat vs bowler
	if seed0 % 3 == 0:
		_add_mesh_cyl(root, Vector3(0.08, 1.88, 0.08), 0.1, 0.035, mat_hat, false)
		_add_mesh_cyl(root, Vector3(0.08, 1.98, 0.08), 0.065, 0.15, mat_hat, false)
		_add_mesh_cyl(root, Vector3(0.08, 1.9, 0.08), 0.07, 0.02, mat_hat_b, false)
	elif seed0 % 3 == 1:
		_add_mesh_cyl(root, Vector3(-0.06, 1.9, -0.06), 0.09, 0.045, mat_hat_b, false)
		_add_mesh_cyl(root, Vector3(-0.06, 1.97, -0.06), 0.07, 0.08, mat_hat_b, false)
	# Scarf drape / cane
	if seed0 % 2 == 0:
		_add_mesh_box(root, Vector3(0.1, 1.3, -0.12), Vector3(0.1, 0.4, 0.035), mat_scarf)
		_add_mesh_box(root, Vector3(0.12, 1.08, -0.14), Vector3(0.08, 0.06, 0.04), mat_scarf)
	else:
		_add_mesh_cyl(root, Vector3(-0.2, 0.85, 0.05), 0.014, 1.35, mat_cane, false)
		_add_mesh_cyl(root, Vector3(-0.2, 1.52, 0.05), 0.025, 0.05, mat_br_d, false)
	_add_contact_shadow(root, 0.32, 0.32)
	return root

static func _make_umbrella_stand(prop: Dictionary) -> Node3D:
	## Loop 191: Victorian stick stand — ceramic/oak pot + brass rim + umbrella crooks
	## (not anonymous dark cylinder mid-FOV).
	var root := Node3D.new()
	root.name = "UmbrellaStand"
	var seed0: int = int(prop.get("seed", 0))
	var mat_br := _solid_metal(Color(0.72, 0.56, 0.28), 0.3)
	var mat_br_d := _solid_metal(Color(0.55, 0.42, 0.2), 0.35)
	var mat_stick := _solid_matte(Color(0.22, 0.14, 0.08), 0.75)
	var mat_stick_b := _solid_matte(Color(0.14, 0.1, 0.08), 0.8)
	var mat_handle := _solid_matte(Color(0.35, 0.22, 0.12), 0.7)
	if seed0 % 2 == 0:
		var mat_w := _solid_matte(Color(0.28, 0.16, 0.09), 0.72)
		var mat_wd := _solid_matte(Color(0.2, 0.11, 0.06), 0.75)
		# Turned oak jar: foot + belly + brass rim
		_add_mesh_cyl(root, Vector3(0, 0.04, 0), 0.16, 0.06, mat_wd, true)
		_add_mesh_cyl(root, Vector3(0, 0.28, 0), 0.14, 0.42, mat_w, false)
		_add_mesh_cyl(root, Vector3(0, 0.52, 0), 0.155, 0.05, mat_br, false)
		_add_mesh_cyl(root, Vector3(0, 0.56, 0), 0.14, 0.03, mat_br_d, false)
		# Inner dark well
		_add_mesh_cyl(root, Vector3(0, 0.35, 0), 0.1, 0.28, mat_wd, false)
	else:
		# Ceramic stand with glaze band + foot
		var mat_cer := _solid_matte(Color(0.78, 0.72, 0.6), 0.88)
		var mat_cer_d := _solid_matte(Color(0.62, 0.55, 0.44), 0.9)
		var mat_glaze := _solid_matte(Color(0.45, 0.22, 0.16), 0.75)
		var mat_clay := _solid_matte(Color(0.55, 0.36, 0.22), 0.88)
		_add_mesh_cyl(root, Vector3(0, 0.04, 0), 0.17, 0.05, mat_clay, true)
		_add_mesh_cyl(root, Vector3(0, 0.28, 0), 0.15, 0.42, mat_cer, false)
		_add_mesh_cyl(root, Vector3(0, 0.35, 0), 0.155, 0.08, mat_glaze, false)
		_add_mesh_cyl(root, Vector3(0, 0.52, 0), 0.17, 0.04, mat_cer_d, false)
		_add_mesh_cyl(root, Vector3(0, 0.35, 0), 0.11, 0.28, mat_cer_d, false)
	# Umbrellas / sticks with crook handles (identity, not bare nubs)
	var n := 3 + seed0 % 2
	for i in n:
		var ang := float(i) * 0.9 + float(seed0) * 0.2
		var ox := cos(ang) * 0.05
		var oz := sin(ang) * 0.04
		var h := 0.55 + float((i + seed0) % 3) * 0.1
		var smat: Material = mat_stick if i % 2 == 0 else mat_stick_b
		_add_mesh_cyl(root, Vector3(ox, 0.55 + h * 0.45, oz), 0.014 + float(i) * 0.002, h, smat, false)
		# Crook handle (horizontal + tip)
		_add_mesh_box(root, Vector3(ox + 0.04, 0.55 + h * 0.9, oz), Vector3(0.08, 0.025, 0.025), mat_handle)
		_add_mesh_cyl(root, Vector3(ox + 0.07, 0.55 + h * 0.85, oz), 0.02, 0.05, mat_handle, false)
	_add_contact_shadow(root, 0.2, 0.2)
	return root

# ─── Features ────────────────────────────────────────────────────────────────

static func _make_chandelier(_prop: Dictionary) -> Node3D:
	## Loop 184: Victorian brass gasolier — ring arms + frosted alpha shades
	## (not cream ice-cream cone cluster mid-FOV).
	var root := Node3D.new()
	root.name = "Chandelier"
	var hang: float = float(_prop.get("hang", 2.95))
	var mat_br := _solid_metal(BRASS, 0.28)
	var mat_br_d := _solid_metal(BRASS.darkened(0.12), 0.32)
	var mat_br_l := _solid_metal(BRASS.lightened(0.08), 0.25)
	var mat_rose := _solid_matte(Color(0.82, 0.78, 0.7), 0.85)
	# Frosted amber glass — alpha so never brass path; soft emission
	var mat_shade := StandardMaterial3D.new()
	mat_shade.albedo_color = Color(0.92, 0.78, 0.48, 0.55)
	mat_shade.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	mat_shade.metallic = 0.0
	mat_shade.roughness = 0.35
	mat_shade.emission_enabled = true
	mat_shade.emission = Color(1.0, 0.82, 0.45)
	mat_shade.emission_energy_multiplier = 0.55
	mat_shade.shading_mode = BaseMaterial3D.SHADING_MODE_PER_PIXEL
	var mat_shade_i := StandardMaterial3D.new()
	mat_shade_i.albedo_color = Color(1.0, 0.9, 0.6, 0.35)
	mat_shade_i.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	mat_shade_i.metallic = 0.0
	mat_shade_i.roughness = 0.25
	mat_shade_i.emission_enabled = true
	mat_shade_i.emission = Color(1.0, 0.88, 0.55)
	mat_shade_i.emission_energy_multiplier = 0.9
	mat_shade_i.shading_mode = BaseMaterial3D.SHADING_MODE_PER_PIXEL
	# Ceiling rose + brass drop rod
	_add_mesh_cyl(root, Vector3(0, hang + 0.3, 0), 0.16, 0.04, mat_rose, false)
	_add_mesh_cyl(root, Vector3(0, hang + 0.26, 0), 0.08, 0.035, mat_br_d, false)
	_add_mesh_cyl(root, Vector3(0, hang + 0.08, 0), 0.018, 0.32, mat_br, false)
	# Central body (compact brass reservoir — not tall glass stack)
	_add_mesh_cyl(root, Vector3(0, hang - 0.05, 0), 0.1, 0.05, mat_br_d, false)
	_add_mesh_cyl(root, Vector3(0, hang - 0.12, 0), 0.15, 0.09, mat_br, false)
	_add_mesh_cyl(root, Vector3(0, hang - 0.18, 0), 0.1, 0.04, mat_br_l, false)
	# Brass arm ring (identity of gasolier)
	_add_mesh_cyl(root, Vector3(0, hang - 0.08, 0), 0.32, 0.02, mat_br_d, false)
	# Six curved arms + compact bell shades
	for i in 6:
		var a := float(i) * 60.0
		var rad := deg_to_rad(a)
		var ax: float = cos(rad) * 0.42
		var az: float = sin(rad) * 0.42
		# Arm segments (stepped curve outward + down)
		_add_mesh_box(root, Vector3(ax * 0.35, hang - 0.06, az * 0.35), Vector3(0.16, 0.028, 0.028), mat_br)
		_add_mesh_box(root, Vector3(ax * 0.7, hang - 0.12, az * 0.7), Vector3(0.14, 0.024, 0.024), mat_br_d)
		# Cup + nozzle
		_add_mesh_cyl(root, Vector3(ax, hang - 0.16, az), 0.035, 0.04, mat_br, false)
		_add_mesh_cyl(root, Vector3(ax, hang - 0.19, az), 0.05, 0.02, mat_br_d, false)
		# Bell shade: wider OPEN mouth DOWN, shorter (not tall ice-cream cone)
		# top narrow (at jet), bottom wider (mouth)
		var shade := MeshInstance3D.new()
		var sm := CylinderMesh.new()
		sm.top_radius = 0.04
		sm.bottom_radius = 0.09
		sm.height = 0.12
		sm.radial_segments = 12
		shade.mesh = sm
		shade.material_override = mat_shade
		shade.position = Vector3(ax, hang - 0.26, az)
		root.add_child(shade)
		# Inner glow
		var inner := MeshInstance3D.new()
		var im := CylinderMesh.new()
		im.top_radius = 0.02
		im.bottom_radius = 0.05
		im.height = 0.08
		im.radial_segments = 10
		inner.mesh = im
		inner.material_override = mat_shade_i
		inner.position = Vector3(ax, hang - 0.24, az)
		root.add_child(inner)
		# Gallery ring at mouth
		_add_mesh_cyl(root, Vector3(ax, hang - 0.32, az), 0.085, 0.012, mat_br_d, false)
		# Flame
		var _fl7 := StandardMaterial3D.new()
		_fl7.albedo_color = Color(1.0, 0.8, 0.4, 0.9)
		_fl7.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
		_fl7.emission_enabled = true
		_fl7.emission = Color(1.0, 0.72, 0.3)
		_fl7.emission_energy_multiplier = 1.7
		_fl7.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		_add_mesh_cyl(root, Vector3(ax, hang - 0.2, az), 0.022, 0.0286, _fl7, false)
	# Crystal pendants under bowl (subtle, not long sticks)
	for j in 6:
		var ja := float(j) * 60.0 + 20.0
		var jr := deg_to_rad(ja)
		_add_mesh_box(
			root,
			Vector3(cos(jr) * 0.1, hang - 0.26, sin(jr) * 0.1),
			Vector3(0.014, 0.07, 0.014),
			_solid_matte(Color(0.75, 0.78, 0.82), 0.25)
		)
	var light := OmniLight3D.new()
	light.light_color = Color(1.0, 0.86, 0.58)
	light.light_energy = 1.25
	light.omni_range = 7.8
	light.position = Vector3(0, hang - 0.2, 0)
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
	## Loop 201: marble surround + mantel kit + fender/tools — solid mats (no stone/brass/wood washout).
	var root := Node3D.new()
	root.name = "Fireplace"
	var seed0: int = int(prop.get("seed", 0))
	var mat_marble := _solid_matte(Color(0.82, 0.8, 0.76), 0.35)
	var mat_marble_d := _solid_matte(Color(0.72, 0.7, 0.66), 0.38)
	var mat_marble_dd := _solid_matte(Color(0.65, 0.63, 0.58), 0.4)
	var mat_marble_l := _solid_matte(Color(0.88, 0.86, 0.82), 0.32)
	var mat_soot := _solid_matte(Color(0.06, 0.05, 0.05), 0.92)
	var mat_soot_l := _solid_matte(Color(0.1, 0.09, 0.09), 0.85)
	var mat_br := _solid_metal(Color(0.72, 0.56, 0.28), 0.3)
	var mat_br_d := _solid_metal(Color(0.55, 0.42, 0.2), 0.35)
	var mat_br_l := _solid_metal(Color(0.78, 0.62, 0.32), 0.28)
	var mat_iron := _solid_metal(Color(0.36, 0.36, 0.38), 0.48)
	var mat_iron_l := _solid_metal(Color(0.44, 0.44, 0.46), 0.45)
	var mat_iron_d := _solid_metal(Color(0.28, 0.28, 0.3), 0.52)
	var mat_tool := _solid_metal(Color(0.28, 0.28, 0.3), 0.5)
	var mat_tool_l := _solid_metal(Color(0.36, 0.36, 0.38), 0.48)
	var mat_stone := _solid_matte(Color(0.55, 0.52, 0.46), 0.85)
	var mat_stone_d := _solid_matte(Color(0.45, 0.42, 0.36), 0.88)
	var mat_m := _solid_matte(Color(0.3, 0.14, 0.08), 0.72)
	var mat_md := _solid_matte(Color(0.18, 0.09, 0.05), 0.78)
	var mat_log := _solid_matte(Color(0.25, 0.12, 0.06), 0.85)
	var mat_ash := _solid_matte(Color(0.22, 0.18, 0.14), 0.9)
	var mat_candle := _solid_matte(Color(0.95, 0.82, 0.45), 0.7)
	var mat_cream := _solid_matte(Color(0.82, 0.76, 0.64), 0.9)
	var mat_cream_d := _solid_matte(Color(0.7, 0.64, 0.52), 0.9)
	var mat_clock := _solid_matte(Color(0.88, 0.85, 0.78), 0.45)
	var mat_clock_case := _solid_matte(Color(0.12, 0.1, 0.1), 0.55)
	var mat_vase := _solid_matte(Color(0.35, 0.2, 0.15), 0.75)
	var mat_coal := _solid_matte(Color(0.22, 0.2, 0.18), 0.7)
	var mat_coal_l := _solid_matte(Color(0.28, 0.26, 0.24), 0.65)
	var mat_coal_d := _solid_matte(Color(0.18, 0.14, 0.1), 0.8)
	var mat_flame := StandardMaterial3D.new()
	mat_flame.albedo_color = Color(1.0, 0.75, 0.35, 0.9)
	mat_flame.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	mat_flame.emission_enabled = true
	mat_flame.emission = Color(1.0, 0.7, 0.3)
	mat_flame.emission_energy_multiplier = 2.0
	mat_flame.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	# Outer surround body + fielded lintel moulding stack
	_add_mesh_box(root, Vector3(0, 0.72, -0.05), Vector3(1.75, 1.45, 0.42), mat_marble)
	_add_mesh_box(root, Vector3(0, 1.28, 0.1), Vector3(1.55, 0.06, 0.14), mat_marble_d)
	_add_mesh_box(root, Vector3(0, 1.35, 0.1), Vector3(1.6, 0.08, 0.16), mat_marble_dd)
	# Inner dark firebox recess + arched lintel lip
	_add_mesh_box(root, Vector3(0, 0.55, 0.12), Vector3(0.95, 0.85, 0.28), mat_soot)
	_add_mesh_box(root, Vector3(0, 0.95, 0.2), Vector3(0.88, 0.06, 0.1), mat_soot_l)
	# Mantel shelf
	_add_mesh_box(root, Vector3(0, 1.45, 0.02), Vector3(1.95, 0.1, 0.55), mat_marble)
	_add_mesh_box(root, Vector3(0, 1.5, 0.05), Vector3(1.85, 0.03, 0.48), mat_marble_l)
	_add_mesh_box(root, Vector3(0, 1.42, 0.22), Vector3(1.9, 0.04, 0.08), mat_marble_d)
	# Chimney-glass overmantel — silvered plate
	_add_mesh_box(root, Vector3(0, 1.95, 0.0), Vector3(1.05, 0.85, 0.08), mat_br_d)
	_add_mesh_box(root, Vector3(0, 1.95, 0.04), Vector3(0.92, 0.72, 0.04), mat_br_d)
	_add_mesh_box(root, Vector3(0, 1.95, 0.055), Vector3(0.82, 0.62, 0.02), mat_soot_l)
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
	_add_mesh_box(root, Vector3(0, 2.42, 0.02), Vector3(0.28, 0.1, 0.05), mat_br_l)
	_add_mesh_cyl(root, Vector3(0, 2.5, 0.03), 0.035, 0.04, mat_br, false)
	# Mantel ornaments by seed
	match seed0 % 3:
		0:
			for sx in [-0.58, 0.58]:
				_add_mesh_cyl(root, Vector3(sx, 1.54, 0.08), 0.055, 0.035, mat_md, false)
				_add_mesh_cyl(root, Vector3(sx, 1.62, 0.08), 0.03, 0.12, mat_m, false)
				_add_mesh_cyl(root, Vector3(sx, 1.7, 0.08), 0.045, 0.025, mat_br_d, false)
				_add_mesh_cyl(root, Vector3(sx, 1.88, 0.08), 0.02, 0.28, mat_candle, false)
				_add_mesh_cyl(root, Vector3(sx, 2.04, 0.08), 0.025, 0.035, mat_flame, false)
			_add_mesh_box(root, Vector3(0, 1.6, 0.1), Vector3(0.22, 0.18, 0.12), mat_clock_case)
			_add_mesh_box(root, Vector3(0, 1.72, 0.12), Vector3(0.14, 0.12, 0.06), mat_clock)
			_add_mesh_box(root, Vector3(0, 1.8, 0.1), Vector3(0.18, 0.03, 0.1), mat_br_d)
		1:
			for sxu in [-0.55, 0.55]:
				_add_mesh_cyl(root, Vector3(sxu, 1.56, 0.08), 0.055, 0.045, mat_cream_d, false)
				_add_mesh_cyl(root, Vector3(sxu, 1.68, 0.08), 0.08, 0.2, mat_cream, false)
				_add_mesh_cyl(root, Vector3(sxu, 1.8, 0.08), 0.05, 0.04, mat_cream, false)
			for sx2 in [-0.15, 0.15]:
				_add_mesh_cyl(root, Vector3(sx2, 1.54, 0.1), 0.04, 0.03, mat_md, false)
				_add_mesh_cyl(root, Vector3(sx2, 1.66, 0.1), 0.022, 0.2, mat_candle, false)
				_add_mesh_cyl(root, Vector3(sx2, 1.8, 0.1), 0.02, 0.03, mat_flame, false)
		_:
			_add_mesh_box(root, Vector3(0.0, 1.62, 0.08), Vector3(0.2, 0.28, 0.12), mat_br_d)
			_add_mesh_box(root, Vector3(0.0, 1.68, 0.12), Vector3(0.14, 0.14, 0.03), mat_clock)
			_add_mesh_box(root, Vector3(0.0, 1.8, 0.08), Vector3(0.16, 0.03, 0.1), mat_br)
			_add_mesh_cyl(root, Vector3(-0.52, 1.58, 0.08), 0.055, 0.18, mat_vase, false)
			_add_mesh_cyl(root, Vector3(0.52, 1.58, 0.08), 0.055, 0.18, mat_vase, false)
	# Columns / pilasters with capital + plinth
	_add_mesh_box(root, Vector3(-0.72, 0.7, 0.12), Vector3(0.16, 1.25, 0.22), mat_marble)
	_add_mesh_box(root, Vector3(0.72, 0.7, 0.12), Vector3(0.16, 1.25, 0.22), mat_marble)
	_add_mesh_box(root, Vector3(-0.72, 1.3, 0.14), Vector3(0.22, 0.1, 0.26), mat_marble_d)
	_add_mesh_box(root, Vector3(0.72, 1.3, 0.14), Vector3(0.22, 0.1, 0.26), mat_marble_d)
	_add_mesh_box(root, Vector3(-0.72, 0.12, 0.14), Vector3(0.22, 0.12, 0.26), mat_marble_dd)
	_add_mesh_box(root, Vector3(0.72, 0.12, 0.14), Vector3(0.22, 0.12, 0.26), mat_marble_dd)
	# Hearth slab + ash lip
	_add_mesh_box(root, Vector3(0, 0.04, 0.35), Vector3(1.55, 0.08, 0.58), mat_stone)
	_add_mesh_box(root, Vector3(0, 0.08, 0.38), Vector3(1.25, 0.03, 0.42), mat_stone_d)
	# Iron fender rail
	_add_mesh_box(root, Vector3(0, 0.16, 0.58), Vector3(1.35, 0.04, 0.05), mat_iron)
	_add_mesh_box(root, Vector3(0, 0.28, 0.58), Vector3(1.3, 0.025, 0.035), mat_iron_l)
	for fx in [-0.62, -0.2, 0.2, 0.62]:
		_add_mesh_cyl(root, Vector3(fx, 0.22, 0.58), 0.018, 0.14, mat_iron_d, false)
	_add_mesh_cyl(root, Vector3(-0.68, 0.14, 0.58), 0.04, 0.08, mat_iron, false)
	_add_mesh_cyl(root, Vector3(0.68, 0.14, 0.58), 0.04, 0.08, mat_iron, false)
	# Andirons
	for sx in [-1.0, 1.0]:
		_add_mesh_box(root, Vector3(sx * 0.3, 0.16, 0.3), Vector3(0.07, 0.22, 0.2), mat_iron)
		_add_mesh_box(root, Vector3(sx * 0.3, 0.28, 0.22), Vector3(0.05, 0.08, 0.08), mat_iron_l)
		_add_mesh_cyl(root, Vector3(sx * 0.3, 0.1, 0.42), 0.03, 0.08, mat_iron_d, false)
		_add_mesh_cyl(root, Vector3(sx * 0.3, 0.32, 0.22), 0.02, 0.03, mat_br_d, false)
	# Grate bars
	for i in 5:
		var gx := -0.32 + float(i) * 0.16
		_add_mesh_box(root, Vector3(gx, 0.2, 0.22), Vector3(0.025, 0.22, 0.04), mat_iron_d)
	# Logs
	_add_mesh_box(root, Vector3(-0.12, 0.24, 0.2), Vector3(0.55, 0.1, 0.16), mat_md)
	_add_mesh_box(root, Vector3(0.15, 0.3, 0.22), Vector3(0.45, 0.09, 0.14), mat_m)
	_add_mesh_box(root, Vector3(0.0, 0.36, 0.18), Vector3(0.35, 0.08, 0.12), mat_log)
	# Ash bed
	_add_mesh_box(root, Vector3(0, 0.14, 0.25), Vector3(0.7, 0.04, 0.28), mat_ash)
	# Fire-tool stand + poker / shovel / tongs
	_add_mesh_cyl(root, Vector3(0.78, 0.08, 0.42), 0.08, 0.04, mat_tool, false)
	_add_mesh_cyl(root, Vector3(0.78, 0.35, 0.42), 0.018, 0.55, mat_tool_l, false)
	_add_mesh_cyl(root, Vector3(0.78, 0.65, 0.42), 0.1, 0.03, mat_tool, false)
	_add_mesh_cyl(root, Vector3(0.72, 0.42, 0.48), 0.01, 0.7, mat_iron_d, false)
	_add_mesh_box(root, Vector3(0.72, 0.08, 0.48), Vector3(0.03, 0.04, 0.06), mat_tool)
	_add_mesh_cyl(root, Vector3(0.72, 0.78, 0.48), 0.022, 0.04, mat_br_d, false)
	_add_mesh_cyl(root, Vector3(0.84, 0.4, 0.38), 0.01, 0.62, mat_iron_d, false)
	_add_mesh_box(root, Vector3(0.84, 0.1, 0.38), Vector3(0.1, 0.02, 0.08), mat_tool)
	_add_mesh_box(root, Vector3(0.84, 0.12, 0.34), Vector3(0.08, 0.04, 0.02), mat_tool_l)
	_add_mesh_cyl(root, Vector3(0.84, 0.72, 0.38), 0.02, 0.035, mat_br_d, false)
	_add_mesh_box(root, Vector3(0.78, 0.4, 0.5), Vector3(0.012, 0.55, 0.012), mat_tool)
	_add_mesh_box(root, Vector3(0.82, 0.4, 0.5), Vector3(0.012, 0.55, 0.012), mat_tool)
	_add_mesh_box(root, Vector3(0.8, 0.12, 0.5), Vector3(0.06, 0.02, 0.04), mat_iron_d)
	# Coal scuttle
	_add_mesh_cyl(root, Vector3(-0.82, 0.18, 0.4), 0.14, 0.28, mat_coal, false)
	_add_mesh_cyl(root, Vector3(-0.82, 0.34, 0.4), 0.15, 0.04, mat_coal_l, false)
	_add_mesh_box(root, Vector3(-0.82, 0.22, 0.52), Vector3(0.04, 0.12, 0.08), mat_tool)
	_add_mesh_box(root, Vector3(-0.7, 0.12, 0.4), Vector3(0.12, 0.06, 0.1), mat_coal_d)
	# Organic flame (spheres + tapered cylinders) — not flat yellow slabs
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
	## Loop 205: sash window — solid-mat mahogany frame + drapery (hollow aperture kept).
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
	var mat_m := _solid_matte(Color(0.3, 0.14, 0.08), 0.72)
	var mat_md := _solid_matte(Color(0.18, 0.09, 0.05), 0.78)
	_add_mesh_box(root, Vector3(-w * 0.5, h * 0.5, 0), Vector3(stile, h, frame_d), mat_m, true)
	_add_mesh_box(root, Vector3(w * 0.5, h * 0.5, 0), Vector3(stile, h, frame_d), mat_m, true)
	_add_mesh_box(root, Vector3(0, h - stile * 0.5, 0), Vector3(w, stile, frame_d), mat_m, true)
	_add_mesh_box(root, Vector3(0, stile * 0.5, 0), Vector3(w, stile, frame_d), mat_m, true)
	_add_mesh_box(root, Vector3(0, h + 0.04, 0.02), Vector3(w + 0.18, 0.08, 0.16), mat_md)
	_add_mesh_box(root, Vector3(0, 0.02, 0.1), Vector3(w + 0.22, 0.07, 0.24), mat_m)
	_add_mesh_box(root, Vector3(0, h * 0.5, 0.03), Vector3(0.045, h - stile * 2.0, 0.04), mat_md)
	_add_mesh_box(root, Vector3(0, h * 0.5, 0.03), Vector3(w - stile * 2.0, 0.045, 0.04), mat_md)
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
		vmat.albedo_color = Color(1.05, 1.05, 1.0)
	else:
		vmat.albedo_color = Color(0.42, 0.62, 0.38)
	vmat.roughness = 1.0
	vmat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	vmat.cull_mode = BaseMaterial3D.CULL_DISABLED
	view_mi.material_override = vmat
	view_mi.position = Vector3(0, h * 0.5, 0.02)
	root.add_child(view_mi)
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
	var fill := OmniLight3D.new()
	fill.light_color = Color(0.85, 0.92, 1.0)
	fill.light_energy = 0.65
	fill.omni_range = 4.2
	fill.position = Vector3(0, h * 0.55, 0.45)
	root.add_child(fill)
	if bool(feat.get("curtains", false)):
		var drape: Color = feat.get("curtain_color", Color(0.38, 0.28, 0.22))
		var mat_drape := _solid_matte(drape, 0.9)
		var mat_drape_d := _solid_matte(drape.darkened(0.12), 0.92)
		var mat_drape_l := _solid_matte(drape.lightened(0.08), 0.9)
		var mat_br_d := _solid_metal(Color(0.55, 0.42, 0.2), 0.35)
		_add_mesh_box(root, Vector3(0, h + 0.02, 0.14), Vector3(w + 0.28, 0.1, 0.12), mat_md)
		_add_mesh_box(root, Vector3(0, h - 0.02, 0.16), Vector3(w + 0.22, 0.04, 0.08), mat_drape_d)
		for sx in [-1.0, 1.0]:
			var px: float = sx * (w * 0.38)
			_add_mesh_box(root, Vector3(px, h * 0.48, 0.12), Vector3(w * 0.22, h * 0.88, 0.06), mat_drape)
			_add_mesh_box(root, Vector3(px + sx * 0.04, h * 0.48, 0.14), Vector3(0.03, h * 0.82, 0.04), mat_drape_d)
			_add_mesh_box(root, Vector3(px - sx * 0.05, h * 0.45, 0.14), Vector3(0.025, h * 0.75, 0.035), mat_drape_l)
			_add_mesh_cyl(root, Vector3(px, h * 0.35, 0.18), 0.02, 0.08, mat_br_d, false)
			_add_mesh_box(root, Vector3(px + sx * 0.06, h * 0.35, 0.16), Vector3(0.1, 0.025, 0.03), mat_drape_d)
		_add_mesh_box(root, Vector3(-w * 0.35, 0.08, 0.14), Vector3(0.18, 0.06, 0.1), mat_drape_d)
		_add_mesh_box(root, Vector3(w * 0.35, 0.08, 0.14), Vector3(0.18, 0.06, 0.1), mat_drape_d)
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
	# Loop 205: solid-mat sill + iron glazing bars (no iron/stone washout)
	var mat_stone := _solid_matte(Color(0.5, 0.47, 0.42), 0.85)
	var mat_br_d := _solid_metal(Color(0.55, 0.42, 0.2), 0.35)
	var mat_iron := _solid_metal(Color(0.34, 0.34, 0.36), 0.48)
	var mat_iron_l := _solid_metal(Color(0.42, 0.42, 0.44), 0.45)
	_add_mesh_box(root, Vector3(0, 0.06, 0.08), Vector3(w - 0.1, 0.08, 0.12), mat_stone)
	for sx in [-1.0, 1.0]:
		for sy in [0.08, h - 0.08]:
			_add_mesh_box(root, Vector3(sx * (w * 0.5 - 0.05), sy, 0.14), Vector3(0.08, 0.06, 0.06), mat_br_d)
	var bar := 0.07
	_add_mesh_box(root, Vector3(0, bar * 0.5, 0.1), Vector3(w, bar, 0.09), mat_iron, true)
	_add_mesh_box(root, Vector3(0, h - bar * 0.5, 0.1), Vector3(w, bar, 0.09), mat_iron, true)
	_add_mesh_box(root, Vector3(-w * 0.5 + bar * 0.5, h * 0.5, 0.1), Vector3(bar, h, 0.09), mat_iron, true)
	_add_mesh_box(root, Vector3(w * 0.5 - bar * 0.5, h * 0.5, 0.1), Vector3(bar, h, 0.09), mat_iron, true)
	for i in 4:
		var fx2 := -w * 0.35 + float(i) * (w * 0.23)
		_add_mesh_box(root, Vector3(fx2, h * 0.5, 0.11), Vector3(0.035, h - 0.14, 0.04), mat_iron_l)
	for j in 3:
		var fy := h * 0.22 * float(j + 1)
		_add_mesh_box(root, Vector3(0, fy, 0.11), Vector3(w - 0.14, 0.035, 0.04), mat_iron_l)
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
	## Loop 204: 4-panel door + architrave — solid-mat wood + brass (no washout mid-FOV).
	## Collision preserved on leaf/case so closed leaf blocks walk-into-void.
	var root := Node3D.new()
	root.name = "DoorFrame"
	var pos: Array = feat.get("pos", [0, 0, 0])
	root.position = Vector3(float(pos[0]), 0.0, float(pos[2]))
	root.rotation_degrees.y = feat.get("yaw", 0.0)
	var w: float = feat.get("width", 1.5)
	var h: float = feat.get("height", 2.35)
	var seed0: int = int(feat.get("seed", int(absf(float(pos[0]) * 7.0 + float(pos[2]) * 3.0))))
	var depth := 0.18
	var door_wood: Color
	var door_frame_col: Color
	var panel_field: Color
	var case_col: Color
	match seed0 % 3:
		0:
			door_wood = Color(0.42, 0.28, 0.16)
			door_frame_col = Color(0.34, 0.22, 0.12)
			panel_field = Color(0.36, 0.24, 0.14)
			case_col = Color(0.3, 0.14, 0.08)
		1:
			door_wood = Color(0.28, 0.16, 0.1)
			door_frame_col = Color(0.2, 0.12, 0.07)
			panel_field = Color(0.24, 0.14, 0.09)
			case_col = Color(0.18, 0.09, 0.05)
		_:
			door_wood = Color(0.5, 0.36, 0.2)
			door_frame_col = Color(0.4, 0.28, 0.15)
			panel_field = Color(0.45, 0.32, 0.18)
			case_col = Color(0.48, 0.34, 0.18)
	var mat_wood := _solid_matte(door_wood, 0.72)
	var mat_wood_l := _solid_matte(door_wood.lightened(0.1), 0.7)
	var mat_wood_d := _solid_matte(door_wood.darkened(0.12), 0.75)
	var mat_frame := _solid_matte(door_frame_col, 0.75)
	var mat_panel := _solid_matte(panel_field, 0.78)
	var mat_case := _solid_matte(case_col, 0.72)
	var mat_stone := _solid_matte(Color(0.48, 0.45, 0.4), 0.85)
	var mat_br := _solid_metal(Color(0.72, 0.56, 0.28), 0.3)
	var mat_br_d := _solid_metal(Color(0.55, 0.42, 0.2), 0.35)
	var mat_br_l := _solid_metal(Color(0.78, 0.62, 0.32), 0.28)
	var mat_key := _solid_matte(Color(0.12, 0.1, 0.08), 0.85)
	# Outer architrave (collision)
	_add_mesh_box(root, Vector3(-w * 0.5 - 0.06, h * 0.5, 0), Vector3(0.14, h + 0.08, depth + 0.06), mat_frame, true)
	_add_mesh_box(root, Vector3(w * 0.5 + 0.06, h * 0.5, 0), Vector3(0.14, h + 0.08, depth + 0.06), mat_frame, true)
	_add_mesh_box(root, Vector3(0, h + 0.05, 0), Vector3(w + 0.34, 0.14, depth + 0.08), mat_case, true)
	_add_mesh_box(root, Vector3(-w * 0.5 + 0.02, h * 0.5, 0.06), Vector3(0.04, h - 0.05, 0.04), mat_case)
	_add_mesh_box(root, Vector3(w * 0.5 - 0.02, h * 0.5, 0.06), Vector3(0.04, h - 0.05, 0.04), mat_case)
	_add_mesh_box(root, Vector3(0, 0.025, 0.02), Vector3(w + 0.18, 0.05, depth + 0.24), mat_stone, true)
	_add_mesh_box(root, Vector3(0, 0.055, 0.02), Vector3(w + 0.12, 0.04, depth + 0.14), mat_frame)
	_add_mesh_box(root, Vector3(0, 0.04, 0.05), Vector3(w - 0.06, 0.08, 0.1), mat_wood_d, true)
	# Warm under-leaf glow (next room light leak)
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
	_add_mesh_box(root, Vector3(0, h + 0.12, 0.02), Vector3(w + 0.28, 0.08, depth + 0.1), mat_case)
	_add_mesh_box(root, Vector3(0, h + 0.18, 0.04), Vector3(w * 0.4, 0.05, 0.08), mat_br_d)
	_add_mesh_box(root, Vector3(-w * 0.5 - 0.06, 0.04, 0), Vector3(0.18, 0.12, depth + 0.1), mat_frame, true)
	_add_mesh_box(root, Vector3(w * 0.5 + 0.06, 0.04, 0), Vector3(0.18, 0.12, depth + 0.1), mat_frame, true)
	# Closed leaf — solid collision blocks walk-through
	var leaf_w := w - 0.1
	var leaf_h := h - 0.05
	var leaf := Node3D.new()
	leaf.name = "DoorLeaf"
	leaf.position = Vector3(-w * 0.5 + 0.05, 0.04, 0.04)
	leaf.rotation_degrees.y = 0.0
	root.add_child(leaf)
	_add_mesh_box(leaf, Vector3(leaf_w * 0.5, leaf_h * 0.5, 0), Vector3(leaf_w, leaf_h, 0.048), mat_wood, true)
	_add_mesh_box(leaf, Vector3(leaf_w * 0.5, 0.04, 0.02), Vector3(leaf_w * 0.98, 0.08, 0.04), mat_frame)
	var stile := 0.11
	var mid_rail_y := leaf_h * 0.4
	_add_mesh_box(leaf, Vector3(stile * 0.5, leaf_h * 0.5, 0.028), Vector3(stile, leaf_h, 0.025), mat_frame)
	_add_mesh_box(leaf, Vector3(leaf_w - stile * 0.5, leaf_h * 0.5, 0.028), Vector3(stile, leaf_h, 0.025), mat_frame)
	_add_mesh_box(leaf, Vector3(leaf_w * 0.5, leaf_h - stile * 0.5, 0.028), Vector3(leaf_w, stile, 0.025), mat_frame)
	_add_mesh_box(leaf, Vector3(leaf_w * 0.5, stile * 0.5, 0.028), Vector3(leaf_w, stile, 0.025), mat_frame)
	_add_mesh_box(leaf, Vector3(leaf_w * 0.5, mid_rail_y, 0.028), Vector3(leaf_w - stile * 1.8, stile * 0.9, 0.025), mat_frame)
	_add_mesh_box(leaf, Vector3(leaf_w * 0.5, leaf_h * 0.5, 0.028), Vector3(stile * 0.8, leaf_h - stile * 2.0, 0.022), mat_frame)
	var pw := (leaf_w - stile * 2.4) * 0.44
	var ph_lo := mid_rail_y - stile * 1.5
	var ph_hi := leaf_h - mid_rail_y - stile * 1.5
	for side in [-1.0, 1.0]:
		var sx: float = float(side)
		var lx: float = leaf_w * 0.5 + sx * (pw * 0.55 + stile * 0.2)
		_add_mesh_box(leaf, Vector3(lx, mid_rail_y * 0.52, 0.02), Vector3(pw, ph_lo * 0.78, 0.018), mat_panel)
		_add_mesh_box(leaf, Vector3(lx, mid_rail_y * 0.52, 0.035), Vector3(pw * 0.78, ph_lo * 0.58, 0.012), mat_wood_l)
		var uy: float = mid_rail_y + (leaf_h - mid_rail_y) * 0.52
		_add_mesh_box(leaf, Vector3(lx, uy, 0.02), Vector3(pw, ph_hi * 0.78, 0.018), mat_panel)
		_add_mesh_box(leaf, Vector3(lx, uy, 0.035), Vector3(pw * 0.78, ph_hi * 0.58, 0.012), mat_wood_l)
	# Brass mortice set
	var knob_x := leaf_w - 0.16
	var knob_y := mid_rail_y + 0.1
	_add_mesh_box(leaf, Vector3(knob_x, knob_y - 0.02, 0.04), Vector3(0.1, 0.18, 0.02), mat_br_d)
	_add_mesh_box(leaf, Vector3(knob_x, knob_y - 0.02, 0.05), Vector3(0.08, 0.14, 0.012), mat_br)
	_add_mesh_cyl(leaf, Vector3(knob_x, knob_y, 0.06), 0.05, 0.02, mat_br, false)
	_add_mesh_cyl(leaf, Vector3(knob_x, knob_y, 0.09), 0.04, 0.06, mat_br_l, false)
	_add_mesh_cyl(leaf, Vector3(knob_x, knob_y, 0.13), 0.025, 0.03, mat_br_d, false)
	_add_mesh_box(leaf, Vector3(knob_x, knob_y - 0.12, 0.055), Vector3(0.055, 0.1, 0.018), mat_br)
	_add_mesh_box(leaf, Vector3(knob_x, knob_y - 0.12, 0.065), Vector3(0.02, 0.05, 0.01), mat_key)
	for hy in [0.28, leaf_h * 0.5, leaf_h - 0.32]:
		_add_mesh_box(leaf, Vector3(0.035, hy, 0.045), Vector3(0.06, 0.18, 0.04), mat_br)
		_add_mesh_box(leaf, Vector3(0.035, hy, 0.06), Vector3(0.03, 0.12, 0.02), mat_br_l)
	return root

static func _make_mirror(feat: Dictionary) -> Node3D:
	## Loop 204: looking-glass — solid-metal gilt frame (no brass washout mid-FOV).
	var root := Node3D.new()
	root.name = "Mirror"
	var pos: Array = feat.get("pos", [0, 0, 0])
	root.position = Vector3(pos[0], pos[1], pos[2])
	root.rotation_degrees.y = feat.get("yaw", 0.0)
	var w: float = float(feat.get("width", 1.05))
	var h: float = float(feat.get("height", 1.45))
	var mat_br := _solid_metal(BRASS, 0.3)
	var mat_br_d := _solid_metal(BRASS.darkened(0.12), 0.35)
	var mat_br_l := _solid_metal(BRASS.lightened(0.08), 0.28)
	var mat_liner := _solid_matte(Color(0.16, 0.1, 0.07), 0.75)
	_add_mesh_box(root, Vector3(0, 0, 0.04), Vector3(w + 0.14, h + 0.14, 0.1), mat_br, true)
	_add_mesh_box(root, Vector3(0, 0, 0.07), Vector3(w + 0.06, h + 0.06, 0.05), mat_br_d)
	_add_mesh_box(root, Vector3(0, 0, 0.085), Vector3(w - 0.06, h - 0.06, 0.03), mat_liner)
	_add_mesh_box(root, Vector3(0, 0, 0.095), Vector3(w - 0.1, h - 0.1, 0.012), mat_br_l)
	_add_mesh_box(root, Vector3(0, h * 0.5 + 0.09, 0.06), Vector3(0.32, 0.15, 0.055), mat_br_l)
	_add_mesh_box(root, Vector3(0, h * 0.5 + 0.16, 0.06), Vector3(0.14, 0.08, 0.04), mat_br)
	_add_mesh_cyl(root, Vector3(0, h * 0.5 + 0.2, 0.07), 0.04, 0.03, mat_br_l, false)
	for sx in [-1.0, 1.0]:
		for sy in [-1.0, 1.0]:
			_add_mesh_box(root, Vector3(sx * (w * 0.5), sy * (h * 0.5), 0.07), Vector3(0.1, 0.1, 0.045), mat_br_l)
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
	## Loop 205: gilt/wood frame oils — solid-mat frames (canvas texture retained).
	## NEVER a room photo. Frame forks: ornate gilt · mahogany · ebony · dark gilt.
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
		0:
			outer = BRASS
			mid = BRASS.lightened(0.1)
			liner = BRASS.darkened(0.18)
			corner_c = BRASS.lightened(0.14)
			rough_o = 0.28
		1:
			outer = Color(0.3, 0.14, 0.08)
			mid = Color(0.36, 0.18, 0.1)
			liner = BRASS.darkened(0.1)
			corner_c = BRASS
			rough_o = 0.55
		2:
			outer = Color(0.08, 0.07, 0.07)
			mid = Color(0.12, 0.1, 0.09)
			liner = Color(0.22, 0.16, 0.1)
			corner_c = BRASS.darkened(0.2)
			rough_o = 0.45
		_:
			outer = BRASS.darkened(0.22)
			mid = BRASS.darkened(0.1)
			liner = Color(0.14, 0.08, 0.05)
			corner_c = BRASS.lightened(0.05)
			rough_o = 0.35
	var mat_outer: Material
	var mat_mid: Material
	var mat_liner: Material
	var mat_corner: Material
	if frame_style == 1 or frame_style == 2:
		mat_outer = _solid_matte(outer, rough_o)
		mat_mid = _solid_matte(mid, rough_o * 0.95)
	else:
		mat_outer = _solid_metal(outer, rough_o)
		mat_mid = _solid_metal(mid, rough_o * 0.95)
	if frame_style == 2:
		mat_liner = _solid_matte(liner, 0.55)
		mat_corner = _solid_metal(corner_c, 0.35)
	else:
		mat_liner = _solid_metal(liner, 0.35) if frame_style != 1 else _solid_metal(liner, 0.32)
		if frame_style == 1:
			mat_liner = _solid_metal(liner, 0.32)
		mat_corner = _solid_metal(corner_c, 0.28)
	_add_mesh_box(root, Vector3(0, 0, 0), Vector3(w + 0.12, h + 0.12, 0.08), mat_outer, true)
	_add_mesh_box(root, Vector3(0, 0, 0.018), Vector3(w + 0.05, h + 0.05, 0.05), mat_mid)
	var rail: float = 0.06
	var aper_w: float = w - 0.16
	var aper_h: float = h - 0.16
	_add_mesh_box(root, Vector3(0, aper_h * 0.5 + rail * 0.35, 0.03), Vector3(aper_w + rail * 1.2, rail, 0.035), mat_liner)
	_add_mesh_box(root, Vector3(0, -(aper_h * 0.5 + rail * 0.35), 0.03), Vector3(aper_w + rail * 1.2, rail, 0.035), mat_liner)
	_add_mesh_box(root, Vector3(aper_w * 0.5 + rail * 0.35, 0, 0.03), Vector3(rail, aper_h, 0.035), mat_liner)
	_add_mesh_box(root, Vector3(-(aper_w * 0.5 + rail * 0.35), 0, 0.03), Vector3(rail, aper_h, 0.035), mat_liner)
	_add_mesh_box(root, Vector3(0, 0, -0.01), Vector3(aper_w + 0.02, aper_h + 0.02, 0.02), _solid_matte(Color(0.12, 0.08, 0.05), 0.8))
	var csz: float = 0.08 if frame_style != 2 else 0.045
	for sx in [-1.0, 1.0]:
		for sy in [-1.0, 1.0]:
			_add_mesh_box(root, Vector3(sx * (w * 0.5 + 0.02), sy * (h * 0.5 + 0.02), 0.03), Vector3(csz, csz, 0.05), mat_corner)
	if frame_style != 2:
		_add_mesh_box(root, Vector3(0, h * 0.5 + 0.1, 0.02), Vector3(0.12, 0.08, 0.04), mat_liner)
		_add_mesh_cyl(root, Vector3(0, h * 0.5 + 0.16, 0.03), 0.025, 0.03, mat_corner, false)
	if frame_style == 0:
		_add_mesh_cyl(root, Vector3(-(w * 0.5 + 0.01), 0, 0.04), 0.03, 0.025, mat_corner, false)
		_add_mesh_cyl(root, Vector3(w * 0.5 + 0.01, 0, 0.04), 0.03, 0.025, mat_corner, false)
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
		# Compact terracotta under card — solid-mat clay (loop 206)
		var pot_r: float = clampf(width * 0.22, 0.16, 0.32)
		var mat_clay := _solid_matte(Color(0.7, 0.4, 0.22), 0.92)
		var mat_clay_l := _solid_matte(Color(0.78, 0.48, 0.28), 0.9)
		var mat_soil := _solid_matte(Color(0.2, 0.14, 0.08), 0.95)
		_add_mesh_cyl(root, Vector3(0, 0.16, 0), pot_r, 0.28, mat_clay, true)
		_add_mesh_cyl(root, Vector3(0, 0.3, 0), pot_r * 1.12, 0.04, mat_clay_l, false)
		_add_mesh_cyl(root, Vector3(0, 0.32, 0), pot_r * 0.85, 0.03, mat_soil, false)

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
	## Loop 207: solid-mat bulk behind painted cards (no wood/velvet washout mid-FOV).
	## Keep all bulk z-max ≤ -0.04 so front hero art is never covered.
	## Loop 143: with cross_planes, never add free-standing legs/stretchers (rug L-junk).
	var mat_md := _solid_matte(Color(0.18, 0.09, 0.05), 0.78)
	var mat_m := _solid_matte(Color(0.3, 0.14, 0.08), 0.72)
	var mat_ml := _solid_matte(Color(0.36, 0.18, 0.1), 0.7)
	match bulk:
		"sofa":
			var sw: float = clampf(width * 0.68, 1.3, 1.9)
			var mat_seat := _solid_matte(Color(0.22, 0.26, 0.16), 0.9)
			var mat_seat_d := _solid_matte(Color(0.16, 0.2, 0.12), 0.92)
			var mat_seat_dd := _solid_matte(Color(0.18, 0.22, 0.14), 0.9)
			_add_mesh_box(root, Vector3(0, 0.2, -0.34), Vector3(sw, 0.12, 0.28), mat_md)
			_add_mesh_box(root, Vector3(0, 0.36, -0.32), Vector3(sw * 0.85, 0.14, 0.24), mat_seat)
			_add_mesh_box(root, Vector3(0, 0.58, -0.44), Vector3(sw * 0.82, 0.28, 0.12), mat_seat_d)
			for sx in [-1.0, 1.0]:
				_add_mesh_box(root, Vector3(sx * (sw * 0.36), 0.42, -0.34), Vector3(0.12, 0.18, 0.22), mat_seat_dd)
				if not cross_planes:
					_add_mesh_cyl(root, Vector3(sx * (sw * 0.34), 0.08, -0.2), 0.03, 0.12, mat_m, false)
					_add_mesh_cyl(root, Vector3(sx * (sw * 0.34), 0.08, -0.4), 0.028, 0.12, mat_m, false)
		"desk":
			var dw: float = clampf(width * 0.75, 1.0, 1.45)
			var mat_leather := _solid_matte(Color(0.1, 0.16, 0.1), 0.88)
			_add_mesh_box(root, Vector3(0, 0.78, -0.28), Vector3(dw, 0.05, 0.32), mat_m)
			_add_mesh_box(root, Vector3(0, 0.81, -0.28), Vector3(dw * 0.88, 0.012, 0.28), mat_leather)
			_add_mesh_box(root, Vector3(-0.38, 0.38, -0.28), Vector3(0.32, 0.7, 0.3), mat_md)
			_add_mesh_box(root, Vector3(0.38, 0.38, -0.28), Vector3(0.32, 0.7, 0.3), mat_md)
			_add_mesh_box(root, Vector3(0, 0.95, -0.4), Vector3(dw * 0.85, 0.22, 0.05), mat_m)
		"wing", "wing_green":
			var ww: float = clampf(width * 0.42, 0.42, 0.58)
			var fab: Color = Color(0.38, 0.44, 0.34) if bulk == "wing_green" else Color(0.4, 0.14, 0.14)
			var mat_fab := _solid_matte(fab, 0.92)
			var mat_fab_d := _solid_matte(fab.darkened(0.08), 0.94)
			var mat_fab_dd := _solid_matte(fab.darkened(0.12), 0.94)
			var mat_fab_a := _solid_matte(fab.darkened(0.05), 0.9)
			if cross_planes:
				_add_mesh_box(root, Vector3(0, 0.42, -0.28), Vector3(ww * 0.85, 0.08, 0.2), mat_md)
				_add_mesh_box(root, Vector3(0, 0.5, -0.26), Vector3(ww * 0.72, 0.1, 0.16), mat_fab)
				for sx in [-1.0, 1.0]:
					for sz in [-1.0, 1.0]:
						_add_mesh_cyl(root, Vector3(sx * ww * 0.22, 0.12, -0.22 + sz * 0.04), 0.022, 0.2, mat_m, false)
						_add_mesh_cyl(root, Vector3(sx * ww * 0.22, 0.02, -0.22 + sz * 0.04), 0.03, 0.04, mat_ml, false)
			else:
				_add_mesh_box(root, Vector3(0, 0.38, -0.32), Vector3(ww * 0.95, 0.1, 0.28), mat_md)
				_add_mesh_box(root, Vector3(0, 0.5, -0.28), Vector3(ww * 0.82, 0.14, 0.26), mat_fab)
				_add_mesh_box(root, Vector3(0, 0.78, -0.42), Vector3(ww * 0.72, 0.5, 0.14), mat_fab_d)
				_add_mesh_box(root, Vector3(0, 0.95, -0.38), Vector3(ww * 0.55, 0.18, 0.12), mat_fab_dd)
				for sx in [-1.0, 1.0]:
					_add_mesh_box(root, Vector3(sx * ww * 0.38, 0.62, -0.28), Vector3(0.1, 0.36, 0.22), mat_fab_a)
					_add_mesh_cyl(root, Vector3(sx * ww * 0.28, 0.12, -0.18), 0.026, 0.18, mat_m, false)
					_add_mesh_cyl(root, Vector3(sx * ww * 0.28, 0.12, -0.38), 0.024, 0.18, mat_md, false)
		"chair":
			var cw: float = clampf(width * 0.48, 0.36, 0.52)
			var mat_vel := _solid_matte(Color(0.22, 0.4, 0.18), 0.92)
			var mat_vel_l := _solid_matte(Color(0.28, 0.46, 0.24), 0.9)
			if cross_planes:
				_add_mesh_box(root, Vector3(0, 0.44, -0.22), Vector3(cw * 0.95, 0.04, 0.2), mat_m)
				_add_mesh_box(root, Vector3(0, 0.5, -0.2), Vector3(cw * 0.88, 0.09, 0.18), mat_vel)
				_add_mesh_box(root, Vector3(0, 0.56, -0.2), Vector3(cw * 0.82, 0.025, 0.16), mat_vel_l)
				for sx in [-1.0, 1.0]:
					for sz in [-1.0, 1.0]:
						_add_mesh_cyl(root, Vector3(sx * cw * 0.28, 0.22, -0.2 + sz * 0.04), 0.015, 0.4, mat_m, false)
						_add_mesh_cyl(root, Vector3(sx * cw * 0.28, 0.02, -0.2 + sz * 0.04), 0.022, 0.035, mat_ml, false)
			else:
				_add_mesh_box(root, Vector3(0, 0.46, -0.32), Vector3(cw, 0.05, 0.22), mat_m)
				_add_mesh_box(root, Vector3(0, 0.52, -0.3), Vector3(cw * 0.88, 0.09, 0.18), mat_vel)
				for sx in [-1.0, 1.0]:
					_add_mesh_cyl(root, Vector3(sx * cw * 0.28, 0.2, -0.24), 0.018, 0.32, mat_m, false)
					_add_mesh_cyl(root, Vector3(sx * cw * 0.28, 0.2, -0.36), 0.016, 0.32, mat_md, false)
				_add_mesh_box(root, Vector3(0, 0.12, -0.28), Vector3(cw * 0.6, 0.025, 0.025), mat_m)
		_:
			_add_mesh_box(root, Vector3(0, height * 0.35, -0.22), Vector3(width * 0.7, height * 0.55, 0.28), mat_md)


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
	## Single thin leather folio on a table — solid-mat spine + gilt (not texture washout).
	var col := _book_color(seed0)
	var mat_book := _solid_matte(col, 0.88)
	var mat_spine := _solid_matte(col.darkened(0.12), 0.9)
	var mat_gilt := _solid_metal(Color(0.78, 0.62, 0.32), 0.28)
	var node := Node3D.new()
	node.position = pos
	node.rotation_degrees.y = yaw_deg
	root.add_child(node)
	_add_mesh_box(node, Vector3(0, 0.012, 0), Vector3(0.12, 0.022, 0.16), mat_book)
	_add_mesh_box(node, Vector3(0.055, 0.012, 0), Vector3(0.008, 0.018, 0.14), mat_gilt)
	_add_mesh_box(node, Vector3(-0.055, 0.012, 0), Vector3(0.012, 0.02, 0.15), mat_spine)


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
	## Loop 209: lower alpha + warm brown (was pure black void disc mid-FOV under plants).
	var mi := MeshInstance3D.new()
	mi.name = "ContactShadow"
	var mesh := CylinderMesh.new()
	mesh.top_radius = rx
	mesh.bottom_radius = rx
	mesh.height = 0.012
	mi.mesh = mesh
	var mat := StandardMaterial3D.new()
	mat.albedo_color = Color(0.08, 0.05, 0.03, 0.28)
	mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	mat.cull_mode = BaseMaterial3D.CULL_DISABLED
	mi.material_override = mat
	# Above floor, below rug — avoid coplanar flicker
	mi.position = Vector3(0, 0.018, 0)
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
