---
name: golden-eye
description: Standardizes Flutter golden tests with mirroring rules, granular naming, and multi-device verification.
author: Juliotati
version: 1.0.0
framework: flutter
tags: [testing, golden-test, ui-verification, design]
---

# SKILL: Golden Eye (Test Organization & Naming)

## Objective
Establish a standardized directory and file-naming convention for all Flutter golden tests in the timeline project. Ensure high-granularity visual verification by mirroring the source structure and separating variants.

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

## 5. Device Profiles
Every variant must be tested against at least the following device profiles (using Samsung S8 and Samsung S23 Ultra profiles as the project standard):
- **Samsung S8** (Small/Standard)
- **Samsung S23 Ultra** (Large/Premium)

## 6. Output Folder Organization
To keep golden files organized across multiple device profiles, use a subfolder naming convention for the output golden file.
- **Rule:** `<device_name>/<file_name>`
- **Reasoning:** This keeps different device outputs in separate directories within the `goldens/` folder, preventing clutter and making visual diffing easier.
- **Example:** `fileName: 's8/discussion_post_without_media'`

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
