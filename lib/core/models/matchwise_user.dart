import 'package:matchwise/core/constants/app_constants.dart';

enum UserType {
  admin,
  student,
  faculty;

  @override
  String toString() => name.replaceAll('Subscription.', kEmptyString);

  static UserType fromString(String value) =>
      UserType.values.firstWhere((element) => element.toString() == value);
}

class MatchWiseUser {
  String firstName;

  String lastName;

  String onyen;

  String email;

  UserType type;

  MatchWiseUser({
    required this.firstName,
    required this.lastName,
    required this.onyen,
    required this.email,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'onyen': onyen,
      'email': email,
      'type': type,
    };
  }

  factory MatchWiseUser.fromMap(Map<String, dynamic> map) {
    return MatchWiseUser(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      onyen: map['onyen'] as String,
      email: map['email'] as String,
      type: map['type'] as UserType,
    );
  }
}
