import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:physio_metric/features/authentication/presentation/account/account_controller.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(accountControllerProvider);
    final controller = ref.read(accountControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Hesabım')),
      body: Center(
        child: state.when(
          loading: () => const CircularProgressIndicator(),
          error: (e, _) => Text('Hata: $e'),
          data: (_) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: controller.sendEmailVerification,
                child: const Text('Doğrulama E-postası Gönder'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: controller.reloadUser,
                child: const Text('Kullanıcıyı Yenile'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: controller.signOut,
                child: const Text('Çıkış Yap'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
