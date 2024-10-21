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
    super.type=UserType.faculty,
    this.positionsOpen = 0,
    researchInterests,
  }){
    this.researchInterests = researchInterests??[];
  }

  Map<String, dynamic> toMap() {
    final json =  {
      'positionsOpen': positionsOpen,
      'researchInterests': researchInterests,
    };
    final jsonData = super.toJson();

    for (var key in jsonData.keys) {
      json[key] = super.toJson()[key];
    }

    return json;
  }

  factory FacultyUser.fromMap(Map<String, dynamic> json) {
    return FacultyUser(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      pid: json['PID'] as String,
      email: json['email'] as String,
      positionsOpen: json['positionsOpen'] as int,
      researchInterests: json['researchInterests'].map((e)=>e.toString()),
    );
  }
}
