import 'package:physio_metric/features/posture/domain/posture_deviation.dart';

/// PostureDiagnosis, farklı postürleri tespit eder.
class PostureDiagnosis {
  PostureDiagnosis(this.deviation);
  final PostureDeviation deviation;

 String neckStraighteningDiagnosis() {
    if (deviation.neckAngle < 10) {
      return 'Boyun düzleşmesi tespit edildi!';
    }
    return 'Boyun açısı normal.';
  }

  String forwardHeadDiagnosis() {
    if (deviation.neckAngle > 30) {
      return 'Baş önde duruş tespit edildi!';
    }
    return 'Baş pozisyonu normal.';
  }

}
