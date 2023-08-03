import '../packages_export.dart';

class AppUser {
  late String id;
  late String name;
  String? imageURL;
  late String email;

  AppUser(
      {required this.id,
      required this.name,
      this.imageURL,
      required this.email});

  AppUser.fromFirestore(QueryDocumentSnapshot doc) {
    id = doc['id'];
    name = doc['name'];
    imageURL = doc['imageURL'];
    email = doc['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['imageURL'] = imageURL;
    data['email'] = email;
    return data;
  }
}
