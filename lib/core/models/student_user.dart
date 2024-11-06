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

  factory StudentUser.fromMap(Map<String, dynamic> json) {
    return StudentUser(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      onyen: json['onyen'] as String,
      email: json['email'] as String,
      courseTAPref: json['courseTAPref'].map((e) => e.toString()),
      researchInterests: json['researchInterests'].map((e) => e.toString()),
      prefProfessors: json['prefProfessors'].map((e) => e.toString()),
      description: json['description'] as String,
      resumeLink: json['resumeLink'] as String,
      videoLink: json['videoLink'] as String,
    );
  }

  Map<String, dynamic> toMap() =>
      {
        'firstName': firstName,
        'lastName': lastName,
        'onyen': onyen,
        'email': email,
        'type': type,
        'courseTAPref': courseTAPref,
        'researchInterests': researchInterests,
        'prefProfessor': prefProfessors,
        'description': description,
        'resumeLink': resumeLink,
        'videoLink': videoLink,
      };
}
