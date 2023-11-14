

import 'package:arhome/utils/roles.enum.dart';

class UserModel {
  late final String? id;
  late final String? email;
  late final String? displayName;
  late final int? phone;
  late final Roles? role;

  UserModel({
    this.id,
    this.email,
    this.displayName,
    this.phone,
    this.role
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      displayName: json['displayName'],
      phone: json['phone'],
      role: _parseRole(json['role']),
    );
  }

  static Roles? _parseRole(String? role) {
    switch (role) {
      case 'CLIENT':
        return Roles.CLIENT;
      case 'OWNER':
        return Roles.OWNER;
      default:
        return null;
    }
  }
}