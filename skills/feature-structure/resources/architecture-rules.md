# Architecture Rules

### 1. Folder Constraints
- **Data Layer:** `data_sources/` can be flat. `models/` MUST be nested (1 folder per model).
- **Domain Layer:** Only abstract classes. No logic here.
- **Presentation Layer:** `screens/` must always have a sub-folder, even for single files.

### 2. Naming Conventions
- Provider classes: `<FeatureName>Provider`
- Repository Interfaces: `<FeatureName>Repository`
- Repository Impl: `<FeatureName>RepositoryImpl`

### 3. The Model Barrel
- Every `data/models/` directory must contain a `models.dart` file.
- This file must `export` every individual model folder.


# Feature Structure Map

```txt
lib/features/
└── <feature_name>/
    ├── <feature_name>.dart                   — Main Library File (contains all "part" path and imports)
    ├── data/
    │   ├── data_sources/
    │   │   ├── <feature_name>_local_ds.dart  (part of '../../<feature_name>.dart')
    │   │   └── <feature_name>_remote_ds.dart (part of '../../<feature_name>.dart')
    │   ├── enums/
    │   │   └── <type>_enum.dart              (part of '../../<feature_name>.dart')
    │   ├── models/
    │   │   ├── <model_name>/                 — Folder to isolate generated files
    │   │   │   ├── <model_name>.dart         — Independent (NOT a part file)
    │   │   │   ├── <model_name>.freezed.dart
    │   │   │   └── <model_name>.g.dart
    │   │   └── models.dart                   — Barrel file (Exports all models)
    │   └── repository/
    │       └── <feature_name>_repo_impl.dart (part of '../../<feature_name>.dart')
    ├── domain/
    │   └── repository/
    │       └── <feature_name>_repo.dart      — Contract (part of '../../<feature_name>.dart')
    └── presentation/
        ├── providers/
        │   └── <feature_name>_provider.dart (Independent, NOT a part file)
        ├── screen/
        │   └── <screen_name>/         — Dedicated screen folder
        │       └── <screen_name>_screen.dart (part of '../../<feature_name>.dart')
        └── widgets/
            ├── <bigger_widget>/        — Dedicated folder for complex UI
                └── <bigger_widget>_title.dart (part of '../../<feature_name>.dart')
                └── <bigger_widget>_description.dart (part of '../../<feature_name>.dart')
            └── <widget_1>.dart          (part of '../../<feature_name>.dart')
            └── <widget_2>.dart          (part of '../../<feature_name>.dart')

```
