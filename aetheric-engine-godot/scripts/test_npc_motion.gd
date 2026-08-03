extends SceneTree
## Headless checks for NPC life pure helpers + Bell walk still loads.
## Run: Godot --headless --path . --script res://scripts/test_npc_motion.gd


func _init() -> void:
	var failed := 0
	print("=== test_npc_motion ===")

	var NpcScript = load("res://scripts/fps_npc.gd")
	if NpcScript == null:
		print("FAIL: cannot load fps_npc.gd")
		quit(1)
		return

	# --- Walk frame selection (regression) ---
	var seen := {}
	var dist := 0.0
	for k in 40:
		dist += 0.08
		var fi: int = NpcScript.select_walk_frame(dist, 0.55, 4)
		seen[fi] = true
		if fi < 0 or fi > 3:
			print("FAIL: frame out of range ", fi)
			failed += 1
	for need in [0, 1, 2, 3]:
		if not seen.has(need):
			print("FAIL: never reached walk frame ", need)
			failed += 1
	if seen.size() == 4:
		print("OK select_walk_frame visits all indices")

	if NpcScript.should_use_idle(true) != true:
		print("FAIL should_use_idle(true)")
		failed += 1
	else:
		print("OK should_use_idle")

	# --- Attend ---
	if not NpcScript.should_attend_player(2.0, 3.5):
		print("FAIL attend inside radius")
		failed += 1
	if NpcScript.should_attend_player(5.0, 3.5):
		print("FAIL attend outside radius")
		failed += 1
	if NpcScript.should_attend_player(3.5, 3.5):
		print("OK attend at exact radius")
	else:
		print("FAIL attend at exact radius")
		failed += 1

	# --- Breath pure ---
	var y0: float = NpcScript.breath_offset_y(0.0, 0.01)
	var y1: float = NpcScript.breath_offset_y(PI * 0.5, 0.01)
	if absf(y0) > 0.0001:
		print("FAIL breath at 0 should be ~0 got ", y0)
		failed += 1
	if absf(y1 - 0.01) > 0.0001:
		print("FAIL breath at pi/2 should be amplitude got ", y1)
		failed += 1
	else:
		print("OK breath_offset_y")

	var s0: float = NpcScript.breath_scale_factor(0.0, 0.01)
	if absf(s0 - 1.0) > 0.0001:
		print("FAIL breath_scale at 0 expected 1 got ", s0)
		failed += 1
	else:
		print("OK breath_scale_factor")

	# --- Dwell jitter bounds ---
	for i in 20:
		var d: float = NpcScript.dwell_with_jitter(8.0, 0.22, float(i) / 19.0)
		if d < 0.5 or d > 8.0 * 1.22 + 0.01:
			print("FAIL dwell_with_jitter out of range ", d)
			failed += 1
	var d_lo: float = NpcScript.dwell_with_jitter(8.0, 0.22, 0.0)
	var d_hi: float = NpcScript.dwell_with_jitter(8.0, 0.22, 1.0)
	if absf(d_lo - 8.0 * 0.78) > 0.02:
		print("FAIL dwell lo expected ", 8.0 * 0.78, " got ", d_lo)
		failed += 1
	if absf(d_hi - 8.0 * 1.22) > 0.02:
		print("FAIL dwell hi expected ", 8.0 * 1.22, " got ", d_hi)
		failed += 1
	else:
		print("OK dwell_with_jitter bounds")

	# --- Fidget interval ---
	var f0: float = NpcScript.fidget_interval(2.8, 6.5, 0.0)
	var f1: float = NpcScript.fidget_interval(2.8, 6.5, 1.0)
	if absf(f0 - 2.8) > 0.001 or absf(f1 - 6.5) > 0.001:
		print("FAIL fidget_interval ", f0, " ", f1)
		failed += 1
	else:
		print("OK fidget_interval")

	# --- Bell textures still solid ---
	var walk_ok := 0
	for i in 4:
		var p := "res://assets/characters/sprites/sprite_bell_walk_%d.png" % i
		var abs_p := ProjectSettings.globalize_path(p)
		var img := Image.new()
		if img.load(abs_p) != OK:
			print("FAIL load ", p)
			failed += 1
			continue
		var semi := 0
		var dark := 0
		for y in range(img.get_height()):
			for x in range(img.get_width()):
				var c := img.get_pixel(x, y)
				if c.a > 0.02 and c.a < 0.98:
					semi += 1
				if c.a >= 0.98:
					var luma := 0.299 * c.r + 0.587 * c.g + 0.114 * c.b
					if luma < 0.25:
						dark += 1
		if semi > 50:
			print("FAIL walk_", i, " semi=", semi)
			failed += 1
		elif dark < 500:
			print("FAIL walk_", i, " dark_solid=", dark)
			failed += 1
		else:
			walk_ok += 1
	if walk_ok == 4:
		print("OK Bell walk hard-alpha all frames")

	# Other NPCs static idle still load (no walk required yet — Bell is test case)
	for id in ["selina", "amara", "rooke", "clara"]:
		var sp := "res://assets/characters/sprites/sprite_%s.png" % id
		var ap := ProjectSettings.globalize_path(sp)
		var im := Image.new()
		if im.load(ap) != OK:
			print("FAIL idle missing ", id)
			failed += 1
		else:
			print("OK idle loads ", id)

	if failed == 0:
		print("=== ALL PASS ===")
		quit(0)
	else:
		print("=== FAILED count=", failed, " ===")
		quit(1)
