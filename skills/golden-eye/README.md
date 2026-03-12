# Golden Eye Skill

The `golden-eye` skill establishes a standardized directory and file-naming convention for all Flutter golden tests in the project. The goal is to mirror the source code structure and ensure high-granularity visual verification through descriptive naming and natural UI sizing.

## Key Principles

- **Mirroring:** Test files live in paths mirroring the `lib/` source.
- **Granularity:** Complex widgets are split into distinct test files for manageable verification.
- **Clarity:** Golden images are named descriptively to indicate the specific state being tested.
- **Sizing:** Uses natural UI sizing instead of restricted device bounds to capture widgets in their intended state.

## Rules at a Glance

1. **Mirror Rule:** `lib/.../widget.dart` -> `test/.../widget_golden_test.dart`.
2. **Variant Split:** More than 2 major visual variations? Split into separate files.
3. **Descriptive Names:** No `test_1.png`. Use `button_loading_state.png`.
4. **Layout:** 3-column max grid in `GoldenTestGroup`.
5. **Natural Sizing:** No restricted bounds; capture the height/width of the UI being tested.
6. **Folder Organization:** Organize golden files in mirrored directories within `local_goldens/`.
7. **Global Config:** Ensure every project defines `test/flutter_test_config.dart` using the standard mirroring and theme settings.

## Implementation Guide

Refer to `SKILL.md` for the detailed specification, `examples/granular_golden_test_template.dart` for the implementation starter, and `resources/flutter_test_config.dart` for the global configuration resource.
