---
name: golden-eye
description: Standardizes Flutter golden tests with mirroring rules and granular naming for high-fidelity UI verification.
author: Juliotati
version: 1.1.0
framework: flutter
tags: [testing, golden-test, ui-verification, design]
---

# SKILL: Golden Eye (Test Organization & Naming)

## Objective
Establish a standardized directory and file-naming convention for all Flutter golden tests in the project. Ensure high-granularity visual verification by mirroring the source structure and separating variants.

## 1. Directory Mirroring Rule
Every golden test file must reside in a `test/` directory path that exactly mirrors its `lib/` counterpart.
- **Rule:** `lib/path/to/widget.dart` -> `test/path/to/widget_golden_test.dart`
- **Example:** `lib/core/presentation/widgets/app_tile.dart` must have a corresponding test at `test/core/presentation/widgets/app_tile_golden_test.dart`.

## 2. Multi-Variant Separation Rule
If a widget or feature has more than **2 distinct visual variations**, split them into dedicated files rather than one giant test file to avoid bloat and maintain clarity.
- **Feature-based Split Example:**
    - `feature/posts/presentation/widgets/text_post_golden_test.dart`
    - `feature/posts/presentation/widgets/media_post_golden_test.dart`

## 3. Granular Output Naming
Generated golden images must use descriptive, human-readable names specifying exactly what is being tested in that variation.
- **Prohibited:** Generic names like `test_1.png`.
- **Requirement:** Use specific descriptors.
- **Example (Discussion Post variants):**
    - `discussion_post_without_media.png`
    - `discussion_post_without_location.png`
    - `discussion_post_without_title.png`

## 4. Golden Group Layout
Within each test file, use a **3-column maximum grid layout** for variant comparison (implemented via `GoldenTestGroup` in **Alchemist**). This ensures the output is readable and consistent.

## 5. Natural UI Sizing
Tests should not use restricted bounds (e.g., fixed device profiles). Instead, they should allow the UI being tested to define its own width and height, ensuring the golden image captures the widget in its natural state.

## 6. Output Folder Organization
To keep golden files organized, the output golden file should follow the granular naming rule directly in the mirrored folder structure.
- **Rule:** Mirror the directory structure in `local_goldens/` as defined in the global configuration.
- **Example:** `fileName: 'app_button_granular_variants'`

## 7. Global Golden Configuration
All projects using this skill must define a `test/flutter_test_config.dart` to standardize the **Alchemist** execution environment.
- **Rule:** Use the provided generic configuration to enforce automatic mirroring, theme consistency, and storage mocking.
- **Example Implementation:**
  - Locate the configuration in `resources/flutter_test_config.dart`.
  - Copy it into the root of the project's `test/` directory.

## 8. Template Reference
Always refer to the following when creating new golden tests:
- **Test Template:** `examples/granular_golden_test_template.dart`.
- **Global Config:** `resources/flutter_test_config.dart`.
