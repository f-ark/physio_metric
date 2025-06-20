import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Firebase Authentication örneğini sağlayan provider.
final firebaseAuthProvider = Provider<FirebaseAuth>(
  (ref) => FirebaseAuth.instance,
);

/// Firebase Firestore örneğini sağlayan provider.
final firestoreProvider = Provider<FirebaseFirestore>(
  (ref) => FirebaseFirestore.instance,
);

/// Google Sign-In örneğini sağlayan provider.
final googleSignInProvider = Provider<GoogleSignIn>((ref) => GoogleSignIn());

// Gelecekte Firebase Storage gibi başka servisler eklenirse,
// provider'ları buraya eklenebilir.
// final firebaseStorageProvider = Provider((ref) => FirebaseStorage.instance);
