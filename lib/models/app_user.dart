import '../packages_export.dart';

class AppUser {
  String? id;
  String? name;
  String? imageURL;
  String? email;

  AppUser({this.id, this.name, this.imageURL, this.email});

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
