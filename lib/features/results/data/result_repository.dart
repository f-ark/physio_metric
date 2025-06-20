import 'package:physio_metric/features/analisis/domain/posture_deviation_value_object_model.dart';

abstract class ResultsRepository {
  Future<List<PostureDeviationValueObjectModel>> getResults();
}
