import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do_app_firebase/data/firestore_data.dart';

abstract class AuthData {
  Future<void> register(String email, String password, String PasswordConfirm);
  Future<void> login(String email, String password);
}

class AuthRemote extends AuthData {
  @override
  Future<void> login(String email, String password) async {
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
  }

  @override
  Future<void> register(String email, String password, String PasswordConfirm) async {
    if (password == PasswordConfirm) {
      FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.trim(), password: password.trim()).then((value) {
        FirestoreData().createUser(email);
      });
    }
  }
}
