#!/usr/bin/env bash
# Fire 4 Nova Reel jobs in parallel, save invocation ARNs, then poll.
# Usage: bash generate-videos.sh
set -euo pipefail

PROFILE="rahsapr-dev"
REGION="us-east-1"
BUCKET="rahsapr-media-gen-us-east-1"
OUT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/videos"
JOBS_FILE="$OUT_DIR/.jobs.txt"
mkdir -p "$OUT_DIR"
> "$JOBS_FILE"

# Helper: fire a single text-to-video job
fire() {
  local slug="$1"
  local prompt="$2"
  local payload=$(cat <<EOF
{
  "taskType": "TEXT_VIDEO",
  "textToVideoParams": { "text": "$prompt" },
  "videoGenerationConfig": {
    "durationSeconds": 6,
    "fps": 24,
    "dimension": "1280x720",
    "seed": $((RANDOM * 100))
  }
}
EOF
)
  echo "▶ Firing: $slug"
  local arn=$(aws bedrock-runtime start-async-invoke \
    --profile "$PROFILE" \
    --region "$REGION" \
    --model-id "amazon.nova-reel-v1:1" \
    --model-input "$payload" \
    --output-data-config "s3OutputDataConfig={s3Uri=s3://$BUCKET/nova-reel/$slug/}" \
    --query invocationArn --output text 2>&1)

  if [[ "$arn" == arn:* ]]; then
    echo "  ✓ ARN: $arn"
    echo "$slug|$arn" >> "$JOBS_FILE"
  else
    echo "  ✗ FAILED: $arn"
  fi
}

# 4 clips — 2 dark, 2 light
fire "dal-dusk" \
  "Cinematic aerial top-down view of Dal Lake in Srinagar Kashmir at dusk. Traditional wooden shikara boats with small warm lanterns glide slowly across still dark water. Deep indigo and midnight blue sky with faint stars appearing. Golden lantern reflections shimmer on the water surface. Misty mountains silhouetted in the distance. Painterly cinematic quality. Slow graceful camera drift. No people visible. Atmospheric and dreamy."

fire "mandap-candlelight" \
  "Close-up slow pan across an ornate Indian wedding mandap at night. Intricate gold embroidery on deep emerald and crimson silk fabrics. Hundreds of small diya oil lamps flicker with warm golden light. Fresh marigold flower garlands draped around carved wooden pillars. Shallow depth of field with bokeh. Deep jewel tones. Cinematic quality. Slow graceful camera movement. No people. Luxurious and intimate."

fire "marigold-petals" \
  "Slow motion top-down view of fresh yellow marigold and pink rose petals falling gently onto soft cream-colored silk fabric with delicate gold thread embroidery. Warm saffron and golden afternoon light. Shallow depth of field. Dreamy painterly quality. Slow graceful falling motion. No people. Peaceful and warm."

fire "chinar-leaves" \
  "Autumn chinar maple leaves with rich orange red and yellow colors drifting slowly downward through warm golden hour light. Painterly hand-held camera feel with soft focus. Kashmir autumn forest in soft background blur. Gentle breeze motion. Cinematic quality. No people. Nostalgic and warm."

echo ""
echo "✅ All jobs fired. ARNs saved to: $JOBS_FILE"
echo "Now run: bash scripts/poll-videos.sh"
