# Golden Eye Skill

The `golden-eye` skill establishes a standardized directory and file-naming convention for all Flutter golden tests in the project. The goal is to mirror the source code structure and ensure high-granularity visual verification through descriptive naming and multi-device testing.

## Key Principles

- **Mirroring:** Test files live in paths mirroring the `lib/` source.
- **Granularity:** Complex widgets are split into distinct test files for manageable verification.
- **Clarity:** Golden images are named descriptively to indicate the specific state being tested.
- **Consistency:** Uses a unified 3-column grid layout and standard device profiles (S8, S23 Ultra).

## Rules at a Glance

1. **Mirror Rule:** `lib/.../widget.dart` -> `test/.../widget_golden_test.dart`.
2. **Variant Split:** More than 2 major visual variations? Split into separate files.
3. **Descriptive Names:** No `test_1.png`. Use `button_loading_state.png`.
4. **Layout:** 3-column max grid in `GoldenTestGroup`.
5. **Devices:** Samsung S8 and Samsung S23 Ultra coverage.
6. **Subfolders:** Organize golden files as `<device_model>/<file_name>` for better folder organization.

## Implementation Guide

Refer to `SKILL.md` for the detailed specification and `examples/granular_golden_test_template.dart` for the implementation starter.
