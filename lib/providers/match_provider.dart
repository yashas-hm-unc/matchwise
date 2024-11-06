import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matchwise/core/models/faculty_user.dart';
import 'package:matchwise/core/models/student_user.dart';

final StateNotifierProvider<MatchedNotifier,
        Map<FacultyUser, List<StudentUser>>> matchedProvider =
    StateNotifierProvider(
  (_) => MatchedNotifier(
    {},
  ),
);

final StateNotifierProvider<SortedNotifier,
    Map<FacultyUser, List<StudentUser>>> sortedProvider = StateNotifierProvider(
  (_) => SortedNotifier(
    {},
  ),
);

class MatchedNotifier
    extends StateNotifier<Map<FacultyUser, List<StudentUser>>> {
  MatchedNotifier(super.state);
  
  void update(FacultyUser faculty, List<StudentUser> students){
    state[faculty] = students;
    state = {...state};
  }
  
  void initDev(Map<FacultyUser, List<StudentUser>> matches){
    state = matches;
  }
}

class SortedNotifier
    extends StateNotifier<Map<FacultyUser, List<StudentUser>>> {
  SortedNotifier(super.state);
}
