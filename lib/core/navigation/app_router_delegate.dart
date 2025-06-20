import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:physio_metric/core/navigation/app_route_state.dart';
import 'package:physio_metric/features/authentication/data/auth_repository.dart';
import 'package:physio_metric/features/authentication/presentation/account/account_screen.dart';
import 'package:physio_metric/features/authentication/presentation/login/login_screen.dart';
import 'package:physio_metric/features/home/presentation/home_screen.dart';
import 'package:physio_metric/features/analisis/presentation/posture_screen.dart';

final appRouteNotifierProvider =
    NotifierProvider<AppRouteNotifier, AppRouteState>(AppRouteNotifier.new);

class AppRouteNotifier extends Notifier<AppRouteState> {
  @override
  AppRouteState build() => const AppRouteState.login();

  void goToHome() => state = const AppRouteState.home();
  void goToLogin() => state = const AppRouteState.login();
  void goToAccount() => state = const AppRouteState.account();
  void goToPosture() => state = const AppRouteState.posture();
}

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

    // Using a record to bundle navigation state
    final navState = (user: appUserAsync, route: routeState);

    return Navigator(
      key: navigatorKey,
      pages: [
        // Pattern matching on the navigation state record
        switch (navState) {
          // Show loading screen
          (user: AsyncLoading(), route: _) => const MaterialPage(
            key: ValueKey('loading_screen'),
            child: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          ),
          // Show error screen
          (user: AsyncError(:final error), route: _) => MaterialPage(
            key: ValueKey('error_screen'),
            child: Scaffold(body: Center(child: Text('Hata: $error'))),
          ),
          // User is not logged in, show login screen
          (user: AsyncData(value: null), route: _) => const MaterialPage(
            key: ValueKey('login_screen'),
            child: LoginAndSignInScreen(),
          ),

          // User is logged in, handle routes
          (user: AsyncData(value: _), route: final route) => switch (route) {
            HomeRoute() => const MaterialPage(
              key: ValueKey('home_screen'),
              child: HomeScreen(),
            ),
            AccountRoute() => const MaterialPage(
              key: ValueKey('account_screen'),
              child: AccountScreen(),
            ),
            PostureRoute() => const MaterialPage(
              key: ValueKey('posture_screen'),
              child: PostureScreen(),
            ),
            // Default to login if route is login but user is logged in (redirect to home)
            // or any other unhandled case.
            LoginRoute() => const MaterialPage(
              key: ValueKey('home_screen'),
              child: HomeScreen(),
            ),
          },
        },
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        // Always go back to home from other screens when logged in
        final appUser = ref.read(appUserStreamProvider);
        if (appUser.hasValue && appUser.value != null) {
          ref.read(appRouteNotifierProvider.notifier).goToHome();
        }

        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(Object configuration) async {
    // This is where you would handle deep linking.
    // For now, we do nothing.
  }
}
