import 'dart:math' as math;

import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:physio_metric/features/posture/domain/posture_deviation.dart';

/// PostureAnalyzer, farklı postürleri tespit eder.
class PostureAnalyzer {
  /// PostureAnalyzer'ı oluşturur.
  PostureAnalyzer();

  /// Kulak-omuz hattının yatayla yaptığı açıya bakarak boyun düzleşmesini tespit eder.
  ///
  /// [landmarks], kulak-omuz hattının yatayla yaptığı açıya bakarak boyun düzleşmesini tespit eder.
  ///
  /// [landmarks], kulak-omuz hattının yatayla yaptığı açıya bakarak boyun düzleşmesini tespit eder.
  /// Kulak-omuz hattının yatayla yaptığı açıya bakarak boyun düzleşmesini tespit eder.
  double calculateNeckAngle(List<PoseLandmark> landmarks) {
    final leftShoulder = landmarks.firstWhere(
      (l) => l.type == PoseLandmarkType.leftShoulder,
    );
    final leftEar = landmarks.firstWhere(
      (l) => l.type == PoseLandmarkType.leftEar,
    );

    // x ekseni farkını hesaplayıyoruz
    final dx = leftEar.x - leftShoulder.x;
    // y ekseni farkını hesaplayıyoruz
    final dy = leftEar.y - leftShoulder.y;
    // atan2 fonksiyonu ile açıyı hesaplayıyoruz
    final angle = math.atan2(dy, dx) * 180 / math.pi;
    // mutlak değer fonksiyonu ile açıyı pozitif yapıyoruz
    return angle.abs();
  }

  /// Omuz açısını hesaplar.
  double calculateShoulderAngle(List<PoseLandmark> landmarks) {
    final leftShoulder = landmarks.firstWhere(
      (l) => l.type == PoseLandmarkType.leftShoulder,
    );
    final rightShoulder = landmarks.firstWhere(
      (l) => l.type == PoseLandmarkType.rightShoulder,
    );
    final dx = rightShoulder.x - leftShoulder.x;
    final dy = rightShoulder.y - leftShoulder.y;
    final angle = math.atan2(dy, dx) * 180 / math.pi;
    return angle.abs();
  }

  /// Genel analiz fonksiyonu
  PostureDeviation analyze(List<PoseLandmark> landmarks) {
    final neckAngle = calculateNeckAngle(landmarks);
    final shoulderAngle = calculateShoulderAngle(landmarks);
    return PostureDeviation(
      neckAngle: neckAngle,
      shoulderAngle: shoulderAngle,
    );
  }
}
