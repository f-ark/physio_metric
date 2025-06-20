import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:physio_metric/core/navigation/app_router_delegate.dart';
import 'package:physio_metric/features/authentication/data/auth_repository.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(appUserStreamProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ana Sayfa'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              ref.read(appRouteNotifierProvider.notifier).goToAccount();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Hoş geldin, ${user.value?.email ?? 'Kullanıcı'}!'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Posture Analiz ekranına git
                // Bu özellik implemente edildikten sonra yönlendirme eklenmeli
              },
              child: const Text('Duruş Analizi Başlat'),
            ),
          ],
        ),
      ),
    );
  }
}
