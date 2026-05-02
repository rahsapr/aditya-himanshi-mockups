#!/usr/bin/env python3
"""Generate Neelam hero + programme images via Bedrock SD 3.5 Large."""
import json, base64, subprocess, sys, os, pathlib

OUT = pathlib.Path(__file__).parent.parent / "images"
OUT.mkdir(exist_ok=True)

MODEL = "stability.sd3-5-large-v1:0"
REGION = "us-west-2"
PROFILE = "rahsapr-dev"

jobs = [
    ("neelam-hero", "16:9",
     "Ornate Mughal-style architecture with deep royal sapphire blue and rich gold art deco geometric patterns, scalloped arches, intricate jali lattice screens, cream ivory marble background, warm golden hour light filtering through, regal luxurious palace aesthetic, Indian palace wedding feel, hand-painted watercolor illustration style, painterly, dreamy, no text, no letters, no words, no people, no faces",
     "text, letters, words, people, faces, modern buildings, casual, washed out, dull"),
    ("neelam-programme", "4:5",
     "Elegant geometric art deco ornament with deep royal sapphire blue, gold and ivory cream, Mughal-inspired medallion pattern, symmetrical, luxurious detail, warm watercolor illustration style, no text, no letters, no words, no people",
     "text, letters, people, asymmetric, modern"),
]

for slug, aspect, prompt, neg in jobs:
    out = OUT / f"{slug}.jpg"
    if out.exists():
        print(f"  ✓ {slug}: exists"); continue

    print(f"▶ {slug} ({aspect})")
    payload = json.dumps({
        "prompt": prompt,
        "mode": "text-to-image",
        "aspect_ratio": aspect,
        "output_format": "jpeg",
        "negative_prompt": neg,
        "seed": 0,
    })

    tmp = out.with_suffix(".tmp.json")
    cmd = ["aws", "bedrock-runtime", "invoke-model",
           "--profile", PROFILE, "--region", REGION,
           "--model-id", MODEL,
           "--body", payload,
           "--cli-binary-format", "raw-in-base64-out",
           str(tmp)]
    result = subprocess.run(cmd, capture_output=True, text=True)
    if result.returncode != 0:
        print(f"  ✗ {slug}: {result.stderr}"); continue

    data = json.load(open(tmp))
    out.write_bytes(base64.b64decode(data["images"][0]))
    tmp.unlink()
    print(f"  ✓ {slug}: saved {out.stat().st_size} bytes")
