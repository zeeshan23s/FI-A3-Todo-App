import '../packages_export.dart';

class Task {
  String? id;
  String? title;
  String? description;
  String? intensity;
  bool? isComplete;
  String? createdAt;
  String? uid;

  Task(
      {this.id,
      this.title,
      this.description,
      this.intensity,
      this.isComplete,
      this.createdAt,
      this.uid});

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
