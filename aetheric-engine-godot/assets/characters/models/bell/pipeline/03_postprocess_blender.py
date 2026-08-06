"""
Blender stage: produce work/bell_rigged.glb
- If work/bell_i2_3d.glb exists: import, scale to 1.78m, plant feet, retarget/copy anims
- Else projection path: skinned body from anim_source + fullbody sheet as front albedo
"""
import bpy
import bmesh
import math
import os
import sys
from mathutils import Vector

WORK = os.environ.get(
    "BELL_PIPE_WORK",
    os.path.join(os.path.dirname(os.path.abspath(__file__)), "work"),
)
I2 = os.path.join(WORK, "bell_i2_3d.glb")
FRONT = os.path.join(WORK, "bell_fullbody_front.jpg")
ANIM = os.path.join(WORK, "anim_source.glb")
CESIUM = os.path.join(WORK, "cesium.glb")
OUT = os.path.join(WORK, "bell_rigged.glb")
MARKER = os.path.join(WORK, "i2_backend.txt")
TARGET_H = 1.78


def clear():
    bpy.ops.object.select_all(action="SELECT")
    bpy.ops.object.delete(use_global=False)
    for coll in (
        bpy.data.meshes,
        bpy.data.materials,
        bpy.data.actions,
        bpy.data.armatures,
        bpy.data.images,
    ):
        for b in list(coll):
            try:
                coll.remove(b)
            except Exception:
                pass


def world_bbox(objs=None):
    if objs is None:
        objs = [o for o in bpy.context.scene.objects if o.type == "MESH"]
    mn = Vector((1e9, 1e9, 1e9))
    mx = Vector((-1e9, -1e9, -1e9))
    found = False
    for o in objs:
        if o.type != "MESH":
            continue
        for c in o.bound_box:
            w = o.matrix_world @ Vector(c)
            mn = Vector((min(mn.x, w.x), min(mn.y, w.y), min(mn.z, w.z)))
            mx = Vector((max(mx.x, w.x), max(mx.y, w.y), max(mx.z, w.z)))
            found = True
    return (mn, mx) if found else (Vector(), Vector())


def scale_plant_all(target_h=TARGET_H):
    meshes = [o for o in bpy.context.scene.objects if o.type == "MESH"]
    if not meshes:
        return
    # find root empties/armatures
    roots = []
    for o in bpy.context.scene.objects:
        if o.parent is None and o.type in ("ARMATURE", "EMPTY", "MESH"):
            # only top-level that contain mesh descendants
            roots.append(o)
    if not roots:
        roots = meshes
    mn, mx = world_bbox(meshes)
    h = max(mx.z - mn.z, 0.01)
    sc = target_h / h
    # Prefer single armature root
    arms = [o for o in bpy.context.scene.objects if o.type == "ARMATURE"]
    root = arms[0] if arms else roots[0]
    while root.parent:
        root = root.parent
    root.scale *= sc
    bpy.context.view_layer.update()
    mn, mx = world_bbox()
    root.location.z -= mn.z
    bpy.context.view_layer.update()
    mn, mx = world_bbox()
    print(f"planted h={mx.z - mn.z:.3f} feet={mn.z:.3f}")


def rename_actions():
    for a in bpy.data.actions:
        nl = a.name.lower()
        if "idle" in nl:
            a.name = "idle"
        elif "walk" in nl and "run" not in nl:
            a.name = "walk"
        elif "sit" in nl:
            a.name = "sit"


def ensure_nla_and_sit(arm):
    if arm is None:
        return
    if not arm.animation_data:
        arm.animation_data_create()
    ad = arm.animation_data
    while ad.nla_tracks:
        ad.nla_tracks.remove(ad.nla_tracks[0])
    for name in ("idle", "walk"):
        act = bpy.data.actions.get(name)
        if not act:
            continue
        tr = ad.nla_tracks.new()
        tr.name = name
        st = tr.strips.new(name, int(act.frame_range[0]), act)
        st.action = act
    # sit
    if bpy.data.actions.get("sit") is None:
        sit = bpy.data.actions.new("sit")
        ad.action = sit
        # key hip bones if present
        for b in arm.pose.bones:
            nl = b.name.lower().replace("mixamorig:", "").replace("mixamorig_", "")
            if nl in ("leftupleg", "rightupleg"):
                b.rotation_mode = "XYZ"
                b.rotation_euler = (0, 0, 0)
                b.keyframe_insert(data_path="rotation_euler", frame=1)
                b.rotation_euler = (math.radians(-70), 0, 0)
                b.keyframe_insert(data_path="rotation_euler", frame=12)
            if nl in ("leftleg", "rightleg"):
                b.rotation_mode = "XYZ"
                b.rotation_euler = (0, 0, 0)
                b.keyframe_insert(data_path="rotation_euler", frame=1)
                b.rotation_euler = (math.radians(75), 0, 0)
                b.keyframe_insert(data_path="rotation_euler", frame=12)
    sit = bpy.data.actions.get("sit")
    if sit:
        tr = ad.nla_tracks.new()
        tr.name = "sit"
        st = tr.strips.new("sit", 1, sit)
        st.action = sit
    ad.action = bpy.data.actions.get("idle")
    print("actions", [a.name for a in bpy.data.actions])


def export_glb(path):
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
    print("exported", path, os.path.getsize(path))


def path_from_i2():
    print("path: image-to-3d mesh")
    bpy.ops.import_scene.gltf(filepath=I2)
    scale_plant_all()
    # Try import anims from anim source
    arms = [o for o in bpy.context.scene.objects if o.type == "ARMATURE"]
    arm = arms[0] if arms else None
    if os.path.isfile(ANIM):
        # Import anim file into same scene — may add second armature; copy actions by name
        before = set(bpy.data.actions.keys())
        bpy.ops.import_scene.gltf(filepath=ANIM)
        after = set(bpy.data.actions.keys())
        new_acts = after - before
        print("imported anim actions", new_acts)
        # remove extra meshes from anim source if they look like props
        # keep all for now; rename actions
    rename_actions()
    if arm is None:
        arms = [o for o in bpy.context.scene.objects if o.type == "ARMATURE"]
        arm = arms[0] if arms else None
    ensure_nla_and_sit(arm)
    # If mesh has no skin but we have armature, try auto weight
    if arm:
        for o in bpy.context.scene.objects:
            if o.type == "MESH" and o.find_armature() is None:
                try:
                    bpy.ops.object.select_all(action="DESELECT")
                    o.select_set(True)
                    arm.select_set(True)
                    bpy.context.view_layer.objects.active = arm
                    bpy.ops.object.parent_set(type="ARMATURE_AUTO")
                    print("auto-weighted", o.name)
                except Exception as e:
                    print("auto-weight skip", o.name, e)
    scale_plant_all()
    export_glb(OUT)


def mat_image(name, image_path):
    img = bpy.data.images.load(image_path)
    img.pack()
    m = bpy.data.materials.new(name)
    m.use_nodes = True
    nt = m.node_tree
    bsdf = nt.nodes.get("Principled BSDF")
    tex = nt.nodes.new("ShaderNodeTexImage")
    tex.image = img
    tex.location = (-300, 200)
    nt.links.new(tex.outputs["Color"], bsdf.inputs["Base Color"])
    if "Alpha" in tex.outputs and "Alpha" in bsdf.inputs:
        nt.links.new(tex.outputs["Alpha"], bsdf.inputs["Alpha"])
        m.blend_method = "CLIP"
    bsdf.inputs["Roughness"].default_value = 0.75
    return m


def project_uv_front(ob):
    me = ob.data
    if not me.uv_layers:
        me.uv_layers.new(name="UVMap")
    uv = me.uv_layers.active.data
    coords = [ob.matrix_world @ v.co for v in me.vertices]
    xs = [c.x for c in coords]
    zs = [c.z for c in coords]
    minx, maxx = min(xs), max(xs)
    minz, maxz = min(zs), max(zs)
    dx = max(maxx - minx, 1e-4)
    dz = max(maxz - minz, 1e-4)
    for poly in me.polygons:
        for li in poly.loop_indices:
            vi = me.loops[li].vertex_index
            w = ob.matrix_world @ me.vertices[vi].co
            u = (w.x - minx) / dx
            v = (w.z - minz) / dz
            uv[li].uv = (u, v)


def path_projection():
    print("path: projection character from fullbody sheet")
    # Import anim source for skeleton + clips (preferred)
    anim_path = ANIM if os.path.isfile(ANIM) else CESIUM
    if not os.path.isfile(anim_path):
        raise SystemExit("no anim_source.glb or cesium.glb")
    bpy.ops.import_scene.gltf(filepath=anim_path)
    # Strip prop-like meshes (BellCoat, hair spheres, etc.) keep body+armature
    keep_mesh_names = []
    for o in list(bpy.context.scene.objects):
        if o.type != "MESH":
            continue
        n = o.name.lower()
        # drop obvious prop stacks from previous bell export
        if any(
            x in n
            for x in (
                "bellcoat",
                "bellhair",
                "bellhead",
                "bellbook",
                "bellvest",
                "bellshirt",
                "bellcravat",
                "sphere",
                "cube",
            )
        ):
            bpy.data.objects.remove(o, do_unlink=True)
            continue
        keep_mesh_names.append(o.name)
    print("kept meshes", keep_mesh_names)

    arms = [o for o in bpy.context.scene.objects if o.type == "ARMATURE"]
    arm = arms[0] if arms else None
    meshes = [o for o in bpy.context.scene.objects if o.type == "MESH"]
    if not meshes:
        raise SystemExit("no mesh after import")

    # Apply reference sheet as material on all body meshes
    if os.path.isfile(FRONT):
        mat = mat_image("mat_bell_ref", FRONT)
        for o in meshes:
            o.data.materials.clear()
            o.data.materials.append(mat)
            project_uv_front(o)
            for p in o.data.polygons:
                p.use_smooth = True
            print("textured", o.name)
    else:
        print("WARN no front sheet for texture")

    # Add coat shell for silhouette weight (dark, continuous)
    if arm:
        hips_z = 0.9
        # dark frock overlay slightly larger
        bpy.ops.mesh.primitive_cylinder_add(radius=0.28, depth=0.95, location=(0, 0.02, 1.05), vertices=24)
        coat = bpy.context.active_object
        coat.name = "BellCoatShell"
        coat.scale = (1.0, 0.75, 1.0)
        bpy.ops.object.transform_apply(scale=True)
        # taper top via simple edit not required
        mcoat = bpy.data.materials.new("mat_coat")
        mcoat.use_nodes = True
        bsdf = mcoat.node_tree.nodes.get("Principled BSDF")
        bsdf.inputs["Base Color"].default_value = (0.08, 0.07, 0.08, 1)
        bsdf.inputs["Roughness"].default_value = 0.9
        # mix with reference if available — keep dark coat
        coat.data.materials.append(mcoat)
        for p in coat.data.polygons:
            p.use_smooth = True
        # parent + auto weight
        bpy.ops.object.select_all(action="DESELECT")
        coat.select_set(True)
        arm.select_set(True)
        bpy.context.view_layer.objects.active = arm
        try:
            bpy.ops.object.parent_set(type="ARMATURE_AUTO")
        except Exception as e:
            print("coat weight", e)
            coat.parent = arm

    # Hair volume from remesh spheres on head bone
    if arm and os.path.isfile(FRONT):
        head = None
        for b in arm.pose.bones:
            if "head" in b.name.lower() and "end" not in b.name.lower():
                head = (arm.matrix_world @ b.matrix).translation
                break
        if head is None:
            head = Vector((0, 0, 1.6))
        mhair = bpy.data.materials.new("mat_hair")
        mhair.use_nodes = True
        mhair.node_tree.nodes.get("Principled BSDF").inputs["Base Color"].default_value = (
            0.4,
            0.38,
            0.42,
            1,
        )
        pieces = []
        import random

        random.seed(3)
        for i in range(22):
            ang = i / 22 * math.tau
            r = 0.08
            loc = head + Vector((math.cos(ang) * r * 0.8, math.sin(ang) * r * 0.5, 0.06))
            bpy.ops.mesh.primitive_uv_sphere_add(radius=0.06, location=loc, segments=8, ring_count=6)
            pieces.append(bpy.context.active_object)
        for _ in range(10):
            loc = head + Vector(
                (
                    random.uniform(-0.1, 0.1),
                    random.uniform(-0.05, 0.08),
                    random.uniform(0.1, 0.25),
                )
            )
            bpy.ops.mesh.primitive_uv_sphere_add(radius=0.05, location=loc, segments=6, ring_count=5)
            pieces.append(bpy.context.active_object)
        bpy.ops.object.select_all(action="DESELECT")
        for p in pieces:
            p.select_set(True)
            p.data.materials.append(mhair)
        bpy.context.view_layer.objects.active = pieces[0]
        bpy.ops.object.join()
        hair = bpy.context.active_object
        hair.name = "BellHair"
        rem = hair.modifiers.new("r", "REMESH")
        rem.mode = "SMOOTH"
        rem.octree_depth = 4
        rem.use_smooth_shade = True
        bpy.ops.object.modifier_apply(modifier=rem.name)
        bpy.ops.object.select_all(action="DESELECT")
        hair.select_set(True)
        arm.select_set(True)
        bpy.context.view_layer.objects.active = arm
        try:
            bpy.ops.object.parent_set(type="ARMATURE_AUTO")
        except Exception:
            hair.parent = arm

    rename_actions()
    ensure_nla_and_sit(arm)
    scale_plant_all()
    export_glb(OUT)


def main():
    clear()
    backend = "projection"
    if os.path.isfile(MARKER):
        backend = open(MARKER).read().strip().split("\n")[0]
    print("backend marker:", backend)
    if os.path.isfile(I2) and os.path.getsize(I2) > 10000 and not backend.startswith("projection"):
        path_from_i2()
    else:
        path_projection()
    print("DONE postprocess")


if __name__ == "__main__":
    main()
