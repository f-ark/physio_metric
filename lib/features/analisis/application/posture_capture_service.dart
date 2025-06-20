import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:physio_metric/features/analisis/data/local/analisis_local_repository.dart';
import 'package:physio_metric/features/analisis/data/photo_repository.dart';
import 'package:physio_metric/features/analisis/data/pose_repository.dart';
import 'package:physio_metric/features/analisis/domain/posture_analyzer.dart';
import 'package:physio_metric/features/analisis/domain/posture_deviation_value_object_model.dart';

class PostureCaptureService {
  PostureCaptureService({
    required this.photoRepository,
    required this.poseRepository,
    required this.postureAnalyzer,
    required this.localRepository,
  });

  final PhotoRepository photoRepository;
  final PoseRepository poseRepository;
  final PostureAnalyzer postureAnalyzer;
  final AnalisisLocalRepository localRepository;

  /// Kamera stream'inden ideal kare gelene kadar dinler, uygun karede PostureDeviation döndürür ve local db'ye kaydeder.
  Future<PostureDeviationValueObjectModel?> captureAndDetectPose(
    Stream<InputImage> cameraStream,
  ) async {
    await for (final image in cameraStream) {
      final landmarks = await poseRepository.analyzePose(image);
      if (_isLandmarksValidForDiagnosis(landmarks)) {
        final deviation = postureAnalyzer.analyze(landmarks);
        await localRepository.saveDeviation(deviation);
        return deviation;
      }
      // Uygun kare gelene kadar dinlemeye devam et
    }
    return null; // Stream biterse
  }

  /// Gerekli eklem noktaları var mı ve poz uygun mu?
  bool _isLandmarksValidForDiagnosis(List<PoseLandmark> landmarks) {
    final requiredTypes = [
      PoseLandmarkType.leftShoulder,
      PoseLandmarkType.leftEar,
      // Gerekirse diğer noktalar eklenebilir
    ];
    return requiredTypes.every((type) => landmarks.any((l) => l.type == type));
  }
}

final postureCaptureServiceProvider = Provider<PostureCaptureService>((ref) {
  final photoRepository = ref.read(photoRepositoryProvider);
  final poseRepository = ref.read(poseRepositoryProvider);
  final postureAnalyzer = PostureAnalyzer();
  final localRepository = ref.read(postureDeviationLocalRepositoryProvider);
  return PostureCaptureService(
    photoRepository: photoRepository,
    poseRepository: poseRepository,
    postureAnalyzer: postureAnalyzer,
    localRepository: localRepository,
  );
});
