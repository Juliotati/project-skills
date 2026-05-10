---
name: bug-hunter
description: Detect, document, and delegate bugs. Evaluates whether a bug requires a reproduction test via test-architect or can be fixed immediately. Use when a bug is reported, detected, or during code audits.
---

# Bug Hunter

The guardian of code quality. Detects issues, documents root causes, and ensures bugs never return.

## Quick start

```md
**Bug Detected**: User can submit form with negative numbers.
**Root Cause**: Missing validation in `amount_input.dart`.
**Classification**: Logical / High Risk.
**Action**: Delegate to `test-architect` to create a reproduction test before fixing.
```

## Workflows

### 1. Detection & Analysis
- [ ] **Spot the Bug**: Identify logical errors, edge cases, or reported issues.
- [ ] **Document**:
    - **Description**: What is happening vs. what should happen.
    - **Root Cause**: Why is it happening (file/line number).
    - **Impact**: How it affects the user/system.

### 2. Classification & Delegation
- [ ] **Evaluate Test Necessity**:
    - **Needs Test**: Logical bugs, edge cases, state management issues, or anything likely to regress. **Delegate to [test-architect](../test-architect/SKILL.md).**
    - **Fix & Move On**: Typos, UI styling tweaks (unless visual regression needed), trivial syntax, or obvious 1-line fixes with zero side effects.
- [ ] **Reproduction**: If a test is needed, the reproduction test must fail **before** the fix is applied.

### 3. Resolution
- [ ] **Fix**: Apply the code change.
- [ ] **Verify**: Ensure the test (if created) now passes.

## Advanced features

See [REFERENCE.md](REFERENCE.md) for Bug Report templates and Risk Assessment criteria.
