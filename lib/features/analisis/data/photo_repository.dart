import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class PhotoRepository {
  PhotoRepository({required ImagePicker picker}) : _picker = picker;
  final ImagePicker _picker;

  /// Cihaz kamerası ile fotoğraf çeker.
  Future<File?> capturePhoto() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    return pickedFile != null ? File(pickedFile.path) : null;
  }
}

final photoRepositoryProvider = Provider<PhotoRepository>((ref) {
  final picker = ImagePicker();
  return PhotoRepository(picker: picker);
});
