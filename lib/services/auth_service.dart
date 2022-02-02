import 'package:firebase_auth/firebase_auth.dart';
import 'package:catatan/models/user_model.dart';
import 'package:catatan/services/user_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserModel user =
          await UserService().getUserById(userCredential.user!.uid);
      return user;
    } catch (e) {
      throw e.toString().split(']')[1].trim();
    }
  }

  Future<UserModel> signUp(
      {required String email,
      required String password,
      required String name,
      String job = '',
      String hobby = ''}) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      UserModel user = UserModel(
        id: userCredential.user!.uid,
        email: email,
        name: name,
        job: job,
        hobby: hobby,
      );

      await UserService().setUser(user);

      return user;
    } catch (e) {
      throw e.toString().split(']')[1].trim();
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw e.toString().split(']')[1].trim();
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw e.toString().split(']')[1].trim();
    }
  }
}
