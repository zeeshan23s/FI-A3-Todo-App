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

    if (AuthController.status['code'] == 200 ||
        AuthController.status['code'] == 403) {
      await UserController.create(AppUser(
              id: AuthController.firebaseAuth.currentUser?.uid,
              name: name,
              email: email))
          .whenComplete(() => _status = UserController.status);

      if (AuthController.status['code'] == 200 &&
          UserController.status['code'] == 200) {
        _currentUser = AuthController.firebaseAuth.currentUser;
        _status = AuthController.status;
      }
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

  Future<void> googleLogin() async {
    UserCredential? user = await AuthController.signInWithGoogle();

    if (AuthController.status['code'] == 200) {
      _currentUser = user?.user;
      debugPrint(_currentUser?.uid);
    } else {
      _currentUser = null;
    }

    _status = AuthController.status;
    notifyListeners();
  }
}
