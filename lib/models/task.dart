import '../packages_export.dart';

class Task {
  late String id;
  late String title;
  String? description;
  late String intensity;
  late bool isComplete;
  late String createdAt;
  late String uid;

  Task(
      {required this.id,
      required this.title,
      this.description,
      required this.intensity,
      required this.isComplete,
      required this.createdAt,
      required this.uid});

  Task.fromFirestore(QueryDocumentSnapshot doc) {
    id = doc['id'];
    title = doc['title'];
    description = doc['description'];
    intensity = doc['intensity'];
    isComplete = doc['is_complete'];
    createdAt = doc['created_at'];
    uid = doc['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['intensity'] = intensity;
    data['is_complete'] = isComplete;
    data['created_at'] = createdAt;
    data['uid'] = uid;
    return data;
  }
}
