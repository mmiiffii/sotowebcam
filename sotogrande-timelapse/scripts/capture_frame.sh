#!/usr/bin/env bash
set -euo pipefail

STREAM_URL="https://webcam.meteo365.es/hls_live/sotograndepuerto.m3u8"
FRAMES_DIR="frames"

mkdir -p "$FRAMES_DIR"

# Timestamp like 2025-11-18_14-30-00 (UTC)
TIMESTAMP="$(date -u +'%Y-%m-%d_%H-%M-%S')"
OUT_FILE="${FRAMES_DIR}/sotogrande_${TIMESTAMP}.jpg"

# Grab a single frame from the HLS stream
ffmpeg -loglevel error -y       -i "$STREAM_URL"       -frames:v 1       -q:v 2       "$OUT_FILE"

echo "Saved frame: $OUT_FILE"
