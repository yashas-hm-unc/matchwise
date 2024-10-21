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
  String id;

  String firstName;
  
  String lastName;

  String pid;

  String email;

  UserType type;
  
  MatchWiseUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.pid,
    required this.email,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'PID': pid,
      'email': email,
      'type': type,
    };
  }
}
