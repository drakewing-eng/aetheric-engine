"""
Apply Mixamo FBX activity clips onto production bell.glb armature (no Beta mesh).

Writes:
  work/mixamo_activity_pack.glb  — clips only (reference)
  final/bell.glb                 — production mesh + idle/walk/sit (if BELL_INSTALL=1)

Env:
  MIXAMO_SRC, BELL_GLB_IN, BELL_PIPE_WORK, BELL_INSTALL (default 1)
"""
import bpy
import os

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
BELL_GLB_IN = os.path.abspath(
    os.environ.get(
        "BELL_GLB_IN",
        os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "final", "bell.glb"),
    )
)
FINAL_DIR = os.path.abspath(
    os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "final")
)
OUT_PACK = os.path.join(WORK, "mixamo_activity_pack.glb")
OUT_BELL = os.environ.get("BELL_GLB_OUT", os.path.join(FINAL_DIR, "bell.glb"))
INSTALL = os.environ.get("BELL_INSTALL", "1") != "0"

CLIP_FILES = [
    ("standing_idle.fbx", "idle"),
    ("idle.fbx", "idle"),
    ("start_walking.fbx", "walk"),
    ("sitting_idle.fbx", "sit"),
    ("sitting_idle_alt.fbx", "sit"),
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


def import_fbx(path):
    bpy.ops.import_scene.fbx(
        filepath=path,
        automatic_bone_orientation=True,
        use_anim=True,
        ignore_leaf_bones=False,
    )


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
        export_image_format="AUTO",
    )
    print("exported", path, os.path.getsize(path) if os.path.isfile(path) else 0)


def bone_name_set(arm):
    if arm is None or arm.type != "ARMATURE":
        return set()
    return {b.name for b in arm.data.bones}


def _action_fcurves(action):
    """Blender 5 layered actions no longer expose Action.fcurves directly."""
    if action is None:
        return []
    # Legacy
    fcs = getattr(action, "fcurves", None)
    if fcs is not None:
        try:
            return list(fcs)
        except Exception:
            pass
    # Blender 4.4+ / 5.x layered action API
    out = []
    try:
        for layer in getattr(action, "layers", []) or []:
            for strip in getattr(layer, "strips", []) or []:
                slots = getattr(action, "slots", []) or []
                if not slots:
                    bag = getattr(strip, "channelbag", None)
                    if callable(bag):
                        try:
                            cb = bag(None)
                            if cb and hasattr(cb, "fcurves"):
                                out.extend(list(cb.fcurves))
                        except Exception:
                            pass
                    continue
                for slot in slots:
                    try:
                        cb = strip.channelbag(slot)
                        if cb and hasattr(cb, "fcurves"):
                            out.extend(list(cb.fcurves))
                    except Exception:
                        continue
    except Exception as e:
        print("NOTE fcurve access", e)
    return out


def normalize_action_bone_names(action, target_bones):
    """Rewrite fcurves pose.bones[\"X\"] to match target armature bone names."""
    if action is None:
        return
    bare_to_target = {}
    for bn in target_bones:
        bare = bn.replace("mixamorig:", "").replace("mixamorig_", "")
        bare_to_target[bare.lower()] = bn
        bare_to_target[bn.lower()] = bn

    for fc in _action_fcurves(action):
        dp = fc.data_path
        if 'pose.bones["' not in dp:
            continue
        try:
            start = dp.index('pose.bones["') + len('pose.bones["')
            end = dp.index('"]', start)
            old = dp[start:end]
        except ValueError:
            continue
        bare = old.replace("mixamorig:", "").replace("mixamorig_", "")
        new = bare_to_target.get(old.lower()) or bare_to_target.get(bare.lower())
        if new and new != old:
            fc.data_path = dp[:start] + new + dp[end:]


def strip_root_location(action):
    """Remove hip/root location fcurves so game navigation owns travel."""
    if action is None:
        return
    fcs = _action_fcurves(action)
    remove = []
    for fc in fcs:
        dp = fc.data_path.lower()
        if "location" in dp and ("hips" in dp or "root" in dp):
            remove.append(fc)
    # Prefer action.fcurves.remove when available; else channelbag
    legacy = getattr(action, "fcurves", None)
    for fc in remove:
        try:
            if legacy is not None:
                legacy.remove(fc)
            else:
                # Best-effort: mute track
                fc.mute = True
        except Exception:
            try:
                fc.mute = True
            except Exception:
                pass


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
        # loop idle/walk
        if name in ("idle", "walk", "sit"):
            st.extrapolation = "HOLD"
    ad.action = bpy.data.actions.get("idle")


def pick_bell_armature():
    """Armature that drives a non-Beta mesh (production body)."""
    arms = [o for o in bpy.context.scene.objects if o.type == "ARMATURE"]
    for a in arms:
        for m in bpy.context.scene.objects:
            if m.type != "MESH":
                continue
            if m.find_armature() != a:
                continue
            nm = m.name.lower()
            if "beta" in nm:
                continue
            return a
    return arms[0] if arms else None


def delete_beta_and_extra_armatures(keep_arm):
    for o in list(bpy.context.scene.objects):
        nm = o.name.lower()
        if o.type == "MESH" and "beta" in nm:
            bpy.data.objects.remove(o, do_unlink=True)
            continue
        if o.type == "ARMATURE" and o != keep_arm:
            # remove if only beta used it
            bpy.data.objects.remove(o, do_unlink=True)


def load_clips_onto_arm(arm):
    got = {}
    target_bones = bone_name_set(arm)
    print("target bones", len(target_bones), "sample", list(target_bones)[:5])
    for fname, clip in CLIP_FILES:
        if clip in got:
            continue
        path = os.path.join(MIXAMO_SRC, fname)
        if not os.path.isfile(path):
            print("NOTE missing", path)
            continue
        before_objs = set(bpy.context.scene.objects)
        before_acts = set(bpy.data.actions.keys())
        print("import", path, "→", clip)
        try:
            import_fbx(path)
        except Exception as e:
            print("FAIL import", e)
            continue
        # delete imported objects (mesh/armature); keep only new actions
        for o in list(bpy.context.scene.objects):
            if o not in before_objs:
                bpy.data.objects.remove(o, do_unlink=True)
        new_acts = set(bpy.data.actions.keys()) - before_acts
        if not new_acts:
            # maybe reused name — take longest action not in got
            candidates = [a for a in bpy.data.actions if a.name not in got.values()]
        else:
            candidates = [bpy.data.actions[n] for n in new_acts]
        if not candidates:
            print("FAIL no action for", clip)
            continue
        candidates.sort(
            key=lambda a: (a.frame_range[1] - a.frame_range[0]), reverse=True
        )
        act = candidates[0]
        # remove other new acts
        for other in candidates[1:]:
            if other.name in new_acts:
                try:
                    bpy.data.actions.remove(other)
                except Exception:
                    pass
        # rename to clip
        # remove previous clip action if any
        old = bpy.data.actions.get(clip)
        if old and old != act:
            try:
                bpy.data.actions.remove(old)
            except Exception:
                pass
        act.name = clip
        try:
            normalize_action_bone_names(act, target_bones)
            strip_root_location(act)
        except Exception as e:
            print("NOTE curve edit skipped", clip, e)
        got[clip] = act.name
        nfc = len(_action_fcurves(act))
        print("OK", clip, "frames", tuple(act.frame_range), "fcurves", nfc)
    return got


def main():
    os.makedirs(WORK, exist_ok=True)
    print("MIXAMO_SRC", MIXAMO_SRC)
    print("BELL_GLB_IN", BELL_GLB_IN)
    if not os.path.isfile(BELL_GLB_IN):
        print("ERROR missing production GLB", BELL_GLB_IN)
        return

    # --- Pack: import FBX alone for reference pack ---
    clear()
    dummy_arm = None
    got_pack = {}
    for fname, clip in CLIP_FILES:
        if clip in got_pack:
            continue
        path = os.path.join(MIXAMO_SRC, fname)
        if not os.path.isfile(path):
            continue
        before = set(bpy.data.actions.keys())
        import_fbx(path)
        new = set(bpy.data.actions.keys()) - before
        if new:
            acts = [bpy.data.actions[n] for n in new]
            acts.sort(key=lambda a: a.frame_range[1] - a.frame_range[0], reverse=True)
            acts[0].name = clip
            got_pack[clip] = acts[0].name
            for a in acts[1:]:
                try:
                    bpy.data.actions.remove(a)
                except Exception:
                    pass
    arms = [o for o in bpy.context.scene.objects if o.type == "ARMATURE"]
    ensure_nla(arms[0] if arms else None, ["idle", "walk", "sit"])
    export_glb(OUT_PACK)
    print("pack", list(got_pack.keys()))

    # --- Production: Bell mesh + Mixamo actions only ---
    clear()
    bpy.ops.import_scene.gltf(filepath=BELL_GLB_IN)
    arm = pick_bell_armature()
    print("bell armature", arm.name if arm else None)
    got = load_clips_onto_arm(arm)
    delete_beta_and_extra_armatures(arm)
    ensure_nla(arm, ["idle", "walk", "sit"])
    print("production clips", list(got.keys()), "actions", [a.name for a in bpy.data.actions])

    # Backup previous final
    if INSTALL and os.path.isfile(OUT_BELL):
        bak = OUT_BELL.replace(".glb", ".pre_mixamo.glb")
        if not os.path.isfile(bak):
            import shutil

            shutil.copy2(OUT_BELL, bak)
            print("backup", bak)
    export_glb(OUT_BELL if INSTALL else os.path.join(WORK, "bell_with_mixamo.glb"))
    print("=== 05_mixamo DONE install=", INSTALL, "clips=", list(got.keys()), "===")


if __name__ == "__main__":
    main()
