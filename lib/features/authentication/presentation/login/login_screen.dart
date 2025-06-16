import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:physio_metric/core/constants/app_spacing.dart';
import 'package:physio_metric/features/authentication/presentation/login/auth_controller.dart';
import 'package:physio_metric/features/authentication/presentation/login/widgets/login_form.dart';

class LoginAndSignInScreen extends ConsumerWidget {
  const LoginAndSignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Giriş Yap')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.responsivePadding(context)),
          child: authState.when(
            data: (_) => const LoginForm(),
            loading: () => const CircularProgressIndicator(),
            error: (error, stack) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  error.toString(),
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: AppSpacing.md),
                const LoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
