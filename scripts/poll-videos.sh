#!/usr/bin/env bash
# Poll all pending Nova Reel jobs, download completed MP4s.
set -euo pipefail

PROFILE="rahsapr-dev"
REGION="us-east-1"
BUCKET="rahsapr-media-gen-us-east-1"
OUT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/videos"
JOBS_FILE="$OUT_DIR/.jobs.txt"

if [[ ! -f "$JOBS_FILE" ]]; then
  echo "No jobs file — run generate-videos.sh first"
  exit 1
fi

echo "Polling Nova Reel jobs (max 10 min, check every 20s)..."
START=$(date +%s)
MAX_WAIT=600

while :; do
  ELAPSED=$(( $(date +%s) - START ))
  if [[ $ELAPSED -gt $MAX_WAIT ]]; then
    echo "⚠ Timeout ($MAX_WAIT s). Some jobs may still be running — re-run this script."
    break
  fi

  ALL_DONE=1
  echo ""
  echo "--- $(date +%H:%M:%S) (${ELAPSED}s elapsed) ---"
  while IFS='|' read -r slug arn; do
    [[ -z "$slug" || -z "$arn" ]] && continue
    local_mp4="$OUT_DIR/${slug}.mp4"

    if [[ -f "$local_mp4" ]]; then
      echo "  ✓ $slug: already downloaded"
      continue
    fi

    status=$(aws bedrock-runtime get-async-invoke --profile "$PROFILE" --region "$REGION" \
      --invocation-arn "$arn" --query status --output text 2>&1)

    case "$status" in
      Completed)
        # ARN format: arn:aws:bedrock:us-east-1:ACCOUNT:async-invoke/INVOCATION_ID
        invoke_id="${arn##*/}"
        s3_key="nova-reel/${slug}/${invoke_id}/output.mp4"
        echo "  ✓ $slug: COMPLETED, downloading s3://$BUCKET/$s3_key"
        aws s3 cp "s3://$BUCKET/$s3_key" "$local_mp4" --profile "$PROFILE" --region "$REGION" 2>&1 | tail -2
        ;;
      InProgress)
        echo "  … $slug: InProgress"
        ALL_DONE=0
        ;;
      Failed)
        echo "  ✗ $slug: FAILED"
        aws bedrock-runtime get-async-invoke --profile "$PROFILE" --region "$REGION" \
          --invocation-arn "$arn" --query failureMessage --output text 2>&1
        ;;
      *)
        echo "  ? $slug: status=$status"
        ALL_DONE=0
        ;;
    esac
  done < "$JOBS_FILE"

  if [[ $ALL_DONE -eq 1 ]]; then
    echo ""
    echo "🎬 All videos ready in: $OUT_DIR"
    ls -lh "$OUT_DIR"/*.mp4 2>/dev/null
    break
  fi
  sleep 20
done
