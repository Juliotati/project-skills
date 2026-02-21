#!/bin/bash
# Validation script for Feature Structure Skill

FEATURE_PATH=$1

echo "🔍 Validating structure for: $FEATURE_PATH"

# 1. Check for the root library file
FEATURE_NAME=$(basename "$FEATURE_PATH")
if [ ! -f "$FEATURE_PATH/$FEATURE_NAME.dart" ]; then
  echo "❌ Error: Missing root library file $FEATURE_NAME.dart"
  exit 1
fi

# 2. Check for Part Of directives (excluding models)
find "$FEATURE_PATH" -name "*.dart" ! -path "*/models/*" ! -name "$FEATURE_NAME.dart" | while read -r file; do
  if ! grep -q "part of" "$file"; then
    echo "❌ Error: $file is missing 'part of' directive."
    exit 1
  fi
done

# 3. Check Model isolation
find "$FEATURE_PATH/data/models" -maxdepth 1 -type d | while read -r dir; do
    if [[ "$dir" == *"models" ]]; then continue; fi
    MODEL_NAME=$(basename "$dir")
    if [ ! -f "$dir/$MODEL_NAME.dart" ]; then
        echo "⚠️ Warning: Model folder $MODEL_NAME is empty or missing main file."
    fi
done

echo "✅ Structure is valid!"
