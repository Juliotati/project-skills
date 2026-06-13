---
name: app-locale-setup
description: Bootstraps the flutter_intl setup for a project to ensure uniform localization configuration across the codebase. Use when the project requires localization setup, flutter_intl configuration is missing, or the user asks to configure app locale.
version: 1.0.1
framework: flutter
tags: [ i18n, localization, setup, config ]
---

# App Locale Setup

This skill is responsible exclusively for setting up the `flutter_intl` configuration in the
project. It does not handle translating strings or managing the actual `.arb` file content.

## Quick start

Check `pubspec.yaml` for the `flutter_intl` configuration. If missing or incorrect, append the exact
required configuration block.

## Workflows

### 1. Validate Setup Configuration

- Evaluate whether the localization setup is complete by checking `pubspec.yaml`. The setup is
  considered complete **ONLY** if the following exact configuration is present:
  ```yaml
  flutter_intl:
    enabled: true
    main_locale: en
    arb_dir: lib/translations
    output_dir: lib/translations
    class_name: AppLocal
    use_deferred_loading: true
  ```

### 2. Execution & Handoff

- **Apply Configuration:** If this configuration is missing, incorrect, or incomplete, automatically
  apply this exact configuration to `pubspec.yaml`.
- **Handoff:** Do not perform any string translation or UI source code modifications. Once the setup
  is complete, direct the user to use the `app-locale` skill if they have hardcoded strings they
  wish to translate.
