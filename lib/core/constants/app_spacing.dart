import 'package:flutter/material.dart';
import 'package:physio_metric/core/utils/responsive.dart';

/// Uygulama genelinde kullanılacak spacing (boşluk) sabitleri.
class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;

  static const EdgeInsets screenPadding = EdgeInsets.all(md);
  static const EdgeInsets formPadding = EdgeInsets.symmetric(
    horizontal: lg,
    vertical: md,
  );

  static double responsivePadding(BuildContext context) {
    return switch (Responsive.screenSize(context)) {
      ScreenSize.xl => xl,
      ScreenSize.lg => lg,
      ScreenSize.sm => sm,
      ScreenSize.xs => xs,
      _ => md,
    };
  }
}
