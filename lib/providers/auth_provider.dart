import '../packages_export.dart';

class AuthProvider with ChangeNotifier {
  User? _currentUser = AuthController.firebaseAuth.currentUser;

  Map<String, dynamic> _status = {'code': 200, 'message': ''};

  User? get currentUser => _currentUser;

  Map<String, dynamic> get status => _status;

  Future<void> login(String email, String password) async {
    await AuthController.signInWithEmailAndPassword(email, password);

    if (AuthController.status['code'] == 200) {
      _currentUser = AuthController.firebaseAuth.currentUser;
    } else {
      _currentUser = null;
    }

    _status = AuthController.status;
    notifyListeners();
  }

  Future<void> register(String name, String email, String password) async {
    await AuthController.createUserWithEmailAndPassword(email, password);

    if (AuthController.status['code'] == 200) {
      _currentUser = AuthController.firebaseAuth.currentUser;
      _status = AuthController.status;
    } else {
      _currentUser = null;
      _status = AuthController.status;
    }

    notifyListeners();
  }

  Future<void> logout() async {
    await AuthController.signOut();
    _currentUser = AuthController.firebaseAuth.currentUser;

    notifyListeners();
  }
}
