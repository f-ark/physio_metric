import 'package:drift/drift.dart' as drift;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:physio_metric/core/drift_database/app_database.dart';
import 'package:physio_metric/core/drift_database/database_provider.dart';
import 'package:physio_metric/features/analisis/data/analisis_repository.dart';
import 'package:physio_metric/features/analisis/domain/posture_deviation_value_object_model.dart';

class AnalisisLocalRepository implements AnalisisRepository {
  AnalisisLocalRepository(this.db);
  final AppDatabase db;

  @override
  Future<void> saveDeviation(PostureDeviationValueObjectModel deviation) async {
    await db
        .into(db.postureDeviations)
        .insert(
          PostureDeviationsCompanion(
            neckAngle: drift.Value(deviation.neckAngle),
            shoulderAngle: drift.Value(deviation.shoulderAngle),
          ),
        );
  }
}

final postureDeviationLocalRepositoryProvider = Provider<AnalisisLocalRepository>((
  ref,
) {
  final db = ref.read(databaseProvider);
  // AppDatabase provider'ı yoksa burada doğrudan oluşturulabilir veya ayrı provider ile alınabilir.
  return AnalisisLocalRepository(db);
});
