import 'package:physio_metric/features/authentication/data/auth_repository.dart';
import 'package:physio_metric/features/authentication/domain/app_user.dart';

class FakeAuthRepository implements AuthRepository {
  @override
  Future<String?> getCurrentUserId() async => 'user1';
  @override
  Future<AppUser?> getCurrentUser() async => const AppUser(
    id: 'user1',
    email: 'test@test.com',
    displayName: 'Test User',
  );

  @override
  bool isEmailVerified() => true;

  @override
  Future<void> reloadUser() async {}

  @override
  Future<void> sendEmailVerification() async {}

  @override
  Future<void> signOut() async {}

  @override
  Future<AppUser?> signInWithEmail(String email, String password) async {
    return Future.value(
      const AppUser(
        id: 'user1',
        email: 'test@test.com',
        displayName: 'Test User',
      ),
    );
  }

  @override
  Future<AppUser?> signInWithGoogle() {
    return Future.value(
      const AppUser(
        id: 'user1',
        email: 'test@test.com',
        displayName: 'Test User',
      ),
    );
  }
}
