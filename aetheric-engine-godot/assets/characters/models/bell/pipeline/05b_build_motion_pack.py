"""Clean Mixamo pack: one body + three full clips (idle/walk/sit). Safe action isolation."""
import bpy
import os
import shutil

WORK = os.environ.get(
    "BELL_PIPE_WORK",
    os.path.join(os.path.dirname(os.path.abspath(__file__)), "work"),
)
MIX = os.path.abspath(
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
OUT_ASSETS = os.path.abspath(os.path.join(os.path.dirname(MIX), "mixamo_activity_pack.glb"))


def clear():
    bpy.ops.object.select_all(action="SELECT")
    bpy.ops.object.delete(use_global=False)
    for coll in (bpy.data.meshes, bpy.data.materials, bpy.data.actions, bpy.data.armatures):
        for b in list(coll):
            try:
                coll.remove(b)
            except Exception:
                pass


def import_fbx(path):
    bpy.ops.import_scene.fbx(
        filepath=path, automatic_bone_orientation=True, use_anim=True
    )


def fcurves_of(action):
    fcs = []
    if hasattr(action, "fcurves") and action.fcurves is not None:
        try:
            return list(action.fcurves)
        except Exception:
            pass
    for layer in getattr(action, "layers", []) or []:
        for strip in getattr(layer, "strips", []) or []:
            for slot in getattr(action, "slots", []) or [None]:
                try:
                    cb = strip.channelbag(slot) if slot is not None else None
                    if cb and hasattr(cb, "fcurves"):
                        fcs.extend(list(cb.fcurves))
                except Exception:
                    pass
    return fcs


def zero_hip_xz(action):
    for fc in fcurves_of(action):
        dp = fc.data_path.lower()
        if "location" not in dp:
            continue
        if "hips" not in dp and "root" not in dp:
            continue
        if fc.array_index in (0, 2):
            for kp in fc.keyframe_points:
                kp.co.y = 0.0
                kp.handle_left.y = 0.0
                kp.handle_right.y = 0.0


def extract_action_from_import(path, keep_names):
    """Import FBX, copy its primary action, delete all newly created objects/actions extras."""
    before_objs = set(bpy.context.scene.objects)
    before_acts = set(bpy.data.actions.keys())
    import_fbx(path)
    new_objs = [o for o in bpy.context.scene.objects if o not in before_objs]
    # Prefer action bound to a new armature
    act = None
    for o in new_objs:
        if o.type == "ARMATURE" and o.animation_data and o.animation_data.action:
            act = o.animation_data.action
            break
    if act is None:
        new_acts = [bpy.data.actions[n] for n in set(bpy.data.actions.keys()) - before_acts]
        if new_acts:
            new_acts.sort(
                key=lambda a: a.frame_range[1] - a.frame_range[0], reverse=True
            )
            act = new_acts[0]
    if act is None:
        print("FAIL no action from", path)
        for o in new_objs:
            try:
                bpy.data.objects.remove(o, do_unlink=True)
            except Exception:
                pass
        return None
    # Independent copy so deleting extras doesn't wipe it
    copied = act.copy()
    # Remove newly created objects (extra armatures/meshes)
    for o in new_objs:
        try:
            bpy.data.objects.remove(o, do_unlink=True)
        except Exception:
            pass
    # Remove new actions except our copy and protected keep_names
    for n in list(bpy.data.actions.keys()):
        if n in keep_names:
            continue
        if n == copied.name:
            continue
        if n not in before_acts and n != act.name:
            try:
                bpy.data.actions.remove(bpy.data.actions[n])
            except Exception:
                pass
    # Remove original act if different object
    if act.name != copied.name and act.name not in keep_names:
        try:
            if act.name in bpy.data.actions:
                bpy.data.actions.remove(bpy.data.actions[act.name])
        except Exception:
            pass
    return copied


def main():
    os.makedirs(WORK, exist_ok=True)
    walk_p = os.path.join(MIX, "start_walking.fbx")
    idle_p = os.path.join(MIX, "standing_idle.fbx")
    sit_p = os.path.join(MIX, "sitting_idle.fbx")
    for label, p in (("walk", walk_p), ("idle", idle_p), ("sit", sit_p)):
        print(label, p, "exists" if os.path.isfile(p) else "MISSING")

    clear()
    # Base mesh from walk
    import_fbx(walk_p)
    arm = [o for o in bpy.context.scene.objects if o.type == "ARMATURE"][0]
    # Drop joint meshes and extra meshes
    for o in list(bpy.context.scene.objects):
        if o.type == "MESH" and "joint" in o.name.lower():
            bpy.data.objects.remove(o, do_unlink=True)
    bodies = [o for o in bpy.context.scene.objects if o.type == "MESH"]
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
    # Clear base actions
    for a in list(bpy.data.actions):
        try:
            bpy.data.actions.remove(a)
        except Exception:
            pass
    print("base mesh", keep.name if keep else None, "arm", arm.name)

    walk = extract_action_from_import(walk_p, set())
    if walk:
        walk.name = "walk"
        zero_hip_xz(walk)
        print("OK walk", tuple(walk.frame_range), len(fcurves_of(walk)))

    idle = extract_action_from_import(idle_p, {"walk"})
    if idle:
        idle.name = "idle"
        zero_hip_xz(idle)
        print("OK idle", tuple(idle.frame_range), len(fcurves_of(idle)))

    sit = extract_action_from_import(sit_p, {"walk", "idle"})
    if sit:
        sit.name = "sit"
        # keep hip height
        print("OK sit", tuple(sit.frame_range), len(fcurves_of(sit)))

    print("actions now", [a.name for a in bpy.data.actions])

    if not arm.animation_data:
        arm.animation_data_create()
    ad = arm.animation_data
    while ad.nla_tracks:
        ad.nla_tracks.remove(ad.nla_tracks[0])
    for name in ("idle", "walk", "sit"):
        act = bpy.data.actions.get(name)
        if not act:
            print("MISSING action", name)
            continue
        tr = ad.nla_tracks.new()
        tr.name = name
        st = tr.strips.new(name, int(act.frame_range[0]), act)
        st.action = act
    ad.action = bpy.data.actions.get("idle") or bpy.data.actions.get("walk")

    bpy.ops.export_scene.gltf(
        filepath=OUT_PACK,
        export_format="GLB",
        export_animations=True,
        export_nla_strips=True,
        export_skins=True,
        export_yup=True,
        export_image_format="NONE",
    )
    shutil.copy2(OUT_PACK, OUT_ASSETS)
    print("exported", OUT_ASSETS, os.path.getsize(OUT_ASSETS))
    # verify glb anim names
    print("=== 05b DONE actions", [a.name for a in bpy.data.actions], "===")


if __name__ == "__main__":
    main()
