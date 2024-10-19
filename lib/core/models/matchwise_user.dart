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

  String name;

  String pid;

  String email;

  UserType type;

  late Map<String, dynamic> details;

  MatchWiseUser({
    required this.id,
    required this.name,
    required this.pid,
    required this.email,
    required this.type,
    Map<String, dynamic>? details,
  }) {
    this.details = details ?? {};
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'PID': pid,
      'email': email,
      'type': type,
      'details': details,
    };
  }

  factory MatchWiseUser.fromJson(Map<String, dynamic> map) {
    return MatchWiseUser(
      id: map['id'] as String,
      name: map['name'] as String,
      pid: map['PID'] as String,
      email: map['email'] as String,
      details: map['details'],
      type: UserType.fromString(map['type']),
    );
  }
}
