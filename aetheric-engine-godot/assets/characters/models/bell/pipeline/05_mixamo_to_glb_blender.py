"""
Build a clean Mixamo activity pack for skeleton-first Bell.

- ONE armature + Beta_Surface body (no duplicate FBX bodies, no Beta_Joints viz)
- idle  <- Standing Idle (preferred) / Idle
- walk  <- Walking / Walk (preferred) OR looped mid-section of Start Walking
- sit   <- Sitting Idle (chair-style preferred)

Env:
  MIXAMO_SRC, BELL_PIPE_WORK, BELL_INSTALL
"""
import bpy
import os
import math
from mathutils import Vector, Matrix

WORK = os.environ.get(
    "BELL_PIPE_WORK",
    os.path.join(os.path.dirname(os.path.abspath(__file__)), "work"),
)
MIXAMO_SRC = os.path.abspath(
    os.environ.get(
        "MIXAMO_SRC",
        os.path.join(
            os.path.dirname(os.path.abspath(__file__)),
            "..",
            "..",
            "..",
            "mixamo",
            "source",
        ),
    )
)
OUT_PACK = os.path.join(WORK, "mixamo_activity_pack.glb")
OUT_ASSETS = os.path.abspath(
    os.path.join(
        os.path.dirname(os.path.abspath(__file__)),
        "..",
        "..",
        "..",
        "mixamo",
        "mixamo_activity_pack.glb",
    )
)

# Preferred files per role (first existing wins for mesh base)
WALK_CANDIDATES = [
    "walking.fbx",
    "walk.fbx",
    "Walking.fbx",
    "Walk.fbx",
    "walking_in_place.fbx",
    "walk_in_place.fbx",
    "standard_walk.fbx",
    "start_walking.fbx",  # last resort — will be mid-looped
]
IDLE_CANDIDATES = ["standing_idle.fbx", "Standing Idle.fbx", "idle.fbx", "Idle.fbx"]
SIT_CANDIDATES = [
    "sitting.fbx",
    "Sitting.fbx",
    "sitting_idle.fbx",
    "Sitting Idle.fbx",
    "sitting_idle_alt.fbx",
    "Sitting Idle (1).fbx",
]


def clear():
    bpy.ops.object.select_all(action="SELECT")
    bpy.ops.object.delete(use_global=False)
    for coll in (
        bpy.data.meshes,
        bpy.data.materials,
        bpy.data.actions,
        bpy.data.armatures,
        bpy.data.images,
        bpy.data.cameras,
        bpy.data.lights,
    ):
        for b in list(coll):
            try:
                coll.remove(b)
            except Exception:
                pass


def find_file(names):
    for n in names:
        p = os.path.join(MIXAMO_SRC, n)
        if os.path.isfile(p):
            return p
        # also try original Mixamo downloads folder siblings
        for alt in (
            os.path.join(os.path.dirname(MIXAMO_SRC), n),
            os.path.join(
                "/Users/babble/ gemini/antigravity/playground/downloads/Mixamo downloads",
                n,
            ),
        ):
            if os.path.isfile(alt):
                return alt
    return None


def import_fbx(path):
    before = set(bpy.context.scene.objects)
    bpy.ops.import_scene.fbx(
        filepath=path,
        automatic_bone_orientation=True,
        use_anim=True,
        ignore_leaf_bones=False,
    )
    after = set(bpy.context.scene.objects)
    return list(after - before)


def first_armature():
    arms = [o for o in bpy.context.scene.objects if o.type == "ARMATURE"]
    return arms[0] if arms else None


def body_meshes(arm):
    out = []
    for o in bpy.context.scene.objects:
        if o.type != "MESH":
            continue
        nm = o.name.lower()
        if "joint" in nm:
            continue
        if o.find_armature() == arm or any(
            m for m in o.modifiers if m.type == "ARMATURE" and m.object == arm
        ):
            out.append(o)
        elif "surface" in nm or "body" in nm or "beta_surface" in nm:
            out.append(o)
    return out


def delete_objects(objs):
    for o in objs:
        if o and o.name in bpy.data.objects:
            bpy.data.objects.remove(o, do_unlink=True)


def make_loop_action(src_action, name, start_frac=0.25, end_frac=0.85):
    """Copy a mid-section of an action and mark as cyclic for walk loops."""
    if src_action is None:
        return None
    fr0, fr1 = src_action.frame_range
    span = max(fr1 - fr0, 1.0)
    a = fr0 + span * start_frac
    b = fr0 + span * end_frac
    if b - a < 8:
        a, b = fr0, fr1
    new = src_action.copy()
    new.name = name
    # Push down unused keys outside range by restricting — Blender 5 layered-safe:
    # Use frame_range by shifting so walk starts at 1
    try:
        # Shift so first frame is 1
        offset = 1.0 - a
        fcs = []
        if hasattr(new, "fcurves") and new.fcurves:
            fcs = list(new.fcurves)
        else:
            for layer in getattr(new, "layers", []) or []:
                for strip in getattr(layer, "strips", []) or []:
                    for slot in getattr(new, "slots", []) or [None]:
                        try:
                            cb = strip.channelbag(slot) if slot is not None else None
                            if cb and hasattr(cb, "fcurves"):
                                fcs.extend(list(cb.fcurves))
                        except Exception:
                            pass
        for fc in fcs:
            # remove keys outside [a,b], then shift
            remove_idx = []
            for i, kp in enumerate(fc.keyframe_points):
                if kp.co.x < a - 0.01 or kp.co.x > b + 0.01:
                    remove_idx.append(i)
            for i in reversed(remove_idx):
                fc.keyframe_points.remove(fc.keyframe_points[i])
            for kp in fc.keyframe_points:
                kp.co.x += offset
                kp.handle_left.x += offset
                kp.handle_right.x += offset
            # Make cyclic: match first/last values
            if len(fc.keyframe_points) >= 2:
                first = fc.keyframe_points[0]
                last = fc.keyframe_points[-1]
                last.co.y = first.co.y
                last.handle_left.y = first.handle_left.y
                last.handle_right.y = first.handle_right.y
    except Exception as e:
        print("NOTE loop edit limited", e)
    new.use_cyclic = True
    print("loop action", name, "from", a, b, "-> frames", new.frame_range[:])
    return new


def zero_root_xz(action):
    """Zero hip/root XZ location keys (keep Y for bounce) for in-place walk/idle."""
    if action is None:
        return
    fcs = []
    try:
        if hasattr(action, "fcurves") and action.fcurves is not None:
            fcs = list(action.fcurves)
        else:
            for layer in getattr(action, "layers", []) or []:
                for strip in getattr(layer, "strips", []) or []:
                    for slot in getattr(action, "slots", []) or [None]:
                        try:
                            cb = strip.channelbag(slot) if slot else None
                            if cb:
                                fcs.extend(list(cb.fcurves))
                        except Exception:
                            pass
    except Exception as e:
        print("NOTE zero_root access", e)
        return
    for fc in fcs:
        dp = fc.data_path.lower()
        if "location" not in dp:
            continue
        if "hips" not in dp and "root" not in dp:
            continue
        # array_index 0=X 1=Y 2=Z
        if fc.array_index in (0, 2):
            for kp in fc.keyframe_points:
                kp.co.y = 0.0
                kp.handle_left.y = 0.0
                kp.handle_right.y = 0.0


def ensure_nla(arm, names):
    if arm is None:
        return
    if not arm.animation_data:
        arm.animation_data_create()
    ad = arm.animation_data
    while ad.nla_tracks:
        ad.nla_tracks.remove(ad.nla_tracks[0])
    for name in names:
        act = bpy.data.actions.get(name)
        if not act:
            continue
        tr = ad.nla_tracks.new()
        tr.name = name
        fr0 = int(act.frame_range[0])
        st = tr.strips.new(name, fr0, act)
        st.action = act
        if name in ("idle", "walk", "sit"):
            try:
                st.extrapolation = "HOLD_FORWARD"
            except Exception:
                pass
    ad.action = bpy.data.actions.get("idle")


def export_glb(path):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    bpy.ops.export_scene.gltf(
        filepath=path,
        export_format="GLB",
        export_animations=True,
        export_nla_strips=True,
        export_skins=True,
        export_yup=True,
        export_texcoords=True,
        export_normals=True,
        export_image_format="NONE",
    )
    print("exported", path, os.path.getsize(path) if os.path.isfile(path) else 0)


def import_action_only(path, target_arm, clip_name, loop_walk=False):
    """Import FBX, steal longest action, delete imported objects, keep action on target."""
    before_acts = set(bpy.data.actions.keys())
    new_objs = import_fbx(path)
    new_acts = set(bpy.data.actions.keys()) - before_acts
    if not new_acts:
        # Maybe reused — take any action not idle/walk/sit yet
        candidates = [a for a in bpy.data.actions if a.name not in ("idle", "walk", "sit")]
    else:
        candidates = [bpy.data.actions[n] for n in new_acts]
    if not candidates:
        print("FAIL no action from", path)
        delete_objects(new_objs)
        return None
    candidates.sort(key=lambda a: a.frame_range[1] - a.frame_range[0], reverse=True)
    act = candidates[0]
    # remove other new acts
    for o in candidates[1:]:
        if o.name in new_acts:
            try:
                bpy.data.actions.remove(o)
            except Exception:
                pass
    # delete imported meshes/armatures (keep only action data)
    delete_objects(new_objs)
    # rename
    old = bpy.data.actions.get(clip_name)
    if old and old != act:
        try:
            bpy.data.actions.remove(old)
        except Exception:
            pass
    if loop_walk or clip_name == "walk":
        # Prefer mid-loop if source looks like Start Walking (long non-cycle)
        fr0, fr1 = act.frame_range
        if (fr1 - fr0) > 40:
            looped = make_loop_action(act, clip_name, 0.28, 0.82)
            if looped:
                try:
                    bpy.data.actions.remove(act)
                except Exception:
                    pass
                act = looped
            else:
                act.name = clip_name
        else:
            act.name = clip_name
            act.use_cyclic = True
    else:
        act.name = clip_name
    if clip_name in ("walk", "idle"):
        zero_root_xz(act)
    # sit: keep hip height (weight-bearing)
    print("OK action", clip_name, "frames", tuple(act.frame_range), "from", os.path.basename(path))
    return act


def main():
    os.makedirs(WORK, exist_ok=True)
    print("MIXAMO_SRC", MIXAMO_SRC)
    clear()

    idle_path = find_file(IDLE_CANDIDATES)
    walk_path = find_file(WALK_CANDIDATES)
    sit_path = find_file(SIT_CANDIDATES)
    print("idle", idle_path)
    print("walk", walk_path)
    print("sit", sit_path)

    # Base mesh: prefer walk file if it's a full character, else idle
    base_path = walk_path or idle_path or sit_path
    if not base_path:
        print("ERROR no Mixamo FBX found")
        return
    import_fbx(base_path)
    arm = first_armature()
    if arm is None:
        print("ERROR no armature")
        return
    # Remove joint viz meshes
    for o in list(bpy.context.scene.objects):
        if o.type == "MESH" and "joint" in o.name.lower():
            bpy.data.objects.remove(o, do_unlink=True)
    # Keep only one body mesh under arm
    bodies = body_meshes(arm)
    print("body meshes", [b.name for b in bodies])
    # Drop extras named .001 etc keep first surface
    keep = None
    for b in bodies:
        if "surface" in b.name.lower():
            keep = b
            break
    if keep is None and bodies:
        keep = bodies[0]
    for b in bodies:
        if b != keep:
            bpy.data.objects.remove(b, do_unlink=True)

    # Clear base actions then load named clips
    for a in list(bpy.data.actions):
        try:
            bpy.data.actions.remove(a)
        except Exception:
            pass

    if idle_path:
        import_action_only(idle_path, arm, "idle", loop_walk=False)
    if walk_path:
        is_start = "start" in os.path.basename(walk_path).lower()
        import_action_only(walk_path, arm, "walk", loop_walk=is_start)
    if sit_path:
        import_action_only(sit_path, arm, "sit", loop_walk=False)

    # Remove any leftover armatures besides our arm
    for o in list(bpy.context.scene.objects):
        if o.type == "ARMATURE" and o != arm:
            bpy.data.objects.remove(o, do_unlink=True)

    ensure_nla(arm, ["idle", "walk", "sit"])
    export_glb(OUT_PACK)
    # Install into assets
    import shutil

    os.makedirs(os.path.dirname(OUT_ASSETS), exist_ok=True)
    shutil.copy2(OUT_PACK, OUT_ASSETS)
    print("installed", OUT_ASSETS)
    print("actions", [a.name for a in bpy.data.actions])
    print("=== 05_mixamo clean pack DONE ===")


if __name__ == "__main__":
    main()
