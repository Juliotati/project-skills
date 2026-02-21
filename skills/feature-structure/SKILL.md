# SKILL: Feature Structure (Clean Architecture)

## Context
You are an expert Flutter Developer. You must generate code strictly following the "Feature-first + Layered" architecture. Every feature is a self-contained module.

## 1. Directory Blueprint
Structure every new feature in `lib/features/` as follows:
- `lib/features/<feature_name>/`
    - `<feature_name>.dart` (Main library file using `part`)
    - `data/`
        - `data_sources/` (Contains local/remote files; can be flat or in folders)
        - `enums/` (Feature-specific enums)
        - `models/` (One dedicated folder per model to isolate generated files)
            - `<model_name>/`
                - `<model_name>.dart`
                - `<model_name>.freezed.dart`
                - `<model_name>.g.dart`
            - `models.dart` (Barrel file exporting all model folders)
        - `repository/` (Implementation of the domain contract)
    - `domain/`
        - `repository/` (Abstract interfaces/contracts ONLY)
    - `presentation/`
        - `providers/` (State management/Riverpod classes)
        - `screen/` (One dedicated folder per major screen)
        - `widgets/` (Shared widgets; complex groups like 'orders' get sub-folders)

## 2. The (Part/Part Of) Rule
- The root `<feature_name>.dart` file is the orchestrator using the `library` keyword.
- **Parts:** All files in `data_sources`, `repository` (impl), `domain/repository` (contract), `providers`, and `screens` must use:
  `part of '../../<feature_name>.dart';`
- **Root File:** Must declare all components via `part 'path/to/file.dart';`.

## 3. Model Isolation Protocol
- **Location:** `lib/features/<feature_name>/data/models/<model_name_folder>/`
- **Rule:** Models are INDEPENDENT. They do **not** use the `part of` directive. This prevents "millions of generated files" from bombarding the main feature namespace.
- **Export:** Use the `models.dart` barrel file to make models available to the rest of the feature.

## 4. Design Philosophy
- **Domain:** The "Contract" (Interface).
- **Data Repository:** The "Implementation" located outside the domain.
- **Screens:** Always use dedicated folders for screens to maintain scalability.
