import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:physio_metric/core/firebase/firebase_providers.dart';
import 'package:physio_metric/features/analisis/domain/posture_deviation_value_object_model.dart';
import 'package:physio_metric/features/results/data/result_repository.dart';

// to-do şimdilik firestore kullanılmayacak, ek özellikler eklendiğinde kullanılması olanlanıyor.

class ResultsRemoteRepository implements ResultsRepository {
  ResultsRemoteRepository({required this.firestore}) {
    firestore.settings = const Settings(persistenceEnabled: true);
  }

  static const String collectionName = 'posture_deviations';
  final FirebaseFirestore firestore;

  CollectionReference get ref => firestore.collection(collectionName);

  @override
  Future<List<PostureDeviationValueObjectModel>> getResults() async {
    final snapshot = await ref.get();
    return snapshot.docs
        .map(
          (doc) => fromFirestore(doc.data() as Map<String, dynamic>),
        )
        .toList();
  }

  /// Firestore'dan alınan Map'ten modele dönüştürür
  static PostureDeviationValueObjectModel fromFirestore(
    Map<String, dynamic> map,
  ) {
    if (map case {
      'neckAngle': final num neck,
      'shoulderAngle': final num shoulder,
    }) {
      return PostureDeviationValueObjectModel(
        neckAngle: neck.toDouble(),
        shoulderAngle: shoulder.toDouble(),
      );
    }
    return const PostureDeviationValueObjectModel(
      neckAngle: 0.0,
      shoulderAngle: 0.0,
    );
  }
}

final resultsRemoteRepositoryProvider = Provider<ResultsRepository>(
  (ref) {
    final firestore = ref.read(firestoreProvider);
    return ResultsRemoteRepository(firestore: firestore);
  },
);
