import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:physio_metric/core/navigation/app_route_state.dart';
import 'package:physio_metric/features/authentication/data/auth_repository.dart';
import 'package:physio_metric/features/authentication/presentation/login/login_screen.dart';

/// Uygulamanın yönlendirme (routing) işlemlerini yöneten RouterDelegate.
class AppRouterDelegate extends RouterDelegate<Object>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<Object> {
  /// Yeni bir AppRouterDelegate oluşturur.
  AppRouterDelegate(this.ref) {
    ref.listen(appRouteNotifierProvider, (_, __) => notifyListeners());
  }

  /// Navigator için anahtar.
  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Riverpod WidgetRef referansı.
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final appUserAsync = ref.watch(appUserStreamProvider);
    final routeState = ref.watch(appRouteNotifierProvider);

    return Navigator(
      key: navigatorKey,
      pages: [
        appUserAsync.when(
          data: (user) {
            if (user == null) {
              return const MaterialPage(
                key: ValueKey('login_and_sign_in_screen'),
                child: LoginAndSignInScreen(),
              );
            } else {
              // Notlar listesi ana sayfa
              return const MaterialPage(
                key: ValueKey('notes_screen'),
                child: NotesScreen(),
              );
            }
          },
          loading: () => const MaterialPage(
            key: ValueKey('loading_screen'),
            child: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          ),
          error: (e, _) => MaterialPage(
            key: ValueKey('error_screen'),
            child: Scaffold(body: Center(child: Text('Hata: $e'))),
          ),
        ),
        // Kullanıcı giriş yaptıysa ve NoteEditRoute ise, NoteEditScreen'i ekle
        if (appUserAsync.asData?.value != null && routeState is NoteEditRoute)
          MaterialPage(
            key: ValueKey('note_edit_and_detail_screen'),
            child: NoteEditAndDetailScreen(
              note: _findNoteById(routeState.noteId),
            ),
          ),
      ],
      onPopPage: (route, result) {
        if (routeState is NoteEditRoute) {
          ref.read(appRouteNotifierProvider.notifier).goToNotesList();
        }
        return route.didPop(result);
      },
    );
  }

  /// Belirli bir noteId ile notu bulur. ( Uygulamada provider'dan alınmalı)
  Note? _findNoteById(String? noteId) {
    if (noteId == null) return null;
    final notesState = ref.read(notesControllerProvider);
    if (notesState is AsyncData) {
      final notes = notesState.value as List<Note>?;
      if (notes == null) return null;
      return notes.where((note) => note.id == noteId).cast<Note?>().firstOrNull;
    }
    return null;
  }

  @override
  Future<void> setNewRoutePath(Object configuration) async {}
}
