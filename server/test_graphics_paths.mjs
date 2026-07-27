/**
 * Structural + surface-quality tests for graphics assets.
 * Drives real on-disk files and source of fps_npc.gd / fps_rooms.gd.
 * Victorian textures must be surface materials (tileable wallpaper/wood),
 * not crops of full room scenes (desks, furniture, chandeliers).
 */
import { readFileSync, existsSync, readdirSync, statSync } from 'fs';
import { join, dirname } from 'path';
import { fileURLToPath } from 'url';
import assert from 'assert';
import { spawnSync } from 'child_process';

const __dirname = dirname(fileURLToPath(import.meta.url));
const GODOT = join(__dirname, '../aetheric-engine-godot');
const SPRITES = join(GODOT, 'assets/characters/sprites');
const VICT = join(GODOT, 'assets/rooms/textures/victorian');
const ROOMS = join(GODOT, 'assets/rooms');
const IDS = ['selina', 'bell', 'amara', 'rooke', 'clara', 'elspeth'];

for (const id of IDS) {
  const p = join(SPRITES, `sprite_${id}.png`);
  assert.ok(existsSync(p), `sprite exists: ${id}`);
  assert.ok(statSync(p).size > 5000, `sprite non-trivial: ${id}`);
}

// Height metadata for age-correct scale
const roomsSrcForHeights = readFileSync(join(GODOT, 'scripts/fps_rooms.gd'), 'utf8');
const heightOf = (id) => {
  const re = new RegExp(`"id": "${id}"[\\s\\S]*?"height": ([0-9.]+)`);
  const m = roomsSrcForHeights.match(re);
  assert.ok(m, `height for ${id}`);
  return Number(m[1]);
};
assert.ok(heightOf('elspeth') >= 1.55, 'Elspeth (~14) height >= 1.55m');
assert.ok(heightOf('clara') >= 1.62, 'Clara (~21) height >= 1.62m');
assert.ok(heightOf('bell') >= 1.72, 'Bell adult height');
assert.ok(heightOf('rooke') >= 1.75, 'Rooke adult height');

// Opaque character presentation (depth-writing alpha scissor quad)
const npcForOpacity = readFileSync(join(GODOT, 'scripts/fps_npc.gd'), 'utf8');
assert.match(npcForOpacity, /TRANSPARENCY_ALPHA_SCISSOR|ALPHA_SCISSOR/);
assert.match(npcForOpacity, /DEPTH_DRAW_OPAQUE|depth_draw_mode/);
assert.match(npcForOpacity, /QuadMesh|CharacterSprite/);

const npcSrc = readFileSync(join(GODOT, 'scripts/fps_npc.gd'), 'utf8');
assert.match(npcSrc, /Sprite3D/);
assert.match(npcSrc, /CharacterSprite/);
assert.match(npcSrc, /body_mesh\.visible = false/);
assert.match(npcSrc, /sprite_path_for/);
assert.doesNotMatch(npcSrc, /World NPC = simple silhouette/);

const roomsSrc = roomsSrcForHeights;
for (const room of ['drawing', 'hall', 'gallery']) {
  assert.match(roomsSrc, new RegExp(`wallpaper_${room}\\.jpg`));
  assert.match(roomsSrc, new RegExp(`floor_${room}\\.jpg`));
  assert.match(roomsSrc, new RegExp(`wainscot_${room}\\.jpg`));
}
for (const id of IDS) {
  assert.match(roomsSrc, new RegExp(`sprite_${id}\\.png`));
}
assert.match(roomsSrc, /"target": "entrance_hall"/);
assert.match(roomsSrc, /"target": "gallery"/);

const builderSrc = readFileSync(join(GODOT, 'scripts/fps_room_builder.gd'), 'utf8');
assert.match(builderSrc, /_add_skirting/);
assert.match(builderSrc, /Skirting_/);
const propsSrc = readFileSync(join(GODOT, 'scripts/fps_props.gd'), 'utf8');
assert.match(propsSrc, /Leather-top writing desk|balloon-back|wing-style|seat cushions/);
assert.match(propsSrc, /_mat_for|fabric_velvet|furniture_wood/);
assert.match(propsSrc, /_make_painting/);
for (const fab of ['fabric_velvet_red.jpg', 'fabric_velvet_green.jpg', 'furniture_wood.jpg']) {
  assert.ok(existsSync(join(VICT, fab)), `furniture texture ${fab}`);
}

// Surface-material quality: reject scene crops (furniture/desks/white paper)
const py = `
from PIL import Image, ImageFilter
import numpy as np
from pathlib import Path
import sys
vict = Path(${JSON.stringify(VICT)})
rooms = Path(${JSON.stringify(ROOMS)})
failed = 0

def load(p):
    return np.array(Image.open(p).convert("RGB").resize((256, 256)), dtype=np.float32)

def white_frac(arr):
    return float(np.mean(np.all(arr > 210, axis=2)))

def mean_rgb(arr):
    return arr.reshape(-1, 3).mean(axis=0)

def edge_mean(arr):
    im = Image.fromarray(arr.astype(np.uint8)).convert("L")
    e = np.array(im.filter(ImageFilter.FIND_EDGES), dtype=np.float32)
    return float(e.mean())

# Full room renders are high-structure scenes; surface mats must differ strongly
scene_refs = {
    "drawing": rooms / "richmond_drawing_room.jpg",
    "hall": rooms / "richmond_entrance_hall.jpg",
    "gallery": rooms / "richmond_gallery.jpg",
}

for room, scene_path in scene_refs.items():
    scene = load(scene_path)
    scene_white = white_frac(scene)
    for kind in ("wallpaper", "floor", "wainscot"):
        p = vict / f"{kind}_{room}.jpg"
        assert p.exists(), f"missing {p}"
        arr = load(p)
        wfrac = white_frac(arr)
        r,g,b = mean_rgb(arr)
        # Scene crops of desks/papers have high near-white content; surface mats should not.
        if wfrac > 0.04:
            print(f"FAIL {p.name}: white_frac={wfrac:.3f} looks like desk/paper scene crop")
            failed += 1
            continue
        # Must not be nearly identical to full room render (MSE low means scene paste)
        mse = float(np.mean((arr - scene) ** 2))
        if mse < 800:
            print(f"FAIL {p.name}: too similar to full room render mse={mse:.0f}")
            failed += 1
            continue
        if kind == "floor":
            # Wood floors: warm browns, R dominant-ish, not green wallpaper
            if not (r > 35 and r >= g - 5 and r > b):
                print(f"FAIL {p.name}: floor not wood-brown mean=({r:.0f},{g:.0f},{b:.0f})")
                failed += 1
                continue
        if kind == "wainscot":
            # Dark wood paneling — relatively dark
            lum = (r + g + b) / 3
            if lum > 120:
                print(f"FAIL {p.name}: wainscot too bright lum={lum:.0f}")
                failed += 1
                continue
        if kind == "wallpaper":
            # Not a wood floor (should not be strongly brown-only plank look); allow green/grey/olive
            if r > g + 40 and r > b + 40 and r > 100:
                print(f"FAIL {p.name}: wallpaper looks like warm wood floor mean=({r:.0f},{g:.0f},{b:.0f})")
                failed += 1
                continue
        print(f"OK surface {p.name} white={wfrac:.3f} mse_vs_scene={mse:.0f} mean=({r:.0f},{g:.0f},{b:.0f})")

sys.exit(1 if failed else 0)
`;

const analysis = spawnSync('python3', ['-c', py], { encoding: 'utf8' });
process.stdout.write(analysis.stdout || '');
process.stderr.write(analysis.stderr || '');
assert.strictEqual(analysis.status, 0, 'victorian surface material quality checks failed');

console.log('PASS test_graphics_paths.mjs');
console.log(JSON.stringify({
  sprites: IDS.map((id) => `sprite_${id}.png`),
  victorian: readdirSync(VICT).filter((n) => !n.endsWith('.import') && !n.startsWith('.')),
}, null, 2));
