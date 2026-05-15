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
      // setupTestDependencies handles the core DI. onSetup is only for extra test-specific tasks.
      await setupTestDependencies(
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
    - Testing Repository implementations (unless explicitly requested). These are low-value and high-maintenance due to external boundary mocking.
    - Redundant coverage of already tested logic.
- [ ] **Propose**: Present a **Technical Proposal** to the user justifying the test plan.

### 2. Dependency Injection & Global State
- [ ] **STRICT: No Mocks for Firebase**: Never use `MockFirestore`, `MockFirebaseAuth`, or `mocktail` to stub Firebase interactions.
- [ ] **STRICT: Use App Layer Fakes**: Always use `AppDatabase` and `AppAuth` abstractions. In tests, the `Environment.test` configuration will automatically provide `FakeAppDatabase` and `FakeAppAuth`.
- [ ] **STRICT: Data-Driven Testing**: Instead of `when(() => ...).thenReturn(...)`, interact with the `FakeAppDatabase` directly to seed data (e.g., `sl<AppDatabase>().setDocument('users/123', {...})`).
- [ ] **STRICT: Reactive Verification**: When testing UI or Providers, use the reactive nature of `FakeAppDatabase` and `FakeAppAuth` to verify that state updates automatically in response to data changes.
- [ ] **STRICT: No `sl` definitions**: Never write `final sl = GetIt.instance` or `GetIt.I`. Use the global `sl` directly.
- [ ] **STRICT: Dependency Origin**: All dependencies must come from `TestDependency`. 
    - If a getter is missing in `TestDependency`, your first task is to add it there.
- [ ] **STRICT: No Ad-hoc Mocks**: Do not register mocks/providers inside `onSetup` unless it is a unique, one-off requirement for that specific test case. Use the real implementations registered in `setupGetIt`.
- [ ] **STRICT: Use TFactory Data**: Avoid hardcoding IDs, names, or any data strings (e.g., `tUserId = 'user_1'`). Always use values directly from the appropriate `TFactory` (e.g., `tUserId = UserTFactory.staffUsers.first.id`). Hardcoded values are ONLY permitted when testing a specific edge case or "invalid" state.
- [ ] **STRICT: Descriptive Naming**: Test descriptions must be meaningful and follow the pattern: `should [expected behavior] when [scenario/state]`. 
- [ ] **STRICT: Resilience Testing**: When testing failure fallbacks (Cache-First logic), use the naming suffix `{TEST_NAME}_resilience_test.dart` to separate failure cases from happy-path logic.
- [ ] **STRICT: Layer-Specific Focus**:
    - **Providers/BLoCs**: Focus on state transitions, action guards, and reactive data reloads.
    - **Core/Utilities**: Focus on exhaustive validation of real concrete implementations.
    - **UI**: Prioritize Golden tests for high-fidelity verification.
- [ ] **STRICT: Silent Logging**: Mandates silencing any global logging utilities in `setupTestDependencies`.
- [ ] **STRICT: setupTestDependencies**: Use the standardized setup that initializes the test environment.

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
