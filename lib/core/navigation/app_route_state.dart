import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Uygulamanın yönlendirme durumunu temsil eden sealed base sınıf.
sealed class AppRouteState {}

/// Notlar listesini temsil eden route durumu.
class NotesListRoute extends AppRouteState {}

/// Not düzenleme ekranını temsil eden route durumu.
class NoteEditRoute extends AppRouteState {
  /// Yeni bir NoteEditRoute oluşturur.
  NoteEditRoute({this.noteId});

  /// Düzenlenen notun kimliği.
  final String? noteId;
}

/// Uygulamanın yönlendirme durumunu yöneten Notifier.
class AppRouteNotifier extends Notifier<AppRouteState> {
  @override
  AppRouteState build() => NotesListRoute();

  /// Notlar listesine yönlendirir.
  void goToNotesList() => state = NotesListRoute();

  /// Not düzenleme ekranına yönlendirir.
  void goToNoteEdit({String? noteId}) => state = NoteEditRoute(noteId: noteId);
}

/// Uygulamanın yönlendirme durumunu sağlayan provider.
final appRouteNotifierProvider =
    NotifierProvider<AppRouteNotifier, AppRouteState>(AppRouteNotifier.new);
