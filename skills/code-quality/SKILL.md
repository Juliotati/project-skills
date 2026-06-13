---
name: code-quality
description: Enforces high-standard Flutter/Dart patterns focusing on widget decomposition, parameter management, strict styling standards, and linter adherence. Use when refactoring widgets, optimizing themes/rebuilds, or validating Dart code quality rules.
author: Juliotati
version: 1.1.0
framework: flutter
tags: [ quality, refactoring, performance, linting, theming ]
---

# Code Quality

Enforces high-standard Flutter/Dart patterns focusing on widget decomposition, parameter management, strict styling standards, and linter adherence.

## Quick start

Instead of large, multi-parameter widget trees with helper functions, prefer concrete, const-constructible widgets with parameter objects:

```dart
// ❌ BAD: Helper functions, hardcoded colors, and too many parameters
Widget build(BuildContext context) {
  return Column(
    children: [
      _buildHeader(context, title, subtitle, imageUrl, isEnabled, onAction, userRole),
      Container(color: Colors.blue, child: const Text('Direct styling')),
    ],
  );
}

// ✅ GOOD: Concrete Widget, parameter object, and correct BuildContext/style extensions
Widget build(BuildContext context) {
  return Column(
    children: [
      const HeaderWidget(config: HeaderConfig(title: title, subtitle: subtitle)),
      Container(
        padding: const .all(8),
        decoration: BoxDecoration(
          color: context.colorScheme.primary,
          borderRadius: .circular(8),
        ),
        child: const Text('Styled with theme colors'),
      ),
    ],
  );
}
```

## Workflows

### 1. Linter Adherence & Backbone
- [ ] **Linter Configuration**: Ensure `analysis_options.yaml` exists at the project root and is strictly followed.
- [ ] **Validation**: If `analysis_options.yaml` is missing, suggest creating it using the [analysis_options_template.yaml](resources/analysis_options_template.yaml) template.
- [ ] **Post-Change Tasks**: After every code change, always run:
  - `dart analyze`
  - `dart format --line-length 80 .`
  - `dart fix --apply --code=directives_ordering,unused_import`
  - `dart run build_runner build --delete-conflicting-outputs`

### 2. Widget Architecture & Decomposition ("Divide and Conquer")
- [ ] **Concrete Widgets**: Always prefer concrete widget classes (`StatelessWidget`/`StatefulWidget`) over helper functions (e.g., `_buildWidget()`).
- [ ] **200-Line Limit**: Any widget file or class exceeding 200 lines must be refactored and split into smaller pieces.
- [ ] **Indentation Limit**: If a build method has more than 5 levels of indentation, extract sub-widgets.
- [ ] **Rebuild Isolation**: Extract highly-dynamic or localized state widgets to isolate rebuilds and prevent adjacent tree updates.

### 3. Function & Parameter Standards
- [ ] **Widget Named Parameters**: Use named parameters for widget constructors when dealing with more than 1 parameter.
- [ ] **Positional Constructors for Providers & Below**: Providers, repositories, data sources, and services MUST use **positional** constructor parameters — not named. Dependencies are injected and self-documenting by type.
  ```dart
  // ❌ BAD: Named parameters in provider constructor
  ProfileEditorProvider({
    required UserProfileModel initialProfile,
    required UserRepository userRepository,
  });

  // ✅ GOOD: Positional parameters in provider constructor
  ProfileEditorProvider(
    UserProfileModel initialProfile,
    this._userRepository,
  );
  ```
- [ ] **Parameter Limits**: Max 5 parameters for functions, and max 7 parameters for custom widgets. **Exception**: Classes that rely on heavy dependency injection (e.g. `RepositoryImpl`, `DataSourceImpl`) may exceed this limit.
- [ ] **Data Grouping**: If parameter limits are exceeded, group related fields into a single data class/model and pass that class instance instead.

### 4. UI & Implementation Standards
- [ ] **No Logic in Widgets**: Never keep business or layout logic inside widgets. Delegate all logic to providers or controllers.
- [ ] **Theme Legibility**: Enforce theme legibility across light and dark modes strictly via `lib/core/theme`.
- [ ] **Styling Extensions**: Utilize styling extensions in `lib/core/extensions` and theme extensions in `lib/core/theme/theme_extensions.dart`.
- [ ] **No Hardcoding**: DO NOT hardcode styling values outside theme definitions (e.g., avoid `Colors.blue` or hardcoded fonts).
- [ ] **Dart Shorthands**: USING Dart shorthand syntax on classes and enums IS A MUST (e.g., `.center`, `.circular(8)` etc) across the codebase.
- [ ] **Navigation**: EXCLUSIVELY use go_router (e.g., `context.push()`, `context.go()`, `context.pop()`) for all navigation. DO NOT use standard navigation methods like `Navigator.of(context).push()`, `Navigator.of(context).pop()`, or `Navigator.push()`. All screens, dialogs, and views must be defined in `app_router.dart`.
### 5. Logic & State Management
- [ ] **Flat Logic**: Avoid nested checks. Refactor deep nesting by using early returns (guard clauses) or consistent design patterns (e.g., state, strategy).
- [ ] **No Provider Injection**: A provider MUST NEVER be injected into another provider to prevent tight coupling.
- [ ] **State Separation**: Use `Provider` to pass state down the tree if needed 1+ layer deep instead of drilling props.

## Advanced features

- See [resources/quality-rules.md](resources/quality-rules.md) for deeper explanation on parameter grouping and rebuilding optimization.
- See [examples/refactor-demo.md](examples/refactor-demo.md) for step-by-step refactoring demonstration from helper functions to concrete widgets.
