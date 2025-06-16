import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:physio_metric/features/authentication/data/auth_repository.dart';
import 'package:physio_metric/features/authentication/presentation/login/auth_validators.dart';

class AuthController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> signInWithEmail(String email, String password) async {
    final userRepo = ref.read(authRepositoryProvider);
    if (!AuthValidators.isValidEmail(email)) {
      state = AsyncValue.error('Geçersiz e-posta', StackTrace.current);
      return;
    }
    if (!AuthValidators.isValidPassword(password)) {
      state = AsyncValue.error(
        'Şifre en az 8 karakter olmalı',
        StackTrace.current,
      );
      return;
    }

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await userRepo.signInWithEmail(email, password);

      if (!userRepo.isEmailVerified()) {
        await userRepo.sendEmailVerification();
        throw Exception(
          'E-posta adresinizi doğrulayın. Doğrulama e-postası gönderildi.',
        );
      }
    });
  }

  Future<void> signInWithGoogle() async {
    final userRepo = ref.read(authRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await userRepo.signInWithGoogle();
    });
  }

  Future<void> signOut() async {
    final userRepo = ref.read(authRepositoryProvider);
    state = const AsyncLoading();
    await userRepo.signOut();
  }
}

final authControllerProvider =
    AsyncNotifierProvider.autoDispose<AuthController, void>(AuthController.new);
