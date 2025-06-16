import 'package:equatable/equatable.dart';

/// [PostureDeviation], analiz sonuçlarını tutan value object.
class PostureDeviation extends Equatable {
  /// PostureDeviation'ı oluşturur.
  ///
  /// [neckAngle], boyun sapması.
  /// [shoulderAngle], omuz sapması.
  const PostureDeviation({
    required this.neckAngle,
    required this.shoulderAngle,
  });
  //boyun sapması
  final double neckAngle;
  //omuz sapması
  final double shoulderAngle;

  @override
  List<Object?> get props => [neckAngle, shoulderAngle];
}
