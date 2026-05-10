import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

/// [Test Architect Example]
///
/// Demonstrates:
/// 1. TFactory usage for Personas.
/// 2. GetIt setup for Real Repositories.
/// 3. Narrative-style testing.

void main() {
  group('User Profile Integration', () {
    late UserRepository repo;
    late AccessService accessService;

    setUp(() async {
      // Setup real local dependencies and mock remote ones
      await setupDependencies(
        onSetup: () async {
          repo = TestDependency.userRepo();
          accessService = TestDependency.accessService();
        },
      );
    });

    tearDown(() async {
      await tearDownDependencies();
    });

    test('should update profile and persist locally using real repository', () async {
      // 1. Arrange: Start with a 'guest' persona
      final initialUser = UserTFactory.guest;
      final updatedName = 'New Name';
      
      // 2. Act: Use the real logic
      await repo.updateName(initialUser.id, updatedName);

      // 3. Assert: Verify the real local datasource was updated
      final result = await repo.getUser(initialUser.id);
      
      expect(result.name, updatedName);
      expect(result.isVerified, false); // Still a guest
    });

    test('admin user should have full access permissions', () async {
      // Use the 'admin' persona directly
      final admin = UserTFactory.admin;
      
      final canDelete = accessService.canPerform(admin, 'delete_post');
      
      expect(canDelete, isTrue);
    });
  });
}

// --- Mocks & Infrastructure Placeholders ---
final sl = GetIt.instance;

class TestDependency {
  static UserRepository userRepo() => sl<UserRepository>();
  static AccessService accessService() => sl<AccessService>();
}

Future<void> setupDependencies({
  Map<String, Object> cache = const {},
  Future<void> Function()? onSetup,
}) async {
  await sl.reset();
  if (onSetup != null) await onSetup();
}

Future<void> tearDownDependencies() async {
  await sl.reset();
}

class UserTFactory {
  static User get guest => User(id: '1', name: 'Guest', isVerified: false);
  static User get admin => User(id: '99', name: 'Admin', isVerified: true);
}

class User {
  final String id;
  final String name;
  final bool isVerified;
  User({required this.id, required this.name, required this.isVerified});
}

abstract class UserRepository {
  Future<void> updateName(String id, String name);
  Future<User> getUser(String id);
}

class AccessService {
  bool canPerform(User user, String action) => user.isVerified;
}
