import 'package:flutter/foundation.dart';

/// Tip güvenliği sağlamak için AppUser kimliğini temsil eden Value Object.
extension type UserId(String id) {}

/// Uygulama genelinde kullanılacak kullanıcı modelidir.
@immutable
class AppUser {
  const AppUser({required this.id, this.email, this.displayName});

  /// JSON'dan model oluşturur.
  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
    id: json['id'] as String,
    email: json['email'] as String?,
    displayName: json['displayName'] as String?,
  );

  /// Kullanıcının benzersiz kimliği (Firebase UID).
  final String id;

  /// Kullanıcının e-posta adresi.
  final String? email;

  /// Kullanıcının görünen adı (displayName).
  final String? displayName;

  /// Modeli JSON'a çevirir.
  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'displayName': displayName,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppUser &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email &&
          displayName == other.displayName;

  @override
  int get hashCode => id.hashCode ^ email.hashCode ^ displayName.hashCode;
}
