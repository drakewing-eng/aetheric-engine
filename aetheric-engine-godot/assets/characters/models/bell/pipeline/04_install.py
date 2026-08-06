#!/usr/bin/env python3
"""Stage 4: install work/bell_rigged.glb → final/bell.glb"""
from __future__ import annotations

import shutil
from pathlib import Path

PIPE = Path(__file__).resolve().parent
WORK = PIPE / "work"
FINAL = PIPE.parent / "final"
SRC = WORK / "bell_rigged.glb"
DST = FINAL / "bell.glb"


def main() -> int:
    print("=== 04_install ===")
    if not SRC.exists() or SRC.stat().st_size < 1000:
        print(f"  missing {SRC}")
        return 1
    FINAL.mkdir(parents=True, exist_ok=True)
    # backup previous
    if DST.exists():
        bak = FINAL / "bell.prev.glb"
        shutil.copy(DST, bak)
        print(f"  backup → {bak.name}")
    shutil.copy(SRC, DST)
    print(f"  installed {DST} ({DST.stat().st_size} bytes)")
    # Ensure runtime still points at glb (no code change needed)
    rt = FINAL / "bell_runtime.gd"
    if rt.exists():
        print(f"  runtime ok: {rt.name}")
    print("=== 04 DONE ===")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
