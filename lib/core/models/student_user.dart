import 'package:matchwise/core/models/matchwise_user.dart';

class StudentUser extends MatchWiseUser {
  List<String> courseTAPref = [];

  List<String> researchInterests = [];

  List<String> prefProfessors = [];

  String description = '';

  String resumeLink = '';

  String videoLink = '';

  StudentUser({
    required super.firstName,
    required super.lastName,
    required super.onyen,
    required super.email,
    super.type = UserType.student,
    super.active = true,
    List<String>? courseTAPref,
    List<String>? researchInterests,
    List<String>? prefProfessors,
    this.description = '',
    this.resumeLink = '',
    this.videoLink = '',
  }) {
    this.courseTAPref = courseTAPref ?? [];
    this.researchInterests = researchInterests ?? [];
    this.prefProfessors = prefProfessors ?? [];
  }

  factory StudentUser.fromJson(Map<String, dynamic> json) {
    return StudentUser(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      onyen: json['onyen'] as String,
      email: json['email'] as String,
      courseTAPref:
          (json['courseTAPref'] as List).map((e) => e.toString()).toList(),
      researchInterests:
          (json['researchInterests'] as List).map((e) => e.toString()).toList(),
      prefProfessors:
          (json['prefProfessors'] as List).map((e) => e.toString()).toList(),
      description: json['description'] as String,
      resumeLink: json['resumeLink'] as String,
      videoLink: json['videoLink'] as String,
      active: json['active'] as bool,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'onyen': onyen,
        'email': email,
        'type': type.toString(),
        'courseTAPref': courseTAPref,
        'researchInterests': researchInterests,
        'prefProfessors': prefProfessors,
        'description': description,
        'resumeLink': resumeLink,
        'videoLink': videoLink,
        'active': active,
      };

  factory StudentUser.fromParent(MatchWiseUser user) => StudentUser(
        firstName: user.firstName,
        lastName: user.lastName,
        onyen: user.onyen,
        email: user.email,
        active: user.active,
      );
}
