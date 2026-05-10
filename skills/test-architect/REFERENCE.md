# Test Architect Reference

Detailed blueprints for high-fidelity testing infrastructure.

## 1. TFactory Pattern

All test data should be centralized in `test/shared/factories/` to avoid duplication and ensure semantic clarity.

### Class Structure
- **Suffix**: Always use `TFactory` (e.g., `UserTFactory`).
- **Personas**: Use static getters for common states (e.g., `active`, `guest`, `admin`).
- **The .build() Method**: Use this for complex overrides.

```dart
class UserTFactory {
  static User _base() => const User(id: '1', name: 'Standard');

  static User get active => _base().copyWith(isVerified: true);
  static User get guest => _base().copyWith(isVerified: false);

  static User build({User? base, String? name}) {
    final start = base ?? _base();
    return start.copyWith(name: name ?? start.name);
  }
}
```

## 2. Dependency Injection (TestDependency)

We use a combination of `GetIt` for global registration and a `TestDependency` helper for explicit wiring.

### Strategy
1.  **Environment Mocks**: Remote services (Firebase, API) must be mocked using `@Injectable(env: [Environment.test])`.
2.  **Explicit Wiring**: The `TestDependency` class manually assembles Repositories/Providers to ensure the "Real" local data sources are injected.
3.  **Flexibility**: In projects without a "Use Case" layer, wire Repositories directly into State Management (Providers/BLoCs).

### `test/helpers/test_utils.dart`
```dart
class TestDependency {
  static SharedPreferences sharedPreferences() => sl<SharedPreferences>();
  
  // Explicitly build the repository with real local storage
  static UserRepositoryImpl userRepo() => UserRepositoryImpl(
    localDataSource: RealLocalDS(sharedPreferences()),
    remoteDataSource: sl<FirestoreService>(), // This is mocked via GetIt
  );

  static UserProvider userProvider() => UserProvider(userRepo());
}

Future<void> setupDependencies({
  Map<String, Object> cache = const {},
  FutureOr<void> Function()? onSetup,
}) async {
  SharedPreferences.setMockInitialValues(cache);
  await setupGetIt(env: Environment.test);
  sl.skipDoubleRegistration = true;
  if (onSetup != null) await onSetup();
}

Future<void> tearDownDependencies() async {
  await sl.reset();
}
```

## 3. The "Why" Analysis

Before writing a test, the agent must ask:
1.  **What risk are we mitigating?** (Regression, logic complexity, edge case).
2.  **Is this already covered?** (e.g. by an integration test or a parent widget test).
3.  **Is this testable with the "Real thing"?** If not, the code might need refactoring first.

## 4. Integration with Golden Eye

When testing Widgets:
1.  Verify the logic with `test-architect`.
2.  Immediately invoke `golden-eye` to verify the visual state.
3.  Ensure the `TFactory` personas used in logic tests are the same ones used in Golden scenarios to maintain consistency.
