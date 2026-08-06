#!/usr/bin/env python3
"""Stage 2: image → raw mesh GLB via cloud backends or local projection flag."""
from __future__ import annotations

import os
import shutil
import traceback
from pathlib import Path

PIPE = Path(__file__).resolve().parent
WORK = PIPE / "work"
FRONT = WORK / "bell_fullbody_front.jpg"
SIDE = WORK / "bell_side.jpg"
BACK = WORK / "bell_back.jpg"
OUT = WORK / "bell_i2_3d.glb"
MARKER = WORK / "i2_backend.txt"


def try_meshy(img: Path) -> bool:
    key = os.environ.get("MESHY_API_KEY", "").strip()
    if not key:
        print("  meshy: no MESHY_API_KEY")
        return False
    import json
    import time
    import urllib.request

    print("  meshy: submitting…")
    # Image to 3D create task (Meshy OpenAPI)
    import base64

    b64 = base64.b64encode(img.read_bytes()).decode("ascii")
    body = json.dumps(
        {
            "image_url": f"data:image/jpeg;base64,{b64}",
            "enable_pbr": True,
        }
    ).encode()
    req = urllib.request.Request(
        "https://api.meshy.ai/openapi/v1/image-to-3d",
        data=body,
        headers={
            "Authorization": f"Bearer {key}",
            "Content-Type": "application/json",
        },
        method="POST",
    )
    try:
        with urllib.request.urlopen(req, timeout=120) as resp:
            data = json.loads(resp.read().decode())
    except Exception as e:
        print(f"  meshy create fail: {e}")
        return False
    task_id = data.get("result") or data.get("id") or data.get("task_id")
    if not task_id:
        print("  meshy: unexpected", data)
        return False
    print(f"  meshy task {task_id}")
    for i in range(90):
        time.sleep(4)
        req2 = urllib.request.Request(
            f"https://api.meshy.ai/openapi/v1/image-to-3d/{task_id}",
            headers={"Authorization": f"Bearer {key}"},
        )
        with urllib.request.urlopen(req2, timeout=60) as resp:
            st = json.loads(resp.read().decode())
        status = st.get("status") or st.get("task_status")
        print(f"  meshy status {status}")
        if status in ("SUCCEEDED", "SUCCESS", "success", "completed"):
            model_urls = st.get("model_urls") or {}
            url = model_urls.get("glb") or st.get("model_url")
            if not url:
                print("  meshy: no glb url", st)
                return False
            urllib.request.urlretrieve(url, OUT)
            print(f"  meshy saved {OUT} ({OUT.stat().st_size})")
            MARKER.write_text("meshy\n")
            return True
        if status in ("FAILED", "failed", "ERROR"):
            print("  meshy failed", st)
            return False
    print("  meshy timeout")
    return False


def try_hf_space(space: str, api_name: str, kwargs: dict) -> bool:
    try:
        from gradio_client import Client, handle_file
    except ImportError:
        print("  gradio_client missing")
        return False
    print(f"  hf try {space} {api_name}")
    try:
        client = Client(space)
        # rewrite file paths
        args = {}
        for k, v in kwargs.items():
            if isinstance(v, Path):
                args[k] = handle_file(str(v)) if v.exists() else None
            else:
                args[k] = v
        result = client.predict(api_name=api_name, **args)
    except Exception as e:
        print(f"  hf fail {type(e).__name__}: {str(e)[:200]}")
        return False
    stack = [result]
    found = []
    while stack:
        x = stack.pop()
        if isinstance(x, (list, tuple)):
            stack.extend(x)
        elif isinstance(x, dict):
            stack.extend(x.values())
        elif isinstance(x, str) and Path(x).exists():
            found.append(Path(x))
    for p in found:
        if p.suffix.lower() in (".glb", ".obj", ".ply") and p.stat().st_size > 2000:
            dest = OUT if p.suffix.lower() == ".glb" else OUT.with_suffix(p.suffix)
            shutil.copy(p, dest)
            print(f"  hf saved {dest} ({dest.stat().st_size})")
            MARKER.write_text(f"hf:{space}\n")
            return dest.suffix.lower() == ".glb" or True
    print("  hf: no mesh file in result", result)
    return False


def try_cloud() -> bool:
    if not FRONT.exists():
        print("  missing front sheet")
        return False
    # Order: meshy → hunyuan → sf3d
    if try_meshy(FRONT):
        return True
    if try_hf_space(
        "tencent/Hunyuan3D-2.1",
        "/shape_generation",
        {
            "image": FRONT,
            "mv_image_front": FRONT if FRONT.exists() else None,
            "mv_image_back": BACK if BACK.exists() else None,
            "mv_image_left": SIDE if SIDE.exists() else None,
            "mv_image_right": None,
            "steps": 10.0,
            "guidance_scale": 5.0,
            "seed": 42.0,
            "octree_resolution": 128.0,
            "check_box_rembg": True,
            "num_chunks": 4000.0,
            "randomize_seed": False,
        },
    ):
        return True
    if try_hf_space(
        "stabilityai/stable-fast-3d",
        "/run_button",
        {
            "input_image": FRONT,
            "foreground_ratio": 0.9,
            "remesh_option": "None",
            "vertex_count": -1,
            "texture_size": 1024,
        },
    ):
        return True
    return False


def main() -> int:
    print("=== 02_image_to_mesh ===")
    force = os.environ.get("BELL_I2_BACKEND", "").strip().lower()
    WORK.mkdir(parents=True, exist_ok=True)

    if force == "projection":
        print("  forced projection backend (no cloud mesh)")
        MARKER.write_text("projection\n")
        if OUT.exists():
            OUT.unlink()
        print("=== 02 DONE (projection) ===")
        return 0

    if force == "meshy":
        ok = try_meshy(FRONT)
        print("=== 02", "DONE" if ok else "FAIL", "===")
        return 0 if ok else 1

    if OUT.exists() and OUT.stat().st_size > 10000:
        print(f"  reuse existing {OUT} ({OUT.stat().st_size})")
        if not MARKER.exists():
            MARKER.write_text("cached\n")
        print("=== 02 DONE (cached) ===")
        return 0

    ok = try_cloud()
    if not ok:
        print("  cloud I2-3D unavailable → projection backend")
        MARKER.write_text("projection\n")
        print("=== 02 DONE (fallback projection) ===")
        return 0
    print("=== 02 DONE ===")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
