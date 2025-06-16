import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// AsyncValue için hata durumunda snackbar gösteren extension.
extension AsyncValueUI<T> on AsyncValue<T> {
  /// Error durumunda context ile snackbar gösterir.
  void showSnackbarOnError(BuildContext context) {
    whenOrNull(
      error: (error, _) {
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(error.toString())));
        }
      },
    );
  }
}
