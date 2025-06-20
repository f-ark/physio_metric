import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

/// Tip güvenliği sağlamak için PostureResult'ın kimliğini temsil eden Value Object.
/// Dart 3'ün `extension type` özelliği, mevcut bir tip (String) üzerine yeni bir
/// isimle bir "sıfır maliyetli soyutlama" oluşturmamızı sağlar. Bu sayede `ResultId`
/// ve `String` çalışma zamanında aynıdır, ancak derleme zamanında farklı tiplerdir.
extension type ResultId(String id) {}

/// Analiz sonucunun temel, değişmez detaylarını bir araya getiren Value Object.
@immutable
class PostureAnalysisDetails extends Equatable {
  const PostureAnalysisDetails({
    required this.analysisDate,
    required this.imageReferences,
    this.overallScore,
  });

  /// Analizin yapıldığı tarih.
  final DateTime analysisDate;

  /// Analizde kullanılan görsellerin referansları (örn: Firebase Storage yolları).
  final List<String> imageReferences;

  /// İsteğe bağlı genel bir skor.
  final double? overallScore;

  @override
  List<Object?> get props => [analysisDate, imageReferences, overallScore];
}

/// [ResultValueObjectModel], analiz sonuçlarını tutan value object.
final class ResultValueObjectModel extends Equatable {
  /// [date], analiz tarihi.
  /// [score], analiz sonucu.
  const ResultValueObjectModel({
    required this.date,
    required this.score,
  });
  final DateTime date;
  final double score;

  bool get isScoreNormal => score < 10;

  @override
  List<Object?> get props => [date, score];
}
