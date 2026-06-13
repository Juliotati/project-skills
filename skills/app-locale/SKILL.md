---
name: app-locale
description: Enforces correct setup and usage of localizations (flutter_intl) across the codebase. Ensures all strings use context.i18n, ARB keys have descriptive metadata, and translations remain synchronized.
version: 1.3.0
framework: flutter
tags: [ i18n, localization, translations, language ]
---

# App Locale Management

This skill ensures the correct setup, synchronization, and usage of translations using `flutter_intl`.

## 1. Context Extension Strict Usage

- **Strict Rule:** The codebase must strictly use translations from `context.i18n` only.
- DO NOT use `AppLocal.of(context)` directly.
- **Variable Holding:** If `context.i18n` is used more than once within the same build method or function, assign it to a local variable (`final i18n = context.i18n;`) instead of repeating `context.i18n`.

```dart
// ❌ BAD
Text(AppLocal.of(context).welcomeMessage)

// ✅ GOOD (Single Use)
Text(context.i18n.welcomeMessage)

// ✅ GOOD (Multiple Uses)
Widget build(BuildContext context) {
  final i18n = context.i18n;
  return Column(
    children: [
      Text(i18n.welcomeMessage),
      Text(i18n.loginPrompt),
    ],
  );
}
```

## 2. ARB File Management

When adding new strings to the application, you must update the corresponding `.arb` files (e.g., `intl_en.arb`, `intl_pt_PT.arb`, `intl_pt_BR.arb`).

- **Descriptive Metadata:** Every new string MUST include descriptive metadata (using the `@key` format in ARB) to provide context for translators.

```json
// ❌ BAD: Missing metadata
{
  "welcomeMessage": "Welcome to the app"
}

// ✅ GOOD: Includes description
{
  "welcomeMessage": "Welcome to the app",
  "@welcomeMessage": {
    "description": "Greeting displayed on the home screen after login"
  }
}
```

## 3. Setup Awareness

- **Check Status:** Evaluate whether the localization setup is complete by checking `pubspec.yaml`. The setup is considered complete **ONLY** if the following configuration is present:
  ```yaml
  flutter_intl:
    enabled: true
    main_locale: en
    arb_dir: lib/translations
    output_dir: lib/translations
    class_name: AppLocal
    use_deferred_loading: true
  ```
- **Already Done:** If this exact configuration is present, the setup is done. **DO NOT** attempt to redo it. Focus exclusively on adding/managing strings and handling hardcoded text.
- **Not Done:** If this configuration is missing, incorrect, or incomplete, the skill must consider localization as not set up. You must then complete the setup by applying this exact configuration to `pubspec.yaml` to ensure uniformity across the codebase.

## 4. Translation Synchronization

- **Always Sync:** Whenever this skill is invoked to do any work, ALWAYS check the main translation file (e.g., `intl_en.arb`) against the other translation files.
- **Propagate Changes:** If there are any keys present in the main translation file that are missing from the other translation files, include those missing keys in the other files to make sure everything is perfectly synchronized.

## 5. Hardcoded Strings & Reporting

- **Automatic Translation:** If you find hardcoded strings in the UI code, go ahead and automatically translate them. Replace them with `context.i18n` calls and add the corresponding keys to the `.arb` files.
- **Reporting Rules:** After completing translations, you MUST provide a report of your actions to the user.
- **Detailed Report (< 20 Strings):** If you translated fewer than 20 strings, provide a detailed report showing exactly what was changed (e.g., show the original hardcoded string and the new `context.i18n` replacement).
- **Truncated Report (20+ Strings):** If there is a large volume of changes (20 or more strings), truncate the report to minimal information. Summarize the number of files modified and the total count of strings translated so you do not overwhelm the user with output.
