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

  bool active;

  MatchWiseUser({
    required this.firstName,
    required this.lastName,
    required this.onyen,
    required this.email,
    required this.type,
    required this.active,
  });

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'onyen': onyen,
        'email': email,
        'type': type.toString(),
      };

  factory MatchWiseUser.fromJson(Map<String, dynamic> json) {
    return MatchWiseUser(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      onyen: json['onyen'] as String,
      email: json['email'] as String,
      active: true,
      type: UserType.admin,
    );
  }
}
