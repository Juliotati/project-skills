---
name: golden-eye
description: Standardizes Flutter golden tests with mirroring rules and granular naming for high-fidelity UI verification. Use when creating, naming, or organizing Flutter golden tests.
---

# Golden Eye

Standardized directory and naming conventions for high-fidelity Flutter golden tests.

## Quick start

```dart
// test/core/widgets/app_button_golden_test.dart (Mirrors lib/)
void main() {
  group('AppButton Golden Tests', () {
    goldenTest(
      'AppButton Granular Variants',
      fileName: 'app_button_variants',
      builder: () => GoldenTestGroup(
        columns: 3,
        children: [
          GoldenTestScenario(name: 'Normal', child: AppButton(text: 'Submit')),
          GoldenTestScenario(name: 'Loading', child: AppButton(text: 'Wait', isLoading: true)),
        ],
      ),
    );
  });
}
```

## Workflows

### 1. Mirroring & Naming
- [ ] Create test at `test/path/to/widget_golden_test.dart` mirroring `lib/`.
- [ ] If >2 visual variations exist, split into dedicated files (e.g., `feature_post_text_test.dart`).
- [ ] Use descriptive output names (e.g., `discussion_post_without_location.png`).

### 2. Layout & Sizing
- [ ] Use `GoldenTestGroup` with a **3-column maximum** grid.
- [ ] Use **Natural UI Sizing**: Do not use fixed device bounds; let the widget define its size.
- [ ] Organize outputs in `local_goldens/` following the mirrored path.

### 3. Global Configuration
- [ ] Ensure `test/flutter_test_config.dart` exists in the project root.
- [ ] Copy the standard config from [resources/flutter_test_config.dart](resources/flutter_test_config.dart).

## Advanced features

See [REFERENCE.md](REFERENCE.md) for detailed rules on variant separation and output organization.
See [examples/granular_golden_test_template.dart](examples/granular_golden_test_template.dart) for a full implementation starter.

