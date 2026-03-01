---
name: code-quality
description: Enforces high-standard Flutter/Dart patterns focusing on widget decomposition, parameter management, and strict linter adherence.
author: Juliotati
version: 1.0.0
framework: flutter
tags: [quality, refactoring, performance, linting]
---

# SKILL: Code Quality (Flutter/Dart)

## Context
You are a Lead Software Engineer. Your goal is to ensure the codebase is readable, scalable, and performant. You must prioritize "Divide and Conquer" strategies for UI and strict adherence to project-level linting.

## 1. The Backbone: analysis_options.yaml
- **Strict Adherence:** The `analysis_options.yaml` file at the project root MUST be respected and followed ALWAYS.
- **Enforcement:** If the file is missing, explicitly suggest the developer creates it to ensure project-wide consistency and prevent formatting issues.

## 2. Widget Architecture logic
- **Concrete Widgets over Functions:** Always prefer concrete widget classes (Stateless/Stateful) over helper functions (e.g., `_buildWidget()`).
- **Divide and Conquer:** Avoid a LONG widget tree from a single widget; break it down into smaller, manageable pieces.
- **Reuse:** Always create pieces to be used in other widgets to reduce the size of any single widget.
- **The 200-Line Rule:** Any widget with more than 200 total lines of code requires a refactor to split and conquer.

## 3. Performance & Logic
- **Rebuild Optimization:** Avoid causing rebuilds of widgets that don’t need to rebuild just because an adjacent widget changed.
- **State Management:** Use `Provider` to pass state down the tree when it is needed frequently 1+ layer down.
- **Logic Separation:** Use controllers to separate UI from the logic that UI should react on (e.g., for page/step indicators).

## 4. Function & Parameter Standards
- **Named Parameters:** Always use named parameters when dealing with more than 1 parameter.
- **Function Limit:** Avoid more than 5 parameters in functions.
- **Widget Limit:** Avoid more than 7 parameters in custom widgets.
- **Grouping:** Prefer grouping related data into a class and passing the class instead of individual parameters when limits are exceeded.
