import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostureScreen extends ConsumerWidget {
  const PostureScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Duruş Analizi'),
      ),
      body: const Center(
        child: Text('Duruş Analizi Ekranı - Yakında!'),
      ),
    );
  }
}
