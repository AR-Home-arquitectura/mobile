import 'package:arhome/models/user.model.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  UserModel currentUser = UserModel();
  bool signIn = false;

  Future<void> updateCurrentUser(UserModel user) async {
    currentUser = user;
    signIn = true;
    notifyListeners();
  }
}