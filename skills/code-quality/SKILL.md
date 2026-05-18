---
name: code-quality
description: Enforces high-standard Flutter/Dart patterns focusing on widget decomposition, parameter management, and strict linter adherence. Use when refactoring widgets, optimizing rebuilds, managing function/widget parameter limits, or validating Dart linter rules.
author: Juliotati
version: 1.0.0
framework: flutter
tags: [ quality, refactoring, performance, linting ]
---

# Code Quality

Enforces high-standard Flutter/Dart patterns focusing on widget decomposition, parameter management, and strict linter adherence.

## Quick start

Instead of large, multi-parameter widget trees with helper functions, prefer concrete, const-constructible widgets with parameter objects:

```dart
// ❌ BAD: Helper functions and too many parameters
Widget build(BuildContext context) {
  return Column(
    children: [
      _buildHeader(context, title, subtitle, imageUrl, isEnabled, onAction, userRole),
    ],
  );
}

// ✅ GOOD: Concrete Widget with parameter object
Widget build(BuildContext context) {
  return const Column(
    children: [
      HeaderWidget(config: HeaderConfig(title: title, subtitle: subtitle)),
    ],
  );
}
```

## Workflows

### 1. Linter Adherence & Backbone
- [ ] **Linter Configuration**: Ensure `analysis_options.yaml` exists at the project root and is strictly followed.
- [ ] **Validation**: If `analysis_options.yaml` is missing, suggest creating it using the [analysis_options_template.yaml](resources/analysis_options_template.yaml) template.
- [ ] **Script Check**: Run the validation script `sh scripts/validate_lints.sh` to check linter presence.

### 2. Widget Architecture & Decomposition ("Divide and Conquer")
- [ ] **Concrete Widgets**: Always prefer concrete widget classes (`StatelessWidget`/`StatefulWidget`) over helper functions (e.g., `_buildWidget()`).
- [ ] **200-Line Limit**: Any widget file or class exceeding 200 lines must be refactored and split into smaller pieces.
- [ ] **Indentation Limit**: If a build method has more than 5 levels of indentation, extract sub-widgets.
- [ ] **Rebuild Isolation**: Extract highly-dynamic or localized state widgets to isolate rebuilds and prevent adjacent tree updates.

### 3. Function & Parameter Standards
- [ ] **Named Parameters**: Use named parameters when dealing with more than 1 parameter.
- [ ] **Parameter Limits**: Max 5 parameters for functions, and max 7 parameters for custom widgets.
- [ ] **Data Grouping**: If parameter limits are exceeded, group related fields into a single data class/model and pass that class instance instead.

### 4. Logic & State Management
- [ ] **State Separation**: Use `Provider` to pass state down the tree if needed 1+ layer deep instead of drilling props.
- [ ] **UI/Logic Isolation**: Use controllers to separate UI layout from reactive logic (e.g., step indicators, animation controllers).

## Advanced features

- See [resources/quality-rules.md](resources/quality-rules.md) for deeper explanation on parameter grouping and rebuilding optimization.
- See [examples/refactor-demo.md](examples/refactor-demo.md) for step-by-step refactoring demonstration from helper functions to concrete widgets.
