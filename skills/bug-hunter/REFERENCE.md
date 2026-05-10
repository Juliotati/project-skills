# Bug Hunter Reference

Guidelines for effective bug classification and resolution.

## 1. Risk Assessment Criteria

Use these rules to decide if a bug needs a reproduction test from `test-architect`.

| Bug Type | Action | Rationale |
| :--- | :--- | :--- |
| **Logical / Math** | **Test Required** | High risk of regression; logic is invisible. |
| **State Management** | **Test Required** | State bugs are hard to debug without isolation. |
| **Edge Case** | **Test Required** | Ensures the "one-in-a-million" case is handled forever. |
| **Integration / DI** | **Test Required** | Validates the "Real-Thing" wiring. |
| **UI Styling** | **Fix & Move On** | Use [golden-eye](../golden-eye/SKILL.md) instead if visual consistency is vital. |
| **Typo / Syntax** | **Fix & Move On** | Low risk, high speed. |

## 2. Bug Report Template

When documenting a bug, follow this structure to provide clarity for the fix:

```md
### [BUG] Short Descriptive Title

- **Environment**: (Dev/Prod/Test)
- **Observed Behavior**: Detailed description of the error.
- **Expected Behavior**: What should have happened.
- **Reproduction Steps**: How to trigger the bug.
- **Proposed Action**: (Fix immediately / Delegate to test-architect)
```

## 3. Delegation Workflow

When delegating to **test-architect**:
1.  Provide the `Bug Report`.
2.  Specify the `TFactory` persona that should be used for reproduction.
3.  Instruct `test-architect` to follow the **"Red-Green"** cycle:
    - Create test -> Run (Fail) -> Apply Fix -> Run (Pass).
