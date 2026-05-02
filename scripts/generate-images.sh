#!/usr/bin/env bash
# Generate all SD 3.5 Large images for the 5 variants.
# Runs in us-west-2 (different region from Nova Reel — no throttle conflict).
set -euo pipefail

PROFILE="rahsapr-dev"
REGION="us-west-2"
MODEL="stability.sd3-5-large-v1:0"
OUT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/images"
mkdir -p "$OUT_DIR"

STYLE_DARK="soft watercolor illustration style, painterly, moody atmospheric, deep jewel tones, hand-painted feel, dreamy, no text, no letters, no words, no faces, no people"
STYLE_LIGHT="warm watercolor illustration style, painterly, soft pastel palette, warm golden light, hand-painted feel, elegant editorial quality, no text, no letters, no words, no faces, no people"
STYLE_SHAAM="ethereal dreamy watercolor, very soft pastels, oyster beige dusty rose pale sage, minimalist editorial, airy and gentle, hand-painted, no text, no letters, no words, no people"
STYLE_MAHAL="ornate art deco illustration, emerald green gold and ivory, geometric mughal arch patterns, architectural elegance, luxurious editorial quality, no text, no letters, no words, no people"

gen() {
  local slug="$1"
  local aspect="$2"
  local prompt="$3"
  local neg="$4"
  local out="$OUT_DIR/${slug}.jpg"

  if [[ -f "$out" ]]; then
    echo "  ✓ $slug: already exists, skipping"
    return
  fi

  echo "▶ Generating: $slug ($aspect)"
  local payload
  payload=$(python3 -c "
import json, sys
print(json.dumps({
    'prompt': sys.argv[1],
    'mode': 'text-to-image',
    'aspect_ratio': sys.argv[2],
    'output_format': 'jpeg',
    'negative_prompt': sys.argv[3],
    'seed': 0
}))
" "$prompt" "$aspect" "$neg")

  local tmpjson=$(mktemp)
  aws bedrock-runtime invoke-model \
    --profile "$PROFILE" \
    --region "$REGION" \
    --model-id "$MODEL" \
    --body "$payload" \
    --cli-binary-format raw-in-base64-out \
    "$tmpjson" > /dev/null 2>&1

  # SD 3.5 Large returns {"images": ["base64..."], "seeds": [...], "finish_reasons": [...]}
  python3 -c "
import json, base64, sys
data = json.load(open('$tmpjson'))
img_b64 = data['images'][0]
open('$out', 'wb').write(base64.b64decode(img_b64))
print(f'  ✓ $slug: saved $(wc -c < $out) bytes')
" || echo "  ✗ $slug: decode failed"
  rm -f "$tmpjson"
}

# ===== Variant 1: Dal (Cinematic Dark) =====
gen "dal-hero-still" "16:9" \
  "Dal Lake in Srinagar Kashmir at twilight, wooden shikara boats with golden lanterns on still dark water, misty Himalayan mountains silhouetted against deep indigo and midnight blue sky, soft golden reflections, cinematic atmospheric mood. $STYLE_DARK" \
  "text, letters, words, typography, people, faces, humans, harsh lighting, saturated colors"

gen "dal-programme" "4:5" \
  "A single wooden shikara boat with a tiny glowing lantern drifting on still dark blue water at night, stars overhead, minimal composition, painterly. $STYLE_DARK" \
  "text, letters, people, faces, bright colors, busy composition"

# ===== Variant 2: Kesar (Saffron Warmth) =====
gen "kesar-hero" "16:9" \
  "Soft warm golden hour scene, scattered marigold flowers and fresh rose petals on cream silk fabric with delicate gold thread embroidery, warm saffron light, Indian wedding aesthetic, luxurious and dreamy. $STYLE_LIGHT" \
  "text, letters, words, people, faces, dark moody lighting"

gen "kesar-programme" "4:5" \
  "Delicate detail of orange marigold garlands and saffron strands against cream silk, soft warm light, painterly close-up, Indian wedding. $STYLE_LIGHT" \
  "text, letters, people, faces, harsh shadows"

# ===== Variant 3: Chinar (Autumn Heritage) =====
gen "chinar-hero" "16:9" \
  "A grand chinar tree in autumn with vivid orange red and golden yellow leaves, some leaves drifting down through warm afternoon light, Kashmir autumn landscape, soft mountains in far distance, hand-painted heritage feel, nostalgic and warm. $STYLE_LIGHT" \
  "text, letters, words, people, faces, winter, snow"

gen "chinar-programme" "4:5" \
  "Single chinar leaf in autumn orange and gold, delicate watercolor botanical study, cream background, elegant, detailed veins. $STYLE_LIGHT" \
  "text, letters, people, busy composition"

# ===== Variant 4: Shaam (Soft Editorial Modern) =====
gen "shaam-hero" "16:9" \
  "Ethereal dreamy landscape, very soft pale mountains in dusty rose and oyster beige, delicate wildflowers in pale sage and powder blue foreground, misty atmosphere, minimalist editorial composition, airy and gentle, Pinterest quiet luxury aesthetic. $STYLE_SHAAM" \
  "text, letters, words, people, faces, saturated colors, dark tones"

gen "shaam-programme" "4:5" \
  "Very soft minimalist composition of pale dusty rose and sage green wildflowers on oyster beige background, delicate and airy, editorial style, painterly. $STYLE_SHAAM" \
  "text, letters, people, busy, dark colors"

gen "shaam-accent" "3:2" \
  "Soft pale mountain range at dawn in misty dusty rose and powder blue, minimalist, dreamy, watercolor wash. $STYLE_SHAAM" \
  "text, people, dark, saturated"

# ===== Variant 5: Mahal (Opulent Palace / Art Deco) =====
gen "mahal-hero" "16:9" \
  "Ornate Mughal-style architecture with emerald green and gold art deco geometric patterns, scalloped arches, intricate jali lattice screens, ivory marble background, golden hour light filtering through, regal luxurious palace aesthetic, Delhi farmhouse wedding feel. $STYLE_MAHAL" \
  "text, letters, words, people, faces, modern buildings, casual"

gen "mahal-programme" "4:5" \
  "Elegant geometric art deco ornament with emerald green gold and ivory, Mughal-inspired medallion pattern, symmetrical, luxurious detail. $STYLE_MAHAL" \
  "text, letters, people, asymmetric, modern"

echo ""
echo "🎨 All images generated."
ls -lh "$OUT_DIR"/*.jpg 2>/dev/null
