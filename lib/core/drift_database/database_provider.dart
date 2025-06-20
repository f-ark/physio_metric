import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:physio_metric/core/drift_database/app_database.dart';

/// AppDatabase örneğini uygulama genelinde sağlayan provider.
///
/// Bu provider, Riverpod'un dahili state yönetimi sayesinde AppDatabase'in
/// uygulama yaşam döngüsü boyunca tek bir örnek (Singleton) olarak kalmasını sağlar.
///
/// [ref.onDispose] kullanarak, bu provider artık kullanılmadığında veritabanı
/// bağlantısının otomatik olarak kapatılmasını sağlıyoruz. Bu, kaynak sızıntılarını
/// önleyen önemli bir adımdır.
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();

  // Provider yok edildiğinde (dispose) veritabanı bağlantısını kapat.
  ref.onDispose(() => db.close());

  return db;
});
