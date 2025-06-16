import 'package:flutter/material.dart';
import 'package:physio_metric/core/constants/app_breakpoints.dart';

enum ScreenSize { xs, sm, md, lg, xl }

class Responsive {
  static ScreenSize screenSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= AppBreakpoints.xl) return ScreenSize.xl;
    if (width >= AppBreakpoints.lg) return ScreenSize.lg;
    if (width >= AppBreakpoints.md) return ScreenSize.md;
    if (width >= AppBreakpoints.sm) return ScreenSize.sm;
    return ScreenSize.xs;
  }

  static bool isMobile(BuildContext context) =>
      screenSize(context) == ScreenSize.xs ||
      screenSize(context) == ScreenSize.sm;

  static bool isTablet(BuildContext context) =>
      screenSize(context) == ScreenSize.md;

  static bool isDesktop(BuildContext context) =>
      screenSize(context) == ScreenSize.lg ||
      screenSize(context) == ScreenSize.xl;

  /// Ekran boyutuna göre responsive değer döndürür.
  static T responsiveValue<T>({
    required double width,
    required T small,
    required T medium,
    required T large,
  }) {
    if (width < 600) return small;
    if (width < 1200) return medium;
    return large;
  }
}
