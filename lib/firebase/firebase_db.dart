import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nti_final_project/firebase/models/user_model.dart';

class FirebaseDb {
  // auth
  final FirebaseAuth auth = FirebaseAuth.instance;

  // fireStore
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // register
  Future<void> register(String name, String email, String password) async {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    UserModel userModel = UserModel(
      name: name,
      uId: userCredential.user!.uid,
      email: email,
      password: password,
      imagePath: 'imagePath',
      frinds: [],
    );
    try {
      await firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(userModel.toJason());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // login
  Future<UserModel> login(String email, String password) async {
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    try {
      DocumentSnapshot<Map<String, dynamic>> data = await firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      return UserModel.fromJson(data.data()!);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
