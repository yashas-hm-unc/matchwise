import 'package:matchwise/core/models/matchwise_user.dart';

class StudentUser extends MatchWiseUser {
  List<String> courseTAPref = [];

  List<String> researchInterests = [];

  List<String> prefProfessors = [];

  String description = '';

  String resumeLink = '';

  String videoLink = '';

  StudentUser({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.pid,
    required super.email,
    super.type = UserType.student,
    courseTAPref,
    researchInterests,
    prefProfessors,
    description,
    resumeLink,
    videoLink,
  }) {
    this.courseTAPref = courseTAPref ?? [];
    this.researchInterests = researchInterests ?? [];
    this.prefProfessors = prefProfessors ?? [];
    this.description = description ?? '';
    this.resumeLink = resumeLink ?? '';
    this.videoLink = videoLink ?? '';
  }

  factory StudentUser.fromMap(Map<String, dynamic> json) {
    return StudentUser(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      pid: json['PID'] as String,
      email: json['email'] as String,
      courseTAPref: json['courseTAPref'].map((e) => e.toString()),
      researchInterests: json['researchInterests'].map((e) => e.toString()),
      prefProfessors: json['prefProfessors'].map((e) => e.toString()),
      description: json['description'] as String,
      resumeLink: json['resumeLink'] as String,
      videoLink: json['videoLink'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    final json = {
      'courseTAPref': courseTAPref,
      'researchInterests': researchInterests,
      'prefProfessor': prefProfessors,
      'description': description,
      'resumeLink': resumeLink,
      'videoLink': videoLink,
    };
    final jsonData = super.toJson();

    for (var key in jsonData.keys) {
      json[key] = super.toJson()[key];
    }

    return json;
  }
}
