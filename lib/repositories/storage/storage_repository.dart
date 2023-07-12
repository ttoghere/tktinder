import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:tktinder/repositories/database/database_repository.dart';
import 'package:tktinder/repositories/storage/base_storage_repository.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;

class StorageRepository extends BaseStorageRepository {
  final storage.FirebaseStorage dataStorage = storage.FirebaseStorage.instance;
  @override
  Future<void> uploadImage(XFile image) async {
    try {
      await dataStorage
          .ref("user_1/${image.name}")
          .putFile(
            File(image.path),
          )
          .then(
            (p0) => DatabaseRepository().updateUserPictures(image.name),
          );
    } catch (_) {}
  }

  @override
  Future<String> getDownloadUrl(String imageName) async {
    String downloadUrl =
        await dataStorage.ref("user_1/$imageName").getDownloadURL();
    return downloadUrl;
  }
}
