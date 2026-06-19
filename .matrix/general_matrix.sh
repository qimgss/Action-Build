#!/usr/bin/env bash
set -euo pipefail

INPUT="$1"
DEVICE_FILE="$2"

echo "INPUT=$INPUT"
echo "DEVICE_FILE=$DEVICE_FILE"

# 矩阵构建
if [ "$INPUT" = "矩阵构建" ]; then
  if [ ! -f "$DEVICE_FILE" ]; then
    echo "ERROR: devices.txt not found"
    exit 1
  fi

  DEVICES=$(grep -v '^$' "$DEVICE_FILE" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
  MATRIX='{"include":[]}'

  while IFS= read -r device; do
    [ -z "$device" ] && continue
    SCHED="false"
    CLEAN="$device"
    if [[ "$device" == *"(SCHED)"* ]]; then
      SCHED="true"
      CLEAN="${device%(SCHED)}"
      CLEAN="${CLEAN%"${CLEAN##*[![:space:]]}"}"
    fi
    MATRIX=$(echo "$MATRIX" | jq --arg f "$CLEAN" --arg s "$SCHED" \
      '.include += [{"file":$f,"sched_hmbird":$s}]')
  done <<< "$DEVICES"

  echo "matrix=$(echo "$MATRIX" | jq -c .)"
  exit 0
fi

# 单个设备
echo "matrix={\"include\":[{\"file\":\"$INPUT\",\"sched_hmbird\":\"false\"}]}"