import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:physio_metric/features/authentication/data/firebase_user_mapper.dart';
import 'package:physio_metric/features/authentication/domain/app_user.dart';

/// Kimlik doğrulama işlemleri için soyut repository.
abstract class AuthRepository {
  Future<AppUser?> signInWithEmail(String email, String password);
  Future<void> sendEmailVerification();
  bool isEmailVerified();
  Future<void> reloadUser();
  Future<AppUser?> signInWithGoogle();
  Future<void> signOut();
  Future<AppUser?> getCurrentUser();
  Future<String?> getCurrentUserId();
}

/// FirebaseAuth ile çalışan repository implementasyonu.
class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository(this._firebaseAuth, this._googleSignIn);
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  User? get _user => _firebaseAuth.currentUser;

  @override
  Future<AppUser?> signInWithEmail(String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user?.toAppUser();
  }

  @override
  Future<void> sendEmailVerification() async {
    if (_user != null && !_user!.emailVerified) {
      await _user!.sendEmailVerification();
    }
  }

  @override
  bool isEmailVerified() {
    return _user != null && _user!.emailVerified;
  }

  @override
  Future<void> reloadUser() async {
    await _user?.reload();
  }

  @override
  Future<AppUser?> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null;
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final userCredential = await _firebaseAuth.signInWithCredential(credential);
    return userCredential.user?.toAppUser();
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
  }

  @override
  Future<String?> getCurrentUserId() async => _user?.toAppUser().id;

  @override
  Future<AppUser?> getCurrentUser() async => _user?.toAppUser();

  /// Kullanıcıyı stream olarak döndürür.
  Stream<AppUser?> get userStream =>
      _firebaseAuth.authStateChanges().map((user) => user?.toAppUser());
}

final firebaseAuthProvider = Provider<FirebaseAuth>(
  (ref) => FirebaseAuth.instance,
);

final googleSignInProvider = Provider<GoogleSignIn>((ref) => GoogleSignIn());

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  final googleSignIn = ref.watch(googleSignInProvider);
  return FirebaseAuthRepository(firebaseAuth, googleSignIn);
});

/// Kullanıcıyı stream olarak sağlayan provider
final appUserStreamProvider = StreamProvider<AppUser?>((ref) {
  final repo = ref.watch(authRepositoryProvider) as FirebaseAuthRepository;
  return repo.userStream;
});
