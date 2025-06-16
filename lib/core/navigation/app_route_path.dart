import 'package:physio_metric/core/navigation/app_route_enum.dart';

/// Uygulama içi route bilgisini temsil eden model.
class AppRoutePath {
  /// Bilinmeyen route oluşturur.
  const AppRoutePath.unknown() : this._(AppRoute.unknown);

  /// Not düzenleme route'u oluşturur.
  const AppRoutePath.noteEdit({String? noteId})
    : this._(AppRoute.noteEdit, noteId: noteId);

  /// Notlar listesi route'u oluşturur.
  const AppRoutePath.notesList() : this._(AppRoute.notesList);

  /// Özel constructor.
  const AppRoutePath._(this.route, {this.noteId});

  /// Route türü.
  final AppRoute route;

  /// Not kimliği (varsa).
  final String? noteId;

  /// Route notlar listesi mi?
  bool get isNotesList => route == AppRoute.notesList;

  /// Route not düzenleme mi?
  bool get isNoteEdit => route == AppRoute.noteEdit;

  /// Route bilinmeyen mi?
  bool get isUnknown => route == AppRoute.unknown;
}
