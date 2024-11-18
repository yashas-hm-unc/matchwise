import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matchwise/core/models/student_user.dart';

final StateNotifierProvider<StudentNotifier, List<StudentUser>>
    studentProvider = StateNotifierProvider(
  (_) => StudentNotifier(
    [],
  ),
);

class StudentNotifier extends StateNotifier<List<StudentUser>> {
  StudentNotifier(super.state);

  set list(List<StudentUser> users) => state = users;

  List<StudentUser> get list => state;
}
