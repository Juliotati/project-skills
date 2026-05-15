---
name: test-architect
description: Write and architect high-fidelity tests using real dependencies, TFactory infrastructure, and 'Why-first' analysis. Use when planning, writing, or auditing Flutter tests.
---

# Test Architect

Standardizes high-fidelity testing with minimal mocks and robust test data infrastructure.

## Quick start

```dart
// test/feature/presentation/providers/user_provider_test.dart
void main() {
  group('UserProvider', () {
    late UserProvider provider;

    setUp(() async {
      // setupDependencies handles the core DI. onSetup is only for extra test-specific tasks.
      await setupDependencies(
        onSetup: () async {
          // 1. Always get dependencies from TestDependency
          provider = TestDependency.userProvider();
          
          // 2. Pre-load data if needed
          await provider.fetchUser();
        },
      ); 
    });

    tearDown(() async {
      await tearDownDependencies();
    });

    test('should update state with user from real local storage', () async {
      expect(provider.state.user, isNotNull);
    });
  });
}
```

## Workflows

### 1. The "Why" Gatekeeper (Analysis)
- [ ] **Analyze**: Before writing code, evaluate if the test is necessary. Avoid:
    - Testing auto-generated code/getters.
    - Testing Flutter core widgets.
    - Redundant coverage of already tested logic.
- [ ] **Propose**: Present a **Technical Proposal** to the user justifying the test plan.

### 2. Dependency Injection & Global State
- [ ] **STRICT: No `sl` definitions**: Never write `final sl = GetIt.instance` or `GetIt.I`. Use the global `sl` directly.
- [ ] **STRICT: Dependency Origin**: All dependencies must come from `TestDependency`. 
    - If a getter is missing in `TestDependency`, your first task is to add it there.
- [ ] **STRICT: No Ad-hoc Mocks**: Do not register mocks/providers inside `onSetup` unless it is a unique, one-off requirement for that specific test case. Use the real implementations registered in `setupGetIt`.
- [ ] **STRICT: setupDependencies**: Use the exact implementation provided in [REFERENCE.md](REFERENCE.md).

### 3. Implementation & Audit
- [ ] **Audit Step**: Before finishing, read the generated test and ensure:
    - [ ] No `GetIt.instance` or `sl` assignments.
    - [ ] No `onSetup` used for core DI registration.
    - [ ] No `MockRepository` created for components that should be "Real".

### 4. Failure Protocol
- [ ] **Report**: If a test fails, analyze if the bug is in the test or a real dependency.
- [ ] **Fix**: Propose a plan to fix the underlying code if the test discovered a real bug.

## Advanced features

See [REFERENCE.md](REFERENCE.md) for detailed TFactory patterns and GetIt test configurations.
See [examples/integration_test_example.dart](examples/integration_test_example.dart) for a full setup.
