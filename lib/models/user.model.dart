import 'package:flutter/material.dart';

class UserModel with ChangeNotifier {
  late final String? id;
  late final String? email;
  late final String? displayName;
  late final int? phone;

  UserModel({
    this.id,
    this.email,
    this.displayName,
    this.phone
  });
}