#!/bin/bash
# Validation script for Feature Structure Skill

FEATURE_PATH=$1

# 1. Find the Project Root (where pubspec.yaml lives)
PROJECT_ROOT="$FEATURE_PATH"
while [[ "$PROJECT_ROOT" != "/" && ! -f "$PROJECT_ROOT/pubspec.yaml" ]]; do
  PROJECT_ROOT=$(dirname "$PROJECT_ROOT")
done

echo "🔍 Validating structure for: $FEATURE_PATH"
echo "📂 Project root identified at: $PROJECT_ROOT"

# 2. Check for the root library file
FEATURE_NAME=$(basename "$FEATURE_PATH")
if [ ! -f "$FEATURE_PATH/$FEATURE_NAME.dart" ]; then
  echo "❌ Error: Missing root library file $FEATURE_NAME.dart"
  exit 1
fi

# 3. Check for Part Of directives (Stitched files)
# These MUST have 'part of'
find "$FEATURE_PATH" -name "*.dart" \
  ! -path "*/models/*" \
  ! -path "*/providers/*" \
  ! -name "$FEATURE_NAME.dart" | while read -r file; do
  if ! grep -q "part of" "$file"; then
    echo "❌ Error: $file is missing 'part of' directive."
    exit 1
  fi
done

# 4. Check Model & Provider Isolation (Independent files)
# These MUST NOT have 'part of'
find "$FEATURE_PATH" -name "*.dart" \( -path "*/models/*" -o -path "*/providers/*" \) | while read -r file; do
  if grep -q "part of" "$file"; then
    echo "❌ Error: $file is independent but contains a 'part of' directive."
    exit 1
  fi
done

# 5. Check for analysis_options.yaml at the real root
if [ ! -f "$PROJECT_ROOT/analysis_options.yaml" ]; then
  echo "⚠️ Suggestion: Create an 'analysis_options.yaml' in the project root ($PROJECT_ROOT) for consistency."
else
  echo "✅ analysis_options.yaml found. Proceeding with linting validation..."
fi

echo "✅ Structure is valid!"
