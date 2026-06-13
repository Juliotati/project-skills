---
name: app-locale
description: Enforces correct usage of localizations (flutter_intl) across the codebase. Ensures all strings use context.i18n and translations remain synchronized. Use when adding new localized strings, translating UI text, or when the user mentions translations.
version: 2.0.1
framework: flutter
tags: [ i18n, localization, translations, language ]
---

# App Locale Management

This skill ensures the correct synchronization and usage of translations using `flutter_intl`.
*Note: This skill assumes the `flutter_intl` setup is already complete. If it is not, use
the `app-locale-setup` skill first.*

## Quick start

When you find a hardcoded string like `Text("Welcome")`, replace it with
`context.i18n.welcomeMessage` and add `"welcomeMessage": "Welcome"` to `intl_en.arb` with metadata.

## Workflows

### 1. Context Extension Strict Usage

- **Strict Rule:** The codebase must strictly use translations from `context.i18n` only. DO NOT use
  `AppLocal.of(context)` directly.
- **Variable Holding:** If `context.i18n` is used more than once within the same build method or
  function, assign it to a local variable (`final i18n = context.i18n;`).

### 2. ARB File Management

- **Descriptive Metadata:** Every new string MUST include descriptive metadata using the `@key`
  format in ARB files (e.g., `"@welcomeMessage": { "description": "Greeting on home screen" }`).
- **Translation Synchronization:** Whenever invoked, ALWAYS check `intl_en.arb` against other
  translation files. If keys are missing in other files, propagate them to ensure perfect
  synchronization.

### 3. Hardcoded Strings & Reporting

- **Automatic Translation:** Automatically translate hardcoded strings in the UI code, replace with
  `context.i18n`, and add keys to `.arb` files.
- **Detailed Report (< 20 Strings):** Format as a Markdown table with emojis (e.g., ✅).

| Status | File            | Original String | New `i18n` Key         |
|:------:|:----------------|:----------------|:-----------------------|
|   ✅    | `lib/home.dart` | "Welcome"       | `context.i18n.welcome` |

- **Truncated Report (20+ Strings):** Truncate to a minimal Markdown table summarizing the number of
  files modified and the total count of strings translated.
