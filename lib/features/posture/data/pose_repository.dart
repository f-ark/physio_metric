import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

class PoseRepository {
  PoseRepository({required PoseDetector poseDetector})
    : _poseDetector = poseDetector;
  final PoseDetector _poseDetector;

  /// Fotoğraftan eklem noktalarını tespit eder.
  Future<List<PoseLandmark>> detectPose(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final poses = await _poseDetector.processImage(inputImage);
    await _poseDetector.close();
    return poses.isNotEmpty ? poses.first.landmarks.values.toList() : [];
  }

  /// Fotoğraftan eklem noktalarını tespit eder.
  Future<List<PoseLandmark>> analyzePose(InputImage image) async {
    final poses = await _poseDetector.processImage(image);
    return poses.isNotEmpty ? poses.first.landmarks.values.toList() : [];
  }
}

final poseRepositoryProvider = Provider<PoseRepository>((ref) {
  final options = PoseDetectorOptions(
    model: PoseDetectionModel.accurate,
  );

  final poseDetector = PoseDetector(options: options);

  return PoseRepository(
    poseDetector: poseDetector,
  );
});
