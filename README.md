# Project Skills

A collection of AI-ready skills designed to automate and enforce high-quality Software Engineering standards in Flutter and Dart projects.

## 🛠 Available Skills

### 1. [Feature Structure (Clean Architecture)](./feature-structure)
Enforces a "Feature-first" layered architecture. It utilizes the "Stitch" pattern to maintain clean namespaces while ensuring strict separation of concerns.
* **Core Pattern:** Uses Dart `library` and `part/part of` directives.
* **Layering:** Separates code into Data (Sources/Models), Domain (Contracts), and Presentation (Providers/Screens).
* **Model Isolation:** Keeps generated `.freezed.dart` and `.g.dart` files in dedicated sub-folders to prevent directory clutter.

### 2. [Code Quality (Flutter/Dart)](./code-quality)
Ensuring readability, scalability, and performance by enforcing strict widget decomposition and linting rules.
* **Linter Backbone:** Strictly adheres to the project's `analysis_options.yaml`.
* **Widget Standards:** Mandates concrete classes over helper functions and enforces a 200-line refactor threshold.
* **Signature Rules:** Requires named parameters for multi-parameter functions and limits parameter counts (Max 5 for functions, Max 7 for widgets).

### 3. [Golden Eye (Visual Testing)](./skills/golden-eye)
Standardizes directory-mirrored golden testing with multi-device verification and centralized configuration.
* **Testing Standard:** Enforces a 1:1 relationship between `lib/` and `test/` paths.
* **Granular Verification:** Splits complex widgets into distinct variations for clear visual diffing.
* **Centralized Config:** Provides a standard `flutter_test_config.dart` for automated mirroring and storage mocking.

## 🚀 How to Use

These skills are designed to be used with AI agents (like Cursor, Gemini CLI, or Claude Code) to guide code generation.

### Installation
```bash
npx skills add Juliotati/project-skills --skill <skill-name>
```
