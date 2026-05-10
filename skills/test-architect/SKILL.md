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
      await setupDependencies(
        onSetup: () async {
          provider = TestDependency.userProvider();
        },
      ); 
    });

    tearDown(() async {
      await tearDownDependencies();
    });

    test('should update state with user from real local storage', () async {
      // 1. Use TFactory for semantic test data
      final mockUser = UserTFactory.active;
      
      // 2. Act
      await provider.fetchUser();
      
      // 3. Assert
      expect(provider.state.user, mockUser);
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

### 2. Dependency Injection (TestDependency)
- [ ] **Setup/Teardown**: Ensure `test/helpers/test_utils.dart` exists with `setupDependencies()` and `tearDownDependencies()`.
- [ ] **Infrastructure**: Use the **TestDependency** utility class to retrieve or manually wire components.
    - Wire **real** local data sources into repositories.
    - Provide **mocks** for remote boundaries (Firebase/Analytics) using `@Injectable(env: [test])`.
- [ ] **Flexibility**: If the project lacks a Use Case layer, wire Repositories directly into Providers.

### 3. Implementation & UI
- [ ] **Realism**: Use real Repositories and BLoCs where possible.
- [ ] **Golden-eye**: If the feature has UI, automatically trigger the [golden-eye](../golden-eye/SKILL.md) skill workflow.

### 4. Failure Protocol
- [ ] **Report**: If a test fails, analyze if the bug is in the test or a real dependency.
- [ ] **Fix**: Propose a plan to fix the underlying code if the test discovered a real bug.

## Advanced features

See [REFERENCE.md](REFERENCE.md) for detailed TFactory patterns and GetIt test configurations.
See [examples/integration_test_example.dart](examples/integration_test_example.dart) for a full setup.
