import 'package:matchwise/core/models/matchwise_user.dart';

class FacultyUser extends MatchWiseUser {
  int positionsOpen;

  List<String> researchInterests = [];

  FacultyUser({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.pid,
    required super.email,
    super.type = UserType.faculty,
    this.positionsOpen = 0,
    List<String>? researchInterests,
  }) {
    this.researchInterests = researchInterests ?? [];
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'PID': pid,
        'email': email,
        'type': type,
        'positionsOpen': positionsOpen,
        'researchInterests': researchInterests,
      };

  factory FacultyUser.fromMap(Map<String, dynamic> json) => FacultyUser(
        id: json['id'] as String,
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        pid: json['PID'] as String,
        email: json['email'] as String,
        positionsOpen: json['positionsOpen'] as int,
        researchInterests: json['researchInterests'].map((e) => e.toString()),
      );

  factory FacultyUser.empty() => FacultyUser(
        id: '',
        firstName: '',
        lastName: '',
        pid: '',
        email: '',
      );
}
