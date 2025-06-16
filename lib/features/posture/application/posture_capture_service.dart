import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

import 'package:physio_metric/features/posture/data/photo_repository.dart';
import 'package:physio_metric/features/posture/data/pose_repository.dart';
import 'package:physio_metric/features/posture/domain/posture_analyzer.dart';
import 'package:physio_metric/features/posture/domain/posture_deviation.dart';

class PostureCaptureService {
  PostureCaptureService({
    required this.photoRepository,
    required this.poseRepository,
    required this.postureAnalyzer,
  });

  final PhotoRepository photoRepository;
  final PoseRepository poseRepository;
  final PostureAnalyzer postureAnalyzer;

  /// Kamera stream'inden ideal kare gelene kadar dinler, uygun karede PostureDeviation döndürür.
  Future<PostureDeviation?> captureAndDetectPose(
    Stream<InputImage> cameraStream,
  ) async {
    await for (final image in cameraStream) {
      final landmarks = await poseRepository.analyzePose(image);
      if (_isLandmarksValidForDiagnosis(landmarks)) {
        final deviation = postureAnalyzer.analyze(landmarks);
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
  final photoRepository = ref.watch(photoRepositoryProvider);
  final poseRepository = ref.watch(poseRepositoryProvider);
  final postureAnalyzer = PostureAnalyzer();
  return PostureCaptureService(
    photoRepository: photoRepository,
    poseRepository: poseRepository,
    postureAnalyzer: postureAnalyzer,
  );
});
