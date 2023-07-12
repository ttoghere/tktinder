import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tktinder/models/user_model.dart';
import 'package:tktinder/repositories/database/base_database_repository.dart';
import 'package:tktinder/repositories/storage/storage_repository.dart';

class DatabaseRepository extends BaseDatabaseRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Stream<User> getUser() {
    return _firestore
        .collection("users")
        .doc("iltznWpnHN7KE9jVMdeI")
        .snapshots()
        .map(
          (event) => User.fromSnapshot(
            event,
          ),
        );
  }

  @override
  Future<void> updateUserPictures(String imageName) async {
    String downloadUrl = await StorageRepository().getDownloadUrl(imageName);
    return _firestore.collection("users").doc("iltznWpnHN7KE9jVMdeI").update(
      {
        "imageUrls": FieldValue.arrayUnion(
          [downloadUrl],
        ),
      },
    );
  }
}
