import 'package:physio_metric/features/authentication/domain/app_user.dart';
import 'package:physio_metric/features/results/domain/posture_result.dart';
import 'package:physio_metric/features/results/domain/result_value_object_model.dart';

/// Sonuçların (Results) kalıcılık katmanıyla etkileşimi için arayüz (Port).
abstract interface class IResultRepository {
  /// Yeni bir postür sonucunu kaydeder.
  Future<void> createResult(PostureResult result);

  /// Belirli bir kimliğe sahip sonucu getirir.
  Future<PostureResult?> getResultById(ResultId id);

  /// Belirli bir kullanıcıya ait tüm sonuçları zaman sıralı olarak getirir.
  Stream<List<PostureResult>> watchResults(UserId userId);

  /// Mevcut bir sonucu günceller.
  Future<void> updateResult(PostureResult result);

  /// Bir sonucu siler.
  Future<void> deleteResult(ResultId id);
}
