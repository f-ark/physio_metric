import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:physio_metric/features/analisis/domain/posture_deviation_value_object_model.dart';
import 'package:physio_metric/features/authentication/domain/app_user.dart';
import 'package:physio_metric/features/results/domain/result_value_object_model.dart';

/// Raporun genel ciddiyet seviyesini modelleyen sealed class.
/// Bu, `switch` ifadelerinde tüm olasılıkların ele alınmasını zorunlu kılar,
/// böylece kod daha güvenli hale gelir.
sealed class Severity extends Equatable {
  const Severity();
}

class LowSeverity extends Severity {
  const LowSeverity();
  @override
  List<Object> get props => [];
}

class MediumSeverity extends Severity {
  const MediumSeverity();
  @override
  List<Object> get props => [];
}

class HighSeverity extends Severity {
  const HighSeverity();
  @override
  List<Object> get props => [];
}

/// Bir postür analizi sonucunu temsil eden ana domain varlığı (Entity).
/// Bu, aynı zamanda Aggregate Root'tur.
@immutable
class PostureResult extends Equatable {
  const PostureResult({
    required this.id,
    required this.userId,
    required this.details,
    required this.deviations,
    required this.severity,
    this.notes,
  });

  /// Sonucun benzersiz kimliği.
  final ResultId id;

  /// Bu sonucun ait olduğu kullanıcının kimliği.
  final UserId userId;

  /// Analizin tarih, skor gibi temel bilgileri.
  final PostureAnalysisDetails details;

  /// Analizde tespit edilen postür sapmalarının listesi.
  final List<PostureDeviationValueObjectModel> deviations;

  /// Raporun genel ciddiyet seviyesi.
  final Severity severity;

  /// İsteğe bağlı hekim veya kullanıcı notları.
  final String? notes;

  @override
  List<Object?> get props => [id, userId, details, deviations, severity, notes];
}
