import 'package:arhome/models/user.model.dart';
import 'package:arhome/utils/roles.enum.dart';
import 'package:arhome/providers/user.provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/toast.widget.dart';

class FirebaseAuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModel?> signUpWithEmailAndPassword(String email, String password) async {

    try {
      UserCredential credential =await _auth.createUserWithEmailAndPassword(email: email, password: password);

      await credential.user!.updateDisplayName("Username");
      await addUserToFirestore(credential.user!);

      return UserModel(id: credential.user!.uid, email: credential.user!.email.toString(), displayName: credential.user!.displayName);
    } on FirebaseAuthException catch (e) {

      if (e.code == 'email-already-in-use') {
        showToast(message: 'The email address is already in use.');
      } else {
        showToast(message: 'An error occurred: ${e.code}');
      }
    }
    return null;

  }

  Future<UserModel?> signInWithEmailAndPassword(String email, String password) async {

    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      UserModel? user = await getUserById(credential.user!.uid);

      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        showToast(message: 'Invalid email or password.');
      } else {
        showToast(message: 'An error occurred: ${e.code}');
      }

    }

    return null;
  }

  Future<void> addUserToFirestore(User user) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    await users.doc(user.uid).set({
      'displayName': user.displayName,
      'email': user.email,
      'phone': null,
      'role': Roles.CLIENT.name
    });
  }

  Future<UserModel?> getUserById(String userId) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();

      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

        UserModel user = UserModel.fromJson(userData);
        return user;
      } else {
        return null;
      }
    } catch (e) {
      print('Error al obtener el usuario: $e');
      return null;
    }
  }
}