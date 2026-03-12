import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// [Golden Eye Template] - Alchemist Version
///
/// 1. Mirror Rule: This file should be in test/core/widgets/app_button_golden_test.dart
///    if matching lib/core/widgets/app_button.dart
/// 2. Multi-Variant Rule: More than 2 major visual variations? Use separate files.
/// 3. Granular Names: Use descriptive names (e.g. 'app_button_loading_state').
/// 4. Layout: Max 3 columns in the GoldenTestGroup.
/// 5. Sizing: Natural UI sizing, no restricted bounds.
void main() {
  group('AppButton Golden Tests', () {
    goldenTest(
      'AppButton Granular Variants - 3 Column Grid',
      fileName: 'app_button_granular_variants',
      builder: () => GoldenTestGroup(
        columns: 3,
        children: [
          GoldenTestScenario(
            name: 'Normal State',
            child: const AppButton(text: 'Submit'),
          ),
          GoldenTestScenario(
            name: 'Danger State',
            child: const AppButton(text: 'Delete', isDanger: true),
          ),
          GoldenTestScenario(
            name: 'Disabled State',
            child: const AppButton(text: 'Wait...', isDisabled: true),
          ),
        ],
      ),
    );

    // Single variant testing with natural sizing
    goldenTest(
      'AppButton Natural Sizing',
      fileName: 'app_button_natural_sizing',
      builder: () => const AppButton(text: 'Natural Size Button'),
    );
  });
}

// --- Placeholder for the actual widget (for template context) ---
class AppButton extends StatelessWidget {
  final String text;
  final bool isDanger;
  final bool isDisabled;

  const AppButton({
    super.key,
    required this.text,
    this.isDanger = false,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: isDisabled ? Colors.grey : (isDanger ? Colors.red : Colors.blue),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
