import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:physio_metric/core/app_startup_provider/app_initializer_provider.dart';
import 'package:physio_metric/core/navigation/app_route_information_parser.dart';
import 'package:physio_metric/core/navigation/app_router_delegate.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initAsync = ref.watch(appInitializerProvider);
    final routerDelegate = AppRouterDelegate(ref);
    final routeInformationParser = AppRouteInformationParser();

    // Ana renk: #7719AA
    const primaryColor = Color(0xFF7719AA);

    final lightColorScheme = ColorScheme.fromSeed(seedColor: primaryColor);
    final darkColorScheme = ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.dark,
    );

    return MaterialApp.router(
      title: 'physio_metric',
      theme: ThemeData(
        colorScheme: lightColorScheme,
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: lightColorScheme.primary,
          foregroundColor: lightColorScheme.onPrimary,
          elevation: 2,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: lightColorScheme.primary,
          foregroundColor: lightColorScheme.onPrimary,
        ),
        cardTheme: CardThemeData(
          color: lightColorScheme.surface,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        scaffoldBackgroundColor: lightColorScheme.surface,
      ),
      darkTheme: ThemeData(
        colorScheme: darkColorScheme,
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: darkColorScheme.primary,
          foregroundColor: darkColorScheme.onPrimary,
          elevation: 2,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: darkColorScheme.primary,
          foregroundColor: darkColorScheme.onPrimary,
        ),
        cardTheme: CardThemeData(
          color: darkColorScheme.surface,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        scaffoldBackgroundColor: darkColorScheme.surface,
      ),
      routerDelegate: routerDelegate,
      routeInformationParser: routeInformationParser,
      backButtonDispatcher: RootBackButtonDispatcher(),
      builder: (context, child) {
        return initAsync.when(
          loading: () => const Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Yükleniyor... '),
                ],
              ),
            ),
          ),

          error: (e, st) => Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Başlatılırken hata: $e'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => ref.refresh(appInitializerProvider),
                    child: const Text('Yeniden Dene'),
                  ),
                ],
              ),
            ),
          ),
          data: (_) => child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
