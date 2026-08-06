#!/usr/bin/env python3
"""Stage 1: ensure full-body character sheets exist for image-to-3D."""
from __future__ import annotations

import shutil
from pathlib import Path

PIPE = Path(__file__).resolve().parent
INPUT = PIPE / "input"
WORK = PIPE / "work"
WORK.mkdir(parents=True, exist_ok=True)

# Expected outputs (may already be produced by Imagine image_edit in agent session)
FRONT = WORK / "bell_fullbody_front.jpg"
SIDE = WORK / "bell_side.jpg"
BACK = WORK / "bell_back.jpg"

# Session / project fallbacks for front sheet
CANDIDATES_FRONT = [
    FRONT,
    PIPE / "work" / "bell_fullbody_front.jpg",
]


def main() -> int:
    print("=== 01_prepare_sheet ===")
    # Copy canonical refs if missing
    for name, srcs in {
        "ref_desk.jpg": [
            INPUT / "ref_desk.jpg",
        ],
        "ref_sprite.png": [INPUT / "ref_sprite.png"],
        "ref_portrait.jpg": [INPUT / "ref_portrait.jpg"],
    }.items():
        for s in srcs:
            if s.exists():
                print(f"  ref ok: {s.name} ({s.stat().st_size} bytes)")
                break
        else:
            print(f"  WARN missing input {name}")

    if FRONT.exists() and FRONT.stat().st_size > 10000:
        print(f"  front sheet ready: {FRONT} ({FRONT.stat().st_size})")
    else:
        print("  ERROR: missing work/bell_fullbody_front.jpg")
        print("  Generate with Imagine from desk+sprite (A-pose full body, white BG)")
        print("  then copy to pipeline/work/bell_fullbody_front.jpg")
        return 1

    for p in (SIDE, BACK):
        if p.exists():
            print(f"  turnaround ok: {p.name}")
        else:
            print(f"  note: optional turnaround missing {p.name}")

    # Write manifest
    manifest = WORK / "sheet_manifest.txt"
    lines = [f"front={FRONT}", f"exists_front={FRONT.exists()}"]
    if SIDE.exists():
        lines.append(f"side={SIDE}")
    if BACK.exists():
        lines.append(f"back={BACK}")
    manifest.write_text("\n".join(lines) + "\n")
    print(f"  wrote {manifest}")
    print("=== 01 DONE ===")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
