import 'package:flutter/material.dart';
import 'package:physio_metric/core/navigation/app_route_path.dart';

/// RouteInformation nesnesini uygulama route'larına çeviren parser.
class AppRouteInformationParser
    extends RouteInformationParser<List<AppRoutePath>> {
  /// RouteInformation'dan uygulama route'larını çözümler.
  @override
  Future<List<AppRoutePath>> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    final uri = routeInformation.uri;
    if (uri.pathSegments.isEmpty) {
      return [const AppRoutePath.notesList()];
    }
    if (uri.pathSegments.length == 1 && uri.pathSegments[0] == 'edit') {
      return [const AppRoutePath.notesList(), const AppRoutePath.noteEdit()];
    }
    if (uri.pathSegments.length == 2 && uri.pathSegments[0] == 'edit') {
      final noteId = uri.pathSegments[1];
      return [
        const AppRoutePath.notesList(),
        AppRoutePath.noteEdit(noteId: noteId),
      ];
    }
    return [const AppRoutePath.unknown()];
  }

  /// Uygulama route'larından RouteInformation oluşturur.
  @override
  RouteInformation? restoreRouteInformation(List<AppRoutePath> configuration) {
    if (configuration.isEmpty) {
      return RouteInformation(uri: Uri.parse('/'));
    }
    final last = configuration.last;
    if (last.isNotesList) {
      return RouteInformation(uri: Uri.parse('/'));
    } else if (last.isNoteEdit) {
      if (last.noteId != null) {
        return RouteInformation(uri: Uri.parse('/edit/${last.noteId}'));
      } else {
        return RouteInformation(uri: Uri.parse('/edit'));
      }
    } else if (last.isUnknown) {
      return RouteInformation(uri: Uri.parse('/404'));
    }
    return RouteInformation(uri: Uri.parse('/'));
  }
}
