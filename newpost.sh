#!/bin/bash

TITLE="$1"
shift

TAGS=""
DESCRIPTION=""

while [[ $# -gt 0 ]]; do
  case $1 in
    --tags)
      TAGS="$2"
      shift 2
      ;;
    --description)
      DESCRIPTION="$2"
      shift 2
      ;;
    *)
      echo "❌ Unknown argument: $1"
      exit 1
      ;;
  esac
done

SLUG=$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -dc '[:alnum:]-')
DATE=$(date +"%Y-%m-%d")
DATETIME=$(date +"%Y-%m-%d %H:%M:%S %z")
POST_DIR="_posts"
FILENAME="$POST_DIR/$DATE-$SLUG.md"

IFS=',' read -ra TAG_ARRAY <<< "$TAGS"
TAGS_YAML=$(printf -- "- %s\n" "${TAG_ARRAY[@]}")

mkdir -p "$POST_DIR"
cat > "$FILENAME" <<EOF
---
title: "$TITLE"
date: $DATETIME
modified: $DATETIME
tags:
$TAGS_YAML
description: "$DESCRIPTION"
---

<!-- Post start here -->
EOF

echo "✅ Post created: $FILENAME"
