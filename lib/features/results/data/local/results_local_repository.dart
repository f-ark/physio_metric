import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:physio_metric/core/drift_database/app_database.dart';
import 'package:physio_metric/core/drift_database/database_provider.dart';
import 'package:physio_metric/features/analisis/domain/posture_deviation_value_object_model.dart';
import 'package:physio_metric/features/results/data/result_repository.dart';

class ResultsLocalRepository implements ResultsRepository {
  ResultsLocalRepository(this.db);
  final AppDatabase db;

  @override
  Future<List<PostureDeviationValueObjectModel>> getResults() async {
    final rows = await db.select(db.postureDeviations).get();
    return rows
        .map(
          (row) => PostureDeviationValueObjectModel(
            neckAngle: row.neckAngle,
            shoulderAngle: row.shoulderAngle,
          ),
        )
        .toList();
  }
}

final resultsLocalRepositoryProvider = Provider<ResultsLocalRepository>((ref) {
  // AppDatabase provider'ı yoksa burada doğrudan oluşturulabilir veya ayrı provider ile alınabilir.
  final db = ref.read(databaseProvider);
  return ResultsLocalRepository(db);
});
