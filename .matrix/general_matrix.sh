#!/usr/bin/env bash
set -euo pipefail

INPUT="$1"
DEVICE_FILE="${2:-}"

# ===== 矩阵构建 =====
if [ "$inputs" = "Alldevices" ]; then
  if [ -f "$DEVICE_FILE" ]; then
    DEVICES=$(grep -v '^$' "$DEVICE_FILE" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
  else
    DEVICES=""
  fi

  MATRIX='{"include":[]}'

  while IFS= read -r device; do
    [ -z "$device" ] && continue
    SCHED="false"
    CLEAN="$device"
    if [[ "$device" == *"(SCHED)"* ]]; then
      SCHED="true"
      CLEAN="${device%(SCHED)}"
      CLEAN="$(echo "$CLEAN" | sed 's/[[:space:]]*$//')"
    fi
    MATRIX=$(echo "$MATRIX" | jq --arg f "$CLEAN" --arg s "$SCHED" \
      '.include += [{"file":$f,"sched_hmbird":$s}]')
  done <<< "$DEVICES"

  echo "$MATRIX" | jq -c .
  exit 0
fi

# ===== 单设备构建（不依赖 jq / 文件）=====
echo "{\"include\":[{\"file\":\"$INPUT\",\"sched_hmbird\":\"false\"}]}"