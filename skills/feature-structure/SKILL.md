---
name: feature-structure
description: Enforces Clean Architecture with the Stitch "part/part of" pattern and model isolation.
author: Julio Tati
version: 1.0.0
framework: flutter
tags: [architecture, clean-code, provider, dart]
---

# SKILL: Feature Structure (Clean Architecture)

## Context
You are an expert Flutter Developer. You must generate code strictly following the "Feature-first + Layered" architecture. Every feature is a self-contained module.

## 1. Directory Blueprint
Structure every new feature in `lib/features/` as follows:
- `lib/features/<feature_name>/`
    - `<feature_name>.dart` (Main library file)
    - `data/`
        - `data_sources/` (Local/Remote sources)
        - `enums/` (Feature-specific enums)
        - `models/` (One folder per model + barrel file)
        - `repository/` (Implementation of domain contracts)
    - `domain/`
        - `repository/` (Abstract interfaces/contracts)
    - `presentation/`
        - `providers/` (State management/Riverpod)
        - `screen/` (Folders per major screen)
        - `widgets/` (Shared feature widgets)

## 2. The "Stitch" Rule (Part/Part Of)
To maintain a clean namespace while keeping files small:
- The root `<feature_name>.dart` acts as the orchestrator.
- **Parts:** `data_sources`, `repository` (impl), `domain/repository`, and `screens`.
- **Independent Files:** `models/` and `providers/`. These must NOT use `part of` and must use standard `imports`.
- **Root File:** Must declare all components via `part 'path/to/file.dart';`.

## 3. Model Isolation Protocol
- **Location:** `lib/features/<feature_name>/data/models/<model_name>/`
- **Rule:** Models are INDEPENDENT. They do **not** use `part of`.
- **Generation:** Always generate `<model_name>.freezed.dart` and `<model_name>.g.dart` in the same sub-folder.
- **Access:** Create a `models.dart` barrel file at the root of `data/models/` to export all sub-folders.

## 4. Layer Responsibilities
- **Domain:** Pure Dart. Defines the "What" (Abstract Repository).
- **Data:** Defines the "How". Implements the Repository and handles JSON via Models.
- **Presentation:** UI and Logic. Providers handle the state, Screens handle the layout.

## 5. Linting & Formatting
- **Standard:** Every file generated MUST strictly adhere to the rules defined in the `analysis_options.yaml` located at the project root.
- **Enforcement:**
    - If `analysis_options.yaml` exists: Read it before generating code to ensure correct linting (e.g., preferred use of `const`, sorting imports, or specific naming conventions).
    - If `analysis_options.yaml` is MISSING: Explicitly notify the developer: *"Warning: analysis_options.yaml not found. It is highly recommended to create one to maintain code consistency across the feature."*
- **Formatting:** Always run `dart format .` logic mentally before presenting code to ensure correct indentation and line lengths.
