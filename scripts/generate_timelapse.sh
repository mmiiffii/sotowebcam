#!/usr/bin/env bash
set -euo pipefail

FRAMES_DIR="frames"
OUT_DIR="timelapses"

mkdir -p "$OUT_DIR"

# Output file with current UTC timestamp
TIMESTAMP="$(date -u +'%Y-%m-%d_%H-%M-%S')"
OUT_FILE="${OUT_DIR}/timelapse_${TIMESTAMP}.mp4"

# Build timelapse at 30 fps from all JPG frames
# Uses glob pattern to match all sotogrande_*.jpg files
ffmpeg -y -loglevel error       -pattern_type glob -framerate 30       -i "${FRAMES_DIR}/sotogrande_*.jpg"       -c:v libx264 -pix_fmt yuv420p       "$OUT_FILE"

echo "Generated timelapse: $OUT_FILE"
