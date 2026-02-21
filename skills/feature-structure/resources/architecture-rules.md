**Feature Structure Map**

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
        │   └── <feature_name>_provider.dart  (part of '../../<feature_name>.dart')
        ├── screen/
        │   └── <screen_name>_folder/         — Dedicated screen folder
        │       └── <screen_name>_screen.dart (part of '../../<feature_name>.dart')
        └── widgets/
            ├── <widget_group_folder>/        — Dedicated folder for complex UI
            └── <shared_widget>.dart          (part of '../../<feature_name>.dart')
