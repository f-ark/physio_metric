import 'package:equatable/equatable.dart';

/// [PostureDeviationValueObjectModel], analiz sonuçlarını tutan value object.
final class PostureDeviationValueObjectModel extends Equatable {
  /// [neckAngle], boyun sapması.
  /// [shoulderAngle], omuz sapması.
  const PostureDeviationValueObjectModel({
    required this.neckAngle,
    required this.shoulderAngle,
  });
  final double neckAngle;
  final double shoulderAngle;

  @override
  List<Object?> get props => [neckAngle, shoulderAngle];
}
