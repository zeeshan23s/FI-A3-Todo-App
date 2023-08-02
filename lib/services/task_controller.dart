import '../packages_export.dart';

class TaskController {
  static final _taskCollection = FirebaseFirestore.instance.collection('task');

  static Map<String, dynamic> status = {'code': 200, 'message': ''};

  static Future<void> create(Task task) async {
    try {
      await _taskCollection
          .add(task.toJson())
          .then(
              (value) => _taskCollection.doc(value.id).update({'id': value.id}))
          .then((value) =>
              status = {'code': 200, 'message': 'Successfully Created!'});
      debugPrint(AuthController.firebaseAuth.currentUser?.uid);
    } on FirebaseException catch (e) {
      status = {'code': e.code, 'message': e.message};
    } catch (e) {
      status = {'code': '500', 'message': e.toString()};
    }
  }

  static Stream<QuerySnapshot> read(String category) {
    return _taskCollection
        .where('uid', isEqualTo: AuthController.firebaseAuth.currentUser?.uid)
        .where('is_complete', isEqualTo: category == 'Completed')
        .snapshots();
  }

  static Future<void> update(Task task) async {
    try {
      await _taskCollection.doc(task.id).update(task.toJson()).then((value) =>
          status = {'code': 200, 'message': 'Successfully Updated!'});
    } on FirebaseException catch (e) {
      status = {'code': e.code, 'message': e.message};
    } catch (e) {
      status = {'code': '500', 'message': e.toString()};
    }
  }

  static Future<void> delete(String? id) async {
    try {
      await _taskCollection.doc(id).delete().then((value) =>
          status = {'code': 200, 'message': 'Successfully Removed!'});
    } on FirebaseException catch (e) {
      status = {'code': e.code, 'message': e.message};
    } catch (e) {
      status = {'code': '500', 'message': e.toString()};
    }
  }
}
