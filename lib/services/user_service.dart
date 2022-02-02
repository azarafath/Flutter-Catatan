import 'package:catatan/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final CollectionReference _userReference =
      FirebaseFirestore.instance.collection('users');

  Future<void> setUser(UserModel user) async {
    try {
      _userReference.doc(user.id).set({
        'id': user.id,
        'email': user.email,
        'name': user.name,
        'job': user.job,
        'hobby': user.hobby,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> getUserById(String id) async {
    try {
      DocumentSnapshot snapshot = await _userReference.doc(id).get();
      return UserModel(
        id: id,
        email: snapshot['email'],
        name: snapshot['name'],
        job: snapshot['job'],
        hobby: snapshot['hobby'],
      );
    } catch (e) {
      rethrow;
    }
  }

  Stream<UserModel> stremUserbyID(String id) {
    try {
      return _userReference
          .doc(id)
          .snapshots()
          .map((DocumentSnapshot snapshot) {
        return UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUser(
    String id,
    String email,
    String name,
    String job,
    String hobby,
  ) async {
    try {
      await _userReference.doc(id).update({
        'email': email,
        'name': name,
        'job': job,
        'hobby': hobby,
      });
    } catch (e) {
      rethrow;
    }
  }
}
