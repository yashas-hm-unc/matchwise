import 'package:matchwise/core/models/matchwise_user.dart';

class FacultyUser extends MatchWiseUser {
  int positionsOpen = 0;

  List<String> researchInterests = [];

  List<String> courses = [];

  FacultyUser({
    required super.firstName,
    required super.lastName,
    required super.onyen,
    required super.email,
    super.type = UserType.faculty,
    this.positionsOpen = 0,
    List<String>? researchInterests,
    List<String>? courses,
  }) {
    this.courses = courses ?? [];
    this.researchInterests = researchInterests ?? [];
  }

  @override
  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'onyen': onyen,
        'email': email,
        'type': type,
        'positionsOpen': positionsOpen,
        'researchInterests': researchInterests,
        'courses': courses,
      };

  factory FacultyUser.fromMap(Map<String, dynamic> json) => FacultyUser(
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        onyen: json['onyen'] as String,
        email: json['email'] as String,
        positionsOpen: json['positionsOpen'] as int,
        researchInterests: json['researchInterests'].map((e) => e.toString()),
        courses: json['courses'].map((e) => e.toString()),
      );

  factory FacultyUser.empty() => FacultyUser(
        firstName: '',
        lastName: '',
        onyen: '',
        email: '',
      );
}
