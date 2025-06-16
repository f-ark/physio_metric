import 'package:firebase_auth/firebase_auth.dart';
import 'package:physio_metric/features/authentication/domain/app_user.dart';

extension FirebaseUserMapper on User {
  AppUser toAppUser() {
    return AppUser(id: uid, email: email, displayName: displayName);
  }
}
