import '../packages_export.dart';

class AuthController {
  static final firebaseAuth = FirebaseAuth.instance;

  static Map<String, dynamic> status = {'code': 200, 'message': ''};

  static Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await sendEmailVerification();
      status = {'code': 200, 'message': 'Successfully Registered!'};
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        status = {
          'code': e.code,
          'message': 'The password provided is too weak.'
        };
      } else if (e.code == 'email-already-in-use') {
        status = {
          'code': e.code,
          'message': 'The account already exists for that email.'
        };
      }
    } catch (e) {
      status = {'code': 500, 'message': e.toString()};
    }
  }

  static Future<void> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      status = {'code': 200, 'message': 'Login Successful!'};
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        status = {'code': e.code, 'message': 'No user found for that email.'};
      } else if (e.code == 'wrong-password') {
        status = {
          'code': e.code,
          'message': 'Wrong password provided for that user.'
        };
      }
    } catch (e) {
      status = {'code': 500, 'message': e.toString()};
    }
  }

  static Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  static Future<void> sendPasswordResetEmail(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      status = {
        'code': 200,
        'message': 'Password reset email have been sent to your email account.'
      };
    } on FirebaseException catch (e) {
      status = {'code': e.code, 'message': e.message};
    } catch (e) {
      status = {'code': 500, 'message': e.toString()};
    }
  }

  static Future<void> sendEmailVerification() async {
    try {
      if (firebaseAuth.currentUser != null) {
        await firebaseAuth.currentUser?.sendEmailVerification();
      }
      status = {
        'code': 200,
        'message': 'Verification email have been send successfully!'
      };
    } on FirebaseException catch (e) {
      status = {'code': e.code, 'message': e.message};
    } catch (e) {
      status = {'code': 500, 'message': e.toString()};
    }
  }

  static Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential? user =
          await FirebaseAuth.instance.signInWithCredential(credential);
      status = {'code': 200, 'message': 'Login Successful!'};

      return user;
    } on FirebaseException catch (e) {
      status = {'code': e.code, 'message': e.message};
    } catch (e) {
      status = {'code': 500, 'message': e.toString()};
    }
    return null;
  }
}
