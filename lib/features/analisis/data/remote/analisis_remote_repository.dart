import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:physio_metric/core/firebase/firebase_providers.dart';
import 'package:physio_metric/features/analisis/data/analisis_repository.dart';
import 'package:physio_metric/features/analisis/domain/posture_deviation_value_object_model.dart';

// to-do şimdilik firestore kullanılmayacak, ek özellikler eklendiğinde kullanılması olanlanıyor.

class AnalisisRemoteRepository implements AnalisisRepository {
  AnalisisRemoteRepository({required this.firestore}) {
    firestore.settings = const Settings(persistenceEnabled: true);
  }

  static const String collectionName = 'posture_deviations';
  final FirebaseFirestore firestore;

  CollectionReference get ref => firestore.collection(collectionName);

  @override
  Future<void> saveDeviation(
    PostureDeviationValueObjectModel deviation, [
    String? userId,
  ]) async {
    final data = toFirestore(deviation);
    if (userId != null) {
      data['userId'] = userId;
    }
    data['timestamp'] = FieldValue.serverTimestamp();
    await ref.add(data);
  }

  Map<String, dynamic> toFirestore(
    PostureDeviationValueObjectModel deviation,
  ) => {
    'neckAngle': deviation.neckAngle,
    'shoulderAngle': deviation.shoulderAngle,
  };
}

final analisisRemoteRepositoryProvider = Provider<AnalisisRepository>(
  (ref) {
    final firestore = ref.read(firestoreProvider);
    return AnalisisRemoteRepository(firestore: firestore);
  },
);
