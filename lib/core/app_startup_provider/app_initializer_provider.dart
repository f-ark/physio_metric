import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:physio_metric/core/drift_database/database_provider.dart';
import 'package:physio_metric/firebase_options.dart';

/// Uygulama başlatılırken gerekli asenkron işlemleri başlatan provider.
final appInitializerProvider = FutureProvider<void>((ref) async {
  // Firebase'i başlat
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Veritabanını başlatmak için `databaseProvider`'ı burada `watch` ediyoruz.
  // Bu, veritabanının uygulama başlamadan önce hazır olmasını sağlar.
  ref.read(databaseProvider);

  // SharedPreferences'ı başlat

  // Gerekirse başka bağımlılıklar da eklenebilir
});
