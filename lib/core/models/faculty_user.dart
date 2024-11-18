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
    super.active = true,
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
        'type': type.toString(),
        'positionsOpen': positionsOpen,
        'researchInterests': researchInterests,
        'courses': courses,
        'active': active,
      };

  factory FacultyUser.fromJson(Map<String, dynamic> json) => FacultyUser(
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        onyen: json['onyen'] as String,
        email: json['email'] as String,
        positionsOpen: json['positionsOpen'] as int,
        researchInterests: (json['researchInterests'] as List)
            .map((e) => e.toString())
            .toList(),
        courses: (json['courses'] as List).map((e) => e.toString()).toList(),
        active: json['active'] as bool,
      );

  factory FacultyUser.empty() => FacultyUser(
        firstName: '',
        lastName: '',
        onyen: '',
        email: '',
      );

  factory FacultyUser.fromParent(MatchWiseUser user) => FacultyUser(
        firstName: user.firstName,
        lastName: user.lastName,
        onyen: user.onyen,
        email: user.email,
        active: user.active,
      );
}
