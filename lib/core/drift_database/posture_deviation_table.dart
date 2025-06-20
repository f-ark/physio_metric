import 'package:drift/drift.dart';

class PostureDeviations extends Table {
  IntColumn get id => integer().autoIncrement()();
  RealColumn get neckAngle => real()();
  RealColumn get shoulderAngle => real()();
}
