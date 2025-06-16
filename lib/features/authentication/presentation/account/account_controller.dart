import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:physio_metric/features/authentication/data/auth_repository.dart';

class AccountController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> sendEmailVerification() async {
    final userRepo = ref.read(authRepositoryProvider);
    state = const AsyncLoading();
    await userRepo.sendEmailVerification();
    state = const AsyncValue.data(null);
  }

  Future<void> reloadUser() async {
    final userRepo = ref.read(authRepositoryProvider);
    state = const AsyncLoading();
    await userRepo.reloadUser();
    state = const AsyncValue.data(null);
  }

  Future<void> signOut() async {
    final userRepo = ref.read(authRepositoryProvider);
    state = const AsyncLoading();
    await userRepo.signOut();
    state = const AsyncValue.data(null);
  }
}

final accountControllerProvider =
    AsyncNotifierProvider.autoDispose<AccountController, void>(
      AccountController.new,
    );
