#!/bin/bash
# Logic to check if the analysis_options.yaml exists as the backbone of the project

# Find Project Root
PROJECT_ROOT="."
while [[ "$PROJECT_ROOT" != "/" && ! -f "$PROJECT_ROOT/pubspec.yaml" ]]; do
  PROJECT_ROOT=$(dirname "$PROJECT_ROOT")
done

if [ -f "$PROJECT_ROOT/analysis_options.yaml" ]; then
  echo "✅ Quality Check: analysis_options.yaml found. Linter rules are active."
else
  echo "⚠️ Quality Warning: No analysis_options.yaml found at $PROJECT_ROOT."
  echo "Suggestion: Create this file to enforce consistency and quality."
fi
