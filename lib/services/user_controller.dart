import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import '../packages_export.dart';

class UserController {
  static final _userCollection = FirebaseFirestore.instance.collection('user');

  static final _storage = FirebaseStorage.instance;

  static Map<String, dynamic> status = {'code': 200, 'message': ''};

  static Future<void> create(AppUser user) async {
    try {
      await _userCollection.doc(user.id).set(user.toJson()).then((value) =>
          status = {'code': 200, 'message': 'Successfully Created!'});
    } on FirebaseException catch (e) {
      status = {'code': e.code, 'message': e.message};
    } catch (e) {
      status = {'code': '500', 'message': e.toString()};
    }
  }

  static Stream<DocumentSnapshot> read(String id) {
    return _userCollection.doc(id).snapshots();
  }

  static Future<void> delete(String id) async {
    try {
      await _userCollection.doc(id).delete().then((value) =>
          status = {'code': 200, 'message': 'Successfully Removed!'});
    } on FirebaseException catch (e) {
      status = {'code': e.code, 'message': e.message};
    } catch (e) {
      status = {'code': '500', 'message': e.toString()};
    }

    if (AuthController.firebaseAuth.currentUser != null) {
      AuthController.firebaseAuth.currentUser!.delete();
    }
  }

  static Future<void> updateImageURL(String id, String imageURL) async {
    try {
      await _userCollection.doc(id).update({'imageURL': imageURL}).then(
          (value) =>
              status = {'code': 200, 'message': 'Successfully Updated!'});
    } on FirebaseException catch (e) {
      status = {'code': e.code, 'message': e.message};
    } catch (e) {
      status = {'code': '500', 'message': e.toString()};
    }
  }

  static Future<String> uploadImage(Uint8List file, String name) async {
    final ref = _storage.ref("images/$name");
    final uploadTask = ref.putData(file);
    final snapshot = await uploadTask.whenComplete(() {});
    return await snapshot.ref.getDownloadURL();
  }
}
